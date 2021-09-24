using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Net;
using Microsoft.Win32;
using System.Text.RegularExpressions;
using System.Net.Mail;
using Microsoft.ApplicationBlocks.Data;
using System.Net.Sockets;
using System.IO;
using System.Security.AccessControl;

namespace VSMail
{
    public partial class frmCMMSMailServer : Form
    {

        private string TenBC;
        Boolean Mashj = false;
        Boolean MRunApp = false;
        DateTime NgayGioHT;
        TMail mail ;
        public frmCMMSMailServer()
        {
            InitializeComponent();
        }
        
        private void btnStartSV_Click(object sender, EventArgs e)
        {
            if (!KiemDuLieu()) return;
            if (DialogResult.No == MessageBox.Show("Are you sure Email suscess sent form : " + txtMail.Text, "", MessageBoxButtons.YesNo)) return;
            StartSV();
        }

        private void StartSV()
        {
            btnStartSV.Enabled = false;
            txtMail.ReadOnly = true;
            txtSmtp.ReadOnly = true;
            txtPort.ReadOnly = true;
            txtPass.ReadOnly = true;
            txtRePass.ReadOnly = true;

            btnTest.Enabled = false;
            
            startToolStripMenuItem.Enabled = false;
            exitToolStripMenuItem.Enabled = false;

            timer1.Enabled = true;
            mail = new TMail(Commons.Modules.sMailFromSmtp, Int32.Parse(Commons.Modules.sMailFromPort), "Phần mềm Báo cáo AT", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, Commons.Modules.bSSL);
        }

        private void btnStop_Click(object sender, EventArgs e)
        {
            btnStartSV.Enabled = true;
            startToolStripMenuItem.Enabled = true;
            exitToolStripMenuItem.Enabled = true;
            txtMail.ReadOnly= false;
            txtSmtp.ReadOnly = false;
            txtPort.ReadOnly = false;
            txtPass.ReadOnly = false;
            txtRePass.ReadOnly = false;

            btnTest.Enabled = true;
            timer1.Enabled = false;
        }

        private void notifyIcon1_DoubleClick(object sender, EventArgs e)
        {
            Show();
            WindowState = FormWindowState.Normal;
        }

        private void Form1_Load(object sender, EventArgs e)
        {

            //Commons.IConnections.Server = "TRAITV";
            //Commons.IConnections.Database = "CMMS_BARIA";
            //Commons.IConnections.Username = "sa";
            //Commons.IConnections.Password = "123";

            try
            {
                DataTable dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, " SELECT TOP 1 *  FROM THONG_TIN_CHUNG"));
                try
                {
                    Commons.Modules.iLoaiGoiMail = int.Parse(dtTmp.Rows[0]["LOAI_GOI_MAIL"].ToString());
                    Commons.Modules.sPrivate = dtTmp.Rows[0]["PRIVATE"].ToString();
                }
                catch
                {
                    Commons.Modules.iLoaiGoiMail = 1;
                    Commons.Modules.sPrivate = "VIETSOFT";
                }

                try
                { Commons.Modules.sMailFrom = dtTmp.Rows[0]["MAIL_FROM"].ToString(); }
                catch
                { Commons.Modules.sMailFrom = ""; }
                try
                { Commons.Modules.sMailFromPass =  Commons.Modules.ObjSystems.GiaiMaDL( dtTmp.Rows[0]["PASS_MAIL"].ToString()); }
                catch
                { Commons.Modules.sMailFromPass = ""; }
                try
                { Commons.Modules.sMailFromSmtp = dtTmp.Rows[0]["SMTP_MAIL"].ToString(); }
                catch
                { Commons.Modules.sMailFromSmtp = ""; }
                try
                { Commons.Modules.sMailFromPort = dtTmp.Rows[0]["PORT_MAIL"].ToString(); }
                catch
                { Commons.Modules.sMailFromPort = ""; }

                try
                {
                    if (Boolean.Parse(dtTmp.Rows[0]["SSL_MAIL"].ToString()))
                        chkSSL.Checked = true;
                    else
                        chkSSL.Checked = false;
                }
                catch
                { Commons.Modules.sMailFromPort = ""; }

                try
                { Commons.Modules.sPrivate = dtTmp.Rows[0]["PRIVATE"].ToString(); }
                catch
                { Commons.Modules.sPrivate = "VIETSOFT"; }


                Hide();
                try
                {
                    if (!Commons.Modules.sMailFrom.Equals(""))
                    {
                        txtMail.Text = Commons.Modules.sMailFrom;
                    }
                    if (!Commons.Modules.sMailFromSmtp.Equals(""))
                    {
                        txtSmtp.Text = Commons.Modules.sMailFromSmtp;
                    }

                    if (!Commons.Modules.sMailFromPort.Equals(""))
                    {
                        txtPort.Text = Commons.Modules.sMailFromPort;
                    }

                    if (!Commons.Modules.sMailFromPass.Equals(""))
                    {
                        txtPass.Text = Commons.Modules.sMailFromPass;
                        txtRePass.Text = txtPass.Text;
                    }
                    try
                    {


                        string user = Environment.UserDomainName + "\\" + Environment.UserName;
                        RegistrySecurity rs = new RegistrySecurity();
                        rs.AddAccessRule(new RegistryAccessRule(user,
                            RegistryRights.WriteKey | RegistryRights.ChangePermissions,
                            InheritanceFlags.None, PropagationFlags.None, AccessControlType.Deny));

                        RegistryKey rk = null;
                        rk = Registry.CurrentUser.CreateSubKey(@"SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
                                                       RegistryKeyPermissionCheck.Default, rs);
                        Commons.Modules.SQLString = "0load";
                        if (rk.GetValue("CMMSMailServer") == null)
                        {
                            checkBox1.Checked = false;
                        }
                        else
                        {
                            checkBox1.Checked = true;
                        }
                        rk.Close();
                        Commons.Modules.SQLString = "";
                    }
                    catch (Exception ex)
                    {
                        MessageBox.Show(ex.Message);
                    }




                    if (checkBox1.Checked) StartSV();
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
            Commons.Modules.SQLString = "";
            mail = new TMail(Commons.Modules.sMailFromSmtp, Int32.Parse(Commons.Modules.sMailFromPort), "Phần mềm Báo cáo AT", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, Commons.Modules.bSSL);

        }

