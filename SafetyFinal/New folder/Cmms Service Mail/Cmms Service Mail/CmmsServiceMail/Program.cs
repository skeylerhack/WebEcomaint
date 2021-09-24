using System;
using System.Collections.Generic;
using System.Windows.Forms;
using System.Threading;
using System.IO;

namespace VSMail
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            try
            {
                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);


                //Commons.Modules.TypeLanguage = 0;
                //Commons.IConnections.Server = ".";
                //Commons.IConnections.Database = "CMMS_DEMO1";
                //Commons.IConnections.Password = "123";
                //Commons.IConnections.Username = "sa";

                //Commons.IConnections.Server = ".\\SQL2014";
                //Commons.IConnections.Database = "CMMS_ECO";

                //Commons.Modules.sMailFrom = "ecomaint.cmms@gmail.com";
                //Commons.Modules.sMailFromPass = "Namviet@2017";
                //Commons.Modules.sMailFromSmtp = "smtp.gmail.com";
                //Commons.Modules.sMailFromPort = "587";
                //Commons.Modules.sPrivate = "VECO";



                Application.EnableVisualStyles();
                Application.SetCompatibleTextRenderingDefault(false);

                FileStream inputstream = File.OpenRead(Application.StartupPath + "\\VSConfig.ini");
                string sChuoi;
                StreamReader sFileInclude;
                sFileInclude = File.OpenText(Application.StartupPath + "\\VSConfig.ini");

                sChuoi = sFileInclude.ReadToEnd();
                sChuoi = Commons.Modules.ObjSystems.GiaiMaDL(sChuoi);
                string[] sArr = sChuoi.Split(new Char[] { '!' });

                Commons.IConnections.Server = sArr[0].ToString();
                Commons.IConnections.Database = sArr[1].ToString();
                Commons.IConnections.Username = sArr[2].ToString();
                Commons.IConnections.Password = sArr[3].ToString();
                Commons.Modules.TypeLanguage = int.Parse(sArr[4].ToString());
                Commons.Modules.ModuleName = "ECOMAIN";



                //Commons.IConnections.Server = ".\\SQL2014";
                //Commons.IConnections.Database = "CMMS_ECO_MAIL";

                Commons.Modules.sMailFrom = "ecomaint@veco.vn";
                Commons.Modules.sMailFromPass = "P@ssword123456";
                Commons.Modules.sMailFromSmtp = "smtp.gmail.com";
                Commons.Modules.sMailFromPort = "587";
                Commons.Modules.sPrivate = "VECO";

                //Ecomaint@veco.vn / pass: P@ssword123456
                //Imap.gmail.com ssl port 993
                //Smtp.gmail.com tls port 587
                bool firstInstance;
                using (Mutex mutex = new Mutex(true, "MMail", out firstInstance))
                {
                    if (firstInstance)
                    {
                        Application.Run(new frmCMMSMailServer());
                    }
                    //else MessageBox.Show("Ứng dụng đang chạy...", "zstar");
                }

            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message);
            }

            
        }
    }
}
