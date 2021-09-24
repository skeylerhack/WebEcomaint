Imports System.Net
Imports System.Net.Mail

Public Class TMail
    Public _Host As String
    Public _Port As String
    Public _MailDisplay As String
    Public _MailFromUser As String
    Public _MailFromPassword As String
    Public _OPENSSL As Boolean
    Public Property Host() As String
        Get
            Return _Host
        End Get
        Set(ByVal value As String)
            _Host = value
        End Set
    End Property
    Public Property Port() As String
        Get
            Return _Port
        End Get
        Set(ByVal value As String)
            _Port = value
        End Set
    End Property
    Public Property MailDisplay() As String
        Get
            Return _MailDisplay
        End Get
        Set(ByVal value As String)
            _MailDisplay = value
        End Set
    End Property
    Public Property MailFromUser() As String
        Get
            Return _MailFromUser
        End Get
        Set(ByVal value As String)
            _MailFromUser = value
        End Set
    End Property
    Public Property MailFromPassword() As String
        Get
            Return _MailFromPassword
        End Get
        Set(ByVal value As String)
            _MailFromPassword = value
        End Set
    End Property
    Public Property OpenSSL() As Boolean
        Get
            Return _OPENSSL
        End Get
        Set(ByVal value As Boolean)
            _OPENSSL = value
        End Set
    End Property
    Public Sub New()
        _Host = ""
        _Port = ""
        _MailDisplay = ""
        _MailFromUser = ""
        _MailFromPassword = ""
    End Sub
    Public Sub New(Host As String, Port As String, MailDisplay As String, MailFromUser As String, MailFromPassword As String, ByVal OpenSSL As Boolean)
        _Host = Host
        _Port = Port
        _MailDisplay = MailDisplay
        _MailFromUser = MailFromUser
        _MailFromPassword = MailFromPassword
        If Host = "smtp.gmail.com" Then
            _OPENSSL = True
        Else
            _OPENSSL = OpenSSL
        End If

        'Commons.Modules.ObjSystems.GiaiMaDL("͈ΆΨΖΆ̨̦̪")
    End Sub
    Public Function SendMail(ByVal [To] As String, ByVal Subject As String, ByVal Body As String, Optional BCC As String = "", Optional CC As String = "", Optional Attachment As String = "", Optional ByRef prbBar As DevExpress.XtraEditors.ProgressBarControl = Nothing)
        Dim iViTri As Integer
        iViTri = prbBar.Position + 10

        Dim smtpclient As New SmtpClient(_Host, _Port)


        smtpclient.EnableSsl = _OPENSSL

        Dim From As New MailAddress(_MailFromUser, _MailDisplay)
        Dim Mail As New MailMessage()
        Mail.From = From
        prbBar.PerformStep()
        prbBar.Update()
        If [To].Length > 0 Then
            If [To].Contains(";") Then
                For Each _to As String In [To].Split(New Char() {";"}, StringSplitOptions.RemoveEmptyEntries)
                    Mail.To.Add(_to)
                Next
            Else
                Mail.To.Add([To])
            End If
        End If
        prbBar.PerformStep()
        prbBar.Update()
        If BCC.Length > 0 Then
            If BCC.Contains(";") Then
                For Each _BCC As String In BCC.Split(New Char() {";"}, StringSplitOptions.RemoveEmptyEntries)

                    Mail.Bcc.Add(_BCC)
                Next
            Else
                Mail.Bcc.Add(BCC)
            End If
        End If

        prbBar.PerformStep()
        prbBar.Update()
        If CC.Length > 0 Then
            If CC.Contains(";") Then
                For Each _CC As String In CC.Split(New Char() {";"}, StringSplitOptions.RemoveEmptyEntries)
                    Mail.CC.Add(_CC)
                Next
            Else
                Mail.CC.Add(CC)
            End If
        End If
        prbBar.PerformStep()
        prbBar.Update()
        If Attachment.Length > 0 Then
            If Attachment.Contains(";") Then
                For Each _Attachment As String In Attachment.Split(New Char() {";"}, StringSplitOptions.RemoveEmptyEntries)
                    Dim atm As New Attachment(_Attachment)
                    Mail.Attachments.Add(atm)
                Next
            Else
                Dim atm As New Attachment(Attachment)
                Mail.Attachments.Add(atm)
            End If
        End If

        Mail.IsBodyHtml = True
        Mail.BodyEncoding = System.Text.Encoding.UTF8
        Mail.SubjectEncoding = System.Text.Encoding.UTF8
        Mail.Priority = MailPriority.High
        Mail.Subject = Subject
        Mail.Body = Body




        Dim credentials As New System.Net.NetworkCredential()
        credentials.UserName = _MailFromUser
        credentials.Password = _MailFromPassword
        smtpclient.Credentials = credentials
        'smtpclient.UseDefaultCredentials = True
        prbBar.PerformStep()
        prbBar.Update()
        Try

            smtpclient.Send(Mail)
            prbBar.PerformStep()
            prbBar.Update()

            prbBar.Position = iViTri
            Return ""
        Catch ex As Exception
            prbBar.Position = iViTri
            Return ex.Message()
        End Try
    End Function
    Public Function SendMail(ByVal [To] As String, ByVal Subject As String, ByVal Body As String, Optional BCC As String = "", Optional CC As String = "", Optional Attachment As String = "")

        Dim smtpclient As New SmtpClient(_Host, _Port)

        smtpclient.EnableSsl = _OPENSSL

        Dim From As New MailAddress(_MailFromUser, _MailDisplay)
        Dim Mail As New MailMessage()
        Mail.From = From

        If [To].Length > 0 Then
            If [To].Contains(";") Then
                For Each _to As String In [To].Split(New Char() {";"}, StringSplitOptions.RemoveEmptyEntries)
                    Mail.To.Add(_to)
                Next
            Else
                Mail.To.Add([To])
            End If
        End If

        If BCC.Length > 0 Then
            If BCC.Contains(";") Then
                For Each _BCC As String In BCC.Split(New Char() {";"}, StringSplitOptions.RemoveEmptyEntries)
                    Mail.Bcc.Add(_BCC)
                Next
            Else
                Mail.Bcc.Add(BCC)
            End If
        End If


        If CC.Length > 0 Then
            If CC.Contains(";") Then
                For Each _CC As String In CC.Split(New Char() {";"}, StringSplitOptions.RemoveEmptyEntries)
                    Mail.CC.Add(_CC)
                Next
            Else
                Mail.CC.Add(CC)
            End If
        End If

        If Attachment.Length > 0 Then
            If Attachment.Contains(";") Then
                For Each _Attachment As String In Attachment.Split(New Char() {";"}, StringSplitOptions.RemoveEmptyEntries)
                    Dim atm As New Attachment(_Attachment)
                    Mail.Attachments.Add(atm)
                Next
            Else
                Dim atm As New Attachment(Attachment)
                Mail.Attachments.Add(atm)
            End If
        End If

        Mail.IsBodyHtml = True
        Mail.BodyEncoding = System.Text.Encoding.UTF8
        Mail.SubjectEncoding = System.Text.Encoding.UTF8
        Mail.Priority = MailPriority.High
        Mail.Subject = Subject
        Mail.Body = Body




        Dim credentials As New System.Net.NetworkCredential()
        credentials.UserName = _MailFromUser
        credentials.Password = _MailFromPassword
        smtpclient.Credentials = credentials
        'smtpclient.UseDefaultCredentials = True

        Try

            smtpclient.Send(Mail)

            Return ""
        Catch ex As Exception

            Return ex.Message()
        End Try
    End Function
End Class