        private void openToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Show();
            WindowState = FormWindowState.Normal;
        }

        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            if (Commons.Modules.SQLString == "0load" ) return;
            try
            {
                string user = Environment.UserDomainName + "\\" + Environment.UserName;

                RegistrySecurity rs = new RegistrySecurity();

                rs.AddAccessRule(new RegistryAccessRule(user,
                    RegistryRights.WriteKey | RegistryRights.ChangePermissions,
                    InheritanceFlags.None, PropagationFlags.None, AccessControlType.Deny));

                RegistryKey rk = null;
                rk = Registry.CurrentUser.CreateSubKey(@"SOFTWARE\Microsoft\Windows\CurrentVersion\Run",
                                               RegistryKeyPermissionCheck.Default, rs);
                
                if (checkBox1.Checked)
                {

                    rk.SetValue("CMMSMailServer", Application.ExecutablePath);
                }
                else
                {
                    rk.DeleteValue("CMMSMailServer", false);
                }
                rk.Close();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }
        }

        private void exitToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Mashj = true;
            try
            {
                this.Close();
            }
            catch { }
            this.Close();
        }

        private void Form1_FormClosing(object sender, FormClosingEventArgs e)
        {
            if (!Mashj)
            {
                e.Cancel = true;
                Hide();
            }
        }

        private void btnTest_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(txtMail.Text.ToString()))
            {
                MessageBox.Show("Please choise mail.");
                return;
            }

            if (string.IsNullOrEmpty(txtSmtp.Text.ToString()))
            {
                MessageBox.Show("Please input SMTP Server.");
                return;
            }
            if (string.IsNullOrEmpty(txtPort.Text.ToString()))
            {
                MessageBox.Show("Please input Port Server.");
                return;
            }
            if (txtPass.Text != txtRePass.Text)
            {
                MessageBox.Show("The passwords do not match, try again.");
                return;
            }

            if (!MInternet.IsConnectedToInternet())
            {
                MessageBox.Show("Please connect internet.");
                return;
            }
            
            string mailTo;
            mailTo = Microsoft.VisualBasic.Interaction.InputBox("Please input mail to :", "Mail To", " ", 500, 300);
            mailTo = mailTo.Trim();
            if (mailTo == "") return;

            if (!isEmail(mailTo))
            {
                MessageBox.Show("Invalid e-mail.");
                return;
            }

            string s = MSendEmail(mailTo, "", "", txtMail.Text, "Test Mail", "Test Mail", "");
            if (s== "")
            {
                if (CapNhapMailCSDL())
                    MessageBox.Show("Email suscess sent form : " + txtMail.Text + " to : " + mailTo + " .");
                else
                    MessageBox.Show("Email not sent form : " + txtMail.Text + " to : " + mailTo + " ." + "\n" + s);
            }
            else
                MessageBox.Show("Email not sent form : " + txtMail.Text + " to : " + mailTo + " ." + "\n" + s);
        }

        private Boolean KiemDuLieu()
        {
            if (string.IsNullOrEmpty(txtMail.Text.ToString()))
            {
                MessageBox.Show("Please choise mail.");
                return false;
            }

            if (string.IsNullOrEmpty(txtSmtp.Text.ToString()))
            {
                MessageBox.Show("Please input SMTP Server.");
                return false;
            }
            if (string.IsNullOrEmpty(txtPort.Text.ToString()))
            {
                MessageBox.Show("Please input Port Server.");
                return false;
            }
            if (txtPass.Text != txtRePass.Text)
            {
                MessageBox.Show("The passwords do not match, try again.");
                return false;
            }

            if (!MInternet.IsConnectedToInternet())
            {
                MessageBox.Show("Please connect internet.");
                return false;
            }
            if (CapNhapMailCSDL())
                return true;
            else
                return false;
        }

        private Boolean CapNhapMailCSDL()
        {
            try
            {
                string sSql = "UPDATE THONG_TIN_CHUNG SET  SSL_MAIL = N'" + chkSSL.Checked + "' , MAIL_FROM = N'" + txtMail.Text + "' , " +
                        " PASS_MAIL = N'" + Commons.Modules.ObjSystems.MaHoaDL(txtPass.Text) + "' , " +
                        " SMTP_MAIL = N'" + txtSmtp.Text + "' , PORT_MAIL = N'" + txtPort.Text + "' ";
                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, sSql);
                Commons.Modules.sMailFrom = txtMail.Text;
                Commons.Modules.sMailFromSmtp = txtSmtp.Text;
                Commons.Modules.sMailFromPort = txtPort.Text;
                Commons.Modules.sMailFromPass = txtPass.Text;
            }
            catch {
                return false;
            }
            return true;
        }

        private bool CheckEmail(string email, string smtp, int port)
        {
            bool ketqua = false;
            TcpClient tClient = new TcpClient(smtp,port);

            string CRLF = "\r\n";
            byte[] dataBuffer;
            string ResponseString;
            NetworkStream netStream = tClient.GetStream();
            StreamReader reader = new StreamReader(netStream);
            ResponseString = reader.ReadLine();
            dataBuffer = BytesFromString("HELO Mashj" + CRLF);
            netStream.Write(dataBuffer, 0, dataBuffer.Length);
            ResponseString = reader.ReadLine();
            dataBuffer = BytesFromString("MAIL FROM:<YourGmailIDHere@gmail.com>" + CRLF);//FROM: gmail tùy ý hoặc để YourGmailIDHere@gmail.com
            netStream.Write(dataBuffer, 0, dataBuffer.Length);
            ResponseString = reader.ReadLine();
            dataBuffer = BytesFromString("RCPT TO:<" + email.Trim() + ">" + CRLF);
            netStream.Write(dataBuffer, 0, dataBuffer.Length);
            ResponseString = reader.ReadLine();
            if (GetResponseCode(ResponseString) == 550 || GetResponseCode(ResponseString) == 553)
                ketqua = false;
            else
                ketqua = true;
            dataBuffer = BytesFromString("QUITE" + CRLF);
            netStream.Write(dataBuffer, 0, dataBuffer.Length);
            tClient.Close();
            return ketqua;
        }

        private byte[] BytesFromString(string str)
        {
            return Encoding.ASCII.GetBytes(str);
        }
        private int GetResponseCode(string ResponseString)
        {
            return int.Parse(ResponseString.Substring(0, 3));
        }

        public bool isEmail(string inputEmail)
        {
            inputEmail = inputEmail ?? string.Empty;
            string strRegex = @"^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}" +
                  @"\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\" +
                  @".)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$";
            Regex re = new Regex(strRegex);
            if (re.IsMatch(inputEmail.Trim()))
                return (true);
            else
                return (false);
        }

        private void txtMail_Validating(object sender, CancelEventArgs e)
        {
            if (txtMail.Text.Trim() == "") return;

            if (!isEmail(txtMail.Text))
            {
                MessageBox.Show("Invalid e-mail.");
                txtMail.Focus();
                e.Cancel = true;
            }
            else
            {   
                string s;
                s = txtMail.Text.Substring(txtMail.Text.Length - "gmail.com".Length, "gmail.com".Length);
                if (s.ToUpper() == "gmail.com".ToUpper())
                {
                    txtSmtp.Text = "smtp.gmail.com";
                    txtPort.Text = "587";
                }
                else
                {
                    s = txtMail.Text.Substring(txtMail.Text.Length - "yahoo.com".Length, "yahoo.com".Length);
                    if (s.ToUpper() == "yahoo.com".ToUpper())
                    {
                        txtSmtp.Text = "smtp.mail.yahoo.com";
                        txtPort.Text = "25";
                    }
                    else
                    {
                        s = txtMail.Text.Substring(txtMail.Text.Length - "hotmail.com".Length, "hotmail.com".Length);
                        if (s.ToUpper() == "hotmail.com".ToUpper())
                        {
                            txtSmtp.Text = "smtp.live.com";
                            txtPort.Text = "25";
                        }
                    }
                }
            
            }
        }

        public string MSendEmail(string SendTo, string SendCC, string SendBCC, string SendFrom, string Subject, string Body, string AttachmentPath)
        {
            try
            {

                System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex(@"\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*");
                string from = SendFrom;
                string to = SendTo; //Danh sách email được ngăn cách nhau bởi dấu ";"
                string subject = Subject;
                string body = Body;
                bool result = true;
                String[] ALL_EMAILS = to.Split(';');

                foreach (string emailaddress in ALL_EMAILS)
                {
                    result = regex.IsMatch(emailaddress);
                    if (result == false)
                        return "Invalid e-mail.";
                }

                if (result == true)
                {
                    try
                    {

                        SmtpClient client = new SmtpClient(txtSmtp.Text, int.Parse(txtPort.Text));
                        //if (txtSmtp.Text == "smtp.gmail.com") client.EnableSsl = true;
                        if (chkSSL.Checked) client.EnableSsl = true;
                        if (txtSmtp.Text == "smtp.gmail.com") client.EnableSsl = true;

                        MailAddress from1 = new MailAddress(SendFrom, "");
                        //MailAddress to1 = new MailAddress(to, "");
                        //MailMessage message = new MailMessage(from1, to1);
                        MailMessage message = new MailMessage();
                        message.From = from1;

                        //add each email adress
                        //foreach (MailAddress m in SendTo)
                        //{
                        //    message.To.Add(m);
                        //}

                        if (SendTo.Trim() != "")
                        {
                            ALL_EMAILS = SendTo.Split(';');
                            foreach (string emailaddress in ALL_EMAILS)
                            {
                                result = regex.IsMatch(emailaddress);
                                if (result)
                                {
                                    message.To.Add(emailaddress);
                                }
                            }
                        }



                        message.SubjectEncoding = Encoding.UTF8;
                        message.BodyEncoding = Encoding.UTF8;
                        message.IsBodyHtml = true;
                        message.Priority = MailPriority.High;
                        message.Body = Body;
                        message.Subject = Subject;

#region "Kiem CC"
                        result = true;
                        if (SendCC.Trim() != "")
                        {
                            ALL_EMAILS = SendCC.Split(';');
                            foreach (string emailaddress in ALL_EMAILS)
                            {
                                result = regex.IsMatch(emailaddress);
                                if (result)
                                {
                                    message.CC.Add(emailaddress);
                                }
                            }
                        }

#endregion

#region "Kiem BCC"
                        result = true;
                        if (SendBCC.Trim() != "")
                        {
                            ALL_EMAILS = SendBCC.Split(';');
                            foreach (string emailaddress in ALL_EMAILS)
                            {
                                result = regex.IsMatch(emailaddress);
                                if (result)
                                {
                                    message.Bcc.Add(emailaddress);
                                }
                            }
                        }
#endregion

#region "Kiem Attach"
                        if (AttachmentPath.Trim() != "")
                        {
                            Attachment attach = new Attachment(AttachmentPath);
                            message.Attachments.Add(attach);
                        }
#endregion
                        
                        NetworkCredential myCreds = new NetworkCredential(SendFrom, txtPass.Text, "");                        
                        client.Credentials = myCreds;
                        //client.SendAsync(message,string.Empty);
                        client.Send(message);
                        message.Dispose();
                        return "";
                    }
                    catch (Exception ex)
                    {
                        return ex.Message;
                    }
                }
                else
                    return "Email not sent";
            }
            catch (Exception ex)
            {
                return ex.Message;
            }
        }
 
        private void timer1_Tick(object sender, EventArgs e)
        {
            if (MRunApp) return;
            MRunApp = true;
            DateTime Ngay = DateTime.Now;
            //Ngay = DateTime.Parse("30/07/2015 08:00:00");

            NgayGioHT = Ngay.Date.AddHours(Ngay.Hour).AddMinutes(Ngay.Minute);


            #region TRAITV
           
            if (Commons.Modules.sPrivate == "BARIA")
            {
                if (DateTime.Now.TimeOfDay.Hours == 14 && DateTime.Now.TimeOfDay.Minutes == 35)
                {
                    GuiMailNhacDuyetBC();
                }
                
                if ((DateTime.Now.TimeOfDay.Hours == 8 && DateTime.Now.TimeOfDay.Minutes == 10) || (DateTime.Now.TimeOfDay.Hours == 14 && DateTime.Now.TimeOfDay.Minutes == 10))
                {
                    GuiMailNhacDuyetBC();
                    GuiMailKhongDuSoLuongBCStop();
                    GuiMailTruocHanThucHien1Tuan();
                    GuiMailTruocHanThucHien3Ngay();
                    GuiMailTruocHanThucHien1Ngay();
                    GuiMailHetHanThucHien();

                    GuiMailTruocHan1TuanAudit();
                    GuiMailTruocHan3NgayAudit();
                    GuiMailTruocHan1NgayAudit();
                    GuiMailHetHanAudit();
                }
            }
            #endregion
            MSchedules();

            MRunApp = false;
        }

        private void MSchedules()
        {
            try
            {
                DataTable dtDSMail = new DataTable();
                dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text,
                    "SELECT * FROM MAIL_SCHEDULES A INNER JOIN DS_MAIL B ON A.ID_SCHEDULES = B.ID_SCHEDULES WHERE HIEU_LUC = 1"));
                if (dtDSMail.Rows.Count == 0) return;
                DataTable dtTmp = new DataTable();
                for (int i = 0; i < dtDSMail.Rows.Count; i++)
                {
                    dtTmp = new DataTable();
                    dtTmp = dtDSMail.Copy();
                    dtTmp.DefaultView.RowFilter = " ID_SCHEDULES = " + int.Parse(dtDSMail.Rows[i]["ID_SCHEDULES"].ToString()) +
                        " AND ID = " + int.Parse(dtDSMail.Rows[i]["ID"].ToString());

                    dtTmp = dtTmp.DefaultView.ToTable();
                    if (dtTmp.Rows.Count > 0)
                    {
#region "Kieu Goi La Ngay LOAI_SCHEDULES = 1"
                        if (int.Parse(dtDSMail.Rows[i]["LOAI_SCHEDULES"].ToString()) == 1)
                        {
                            MNgay(dtTmp);
                        }
#endregion

#region "Kieu Goi La Tuan LOAI_SCHEDULES = 2"
                        if (int.Parse(dtDSMail.Rows[i]["LOAI_SCHEDULES"].ToString()) == 2)
                        {
                            MTuan(dtTmp);
                        }
#endregion

#region "Kieu Goi La Thang LOAI_SCHEDULES = 3"
                        if (int.Parse(dtDSMail.Rows[i]["LOAI_SCHEDULES"].ToString()) == 3)
                        {
                            MThang(dtTmp);
                        }
#endregion
                    }
                }

            }
            catch { }

        }

        private void MNgay(DataTable dtSch)
        {
            try
            {
#region "Kiem Ngay Goi Theo Ngay Bat Dau hieu Luc
                DateTime NgayBDHL, NgayHT;
                int GoiMoi;
                NgayHT = NgayGioHT.Date;
                NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                GoiMoi = int.Parse(dtSch.Rows[0]["GOI_MOI"].ToString());
                TimeSpan timespan = (NgayHT - NgayBDHL);
                if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) != (timespan.TotalDays / GoiMoi)) return;
