Imports DevExpress.XtraEditors
Imports System.Data.SqlClient
'Imports Microsoft.Office

Public Class FrmXNGuiMail
    Private _mailto As String = ""
    Private _subject As String = ""
    Private _body As String = ""
    Private _subjectEng As String = ""
    Private _bodyEng As String = ""
    Private _XoaBC As Boolean = False
    Public Shared TT As Boolean = False

    Private _reportVN As String = ""
    Private _reportEng As String = ""
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal mailto As String, ByVal subject As String, ByVal body As String, Optional subjectEng As String = "", Optional bodyEng As String = "", Optional reportVN As String = "", Optional reportEng As String = "")

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _mailto = mailto
        _subject = subject
        _body = body
        _subjectEng = subjectEng
        _bodyEng = bodyEng
        _reportVN = reportVN
        _reportEng = reportEng
        txtEmailTo.Text = _mailto
        txtEmailTo.SelectionStart = txtEmailTo.TextLength + 1
    End Sub
    Public Sub New(ByVal mailto As String, ByVal subject As String, ByVal body As String, ByVal XoaBC As Boolean, Optional subjectEng As String = "", Optional bodyEng As String = "")

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _mailto = mailto
        _subject = subject
        _body = body
        txtEmailTo.Text = _mailto
        txtEmailTo.SelectionStart = txtEmailTo.TextLength + 1
        _XoaBC = XoaBC
        _subjectEng = subjectEng
        _bodyEng = bodyEng
    End Sub
    Private Sub FrmXNGuiMail_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        LoadCheckComboList()
        Me.AcceptButton = btnThucHien
        If _XoaBC = True Then
            lbLydo.Visible = True
            txtLydo.Visible = True
        Else
            lbLydo.Visible = False
            txtLydo.Visible = False
        End If
        btnTKNG.Text = "+"
    End Sub
    Public Function GetListInfoNBC()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_MAIL")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_FIND"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Return ds.Tables(0)

        Catch generatedExceptionName As Exception
            Return New DataTable()
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Private Sub GetCheckValue()
        Try
            'txtEmailCC.Visible = False
            Dim sl As String = ""
            For ct As Integer = 0 To CheckedComboBoxEdit1.Properties.Items.Count - 1
                Dim it As DevExpress.XtraEditors.Controls.CheckedListBoxItem = CheckedComboBoxEdit1.Properties.Items(ct)
                If it.CheckState = CheckState.Checked Then
                    sl = IIf(sl.Length = 0, it.Value, sl & ";" & it.Value)
                    'txtEmailCC.Visible = True
                    txtEmailCC.Focus()
                End If
            Next
            txtEmailCC.Text = sl
            txtEmailCC.SelectionStart = txtEmailCC.TextLength + 1
        Catch ex As Exception

        End Try

    End Sub
    Private Sub btnThucHien_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnThucHien.Click
        'Gui mail
        Try
            Dim mail As New TMail(Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort, "Phần mềm Báo cáo AT", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, Commons.Modules.bSSL)
            ''''Dim mail As New TMail("xxxxxxxxxxx", "xxxxxx", "Phần mềm Báo cáo AT", "xxxxxxxxxxxx", "xxxxxxxxxxx", False)
            If _XoaBC = True Then
                If txtLydo.Text = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmXNGuiMail", "PHAINHAPLYDOXOA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Exit Sub
                End If
                _body = _body.Replace("@LYDO@", txtLydo.Text)
                _bodyEng = _bodyEng.Replace("@LYDO@", txtLydo.Text)
            End If
            Try
                _body = _body.Replace("@TVT_REPORT_VN@", _reportVN)
                _bodyEng = _bodyEng.Replace("@TVT_REPORT_ENG@", _reportEng)
            Catch ex As Exception

            End Try



            ProgressBarControl1.Text = 10
            Dim stmp As String = ""

            ''''txtEmailTo.Text = "xxxxxxxxxxxx"
            ''''txtEmailCC.Text = ""
            ''''txtLstmailHSE.Text = ""
            ''''Dim _cc As String = "xxxxxx;xxxxx;xxxxx"
            ''''Dim attachment As String = "xxxxx;xxxxx"

            If txtEmailCC.Text.Length > 0 Or txtLstmailHSE.Text.Length > 0 Then
                Dim cc As String = ""
                If txtEmailCC.Text.Length > 0 Then
                    cc = txtEmailCC.Text & ";" & txtLstmailHSE.Text
                Else
                    cc = txtLstmailHSE.Text
                End If
                cc = GetListMailCC(cc)




                If cc.ToLower().Contains("paulo.hladchuk@bariaserece.com") Or txtEmailTo.Text.ToLower().Contains("paulo.hladchuk@bariaserece.com") Then
                    'stmp = Commons.Modules.MMail.MSendEmail(txtEmailTo.Text, cc, Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, _subjectEng, _bodyEng, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort, ProgressBarControl1)
                    stmp = mail.SendMail(txtEmailTo.Text, _subjectEng, _bodyEng,, cc,, ProgressBarControl1)



                Else
                    'stmp = Commons.Modules.MMail.MSendEmail(txtEmailTo.Text, cc, Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, _subject, _body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort, ProgressBarControl1)
                    stmp = mail.SendMail(txtEmailTo.Text, _subject, _body,, cc,, ProgressBarControl1)
                End If

            Else

                If txtEmailTo.Text.ToLower().Contains("paulo.hladchuk@bariaserece.com") Then
                    'stmp = Commons.Modules.MMail.MSendEmail(txtEmailTo.Text, Commons.Modules.sMailFrom.ToString(), Commons.Modules.sMailFromPass, _subjectEng, _bodyEng, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort, ProgressBarControl1)

                    stmp = mail.SendMail(txtEmailTo.Text, _subjectEng, _bodyEng,,,, ProgressBarControl1)
                Else
                    'stmp = Commons.Modules.MMail.MSendEmail(txtEmailTo.Text, Commons.Modules.sMailFrom.ToString(), Commons.Modules.sMailFromPass, _subject, _body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort, ProgressBarControl1)
                    stmp = mail.SendMail(txtEmailTo.Text, _subject, _body,,,, ProgressBarControl1)
                End If
            End If
            If stmp <> "" Then
                XtraMessageBox.Show(stmp, "", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            End If
        Catch ex As Exception

        End Try
        Me.Close()
    End Sub

    Private Sub txtEmailCC_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs)
        If e.KeyValue = Keys.Enter Then
            Try
                ProgressBarControl1.Text = 10
                Dim stmp As String = ""
                If txtEmailCC.Text.Length > 0 Then
                    stmp = Commons.Modules.MMail.MSendEmail(txtEmailTo.Text, txtEmailCC.Text, Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, _subject, _body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort, ProgressBarControl1)
                Else
                    stmp = Commons.Modules.MMail.MSendEmail(txtEmailTo.Text, Commons.Modules.sMailFrom.ToString(), Commons.Modules.sMailFromPass, _subject, _body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort, ProgressBarControl1)
                End If
                If stmp <> "" Then
                    XtraMessageBox.Show(stmp, "", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                End If
            Catch ex As Exception

            End Try
            Me.Close()
        End If
    End Sub

    Private Sub btnHuy_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XACNHANHUYGUIMAIL", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            Me.Close()
        End If
    End Sub


    Private Sub CheckedComboBoxEdit1_Closed(ByVal sender As System.Object, ByVal e As DevExpress.XtraEditors.Controls.ClosedEventArgs) Handles CheckedComboBoxEdit1.Closed
        GetCheckValue()
    End Sub
    Public Sub LoadCheckComboList()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_MAIL"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                CheckedComboBoxEdit1.Properties.Items.Clear()

                For ct As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    Dim it As New DevExpress.XtraEditors.Controls.CheckedListBoxItem
                    it.Description = ds.Tables(0).Rows(ct)(0).ToString()
                    it.Value = ds.Tables(0).Rows(ct)(1).ToString()
                    it.CheckState = CheckState.Unchecked
                    CheckedComboBoxEdit1.Properties.Items.Add(it)
                Next
            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Private Sub btnTKNG_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTKNG.Click
        Dim frm As New FrmFind(GetListInfoNBC())
        frm.Width = txtEmailCC.Width + 8
        Dim p As New Point(Me.Location.X + 75, Me.Location.Y + 97)
        frm.Location = p
        frm.ShowDialog()
        SetCheckValue(frm._name)
    End Sub
    Private Sub SetCheckValue(ByVal id As String)
        Try
            Dim sl As String = ""
            For ct As Integer = 0 To CheckedComboBoxEdit1.Properties.Items.Count - 1
                Dim it As DevExpress.XtraEditors.Controls.CheckedListBoxItem = CheckedComboBoxEdit1.Properties.Items(ct)
                If it.Description = id Then
                    CheckedComboBoxEdit1.Properties.Items(ct).CheckState = CheckState.Checked
                    sl = IIf(sl.Length = 0, it.Value, sl & ";" & it.Value)
                End If

            Next
            GetCheckValue()
        Catch ex As Exception

        End Try

    End Sub
    Private Function GetListMailCC(ByVal lstEmail As String)
        Dim s() As String = lstEmail.Split(";")
        Dim cl As New Collection
        Dim lst As String = ""
        For i As Integer = 0 To s.Length - 1
            If cl.Contains(s(i)) = False Then
                cl.Add(New String() {s(i).ToString()}, s(i).ToString())
            End If
        Next
        For i As Integer = 1 To cl.Count
            If lst.Length = 0 Then
                lst = cl(i)(0).ToString()
            Else
                lst = lst & ";" & cl(i)(0).ToString()
            End If
        Next
        Return lst
    End Function

    'Private Sub btnPreviewMail_Click(sender As Object, e As EventArgs) Handles btnPreviewMail.Click
    '    Try
    '        Dim body As String = _body
    '        Dim bodyEng As String = _bodyEng
    '        If _XoaBC = True Then

    '            body = body.Replace("@LYDO@", txtLydo.Text)
    '            bodyEng = bodyEng.Replace("@LYDO@", txtLydo.Text)
    '        End If
    '        Try
    '            body = body.Replace("@TVT_REPORT_VN@", _reportVN)
    '            bodyEng = bodyEng.Replace("@TVT_REPORT_ENG@", _reportEng)
    '        Catch ex As Exception

    '        End Try

    '        Dim stmp As String = ""
    '        Dim cc As String = ""
    '        If txtEmailCC.Text.Length > 0 Or txtLstmailHSE.Text.Length > 0 Then

    '            If txtEmailCC.Text.Length > 0 Then
    '                cc = txtEmailCC.Text & ";" & txtLstmailHSE.Text
    '            Else
    '                cc = txtLstmailHSE.Text
    '            End If
    '            cc = GetListMailCC(cc)
    '            If cc.ToLower().Contains("paulo.hladchuk@bariaserece.com") Or txtEmailTo.Text.ToLower().Contains("paulo.hladchuk@bariaserece.com") Then
    '                setEmailSend(_subjectEng, bodyEng, _mailto, cc, "", "")
    '            Else
    '                setEmailSend(_subject, body, _mailto, cc, "", "")
    '            End If

    '        Else
    '            If txtEmailTo.Text.ToLower().Contains("paulo.hladchuk@bariaserece.com") Then
    '                setEmailSend(_subjectEng, bodyEng, _mailto, cc, "", "")
    '            Else
    '                setEmailSend(_subject, body, _mailto, cc, "", "")
    '            End If
    '        End If

    '    Catch ex As Exception

    '    End Try
    'End Sub
    'Private Sub setEmailSend(sSubject As String, sBody As String,
    '                         sTo As String, sCC As String,
    '                         sFilename As String, sDisplayname As String)



    '    Dim oApp As Interop.Outlook._Application
    '    oApp = New Interop.Outlook.Application

    '    Dim nSpace As Interop.Outlook.NameSpace = Nothing
    '    Dim targetFolder As Interop.Outlook.MAPIFolder = Nothing
    '    Dim folderItems As Interop.Outlook.Items = Nothing
    '    Dim mail As Interop.Outlook.MailItem = Nothing
    '    Dim movedMail As Interop.Outlook.MailItem = Nothing

    '    Dim strS As String = sFilename
    '    Dim strN As String = sDisplayname

    '    Try
    '        nSpace = oApp.GetNamespace("MAPI")
    '        targetFolder = nSpace.GetDefaultFolder(Interop.Outlook.OlDefaultFolders.olFolderDrafts)
    '        folderItems = targetFolder.Items
    '        mail = folderItems.Add(Interop.Outlook.OlItemType.olMailItem)

    '        mail.Subject = sSubject
    '        mail.HTMLBody = "<html> <body> " & sBody.Replace("<br>", "</p>") & " </body> </html>"

    '        mail.To = sTo
    '        If sCC <> "" Then
    '            mail.CC = sCC
    '        End If


    '        If sFilename <> "" Then
    '            Dim sBodyLen As Integer = Int(sBody.Length)
    '            Dim oAttachs As Interop.Outlook.Attachments = mail.Attachments
    '            Dim oAttach As Interop.Outlook.Attachment

    '            oAttach = oAttachs.Add(strS, , sBodyLen, strN)

    '        End If

    '        '' move the item to Inbox and then save it there 
    '        'movedMail = mail.Move(targetFolder)
    '        'movedMail.Save()
    '        'movedMail.Display(True)
    '        mail.Display(True)


    '    Catch ex As Exception
    '        System.Windows.Forms.MessageBox.Show(ex.Message)
    '    Finally
    '        If Not IsNothing(movedMail) Then Runtime.InteropServices.Marshal.ReleaseComObject(movedMail)
    '        If Not IsNothing(mail) Then Runtime.InteropServices.Marshal.ReleaseComObject(mail)
    '        If Not IsNothing(folderItems) Then Runtime.InteropServices.Marshal.ReleaseComObject(folderItems)
    '        If Not IsNothing(targetFolder) Then Runtime.InteropServices.Marshal.ReleaseComObject(targetFolder)
    '        If Not IsNothing(nSpace) Then Runtime.InteropServices.Marshal.ReleaseComObject(nSpace)
    '    End Try

    'End Sub
End Class