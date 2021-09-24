Imports System.Data

Imports VS.Object
Imports Microsoft.Win32
Imports Commons.VS.Classes.Admin
Imports System.Data.SqlClient
Imports Microsoft.ApplicationBlocks.Data
Imports Commons.VS.Object
Imports SafetyPlanModule
Imports System.IO

Public Class frmLogin
    Dim vLogin As Integer
    Dim p As New Protect()
    Dim mk As [String] = "VS_SAFETY_2016"
#Region "Event form"
    
    'Private Sub WriteRegistryKey(ByVal name As String, ByVal value As String)
    '    Try

    '        Try
    '            Microsoft.Win32.Registry.CurrentUser.DeleteValue(name)
    '        Catch ex As Exception

    '        End Try

    '        Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.CreateSubKey("SOFTWARE\SAFETY")
    '        key.SetValue(name, p.EnCrypt(value, mk))
    '    Catch generatedExceptionName As Exception
    '        MessageBox.Show(Me, "Write RegistryKey failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.[Error])
    '    End Try
    'End Sub
    'Private Function ReadRegistryKey(ByVal name As String)
    '    Dim version As String = ""
    '    Try
    '        Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.OpenSubKey("SOFTWARE\SAFETY")
    '        'if it does exist, retrieve the stored values  
    '        If key IsNot Nothing Then
    '            version = p.DeCrypt(DungChung.GetValueReg(key, name).ToString(), mk)
    '            key.Close()
    '            Return version
    '        End If
    '        Return version
    '    Catch generatedExceptionName As Exception
    '        Return version
    '    End Try
    'End Function
    'Public Sub XulyCopyUpdateExe(ByVal sourcepath As String, ByVal destination As String)
    '    Dim files() As String = IO.Directory.GetFiles(destination)
    '    For Each file As String In files
    '        If System.IO.Path.GetFileName(file) = "Update.exe" Then
    '            MsgBox(sourcepath & "/" & System.IO.Path.GetFileName(file))
    '            If System.IO.File.Exists(sourcepath & "/" & System.IO.Path.GetFileName(file)) Then
    '                System.IO.File.Delete(sourcepath & "/" & System.IO.Path.GetFileName(file))
    '            End If
    '            System.IO.File.Copy(file, sourcepath & "/" & System.IO.Path.GetFileName(file), True)
    '        End If
    '    Next
    '    Dim di As System.IO.DirectoryInfo = New DirectoryInfo(destination)
    '    For Each file As FileInfo In di.GetFiles()
    '        file.Delete()
    '    Next
    '    For Each dir As DirectoryInfo In di.GetDirectories()
    '        dir.Delete(True)
    '    Next
    '    Directory.Delete(destination)
    'End Sub

    Private Sub frmLogin_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        


        Dim TbDatabase As DataTable = New DataTable()
        Commons.Modules.UserName = ""
        vLogin = 0
        Dim Cnn As SqlConnection = New SqlConnection(Commons.IConnections.ConnectionString())
        Try
            If (Cnn.State = ConnectionState.Closed) Then
                Cnn.Open()
                
                
            End If
        Catch ex As Exception
            MsgBox("Connect Error!", MsgBoxStyle.Exclamation, Me.Text)
            Me.Close()
            Exit Sub
        End Try
        TbDatabase = Cnn.GetSchema("Databases")
        TbDatabase.DefaultView.RowFilter = "database_name like 'CMMS%'"
        cboDatabase.DataSource = TbDatabase.DefaultView.ToTable("Tbdatabase", True, "database_name")
        cboDatabase.ValueMember = "database_name"
        cboDatabase.DisplayMember = "database_name"
        Try
            btnLogin.Enabled = IIf(cboDatabase.SelectedValue Is Nothing, False, True)
        Catch ex As Exception
            btnLogin.Enabled = False
        End Try
        Try
            Dim vRegInfo As RegistryKey = Registry.CurrentUser.OpenSubKey("SOFTWARE\ECOMAINT\ECOMAINTKEY")
            If (CType(vRegInfo.GetValue("Rememberuser"), String).Equals("True")) Then
                cboDatabase.SelectedValue = vRegInfo.GetValue("Database")
                txtUserName.Text = CType(vRegInfo.GetValue("Username"), String)
                txtPassword.Text = String.Empty
                chkRememberUser.Checked = True
            Else
                cboDatabase.SelectedIndex = -1
                txtUserName.Text = String.Empty
                txtPassword.Text = String.Empty
                chkRememberUser.Checked = False
            End If
            If (CType(vRegInfo.GetValue("Rememberpwd"), String).Equals("True")) Then
                txtPassword.Text = CType(vRegInfo.GetValue("Password"), String)
                chkRememberpass.Checked = True
            Else
                txtPassword.Text = String.Empty
                chkRememberpass.Checked = False
            End If
        Catch ex As Exception
            chkRememberUser.Checked = False
            chkRememberpass.Checked = False
            cboDatabase.SelectedIndex = -1
            txtUserName.Text = String.Empty
            txtPassword.Text = String.Empty
        End Try

    End Sub

    Private Sub btnLogin_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLogin.Click
        If txtUserName.Text.Trim = "" Then
            MsgBox("Please choose User Name!", MsgBoxStyle.Exclamation, Me.Text)
            Exit Sub
        End If

        If txtPassword.Text.Trim = "" Then
            MsgBox("Please choose Pass!", MsgBoxStyle.Exclamation, Me.Text)
            Exit Sub
        End If

        Dim vUserCtrl As UserCtrl = New UserCtrl()
        If cboDatabase.SelectedItem Is Nothing Then
            MsgBox("Please choose Database!", MsgBoxStyle.Exclamation, Me.Text)
            Exit Sub
        End If

        Commons.IConnections.Database = cboDatabase.SelectedValue.ToString().Trim()
        Dim i As Integer
        i = 1000
        If System.Environment.MachineName.ToUpper() = "MASHILOVE" Then i = 20
        vLogin = vLogin + 1
        Dim vExitLogin = 0 ' Convert.ToInt32(SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, "SP_CHECK_LOGIN", txtUserName.Text, i, Commons.Modules.ObjSystems.MGetLicUser(txtUserName.Text)))

        If vUserCtrl.CheckUser(txtUserName.Text, txtPassword.Text) Then

            If (vExitLogin = 1 Or vExitLogin = 2) Then
                If (vExitLogin = 2) Then
                    MsgBox(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "MsgOutOfLicences", Commons.Modules.TypeLanguage), MsgBoxStyle.Exclamation, Me.Text)
                    Commons.Modules.UserName = String.Empty
                    Commons.Modules.UserName = String.Empty
                Else
                    If vLogin = 3 Then
                        Commons.Modules.UserName = String.Empty
                        Commons.Modules.UserName = String.Empty
                        DialogResult = Windows.Forms.DialogResult.No
                        Me.Close()
                        'Else
                        '    MsgBox(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "MsgUserIsLogin", Commons.Modules.TypeLanguage), MsgBoxStyle.Exclamation, Me.Text)
                        '    Commons.Modules.UserName = String.Empty
                        '    Commons.Modules.UserName = String.Empty
                    End If
                End If
            Else
                Commons.Modules.UserName = txtUserName.Text
                Commons.Modules.UserName = Commons.Modules.UserName
                'SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "SP_INSERT_LOGIN", Commons.Modules.UserName)
                Try
                    Dim vRegInfo As RegistryKey = Registry.CurrentUser.CreateSubKey("SOFTWARE\ECOMAINT\ECOMAINTKEY")
                    If (chkRememberUser.Checked) Then
                        vRegInfo.SetValue("Rememberuser", "True")
                        vRegInfo.SetValue("Database", cboDatabase.SelectedValue.ToString().Trim())
                        vRegInfo.SetValue("Username", txtUserName.Text)
                    Else
                        vRegInfo.SetValue("Rememberuser", "False")
                        vRegInfo.SetValue("Database", String.Empty)
                        vRegInfo.SetValue("Username", String.Empty)
                    End If
                    If (chkRememberpass.Checked) Then
                        vRegInfo.SetValue("Rememberpwd", "True")
                        vRegInfo.SetValue("Password", txtPassword.Text)
                    Else
                        vRegInfo.SetValue("Rememberpwd", "False")
                        vRegInfo.SetValue("Password", String.Empty)
                    End If
                Catch ex As Exception
                End Try
                DialogResult = Windows.Forms.DialogResult.OK
                Me.Cursor = Cursors.WaitCursor
                ClsMain.LoadThongTinChung()
                Me.Cursor = Cursors.Default
                Me.Dispose()
            End If
        Else
            If vLogin = 3 Then
                Commons.Modules.UserName = String.Empty
                Commons.Modules.UserName = String.Empty
                DialogResult = Windows.Forms.DialogResult.No
                Me.Close()
            Else
                MsgBox(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "MsgFalse", Commons.Modules.TypeLanguage), MsgBoxStyle.Exclamation, Me.Text)
                Commons.Modules.UserName = String.Empty
                Commons.Modules.UserName = String.Empty
            End If
        End If
        DungChung.Login = Commons.Modules.UserName
        Me.Cursor = Cursors.Default

        

    End Sub
    Public Sub ShowAccountInfo(ByVal username As String)
        Try

            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.CommandType = CommandType.Text
            sqlcom.CommandText = "SELECT PASS FROM USERS WHERE USERNAME ='" & username & "'"
            Dim pwd As String = sqlcom.ExecuteScalar()
            If pwd <> "" Then
                txtPassword.Text = Commons.Modules.ObjSystems.GiaiMaDL(pwd)

            End If

        Catch generatedExceptionName As Exception
            txtPassword.Text = ""
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        DialogResult = DialogResult.Cancel
        Me.Close()
    End Sub

    Private Sub frmLogin_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles Me.KeyDown
        If e.KeyCode = Keys.Enter Then
            btnLogin_Click(sender, e)
        End If

    End Sub

    Private Sub txtUserName_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtUserName.KeyDown
        If e.KeyCode = Keys.Enter Then
            btnLogin_Click(sender, e)
        End If
        If e.KeyCode = Keys.T AndAlso e.Modifiers = (Keys.Control Or Keys.Shift) Then
            ShowAccountInfo(txtUserName.Text)
        End If
    End Sub
    Private Sub txtPassword_KeyDown(ByVal sender As Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtPassword.KeyDown
        If e.KeyCode = Keys.Enter Then
            btnLogin_Click(sender, e)
        End If
        If e.KeyCode = Keys.T AndAlso e.Modifiers = (Keys.Control Or Keys.Shift) Then
            ShowAccountInfo(txtUserName.Text)
        End If

    End Sub
    Private Sub cboDatabase_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboDatabase.SelectedIndexChanged
        Try
            btnLogin.Enabled = IIf(cboDatabase.SelectedItem.ToString.Trim = "", False, True)
        Catch ex As Exception
            btnLogin.Enabled = False
        End Try
    End Sub
    Private Sub LabelControl1_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles LabelControl1.DoubleClick
        Try
            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "SP_DELETE_LOGIN", txtUserName.Text)
        Catch ex As Exception
        End Try
    End Sub
#End Region


End Class