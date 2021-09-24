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


                //Commons.IConnections.Database = "CMMS_demo";
                //Commons.IConnections.Username = "sa";
                //Commons.IConnections.Password = "123";
                //Commons.Modules.UserName = "admin";

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