#endregion

#region "Kiem Du Lieu Goi"
                if (!MKiemNgayBDKTSch(dtSch)) return;
#endregion

#region Tao Du Lieu Goi
                TaoDuLieu(dtSch);
#endregion
            }
            catch {return;}
        
        }

        private void MTuan(DataTable dtSch)
        {
            try
            {
#region "Kiem Du Lieu Goi"
                if (!MKiemNgayBDKTSch(dtSch)) return;
#endregion

#region "Kiem Ngay Goi Theo Ngay Bat Dau hieu Luc"
                DateTime NgayBDHL, NgayHT;
                int GoiMoi;
                Boolean Thu2, Thu3, Thu4, Thu5, Thu6, Thu7, ThuCN;


                Thu2 = Boolean.Parse(dtSch.Rows[0]["THU_2"].ToString());
                Thu3 = Boolean.Parse(dtSch.Rows[0]["THU_3"].ToString());
                Thu4 = Boolean.Parse(dtSch.Rows[0]["THU_4"].ToString());
                Thu5 = Boolean.Parse(dtSch.Rows[0]["THU_5"].ToString());
                Thu6 = Boolean.Parse(dtSch.Rows[0]["THU_6"].ToString());
                Thu7 = Boolean.Parse(dtSch.Rows[0]["THU_7"].ToString());
                ThuCN = Boolean.Parse(dtSch.Rows[0]["THU_CN"].ToString());
                NgayHT = NgayGioHT.Date;
                NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                GoiMoi = int.Parse(dtSch.Rows[0]["GOI_MOI"].ToString()) * 7;

                Boolean KiemNgay = true;

                if (!Thu2 && !Thu3 && !Thu4 && !Thu5 && !Thu6 && !Thu7 && !ThuCN)
                {
                    TimeSpan timespan = (NgayHT - NgayBDHL);
                    if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) != (timespan.TotalDays / GoiMoi)) return;
                }
                else
                {
                    if (Thu2)
                    {
                        NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                        while (NgayBDHL.DayOfWeek != DayOfWeek.Monday) NgayBDHL = NgayBDHL.AddDays(1);
                        TimeSpan timespan = (NgayHT - NgayBDHL);
                        if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) == (timespan.TotalDays / GoiMoi)) goto EndKiem;
                    }
                    if (Thu3)
                    {
                        NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                        while (NgayBDHL.DayOfWeek != DayOfWeek.Tuesday) NgayBDHL = NgayBDHL.AddDays(1);
                        TimeSpan timespan = (NgayHT - NgayBDHL);
                        if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) == (timespan.TotalDays / GoiMoi)) goto EndKiem;
                    }
                    if (Thu4)
                    {
                        NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                        while (NgayBDHL.DayOfWeek != DayOfWeek.Wednesday) NgayBDHL = NgayBDHL.AddDays(1);
                        TimeSpan timespan = (NgayHT - NgayBDHL);
                        if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) == (timespan.TotalDays / GoiMoi)) goto EndKiem;
                    }
                    if (Thu5)
                    {
                        NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                        while (NgayBDHL.DayOfWeek != DayOfWeek.Thursday) NgayBDHL = NgayBDHL.AddDays(1);
                        TimeSpan timespan = (NgayHT - NgayBDHL);
                        if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) == (timespan.TotalDays / GoiMoi)) goto EndKiem;
                    }
                    if (Thu6)
                    {
                        NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                        while (NgayBDHL.DayOfWeek != DayOfWeek.Friday) NgayBDHL = NgayBDHL.AddDays(1);
                        TimeSpan timespan = (NgayHT - NgayBDHL);
                        if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) == (timespan.TotalDays / GoiMoi)) goto EndKiem;
                    }
                    if (Thu7)
                    {
                        NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                        while (NgayBDHL.DayOfWeek != DayOfWeek.Saturday) NgayBDHL = NgayBDHL.AddDays(1);
                        TimeSpan timespan = (NgayHT - NgayBDHL);
                        if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) == (timespan.TotalDays / GoiMoi)) goto EndKiem;
                    }
                    if (ThuCN)
                    {
                        NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());
                        while (NgayBDHL.DayOfWeek != DayOfWeek.Sunday) NgayBDHL = NgayBDHL.AddDays(1);
                        TimeSpan timespan = (NgayHT - NgayBDHL);
                        
                        if (((timespan.TotalDays / GoiMoi) - (timespan.TotalDays % GoiMoi)) == (timespan.TotalDays / GoiMoi)) goto EndKiem;
                    }
                    KiemNgay = false;
                }
                if (KiemNgay == false) return;
            EndKiem: ;
