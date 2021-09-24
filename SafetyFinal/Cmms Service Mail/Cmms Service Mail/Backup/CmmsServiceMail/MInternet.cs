using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;
using System.IO;
using System.Data;
using Microsoft.ApplicationBlocks.Data;
//using CrystalDecisions.CrystalReports.Engine;
//using CrystalDecisions.Shared;

namespace VSMail
{
    [Flags]
    enum eConnectionState : int
    {
        INTERNET_CONNECTION_MODEM = 0x1, INTERNET_CONNECTION_LAN = 0x2, INTERNET_CONNECTION_PROXY = 0x4, INTERNET_RAS_INSTALLED = 0x10, INTERNET_CONNECTION_OFFLINE = 0x20, INTERNET_CONNECTION_CONFIGURED = 0x40
    }
    class MInternet
    {
        [DllImport("wininet.dll", CharSet = CharSet.Auto)]
        static extern bool InternetGetConnectedState(ref eConnectionState lpdwFlags, int dwReserved);

        public MInternet()
        {
            
        }

        public static bool IsConnectedToInternet()
        {
            eConnectionState Description = 0;
            bool conn = InternetGetConnectedState(ref Description, 0);
            return conn;
        }

        public static bool GhiLog(string sPath, string NoiDung, string TenBaoCao, DateTime NgayGioGoi)
        {
            StreamWriter sW = new StreamWriter(sPath + System.IO.Path.DirectorySeparatorChar + "sMailLog.txt",true);
            try
            {
                sW.WriteLine(NgayGioGoi.ToShortDateString() + ":" + NgayGioGoi.ToShortTimeString() + " " + TenBaoCao + ": " + NoiDung +". ");
            }
            catch { }
            sW.Close();
            return true;
        }
    }
}
