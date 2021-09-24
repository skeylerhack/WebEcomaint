using Microsoft.VisualBasic;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Diagnostics;
using System.Net;
using System.Net.Mail;

public class TMail
{
    public string _Host;
    public int _Port;
    public string _MailDisplay;
    public string _MailFromUser;
    public string _MailFromPassword;
    public bool _OPENSSL;
    public string Host
    {
        get { return _Host; }
        set { _Host = value; }
    }
    public int Port
    {
        get { return _Port; }
        set { _Port = value; }
    }
    public string MailDisplay
    {
        get { return _MailDisplay; }
        set { _MailDisplay = value; }
    }
    public string MailFromUser
    {
        get { return _MailFromUser; }
        set { _MailFromUser = value; }
    }
    public string MailFromPassword
    {
        get { return _MailFromPassword; }
        set { _MailFromPassword = value; }
    }
    public bool OpenSSL
    {
        get { return _OPENSSL; }
        set { _OPENSSL = value; }
    }
    public TMail()
    {
        _Host = "";
        _Port = 25;
        _MailDisplay = "";
        _MailFromUser = "";
        _MailFromPassword = "";
    }
    public TMail(string Host, int Port, string MailDisplay, string MailFromUser, string MailFromPassword, bool OpenSSL)
    {
        _Host = Host;
        _Port = Port;
        _MailDisplay = MailDisplay;
        _MailFromUser = MailFromUser;
        _MailFromPassword = MailFromPassword;
        if (Host == "smtp.gmail.com")
            _OPENSSL = true;
        else                   
            _OPENSSL = OpenSSL;
    }

    public string SendMail(string To, string Subject, string Body, string BCC = "", string CC = "", string Attachment = "")
    {
        try
        {
            if (To == "") return "MailTo is empty!";
            SmtpClient smtpclient = new SmtpClient(_Host, _Port);

            smtpclient.EnableSsl = _OPENSSL;

            MailAddress From = new MailAddress(_MailFromUser, _MailDisplay);
            MailMessage Mail = new MailMessage();
            Mail.From = From;

            if (To.Length > 0)
            {
                if (To.Contains(";"))
                {
                    foreach (string _to in To.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries))
                    {
                        Mail.To.Add(_to);
                    }
                }
                else
                {
                    Mail.To.Add(To);
                }
            }

            if (BCC.Length > 0)
            {
                if (BCC.Contains(";"))
                {
                    foreach (string _BCC in BCC.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries))
                    {
                        Mail.Bcc.Add(_BCC);
                    }
                }
                else
                {
                    Mail.Bcc.Add(BCC);
                }
            }


            if (CC.Length > 0)
            {
                if (CC.Contains(";"))
                {
                    foreach (string _CC in CC.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries))
                    {
                        Mail.CC.Add(_CC);
                    }
                }
                else
                {
                    Mail.CC.Add(CC);
                }
            }

            if (Attachment.Length > 0)
            {
                if (Attachment.Contains(";"))
                {
                    foreach (string _Attachment in Attachment.Split(new char[] { ';' }, StringSplitOptions.RemoveEmptyEntries))
                    {
                        Attachment atm = new Attachment(_Attachment);
                        Mail.Attachments.Add(atm);
                    }
                }
                else
                {
                    Attachment atm = new Attachment(Attachment);
                    Mail.Attachments.Add(atm);
                }
            }

            Mail.IsBodyHtml = true;
            Mail.BodyEncoding = System.Text.Encoding.UTF8;
            Mail.SubjectEncoding = System.Text.Encoding.UTF8;
            Mail.Priority = MailPriority.High;
            Mail.Subject = Subject;
            Mail.Body = Body;
            



            System.Net.NetworkCredential credentials = new System.Net.NetworkCredential();
            credentials.UserName = _MailFromUser;
            credentials.Password = _MailFromPassword;
            smtpclient.Credentials = credentials;
            //smtpclient.UseDefaultCredentials = True


            try
            {
                smtpclient.Send(Mail);
               
                return "";

            }
            catch (Exception ex)
            {
                return ex.Message;
            }

        }
        catch
        {
            return  To +" is not valid email address!";
        }
    }
}