#endregion

#region Tao Du Lieu Goi
                TaoDuLieu(dtSch);
#endregion

            }
            catch
            {
                return;
            }

        }

        private void MThang(DataTable dtSch)
        {
            try
            {
                int GoiMoi, VaoNgayThang;
                DateTime NgayBDHL, NgayHT;
                NgayHT = NgayGioHT.Date;
                NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());

#region "Kiem Du Lieu Goi"
                if (!MKiemNgayBDKTSch(dtSch)) return;
#endregion

#region "Kiem Ngay Goi Theo Ngay Bat Dau hieu Luc"

                NgayBDHL = DateTime.Parse(dtSch.Rows[0]["TG_BD_HL"].ToString());

                if (int.Parse(dtSch.Rows[0]["LOAI_THANG"].ToString()) == 1)
                {
                    GoiMoi = int.Parse(dtSch.Rows[0]["GOI_MOI"].ToString());
                    VaoNgayThang = int.Parse(dtSch.Rows[0]["VAO_NGAY_THANG"].ToString());
                    while (NgayBDHL.Day != VaoNgayThang) NgayBDHL = NgayBDHL.AddDays(1);
                    int SoThang = Commons.Modules.ObjSystems.MGetSoNgayThang(NgayBDHL, NgayHT);
                    if ((SoThang % GoiMoi) != 0) return;
                    DateTime NgayGoi = NgayBDHL.AddMonths(SoThang);
                    if (NgayGoi != NgayHT) return;
                }
                else
                {
                    NgayBDHL = DateTime.Parse("01/" + NgayBDHL.AddMonths(1).Month + "/" + NgayBDHL.Year);
                    // 0 tuan dau tien, 1 la tuan thu 1, 2 la tuan thu 2, 3 la tuan thu 3, 4 la tuan thu 4, 5 la tuan thu 5 , 6 la tuan thu 6
                    int VaoTuan = int.Parse(dtSch.Rows[0]["LOAI_TUAN_THANG"].ToString());
                    // 0 la CN , 1 la thu 2, 2 thu 3, 3 thu 4
                    VaoNgayThang = int.Parse(dtSch.Rows[0]["THU_TUAN_THANG"].ToString());
                    GoiMoi = int.Parse(dtSch.Rows[0]["SO_THANG_THANG"].ToString());
                    int SoThang = Commons.Modules.ObjSystems.MGetSoNgayThang(NgayBDHL, NgayHT);
                    //GoiMoi = 4;

#region "Kiem Coi co dung so thang goi khong
                    if ((SoThang % GoiMoi) != 0) return;
#endregion
#region "Kiem Coi co dung so tuan goi khong
                    int SoTuan = GetWeekOfMonth(NgayHT);
                    if (SoTuan != VaoTuan) return;
#endregion

#region "Kiem Coi co dung ngay tuan goi khong
                    if (VaoNgayThang == 0) if (NgayHT.DayOfWeek != DayOfWeek.Sunday) return;
                    if (VaoNgayThang == 1) if (NgayHT.DayOfWeek != DayOfWeek.Monday) return;
                    if (VaoNgayThang == 2) if (NgayHT.DayOfWeek != DayOfWeek.Tuesday) return;
                    if (VaoNgayThang == 3) if (NgayHT.DayOfWeek != DayOfWeek.Wednesday) return;
                    if (VaoNgayThang == 4) if (NgayHT.DayOfWeek != DayOfWeek.Thursday) return;
                    if (VaoNgayThang == 5) if (NgayHT.DayOfWeek != DayOfWeek.Friday) return;
                    if (VaoNgayThang == 6) if (NgayHT.DayOfWeek != DayOfWeek.Saturday) return;
#endregion
                }
#endregion

#region Tao Du Lieu Goi
                TaoDuLieu(dtSch);
#endregion
            }
            catch
            {
                return;
            }
        }

        private void TaoDuLieu(DataTable dtSch)
        {
            TenBC = "";
            int iTinhTrang = 1;
            // iTinhTrang = 0 khong co du lieu. 1 co du lieu.  2 loi

            string sLoi = "";
            if (TaoBaoCao(dtSch, out iTinhTrang, out sLoi))
            {
                if (Commons.Modules.iLoaiGoiMail == 2 || Commons.Modules.iLoaiGoiMail == 3)
                {
                    CapNhapMailVaoCSDL(dtSch);
                }
                if (Commons.Modules.iLoaiGoiMail == 1 || Commons.Modules.iLoaiGoiMail == 3)
                {
                    GoiMail(dtSch);
                }
            }
            else
            {
                //if (TenBC == "KhongCoDuLieuIn")
                if (iTinhTrang == 0)
                {
                    TenBC = dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + " : no data print."  + sLoi;
                    MInternet.GhiLog(Application.StartupPath.ToString(), "", TenBC, NgayGioHT);
                }
                if (iTinhTrang == 2)
                {
                    TenBC = dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + " : can not create";
                    if (sLoi != "" )
                        TenBC = dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + " : " + sLoi;

                    MInternet.GhiLog(Application.StartupPath.ToString(), "Error", TenBC, NgayGioHT);
                }


                TenBC = "";
            }        
        }

        private Boolean TaoBaoCao(DataTable dtSch, out int iTinhTrang, out string sLoi )
        {
            // iTinhTrang = 0 khong co du lieu. 1 co du lieu.  2 loi
            iTinhTrang = 1;
            sLoi = "";
            string sBCao, sDuoiFile;
            try
            {
                VSMail.MClass.MBaoCao MBaoCao = new VSMail.MClass.MBaoCao();
                sBCao = dtSch.Rows[0]["ID_MAIL"].ToString().ToUpper();
                TenBC = "";
                sDuoiFile = "pdf";
                MMail.MLoadBaoCao MBaoCaoVB = new MMail.MLoadBaoCao();

            #region InVTPT ucVTPTSLTonNhohonTTT
                if ("ucVTPTSLTonNhohonTTT".ToUpper() == sBCao)
                {
                    Boolean bCoDuLieu = true;
                    if (!MBaoCao.InVTPT(dtSch, out iTinhTrang,out sLoi))
                    {
                        if (!bCoDuLieu) TenBC = "KhongCoDuLieuIn";
                        return false;
                    }
                }
            #endregion

            #region InGSTT  ucMailPGSTTDHKT
                if ("ucMailPGSTTDHKT".ToUpper() == sBCao)
                    if (!MBaoCao.InGSTT(dtSch, out iTinhTrang)) return false;
            #endregion

            #region InPBTCTH    ucMailBTDKCThucHien
                if ("ucMailBTDKCThucHien".ToUpper() == sBCao)
                    if (!MBaoCao.InPBTCTH(dtSch, out iTinhTrang)) return false;
            #endregion

            #region Phieu Bao Tri Qua Han Ket Thuc  ucPBTQuaHanKT
                if ("ucPBTQuaHanKT".ToUpper() == sBCao)
                    if (!MBaoCao.InPBTQHKT(dtSch, out iTinhTrang)) return false;
            #endregion

            #region Phieu Bao Tri Trong Ngay    ucPBTTrongNgay
                if ("ucPBTTrongNgay".ToUpper() == sBCao)
                {
                    if (!MBaoCao.InPBTTrongNgay(dtSch, out iTinhTrang)) return false;
                }
            #endregion

            #region Thiet Bi Den han hieu Chuan     ucThietBiDenHanHieuChuan
                if ("ucThietBiDenHanHieuChuan".ToUpper() == sBCao)
                    if (!MBaoCao.InThietBiDenHanHieuChuan(dtSch, out iTinhTrang)) return false;
            #endregion

            #region ucMailBieuDoChiPhiTheoNX
                if ("ucMailBieuDoChiPhiTheoNX".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.BDCPTNXInBieuDoChiPhiTheoNX(dtSch, grdChung, grvChung, out iTinhTrang)) return false;
                }
            #endregion

            #region ucMailBieuDoChiPhiTheoNX Thang
                if ("ucMailBieuDoChiPhiTheoNXThang".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.BDCPTNXTInBieuDoChiPhiTheoNXThang(dtSch, grdChung, grvChung, out iTinhTrang, out sLoi)) return false;
                }
            #endregion

            #region ucMailBieuDoChiPhiTheoTB
                if ("ucMailBieuDoChiPhiTheoTB".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.InBieuDoChiPhiTheoTB(dtSch, grdChung, grvChung, out iTinhTrang)) return false;
                }
            #endregion

            #region ucMailBieuDoChiPhiTheoTBThang
                if ("ucMailBieuDoChiPhiTheoTBThang".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.InBieuDoChiPhiTheoTBThang(dtSch, grdChung, grvChung, out iTinhTrang)) return false;
                }
            #endregion

            #region ucMailBieuDoTGNMayTheoMay
                if ("ucMailBieuDoTGNMayTheoMay".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.BDTGNMTMInBieuDoTGNMayTheoMay(dtSch, grdChung, grvChung, out iTinhTrang)) return false;
                }
            #endregion

            #region ucMailBieuDoTGNMayTheoMayThang
                if ("ucMailBieuDoTGNMayTheoMayThang".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.BDTGNMTMThangInBieuDoTGNMayTheoMayThang(dtSch, grdChung, grvChung, out iTinhTrang)) return false;
                }
            #endregion

            #region ucMailBieuDoTGNMayTheoNX
                if ("ucMailBieuDoTGNMayTheoNX".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.BDTGNMTNXInBieuDoTGNMayTheoNX(dtSch, grdChung, grvChung, out iTinhTrang)) return false;
                }
            #endregion

            #region ucMailBieuDoTGNMayTheoNXThang
                if ("ucMailBieuDoTGNMayTheoNXThang".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.BDTGNMTNXThangInBieuDoTGNMayTheoNXThang(dtSch, grdChung, grvChung, out iTinhTrang)) return false;
                }
            #endregion

            #region ucMailBaoTriDinhKyThangCS
                if ("ucMailBaoTriDinhKyThangCS".ToUpper() == sBCao)
                {
                    string sLoiBC = "";
                    sDuoiFile = "xls";
                    sLoiBC = MBaoCaoVB.BTDKTCSInMailBaoTriDinhKyThangCS(dtSch);
                    if (sLoiBC.ToUpper() != "true".ToUpper())
                    {
                        //if (sLoiBC == "KhongCoDuLieuIn")
                        //{
                        //    TenBC = "KhongCoDuLieuIn";
                        //    return false;
                        //}

                        //if (sLoiBC == "False")
                        sLoi = sLoiBC;
                        TenBC = "";
                        iTinhTrang = 2;
                        return false;
                    }
                }
            #endregion

            #region ucMailVatTuDeXuatChuaNhapKho
                if ("ucMailVatTuDeXuatChuaNhapKho".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.VTDXCXKInThietBiDenHanHieuChuan(dtSch, grdChung, grvChung, out iTinhTrang)) return false;
                }
            #endregion

            #region ucMailChuaCoHoaDon
                if ("ucMailChuaCoHoaDon".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    if (!MBaoCao.CCHDLoadDLChuaCoHoaDon(dtSch, grdChung, grvChung, out iTinhTrang, out sLoi)) return false;
                }
                #endregion


            #region ucMailBieuDoTGNMayTheoMayThang
                if ("ucMailPhanTichTGNMay".ToUpper() == sBCao)
                {
                    sDuoiFile = "xls";
                    TenBC = "PRO_DT_REPORT_" + DateTime.Now.AddDays(-1).ToString("yyyyMMdd") + ".xls";
                    if (!MBaoCao.PhanTichTGNMTMThang(dtSch, grdChung, grvChung, out iTinhTrang, out sLoi, out TenBC))
                    {
                        MInternet.GhiLog(Application.StartupPath.ToString(), "PTTGNM" + sLoi, TenBC, NgayGioHT);
                        return false;
                    }
                    else
                        return true;
                }
            #endregion

            }
            catch 
            {
                TenBC = "";
                return false; 
            }
            TenBC = dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + "." + sDuoiFile;
            return true;
        }

        public static int GetWeekOfMonth(DateTime date)
        {
            DateTime beginningOfMonth = new DateTime(date.Year, date.Month, 1);

            while (date.Date.AddDays(1).DayOfWeek != System.Globalization.CultureInfo.CurrentCulture.DateTimeFormat.FirstDayOfWeek)
                date = date.AddDays(1);
             
            return (int)Math.Truncate((double)date.Subtract(beginningOfMonth).TotalDays / 7f) + 1;
        } 

        private Boolean MKiemNgayBDKTSch(DataTable dtSch)
        {

#region "Kiem Ngay hieu luc BD va KT goi"
            if (DateTime.Parse(dtSch.Rows [0]["TG_BD_HL"].ToString()).Date > NgayGioHT.Date) return false;
            if (int.Parse(dtSch.Rows[0]["LOAI_HIEU_LUC"].ToString()) == 1)
                if (DateTime.Parse(dtSch.Rows[0]["TG_KT_HL"].ToString()).Date < NgayGioHT.Date) return false;
#endregion

#region "Kiem Goi Vao Luc Hay Goi Moi
            int GoiMoi;
            //Goi co thoi gian xac dinh loai time = 0
            if (int.Parse(dtSch.Rows[0]["LOAI_TIME"].ToString()) == 0)
            {
                DateTime GioGoi;
                GioGoi = DateTime.Parse(dtSch.Rows[0]["GIO_GOI"].ToString());
                GioGoi = NgayGioHT.Date.AddHours(GioGoi.Hour).AddMinutes(GioGoi.Minute).AddSeconds(GioGoi.Second);
                if (GioGoi != NgayGioHT) return false; else return true;
            }
            DateTime GioBD, GioKT;
            GioBD = DateTime.Parse("00:00:00");
            GioBD = NgayGioHT.Date.AddHours(GioBD.Hour).AddMinutes(GioBD.Minute).AddSeconds(GioBD.Second);
            GioKT = DateTime.Parse("23:59:59");
            GioKT = NgayGioHT.Date.AddHours(GioKT.Hour).AddMinutes(GioKT.Minute).AddSeconds(GioKT.Second);
            try
            {
                GioBD = DateTime.Parse(dtSch.Rows[0]["TG_BD"].ToString());
                GioBD = NgayGioHT.Date.AddHours(GioBD.Hour).AddMinutes(GioBD.Minute).AddSeconds(GioBD.Second);
                GioKT = DateTime.Parse(dtSch.Rows[0]["TG_KT"].ToString());
                GioKT = NgayGioHT.Date.AddHours(GioKT.Hour).AddMinutes(GioKT.Minute).AddSeconds(GioKT.Second);
            }
            catch { }


            GoiMoi = int.Parse(dtSch.Rows[0]["SO_GIO_GOI"].ToString());
            if (GioBD > NgayGioHT) return false;
            if (GioKT < NgayGioHT) return false;
            TimeSpan timespan = (NgayGioHT - GioBD);
            //Goi moi gio loai time = 1
            if (int.Parse(dtSch.Rows[0]["LOAI_TIME"].ToString()) == 1)
                if (((timespan.TotalHours / GoiMoi) - (timespan.TotalHours % GoiMoi)) != (timespan.TotalHours / GoiMoi)) return false;
            
            //Goi moi phut loai time = 2
            if (int.Parse(dtSch.Rows[0]["LOAI_TIME"].ToString()) == 2)
                if (((timespan.TotalMinutes / GoiMoi) - (timespan.TotalMinutes % GoiMoi)) != (timespan.TotalMinutes / GoiMoi)) return false;
            
            //Goi moi giay loai time = 3
            if (int.Parse(dtSch.Rows[0]["LOAI_TIME"].ToString()) == 3)
                if (((timespan.TotalSeconds / GoiMoi) - (timespan.TotalSeconds % GoiMoi)) != (timespan.TotalSeconds / GoiMoi)) return false;
            
#endregion

            return true;
        }


        private void btnOK_Click(object sender, EventArgs e)
        {
            //#region "test"
            //DateTime Ngay = DateTime.Now;
            //DateTime Ngay = DateTime.Parse("2016-03-22 08:00:00.000");
            //NgayGioHT = Ngay.Date.AddHours(Ngay.Hour).AddMinutes(Ngay.Minute);
            //HIEU_LUC = 1 AND
            //DataTable dtDSMail = new DataTable();
            //dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text,
            //    "SELECT * FROM MAIL_SCHEDULES A INNER JOIN DS_MAIL B ON A.ID_SCHEDULES = B.ID_SCHEDULES WHERE  " +
            //        "  A.ID_SCHEDULES = 1 and id = 32"));
            //if (dtDSMail.Rows.Count == 0) return;
            //TaoDuLieu(dtDSMail);
            //#endregion

            Hide();
        }

        #region Goi mail
        private void GoiMail(DataTable dtSch)
        {
            string sPath;
            sPath = System.Windows.Forms.Application.StartupPath + "\\" + TenBC;
            try
            {
                Commons.Modules.bSSL = chkSSL.Checked;
                string s = "";
                s = Commons.Modules.MMail.MSendEmail(dtSch.Rows[0]["MAIL_TO"].ToString(), dtSch.Rows[0]["MAIL_CC"].ToString(), dtSch.Rows[0]["MAIL_BCC"].ToString(), txtMail.Text, 
                    txtPass.Text, dtSch.Rows[0]["TEN_BC"].ToString(), dtSch.Rows[0]["ND_BC"].ToString(), sPath,txtSmtp.Text,txtPort.Text);
                
                if (s == "") s = "suscess sent to " + dtSch.Rows[0]["MAIL_TO"].ToString() + 
                    (dtSch.Rows[0]["MAIL_CC"].ToString() == "" ? "" : ". CC " + dtSch.Rows[0]["MAIL_CC"].ToString()) +
                    (dtSch.Rows[0]["MAIL_BCC"].ToString() == "" ? "" : ". BCC " + dtSch.Rows[0]["MAIL_BCC"].ToString());
                
                MInternet.GhiLog(Application.StartupPath.ToString(), s, TenBC, NgayGioHT);
            }
            catch (Exception ex)
            {
                MInternet.GhiLog(Application.StartupPath.ToString(), "Error", TenBC + "\n" + ex.Message, NgayGioHT);
            }
            Commons.Modules.ObjSystems.Xoahinh(sPath);

        }
        #endregion

        #region Dua File Vao CSDL
        private void CapNhapMailVaoCSDL(DataTable dtSch)
        {
            try
            {
                if (Commons.Modules.sDDanMail == "")
                {
                    Commons.Modules.sDDanMail = @"D:\Vietsoft Ecomaint";
                    System.IO.Directory.CreateDirectory(Commons.Modules.sDDanMail);
                }
                string sPath;
                sPath = System.Windows.Forms.Application.StartupPath + "\\" + TenBC;
                string sKQ = "";
                
                Commons.Modules.MMail.CapNhapMailVaoCSDL(TenBC, sPath, dtSch.Rows[0]["MAIL_TO"].ToString(), dtSch.Rows[0]["MAIL_CC"].ToString(),
                    dtSch.Rows[0]["MAIL_BCC"].ToString(), dtSch.Rows[0]["TEN_BC"].ToString(), dtSch.Rows[0]["ND_BC"].ToString(), ref sKQ);
                if (sKQ == "") sKQ = "suscess save to " + Commons.Modules.sDDanMail;

                MInternet.GhiLog(Application.StartupPath.ToString(), sKQ, TenBC, NgayGioHT);
                Commons.Modules.ObjSystems.Xoahinh(sPath);
            }
            catch (Exception ex)
            {
                MInternet.GhiLog(Application.StartupPath.ToString(), "Error", TenBC + " : " + ex.Message, NgayGioHT);
            }

        }
        #endregion

        private void lbmgs_DoubleClick(object sender, EventArgs e)
        {
            //DataTable dtDSMail = new DataTable();
            //dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text,
            //"SELECT * FROM MAIL_SCHEDULES A INNER JOIN DS_MAIL B ON A.ID_SCHEDULES = B.ID_SCHEDULES WHERE HIEU_LUC = 1 AND A.ID_SCHEDULES = 2"));
            //if (dtDSMail.Rows.Count == 0) return;

            //TaoDuLieu(dtDSMail);
        }


        #region GUIMAIL_TRAITV

        private void GuiMailTruocHan1NgayAudit()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_NHACMAILTRUOCHAN1NGAY_AUDIT"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "USER_MAIL");
            dataItemgroup.DefaultView.Sort = "USER_MAIL";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "USER_MAIL = '" + r["USER_MAIL"].ToString() + "'";
                    GuiMailTruocHanThucHien1NgayAudit(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailTruocHan3NgayAudit()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_NHACMAILTRUOCHAN3NGAY_AUDIT"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "USER_MAIL");
            dataItemgroup.DefaultView.Sort = "USER_MAIL";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "USER_MAIL = '" + r["USER_MAIL"].ToString() + "'";
                    GuiMailTruocHanThucHien3NgayAudit(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailTruocHan1TuanAudit()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_NHACMAILTRUOCHAN1TUAN_AUDIT"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "USER_MAIL");
            dataItemgroup.DefaultView.Sort = "USER_MAIL";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "USER_MAIL = '" + r["USER_MAIL"].ToString() + "'";
                    GuiMailTruocHanThucHien1TuanAudit(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailHetHanAudit()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_NHACMAILHETHANTHUCHIEN_AUDIT"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "USER_MAIL");
            dataItemgroup.DefaultView.Sort = "USER_MAIL";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "USER_MAIL = '" + r["USER_MAIL"].ToString() + "'";
                    GuiMailHetHanThucHienAudit(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailTruocHanThucHien1Ngay()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_GUIMAILTRUOCHAN1NGAY"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "Incharge");
            dataItemgroup.DefaultView.Sort = "Incharge";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "Incharge = '" + r["Incharge"].ToString() + "'";
                    GuiMailTruocHanThucHien1Ngay(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailTruocHanThucHien3Ngay()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_GUIMAILTRUOCHAN3NGAY"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "Incharge");
            dataItemgroup.DefaultView.Sort = "Incharge";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "Incharge = '" + r["Incharge"].ToString() + "'";
                    GuiMailTruocHanThucHien3Ngay(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailKhongDuSoLuongBCStop()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_GUIMAILKHONGDUSOLUONGBAOCAOTHANG"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "USER_MAIL", "Staffname", "Count");
            dataItemgroup.DefaultView.Sort = "Staffname";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {

                    GuiMailKhongDuSoLuongBaoCaoStop(r["USER_MAIL"].ToString(), r["Staffname"].ToString(), r["Count"].ToString());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailNhacDuyetBC()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_NHAC_DUYET_MAIL"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "USER_MAIL");
            dataItemgroup.DefaultView.Sort = "USER_MAIL";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "USER_MAIL = '" + r["USER_MAIL"].ToString() + "'";

                    GuiMailNhacDuyetChungTu(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailTruocHanThucHien1Tuan()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_GUIMAILTRUOCHAN1TUAN"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "Incharge");
            dataItemgroup.DefaultView.Sort = "Incharge";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "Incharge = '" + r["Incharge"].ToString() + "'";
                    GuiMailTruocHanThucHien1Tuan(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }

        private void GuiMailHetHanThucHien()
        {
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.StoredProcedure, "SP_GUIMAILHETHANTHUCHIEN"));
            if (dtDSMail.Rows.Count == 0) return;
            System.Data.DataTable dataItemgroup = new System.Data.DataTable();
            dataItemgroup = dtDSMail.DefaultView.ToTable(true, "Incharge");
            dataItemgroup.DefaultView.Sort = "Incharge";
            foreach (DataRow r in dataItemgroup.Rows)
            {
                try
                {
                    DataView someView = new DataView(dtDSMail);
                    someView.RowFilter = "Incharge = '" + r["Incharge"].ToString() + "'";
                    GuiMailHetHanThucHien(someView.ToTable());
                }
                catch (Exception ex)
                {
                    MessageBox.Show(ex.Message);

                }

            }


        }
        private void GuiMailKhongDuSoLuongBaoCaoStop(String mailt, String dear, String sl)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện thẻ STOP";
                string body = "";
                if (mailt == "") return;
                mailto = mailt;
                body = "Dear <b>" + dear + "</b></br>";
                body = body + "Vui lòng thực hiện " + sl + " thẻ STOP và Đăng nhập vào phần mềm Ecomaint/Safety (mục 2.3) để hoàn tất báo cáo.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_KhongDuSoLuongBaoCaoStop", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailTruocHanThucHien1Tuan(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện Hành động khắc phục, phòng ngừa từ Ecomaint/Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();
                body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                body = body + "Danh sách các hành động cần thực hiện ngay trước hạn thực hiện 1 tuần:</br>";
                body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                body = body + " align='left'>";
                body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                body = body + " <td align=center width='120px' height='30px'><b>Chứng từ</b></td>";
                body = body + " <td align=center  width='150px'><b>Loại chứng từ</b></td>";
                body = body + " <td align=center  width='300px'><b>Hành động</b></td>";
                body = body + " <td align=center  width='200px'><b>Người thực hiện</b></td>";
                body = body + " <td align=center width='100px'><b>Hạn thực hiện</b></td>";
                body = body + " </tr>";
                for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                {
                    body = body + " <tr align=center valign='middle'>";
                    body = body + " <td align=center width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                    body = body + " <td align=center  width='150px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                    body = body + " <td align=left  width='300px'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                    body = body + " <td align=center width='200px'>" + dtlistmail.Rows[i][5].ToString() + "</td>";
                    body = body + " <td align=center width='120px'>" + dtlistmail.Rows[i][6].ToString() + "</td>";
                    body = body + " </tr>";
                }
                body = body + " </table></br>";
                body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện các hành động khắc phục, phòng ngừa được đề xuất theo đúng thời hạn.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_TruocHanThucHien1Tuan", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailTruocHanThucHien3Ngay(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện Hành động khắc phục, phòng ngừa từ Ecomaint/Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();
                body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                body = body + "Danh sách các hành động cần thực hiện ngay trước hạn thực hiện 3 ngày:</br>";
                body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                body = body + " align='left'>";
                body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                body = body + " <td align=center width='120px' height='30px'><b>Chứng từ</b></td>";
                body = body + " <td align=center  width='150px'><b>Loại chứng từ</b></td>";
                body = body + " <td align=center  width='300px'><b>Hành động</b></td>";
                body = body + " <td align=center  width='200px'><b>Người thực hiện</b></td>";
                body = body + " <td align=center width='100px'><b>Hạn thực hiện</b></td>";
                body = body + " </tr>";
                for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                {
                    body = body + " <tr align=center valign='middle'>";
                    body = body + " <td align=center width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                    body = body + " <td align=center  width='150px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                    body = body + " <td align=left  width='300px'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                    body = body + " <td align=center width='200px'>" + dtlistmail.Rows[i][5].ToString() + "</td>";
                    body = body + " <td align=center width='120px'>" + dtlistmail.Rows[i][6].ToString() + "</td>";
                    body = body + " </tr>";
                }
                body = body + " </table></br>";
                body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện các hành động khắc phục, phòng ngừa được đề xuất theo đúng thời hạn.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_TruocHanThucHien3Ngay", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailTruocHanThucHien1NgayAudit(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện Hành động hệ thống quản lý an toàn Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();
                body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                body = body + "Danh sách các hành động trong Mục 2.6 'Hệ thống Quản lý An toàn' cần thực hiện ngay trước hạn thực hiện 1 ngày:</br>";
                body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                body = body + " align='left'>";
                body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                body = body + " <td align=center width='40px' height='30px'><b>STT</b></td>";
                body = body + " <td align=center width='120px' height='30px'><b>Hành động</b></td>";
                body = body + " <td align=center width='100px'><b>Hạn thực hiện</b></td>";
                body = body + " </tr>";
                for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                {
                    body = body + " <tr align=center valign='middle'>";
                    body = body + " <td align=left width='40px' valign='middle'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                    body = body + " <td align=left width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                    body = body + " <td align=center width='120px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                    body = body + " </tr>";
                }
                body = body + " </table></br>";
                body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện các hành động được đề xuất theo đúng thời hạn.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_TruocHanThucHien1NgayAudit", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailTruocHanThucHien3NgayAudit(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện Hành động hệ thống quản lý an toàn Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();
                body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                body = body + "Danh sách các hành động trong Mục 2.6 'Hệ thống Quản lý An toàn' cần thực hiện ngay trước hạn thực hiện 3 ngày:</br>";
                body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                body = body + " align='left'>";
                body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                body = body + " <td align=center width='40px' height='30px'><b>STT</b></td>";
                body = body + " <td align=center width='120px' height='30px'><b>Hành động</b></td>";
                body = body + " <td align=center width='100px'><b>Hạn thực hiện</b></td>";
                body = body + " </tr>";
                for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                {
                    body = body + " <tr align=center valign='middle'>";
                    body = body + " <td align=left width='40px' valign='middle'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                    body = body + " <td align=left width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                    body = body + " <td align=center width='120px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                    body = body + " </tr>";
                }
                body = body + " </table></br>";
                body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện các hành động được đề xuất theo đúng thời hạn.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_TruocHanThucHien3NgayAudit", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailTruocHanThucHien1TuanAudit(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện Hành động hệ thống quản lý an toàn Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();
                body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                body = body + "Danh sách các hành động trong Mục 2.6 'Hệ thống Quản lý An toàn' cần thực hiện ngay trước hạn thực hiện 1 tuần:</br>";
                body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                body = body + " align='left'>";
                body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                body = body + " <td align=center width='40px' height='30px'><b>STT</b></td>";
                body = body + " <td align=center width='120px' height='30px'><b>Hành động</b></td>";
                body = body + " <td align=center width='100px'><b>Hạn thực hiện</b></td>";
                body = body + " </tr>";
                for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                {
                    body = body + " <tr align=center valign='middle'>";
                    body = body + " <td align=left width='40px' valign='middle'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                    body = body + " <td align=left width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                    body = body + " <td align=center width='120px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                    body = body + " </tr>";
                }
                body = body + " </table></br>";
                body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện các hành động được đề xuất theo đúng thời hạn.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_TruocHanThucHien1TuanAudit", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailTruocHanThucHien1Ngay(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện Hành động khắc phục, phòng ngừa từ Ecomaint/Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();
                body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                body = body + "Danh sách các hành động cần thực hiện ngay trước hạn thực hiện 1 ngày:</br>";
                body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                body = body + " align='left'>";
                body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                body = body + " <td align=center width='120px' height='30px'><b>Chứng từ</b></td>";
                body = body + " <td align=center  width='150px'><b>Loại chứng từ</b></td>";
                body = body + " <td align=center  width='300px'><b>Hành động</b></td>";
                body = body + " <td align=center  width='200px'><b>Người thực hiện</b></td>";
                body = body + " <td align=center width='100px'><b>Hạn thực hiện</b></td>";
                body = body + " </tr>";
                for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                {
                    body = body + " <tr align=center valign='middle'>";
                    body = body + " <td align=center width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                    body = body + " <td align=center  width='150px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                    body = body + " <td align=left  width='300px'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                    body = body + " <td align=center width='200px'>" + dtlistmail.Rows[i][5].ToString() + "</td>";
                    body = body + " <td align=center width='120px'>" + dtlistmail.Rows[i][6].ToString() + "</td>";
                    body = body + " </tr>";
                }
                body = body + " </table></br>";
                body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện các hành động khắc phục, phòng ngừa được đề xuất theo đúng thời hạn.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_TruocHanThucHien1Ngay", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailNhacDuyetChungTu(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện duyệt báo cáo Ecomaint/Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();

                

                if (mailto.ToLower().Contains("paulo.hladchuk@bariaserece.com") == true)
                {
                    subject = "Please review reports from Ecomaint/Safety";
                    body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                    body = body + "List of reports is needed to review now:</br>";
                    body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                    body = body + " align='left'>";
                    body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                    body = body + " <td align=center width='120px' height='30px'><b>Doc. No.</b></td>";
                    body = body + " <td align=center  width='150px'><b>Doc. Type</b></td>";
                    body = body + " <td align=center  width='200px'><b>Create date</b></td>";
                    body = body + " <td align=center  width='200px'><b>Create by</b></td>";
                    body = body + " </tr>";
                    for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                    {
                        body = body + " <tr align=center valign='middle'>";
                        body = body + " <td align=center width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                        body = body + " <td align=center  width='150px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                        body = body + " <td align=left  width='200px'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                        body = body + " <td align=center width='200px'>" + dtlistmail.Rows[i][5].ToString() + "</td>";
                        body = body + " </tr>";
                    }
                    body = body + " </table></br>";
                    body = body + "Please log in Ecomaint/Safety Software to review reports.</br>";
                    body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                }
                else
                {
                    body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                    body = body + "Danh sách các báo cáo cần duyệt ngay:</br>";
                    body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                    body = body + " align='left'>";
                    body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                    body = body + " <td align=center width='120px' height='30px'><b>Chứng từ</b></td>";
                    body = body + " <td align=center  width='150px'><b>Loại chứng từ</b></td>";
                    body = body + " <td align=center  width='200px'><b>Ngày tạo</b></td>";
                    body = body + " <td align=center  width='200px'><b>Người tạo</b></td>";
                    body = body + " </tr>";
                    for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                    {
                        body = body + " <tr align=center valign='middle'>";
                        body = body + " <td align=center width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                        body = body + " <td align=center  width='150px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                        body = body + " <td align=left  width='200px'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                        body = body + " <td align=center width='200px'>" + dtlistmail.Rows[i][5].ToString() + "</td>";
                        body = body + " </tr>";
                    }
                    body = body + " </table></br>";
                    body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để duyệt báo cáo.</br>";
                    body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                }

                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_NhacDuyetBaoCao", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailHetHanThucHienAudit(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện Hành động hệ thống quản lý an toàn Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();
                body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                body = body + "Danh sách các hành động trong Mục 2.6 'Hệ thống Quản lý An toàn' đang <b>Overdue</b> cần thực hiện ngay:</br>";
                body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                body = body + " align='left'>";
                body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                body = body + " <td align=center width='40px' height='30px'><b>STT</b></td>";
                body = body + " <td align=center width='120px' height='30px'><b>Hành động</b></td>";
                body = body + " <td align=center width='100px'><b>Hạn thực hiện</b></td>";
                body = body + " </tr>";
                for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                {
                    body = body + " <tr align=center valign='middle'>";
                    body = body + " <td align=left width='40px' valign='middle'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                    body = body + " <td align=left width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                    body = body + " <td align=center width='120px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                    body = body + " </tr>";
                }
                body = body + " </table></br>";
                body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện ngay các hành động được đề xuất.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_HetHanThucHienAudit", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }
        private void GuiMailHetHanThucHien(DataTable dtlistmail)
        {
            try
            {
                string mailto = "";
                string subject = "Thực hiện Hành động khắc phục, phòng ngừa từ Ecomaint/Safety";
                string body = "";
                if (dtlistmail.Rows.Count == 0) return;
                mailto = dtlistmail.Rows[0][0].ToString();

                body = "Dear <b>" + dtlistmail.Rows[0][1].ToString() + "</b></br>";
                body = body + "Danh sách các hành động đang <b>Overdue</b> cần thực hiện ngay:</br>";
                body = body + "<table style='width:100%;' border='1' cellpadding='1' cellspacing='1'";
                body = body + " align='left'>";
                body = body + " <tr bgcolor=ActiveCaption align='center' valign='middle'>";
                body = body + " <td align=center width='120px' height='30px'><b>Chứng từ</b></td>";
                body = body + " <td align=center  width='150px'><b>Loại chứng từ</b></td>";
                body = body + " <td align=center  width='300px'><b>Hành động</b></td>";
                body = body + " <td align=center  width='200px'><b>Người thực hiện</b></td>";
                body = body + " <td align=center width='100px'><b>Hạn thực hiện</b></td>";
                body = body + " </tr>";
                for (int i = 0; i <= dtlistmail.Rows.Count - 1; i++)
                {
                    body = body + " <tr align=center valign='middle'>";
                    body = body + " <td align=center width='120px' valign='middle'>" + dtlistmail.Rows[i][2].ToString() + "</td>";
                    body = body + " <td align=center  width='150px'>" + dtlistmail.Rows[i][3].ToString() + "</td>";
                    body = body + " <td align=left  width='300px'>" + dtlistmail.Rows[i][4].ToString() + "</td>";
                    body = body + " <td align=center width='200px'>" + dtlistmail.Rows[i][5].ToString() + "</td>";
                    body = body + " <td align=center width='120px'>" + dtlistmail.Rows[i][6].ToString() + "</td>";
                    body = body + " </tr>";
                }
                body = body + " </table></br>";
                body = body + "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện ngay các hành động khắc phục, phòng ngừa được đề xuất.</br>";
                body = body + "Thanks & Best regards.</br></br></br></br></br></br></br></br></br></br>";
                string s = "";
                //s = Commons.Modules.MMail.MSendEmail(mailto, "", Commons.Modules.sMailFrom, Commons.Modules.sMailFromPass, subject, body, "", Commons.Modules.sMailFromSmtp, Commons.Modules.sMailFromPort);
                s = mail.SendMail(mailto, subject, body, "", "","");
                if (s == "")
                {
                    s = "Suscess sent to " + mailto;
                }
                MInternet.GhiLog(Application.StartupPath.ToString(), s, "Safety_HetHanThucHien", NgayGioHT);
            }
            catch (Exception)
            {

                throw;
            }


        }

        #endregion

        private void label1_DoubleClick(object sender, EventArgs e)
        {
            //#region "test"
            //DateTime Ngay = DateTime.Now;
            //DateTime Ngay = DateTime.Parse("2016-03-22 08:00:00.000");
            //NgayGioHT = Ngay.Date.AddHours(Ngay.Hour).AddMinutes(Ngay.Minute);
            //HIEU_LUC = 1 AND
            DataTable dtDSMail = new DataTable();
            dtDSMail.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text,
                "SELECT * FROM MAIL_SCHEDULES A INNER JOIN DS_MAIL B ON A.ID_SCHEDULES = B.ID_SCHEDULES WHERE  " +
                    "  A.ID_SCHEDULES = 1 and id = 32"));
            if (dtDSMail.Rows.Count == 0) return;
            TaoDuLieu(dtDSMail);
            //#endregion
        }
        
    }
}
