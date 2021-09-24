Imports System.IO
Imports Commons.VS.Events
Imports Commons.VS.Classes.Admin
Imports System.Data.SqlClient
Imports Microsoft.ApplicationBlocks.Data
Imports Microsoft.Win32
Imports System.Diagnostics
Imports VS.Object
Imports SafetyPlanModule
Imports DevExpress.XtraEditors


Public Class frmMain
    Dim iLic As Integer
    Dim p As New Protect()
    Dim mk As [String] = "VS_SAFETY_2016"

    Private Sub WriteRegistryKey(ByVal name As String, ByVal value As String)
        Try
            Try
                Microsoft.Win32.Registry.CurrentUser.DeleteValue(name)
            Catch ex As Exception

            End Try

            Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.CreateSubKey("SOFTWARE\SAFETY")
            key.SetValue(name, p.EnCrypt(value, mk))
        Catch generatedExceptionName As Exception
            MessageBox.Show(Me, "Write RegistryKey failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.[Error])
        End Try
    End Sub
    Private Function ReadRegistryKey(ByVal name As String)
        Dim version As String = ""
        Try
            Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.OpenSubKey("SOFTWARE\SAFETY")
            'if it does exist, retrieve the stored values  
            If key IsNot Nothing Then
                version = p.DeCrypt(DungChung.GetValueReg(key, name).ToString(), mk)
                key.Close()
                Return version
            End If
            Return version
        Catch generatedExceptionName As Exception
            Return version
        End Try
    End Function
    
    'Chỉnh sửa ngôn ngữ
    Public Shared Function LoadEditLanguage() As Boolean
        Try
            ' Dim frmForm As frmLanguage = New frmLanguage()
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, frmLanguage.Name) Then
                ShowForm(frmLanguage)
            End If
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    'Phân quyền sử dụng
    Public Shared Function LoadPhanQuyen() As Boolean
        Try

            If Commons.Modules.UserName.ToUpper = "ADMIN" Then
                ShowForm(frmNhomquyen)
            Else
                'Dim frmPhanQuyen As frmNhomquyen = New frmNhomquyen()
                If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, frmNhomquyen.Name) Then
                    ShowForm(frmNhomquyen)
                End If
            End If

            Return True
        Catch ex As Exception
            Return False
        End Try

    End Function
    'Đổi mật khẩu
    Public Shared Function LoadDoiPassword() As Boolean
        Try
            frmPassword.ShowDialog()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Sub MainForm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try


            Try

                Try
                    If System.IO.File.Exists(Application.StartupPath & "/UrlShare.ini") Then
                        System.IO.File.Delete(Application.StartupPath & "/UrlShare.ini")
                    End If
                    Dim foldershare As String = ""
                    foldershare = SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT TOP 1 DUONG_DAN_TL FROM THONG_TIN_CHUNG")
                    Dim file As System.IO.StreamWriter
                    file = My.Computer.FileSystem.OpenTextFileWriter(Application.StartupPath & "/UrlShare.ini", True)
                    file.WriteLine(foldershare)
                    file.Close()
                Catch ex As Exception

                End Try

                If File.Exists(Application.StartupPath & "/TMP_UPDATE/Update.exe") Then
                    File.Copy(Application.StartupPath & "/TMP_UPDATE/Update.exe", Application.StartupPath & "/Update.exe", True)
                End If

                'If File.Exists(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll") Then
                '    File.Copy(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll", Application.StartupPath & "/Ionic.Zip.dll", True)
                'End If

                If Directory.Exists(Application.StartupPath & "/TMP_UPDATE") Then
                    Try
                        If File.Exists(Application.StartupPath & "/TMP_UPDATE/Update.exe") Then
                            File.Delete(Application.StartupPath & "/TMP_UPDATE/Update.exe")
                        End If

                        'If File.Exists(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll") Then
                        '    File.Delete(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll")
                        'End If
                        Directory.Delete(Application.StartupPath & "/TMP_UPDATE")
                    Catch ex As Exception

                    End Try
                End If

            Catch ex As Exception

            End Try
            Try
                Process.Start(Application.StartupPath & "/Update.exe")
                'Process.Start("Update.exe", "1 \\\\192.168.2.22\\Update")
            Catch ex As Exception

            End Try

            Dim strDate As String = Registry.GetValue("HKEY_CURRENT_USER\Control Panel\International", "sShortDate", "dd/MM/yyyy")
            Dim strTime As String = Registry.GetValue("HKEY_CURRENT_USER\Control Panel\International", "sTimeFormat", "HH:mm:ss")
            If UCase(strDate) <> "DD/MM/YYYY" Then Registry.SetValue("HKEY_CURRENT_USER\Control Panel\International", "sShortDate", "dd/MM/yyyy")
            If UCase(strTime) <> "HH:MM:SS" Then Registry.SetValue("HKEY_CURRENT_USER\Control Panel\International", "sTimeFormat", "HH:mm:ss")
            strDate = Registry.GetValue("HKEY_CURRENT_USER\Control Panel\International", "sShortDate", "dd/MM/yyyy")
            strTime = Registry.GetValue("HKEY_CURRENT_USER\Control Panel\International", "sTimeFormat", "HH:mm:ss")
            If Not String.Equals(strDate, "dd/MM/yyyy", StringComparison.OrdinalIgnoreCase) Or Not String.Equals(strTime, "HH:mm:ss", StringComparison.OrdinalIgnoreCase) Then
                MsgBox("User đăng nhập không có quyền thay đổi hệ thống!" & vbCrLf & "Bạn vui lòng liện hệ với người quản trị để được hướng dẫn.", MsgBoxStyle.Exclamation)
                End
            End If
        Catch ex As Exception
            MsgBox("User đăng nhập không có quyền thay đổi hệ thống!" & vbCrLf & "Bạn vui lòng liện hệ với người quản trị để được hướng dẫn.", MsgBoxStyle.Exclamation)
            End
        End Try
        If Commons.Modules.LicDemo = True Then
            Dim fInfo As New FileInfo(System.Windows.Forms.Application.StartupPath & "\Vietsoft.exe")
            Dim dateMod As Date = fInfo.LastWriteTime.Date
            If DateDiff(DateInterval.Day, Now.Date, CDate(Commons.Modules.DemoDate)) < 0 Then
                MsgBox("Thời hạn chạy phiên bản dùng thử đã hết " & Application.ProductName & vbCrLf & vbCrLf & "Bạn vui lòng liên hệ với nhà cung cấp để được hướng dẫn.", MsgBoxStyle.Exclamation)
                End
            ElseIf DateDiff(DateInterval.Day, CDate(dateMod), Now.Date) < 0 Then
                MsgBox("Thời hạn chạy phiên bản dùng thử đã hết " & Application.ProductName & vbCrLf & vbCrLf & "Bạn vui lòng liên hệ với nhà cung cấp để được hướng dẫn.", MsgBoxStyle.Exclamation)
                End
            End If
        End If


        iLic = Commons.Modules.ObjSystems.MGetLicUser(Commons.Modules.UserName)


        'PictureEdit1.EditValue = My.Resources.Eco_VICT
        'PictureEdit1.Properties.SizeMode = DevExpress.XtraEditors.Controls.PictureSizeMode.Stretch
    End Sub

    ' Set quyền trên menu
    Public Shared Sub UserPermission(ByVal sUserName As String)
        Dim _Menu As MenuCtrl = New MenuCtrl()
        _Menu.LoadMenu()
    End Sub
    'Đóng form
    Private Sub MainForm_FormClosing(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles MyBase.FormClosing
        Try
            If Commons.Modules.UserName.Trim = "" Then Exit Sub

            If (MessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "MsgExitApp", Commons.Modules.TypeLanguage), Me.Text, MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes) Then
                Try
                    Try
                        Dim regKey As RegistryKey

                        regKey = Registry.CurrentUser.OpenSubKey("Software\VS_SAFETY", True)
                        regKey.SetValue("VS_SAFETY", "SAFETY")
                       
                        regKey.SetValue("TypeLanguage", Commons.Modules.TypeLanguage)

                        regKey.Close()
                    Catch ex As Exception

                    End Try
                    'SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "SP_DELETE_LOGIN", Commons.Modules.UserName)
                    Application.ExitThread()

                Catch ex As Exception
                End Try
            Else
                e.Cancel = True
                Exit Sub
            End If
        Catch ex As Exception
            Application.ExitThread()
        End Try
    End Sub
    Public Shared Function ShowFrmMonthlyReport() As Boolean
        Try
            Dim frmExportExcel As New FrmExportExcel(0)
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmMonthlyReport") Then
                frmExportExcel.ShowDialog()
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmCommitteeMeeting() As Boolean
        Try
            Dim frmExportExcel As New FrmExportExcel(1)
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmMonthlyReport") Then
                frmExportExcel.ShowDialog()
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmAnalysisTrenching() As Boolean
        Try
            Dim frmExportExcel As New FrmExportExcel(2)
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmMonthlyReport") Then
                frmExportExcel.ShowDialog()
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmStopChart() As Boolean
        Try
            Dim frmExportExcel As New FrmExportExcel(3)
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmMonthlyReport") Then
                frmExportExcel.ShowDialog()
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Private Sub MnTop_ItemAdded(ByVal sender As System.Object, ByVal e As System.Windows.Forms.ToolStripItemEventArgs)
        If (e.Item.Text.Trim().Equals(String.Empty)) Then
            e.Item.Visible = False
        End If
    End Sub


    'Đăng nhập
    Public Shared Function LogIn() As Boolean
        Try
            Dim sUser = Commons.Modules.UserName
            frmMain.TimerLogin.Stop()

            Dim iLogin As DialogResult
            iLogin = frmLogin.ShowDialog()
            If iLogin = Windows.Forms.DialogResult.Cancel Then
                Commons.Modules.UserName = sUser
                frmMain.TimerLogin.Start()
                Exit Function
            End If
            If iLogin = Windows.Forms.DialogResult.No Then End
            If sUser <> Commons.Modules.UserName Then
                'SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "SP_DELETE_LOGIN", sUser)
            End If
            frmMain.TimerLogin.Start()

            If Commons.Modules.UserName.Trim.Equals(String.Empty) Then End



            ' Safety setting

            DungChung.Login = Commons.Modules.UserName

            ' '''''
            For Each frmChild As Form In frmMain.MdiChildren
                frmChild.Close()
            Next


            Dim _NGUOI_DANG_NHAP As String = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, frmMain.ActiveForm.Name, "NGUOI_DANG_NHAP", Commons.Modules.TypeLanguage)
            Dim _TEN_CONG_TY As String = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, frmMain.ActiveForm.Name, "TEN_CONG_TY", Commons.Modules.TypeLanguage)
            Dim _PHIEN_BAN As String = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, frmMain.ActiveForm.Name, "PHIEN_BAN", Commons.Modules.TypeLanguage)
            _NGUOI_DANG_NHAP += IIf(Commons.Modules.UserName <> "", Commons.Modules.UserName, " - - - - -")
            _PHIEN_BAN += Application.ProductName.ToString ' & " " & Application.ProductVersion.ToString

            CType(frmMain.ActiveForm, frmMain).BarUserName.Caption = _NGUOI_DANG_NHAP
            CType(frmMain.ActiveForm, frmMain).BarCompanyInfo.Caption = Replace(_TEN_CONG_TY.ToUpper(), "''", "'")
            CType(frmMain.ActiveForm, frmMain).BarVersion.Caption = _PHIEN_BAN
            CType(frmMain.ActiveForm, frmMain).BarDateUpdate.Caption = "Version Current : " & Commons.Modules.sInfoClient & " - Server " & Commons.Modules.sInfoSer '_NGAY_CAP_NHAT


            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function


    'Ngôn ngữ tiếng việt
    Public Shared Function LanguageVietNam() As Boolean
        Try
            If Commons.Modules.TypeLanguage = 0 Then Exit Function
            Commons.Modules.TypeLanguage = 0
            UserPermission(Commons.Modules.UserName)
            For Each vFrm As Form In frmMain.MdiChildren
                'ClsMain.SetLanguageForm(vFrm)
                Commons.Modules.ObjSystems.ThayDoiNN(vFrm)

            Next
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    'Ngôn ngữ tiếng anh 
    Public Shared Function LanguageEnglish() As Boolean
        Try
            If Commons.Modules.TypeLanguage = 1 Then Exit Function
            Commons.Modules.TypeLanguage = 1
            UserPermission(Commons.Modules.UserName)
            For Each vFrm As Form In frmMain.MdiChildren

                Commons.Modules.ObjSystems.ThayDoiNN(vFrm)

            Next
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function LanguageChinese() As Boolean
        Try
            Commons.Modules.TypeLanguage = 2
            UserPermission(Commons.Modules.UserName)
            For Each vFrm As Form In frmMain.MdiChildren
                'ClsMain.SetLanguageForm(vFrm)
                Commons.Modules.ObjSystems.ThayDoiNN(vFrm)
            Next
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    'Thoát chương trình
    Public Shared Function ExitSystem() As Boolean
        Try
            frmMain.Close()
        Catch ex As Exception
            Return False
            frmMain.Close()
        End Try

    End Function



    'Mainform show
    Private Sub frmMain_Shown(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Shown
        TimerLogin.Stop()

        Dim iLogin As DialogResult
        iLogin = frmLogin.ShowDialog()
        If iLogin = Windows.Forms.DialogResult.Cancel Or iLogin = Windows.Forms.DialogResult.No Then End
        TimerLogin.Start()
        If Commons.Modules.UserName.Trim.Equals(String.Empty) Then End


        TimerLogin.Enabled = True
        UserPermission(Commons.Modules.UserName)
        Dim _NGUOI_DANG_NHAP As String
        _NGUOI_DANG_NHAP = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmMain", "NGUOI_DANG_NHAP", Commons.Modules.TypeLanguage)
        Dim _TEN_CONG_TY As String = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmMain", "TEN_CONG_TY", Commons.Modules.TypeLanguage)
        Dim _PHIEN_BAN As String = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmMain", "PHIEN_BAN", Commons.Modules.TypeLanguage)
        _NGUOI_DANG_NHAP += IIf(Commons.Modules.UserName <> "", Commons.Modules.UserName, " - - - - -")
        _PHIEN_BAN += "SAFETY " 'Application.ProductName.ToString ' & " " & Application.ProductVersion.ToString
        Dim version As String = "1.0.0.1"
        If File.Exists(Application.StartupPath & "/Version.txt") Then
            version = File.ReadAllText(Application.StartupPath & "/Version.txt").Trim()
        End If

        Try
            Me.BarUserName.Caption = _NGUOI_DANG_NHAP
            Me.BarCompanyInfo.Caption = Replace(_TEN_CONG_TY.ToUpper(), "''", "'")
            Me.BarVersion.Caption = _PHIEN_BAN
            Me.BarDateUpdate.Caption = "Version Current : " & version '& " - Server " & Commons.Modules.sInfoSer '_NGAY_CAP_NHAT

            'CType(frmMain.ActiveForm, frmMain).BarUserName.Caption = _NGUOI_DANG_NHAP
            'CType(frmMain.ActiveForm, frmMain).BarCompanyInfo.Caption = Replace(_TEN_CONG_TY.ToUpper(), "''", "'")
            'CType(frmMain.ActiveForm, frmMain).BarVersion.Caption = _PHIEN_BAN
            'CType(frmMain.ActiveForm, frmMain).BarDateUpdate.Caption = "Version Current : " & version '& " - Server " & Commons.Modules.sInfoSer '_NGAY_CAP_NHAT
        Catch ex As Exception
        End Try


        Commons.Modules.DataGridViewCellStyle1.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleCenter
        Commons.Modules.DataGridViewCellStyle1.BackColor = System.Drawing.SystemColors.Control
        Commons.Modules.DataGridViewCellStyle1.Font = New System.Drawing.Font("Tahoma", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Commons.Modules.DataGridViewCellStyle1.ForeColor = System.Drawing.SystemColors.WindowText
        Commons.Modules.DataGridViewCellStyle1.SelectionBackColor = System.Drawing.SystemColors.Highlight
        Commons.Modules.DataGridViewCellStyle1.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Commons.Modules.DataGridViewCellStyle1.WrapMode = System.Windows.Forms.DataGridViewTriState.[True]

        Commons.Modules.DataGridViewCellStyle2.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft
        Commons.Modules.DataGridViewCellStyle2.BackColor = System.Drawing.SystemColors.Window
        Commons.Modules.DataGridViewCellStyle2.Font = New System.Drawing.Font("Tahoma", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Commons.Modules.DataGridViewCellStyle2.ForeColor = System.Drawing.SystemColors.WindowText
        Commons.Modules.DataGridViewCellStyle2.SelectionBackColor = System.Drawing.SystemColors.Highlight
        Commons.Modules.DataGridViewCellStyle2.SelectionForeColor = System.Drawing.SystemColors.HighlightText
        Commons.Modules.DataGridViewCellStyle2.WrapMode = System.Windows.Forms.DataGridViewTriState.[False]

        VietShape.Modules.TypeLanguage = Commons.Modules.TypeLanguage
        VietShape.Modules.UserName = Commons.Modules.UserName
        VietShape.Modules.ConnectionString = Commons.IConnections.ConnectionString
        txtQuickFind.Visible = True


        'Dim st As String = Commons.Modules.ObjSystems.GiaiMaDL(My.Computer.FileSystem.ReadAllText(Application.StartupPath & "/VSConfig.ini").Trim())
        'Try
        '    If System.IO.File.Exists(Application.StartupPath & "/UrlShare.ini") Then
        '        System.IO.File.Delete(Application.StartupPath & "/UrlShare.ini")
        '    End If
        '    Dim foldershare As String = ""
        '    foldershare = SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT TOP 1 DUONG_DAN_TL FROM THONG_TIN_CHUNG")
        '    Dim file As System.IO.StreamWriter
        '    file = My.Computer.FileSystem.OpenTextFileWriter(Application.StartupPath & "/UrlShare.ini", True)
        '    file.WriteLine(foldershare)
        '    file.Close()
        'Catch ex As Exception

        'End Try

    End Sub

    'Hàm show form 
    Public Shared Sub ShowForm(ByVal frmForm As Form, Optional ByVal bDialog As Boolean = False)

        Try
            Try
                For Each frmChild As Form In frmMain.MdiChildren
                    If (frmForm.Name.Trim().Equals(frmChild.Name.Trim())) Then
                        frmChild.Activate()
                        Exit Sub
                    End If
                Next
            Catch ex As Exception
            End Try

            frmMain.Cursor = Cursors.WaitCursor
            If bDialog = True Then
                frmForm.ShowDialog()
            Else
                frmForm.MdiParent = frmMain
                frmForm.WindowState = FormWindowState.Maximized
                frmForm.Show()
            End If

        Catch ex As Exception
            frmMain.Cursor = Cursors.Default
            MessageBox.Show("Load form error" + vbCrLf + ex.Message)
        End Try
        frmMain.Cursor = Cursors.Default
        Try
            Commons.Modules.PermisString = Commons.Modules.ObjGroups.GetNHOM_FORM_QUYEN(Commons.Modules.UserName, frmForm.Name)
        Catch ex As Exception

        End Try

    End Sub
    'Hàm show form new
    Public Shared Sub ShowFormNew(ByVal frmForm As Form, Optional ByVal bDialog As Boolean = False)

        Try
            Try
                For Each frmChild As Form In frmMain.MdiChildren
                    If (frmForm.Name.Trim().Equals(frmChild.Name.Trim())) Then
                        frmChild.Close()
                    End If
                Next
            Catch ex As Exception
            End Try

            frmMain.Cursor = Cursors.WaitCursor
            If bDialog = True Then
                frmForm.ShowDialog()
            Else
                frmForm.MdiParent = frmMain
                frmForm.WindowState = FormWindowState.Maximized
                frmForm.Show()
            End If

        Catch ex As Exception
            frmMain.Cursor = Cursors.Default
            MessageBox.Show("Load form error" + vbCrLf + ex.Message)
        End Try
        frmMain.Cursor = Cursors.Default
        Try
            Commons.Modules.PermisString = Commons.Modules.ObjGroups.GetNHOM_FORM_QUYEN(Commons.Modules.UserName, frmForm.Name)
        Catch ex As Exception

        End Try

    End Sub
    Private Sub XtraTabbedMdiManager_PageAdded(ByVal sender As System.Object, ByVal e As DevExpress.XtraTabbedMdi.MdiTabPageEventArgs) Handles XtraTabbedMdiManager.PageAdded
        PictureEdit1.SendToBack()
    End Sub

    Private Sub XtraTabbedMdiManager_PageRemoved(ByVal sender As System.Object, ByVal e As DevExpress.XtraTabbedMdi.MdiTabPageEventArgs) Handles XtraTabbedMdiManager.PageRemoved
        If XtraTabbedMdiManager.Pages.Count = 0 Then
            PictureEdit1.BringToFront()
        End If
    End Sub

#Region "Safety"
    Public Shared Function ShowHelpSafety() As Boolean
        Try
            Process.Start(Application.StartupPath & "/Help.doc")
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowListAlertMail() As Boolean
        Try
            Dim FrmListAlertMail As New FrmListAlertMail

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmListAlertMail") Then
                ShowForm(FrmListAlertMail)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFormHazardReport() As Boolean
        Try
            Dim frmHazardreport As New FrmHazardReport()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmHazardReport") Then
                ShowForm(frmHazardreport)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFormHazardReportNew(ByVal DocNum As String) As Boolean
        Try
            Dim frmHazardreport As New FrmHazardReport(DocNum)

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmHazardReport") Then
                ShowFormNew(frmHazardreport)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmIncidentAndAccident() As Boolean
        Try
            Dim frmIncidentAndAccident As New FrmIncidentAndAccident()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmIncidentAndAccident") Then
                ShowForm(frmIncidentAndAccident)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmIncidentAndAccidentNew(ByVal DocNum As String) As Boolean
        Try
            Dim frmIncidentAndAccident As New FrmIncidentAndAccident(DocNum)

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmIncidentAndAccident") Then
                ShowFormNew(frmIncidentAndAccident)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmStopCard() As Boolean
        Try
            Dim frmStopCard As New FrmStopCard()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmStopCard") Then
                ShowForm(frmStopCard)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmStopCardNew(ByVal DocNum As String) As Boolean
        Try
            Dim frmStopCard As New FrmStopCard(DocNum)

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmStopCard") Then
                ShowFormNew(frmStopCard)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmInspection() As Boolean
        Try
            Dim frmInspection As New FrmInspection()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmInspection") Then
                ShowForm(frmInspection)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowFrmApprovalAut() As Boolean
        Try
            Dim frm As New FrmPhanQuyenDuyet()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmPhanQuyenDuyet") Then
                ShowForm(frm)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function


    Public Shared Function ShowFrmDanhMucQuanLyRuiRo() As Boolean
        Try
            Dim frmDanhMucQuanLyRuiRo As New FrmDanhMucQuanLyRuiRo()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmDanhMucQuanLyRuiRo") Then
                ShowForm(frmDanhMucQuanLyRuiRo)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowfrmAUDIT() As Boolean
        Try
            Dim frmAUDIT As New FrmAUDIT()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmAUDIT") Then
                ShowForm(frmAUDIT)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function



    Public Shared Function ShowListCongViec() As Boolean
        Try
            Dim frmListCongViec As New FrmListCongViec()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmListCongViec") Then
                ShowForm(frmListCongViec)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowFrmKhuVuc() As Boolean
        Try
            Dim frmFrmKhuVuc As New FrmKhuVuc()
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmKhuVuc") Then
                ShowForm(frmFrmKhuVuc)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowFrmListMoiNguy() As Boolean
        Try
            Dim frmListMoiNguy As New FrmListMoiNguy()
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmListMoiNguy") Then
                ShowForm(frmListMoiNguy)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ShowFrmListNhanVienSafety() As Boolean
        Try
            Dim frmListNhanVienSafety As New FrmListNhanVienSafety()
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmListNhanVienSafety") Then
                ShowForm(frmListNhanVienSafety)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowFrmListDepartment() As Boolean
        Try
            Dim frmListDepartment As New FrmListDepartment()
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmListDepartment") Then
                ShowForm(frmListDepartment)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowFrmListDTTiepXuc() As Boolean
        Try
            Dim frmListDTTiepXuc As New FrmListDTTiepXuc()
            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmListDTTiepXuc") Then
                ShowForm(frmListDTTiepXuc)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowFormLeaderShip() As Boolean
        Try
            Dim frmLeadership As New FrmLeadership()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmLeadership") Then
                ShowForm(frmLeadership)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Public Shared Function ShowFormLeadershipDetails() As Boolean
        Try
            Dim FrmLeadershipDetails As New FrmLeadershipDetails()

            If Commons.Modules.ObjSystems.check_permission(Commons.Modules.UserName, "FrmLeadershipDetails") Then
                ShowForm(FrmLeadershipDetails)
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
#End Region

    Private Sub txtQuickFind_MouseHover(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtQuickFind.MouseHover
        Dim tooltip As New ToolTip
        tooltip.SetToolTip(txtQuickFind, "Quick Find Document - Tìm kiếm nhanh chứng từ")
    End Sub


    Private Sub txtQuickFind_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtQuickFind.KeyDown

        If e.KeyCode = Keys.Enter Then
            If txtQuickFind.TextLength > 0 Then
                If fnCheckDocNum() = True Then
                    Select Case Microsoft.VisualBasic.Left(txtQuickFind.Text, 2)
                        Case "ST"
                            Call ShowFrmStopCardNew(txtQuickFind.Text)
                        Case "HZ"
                            Call ShowFormHazardReportNew(txtQuickFind.Text)
                        Case "IC"
                            Call ShowFrmIncidentAndAccidentNew(txtQuickFind.Text)
                    End Select
                    txtQuickFind.Text = ""
                Else
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGTIMTHAYCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                End If
            End If
        End If
    End Sub
    Private Function fnCheckDocNum()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("DOCNUM", txtQuickFind.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_CHECK_DOC_NUM"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function

    Private Sub txtQuickFind_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtQuickFind.Click
        txtQuickFind.SelectionStart = txtQuickFind.TextLength + 1
    End Sub
    Shared Function DownloadFileVersion()
        Try

            Dim source As String = "\\PMP-ECOMAIN\Data$\Data\Tailieumay\UpdateSafety\Version.txt"
            source = SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT TOP 1 DUONG_DAN_TL FROM THONG_TIN_CHUNG") & "\UpdateSafety\Version.txt"
            If source = "" Then
                source = "\\PMP-ECOMAIN\Data$\Data\Tailieumay\UpdateSafety\Version.txt"
            End If
            'Dim source As String = "\\PMP-ECOMAIN\Data$\Data\Tailieumay\UpdateSafety\Version.txt"
            If Not File.Exists(source) Then
                Return False
            End If
            If Not Directory.Exists(Application.StartupPath & "/UpdateSafety") Then
                Directory.CreateDirectory(Application.StartupPath & "/UpdateSafety")
            End If
            System.IO.File.Copy(source, Application.StartupPath & "/UpdateSafety" & "\Version.txt", True)
            Return True
        Catch ex As Exception
            MsgBox(ex.Message)
            Return False
        End Try
    End Function
    Shared Function CheckUpdateVersion()
        Dim client_vs As String = ""
        Dim server_vs As String = ""
        Dim flag As Boolean = False
        Dim p As String = Application.StartupPath & "/UpdateSafety"
        Dim pth As String() = p.Split("/")
        If System.IO.File.Exists(Application.StartupPath & "/Version.txt") Then
            client_vs = IO.File.ReadAllText(Application.StartupPath & "/Version.txt")
            flag = False
        Else
            flag = True
        End If

        If System.IO.File.Exists(Application.StartupPath & "/" & pth(pth.Length - 1) & "/Version.txt") Then
            server_vs = IO.File.ReadAllText(Application.StartupPath & "/" & pth(pth.Length - 1) & "/Version.txt")

            If flag = True Then
                Return True
            End If
        Else
            Return False
        End If

        If server_vs.Trim() <> client_vs.Trim() Then
            Return True
        Else
            Return False
        End If
    End Function

    Private Sub Timer1_Tick(sender As Object, e As EventArgs) Handles Timer1.Tick
        'If DownloadFileVersion() Then
        '    If CheckUpdateVersion() Then
        '        Timer1.Stop()
        '        If Commons.Modules.TypeLanguage = 0 Then

        '            If XtraMessageBox.Show("Phiên bản hiện tại chưa được cập nhật.Bạn có muốn cập nhật phiên bản mới nhất?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
        '                Try
        '                    If File.Exists(Application.StartupPath & "/TMP_UPDATE/Update.exe") Then
        '                        File.Copy(Application.StartupPath & "/TMP_UPDATE/Update.exe", Application.StartupPath & "/Update.exe", True)
        '                    End If

        '                    'If File.Exists(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll") Then
        '                    '    File.Copy(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll", Application.StartupPath & "/Ionic.Zip.dll", True)
        '                    'End If

        '                    If Directory.Exists(Application.StartupPath & "/TMP_UPDATE") Then
        '                        Try
        '                            If File.Exists(Application.StartupPath & "/TMP_UPDATE/Update.exe") Then
        '                                File.Delete(Application.StartupPath & "/TMP_UPDATE/Update.exe")
        '                            End If

        '                            'If File.Exists(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll") Then
        '                            '    File.Delete(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll")
        '                            'End If
        '                            Directory.Delete(Application.StartupPath & "/TMP_UPDATE")
        '                        Catch ex As Exception

        '                        End Try
        '                    End If

        '                Catch ex As Exception

        '                End Try
        '                Try
        '                    Process.Start(Application.StartupPath & "/Update.exe")

        '                Catch ex As Exception

        '                End Try
        '                Exit Sub

        '            End If

        '        Else
        '            If XtraMessageBox.Show("The current version has not been updated.Do you want to update to the latest version?", "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
        '                Try
        '                    If File.Exists(Application.StartupPath & "/TMP_UPDATE/Update.exe") Then
        '                        File.Copy(Application.StartupPath & "/TMP_UPDATE/Update.exe", Application.StartupPath & "/Update.exe", True)
        '                    End If

        '                    'If File.Exists(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll") Then
        '                    '    File.Copy(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll", Application.StartupPath & "/Ionic.Zip.dll", True)
        '                    'End If

        '                    If Directory.Exists(Application.StartupPath & "/TMP_UPDATE") Then
        '                        Try
        '                            If File.Exists(Application.StartupPath & "/TMP_UPDATE/Update.exe") Then
        '                                File.Delete(Application.StartupPath & "/TMP_UPDATE/Update.exe")
        '                            End If

        '                            'If File.Exists(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll") Then
        '                            '    File.Delete(Application.StartupPath & "/TMP_UPDATE/Ionic.Zip.dll")
        '                            'End If
        '                            Directory.Delete(Application.StartupPath & "/TMP_UPDATE")
        '                        Catch ex As Exception

        '                        End Try
        '                    End If

        '                Catch ex As Exception

        '                End Try
        '                Try
        '                    Process.Start(Application.StartupPath & "/Update.exe")

        '                Catch ex As Exception

        '                End Try
        '                Exit Sub
        '            End If
        '        End If
        '    Else
        '        'If Commons.Modules.TypeLanguage = 0 Then
        '        '    XtraMessageBox.Show("Phiên bản hiện tại đang là phiên bản cuối cùng không có phiên bản mới hơn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information)
        '        'Else
        '        '    XtraMessageBox.Show("The current version is the last version does not have a newer version", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
        '        'End If
        '        Exit Sub
        '    End If
        'Else
        '    'If Commons.Modules.TypeLanguage = 0 Then
        '    '    XtraMessageBox.Show("Phiên bản hiện tại đang là phiên bản cuối cùng không có phiên bản mới hơn", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information)
        '    'Else
        '    '    XtraMessageBox.Show("The current version is the last version does not have a newer version", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
        '    'End If
        '    Exit Sub
        'End If

    End Sub
End Class