using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks.Data;

namespace CmmsServiceMail.MClass
{
    class ucSchMailPGSTTDHKT
    {

        public Boolean InGSTT(DataTable dtSch)
        {
            try
            {
                DataTable TbTSGSTT = new DataTable();
                DateTime TNgay, DNgay;
                string sUserName, sThietBi;
                int NNgu, iSNgay;
                Boolean SauNgayBD;
                sThietBi = "";
                SauNgayBD = false;
                iSNgay = 0;
                NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
                sUserName = dtSch.Rows[0]["USERNAME"].ToString();

                if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
                {
                    string sStmp;
                    sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                    string[] chuoi_tach = sStmp.Split(new Char[] { ',' });
                    int i = 0;

                    foreach (string s in chuoi_tach)
                    {
                        if (i == 0) sThietBi = s;

                        if (i == 1)
                            if (s.Trim() == "0") SauNgayBD = false; else SauNgayBD = true;

                        if (i == 2) iSNgay = int.Parse(s);
                        i++;
                    }
                }

                //If SauNgayBD = true nghia la in tu ngay bat dau in (tu ngay) + them so ngay ra den ngay
                //If SauNgayBD = false nghia la Ngay bat dau in la den ngay - di so ngay ra tu ngay.
                if (SauNgayBD)
                {
                    TNgay = DateTime.Now.Date;
                    DNgay = TNgay.AddDays(Convert.ToDouble(iSNgay));
                }
                else
                {
                    DNgay = DateTime.Now.Date;
                    TNgay = DNgay.AddDays(Convert.ToDouble(-iSNgay));
                }

                TbTSGSTT.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_TSGSTTDHKT", sUserName,
                    NNgu, TNgay, DNgay, "-1", -1, "-1", sThietBi, "-1", "-1", "-1"));

                DataTable vtbLg = new DataTable();
                DataSet dvBC = new DataSet();

                CmmsServiceMail.MClass.MLoadReport Mload = new CmmsServiceMail.MClass.MLoadReport();
                TbTSGSTT.TableName = "TINH_TRANG_THIET_BI";
                vtbLg = LoadNNPGSTTDHKT(NNgu, TNgay, DNgay);
                vtbLg.TableName = "TIEU_DE_TINH_TRANG_THIET_BI";
                Mload.AddDataTableSource(TbTSGSTT);
                Mload.AddDataTableSource(vtbLg);

                if (!Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptTINH_TRANG_THIET_BI",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + dtSch.Rows[0]["ID"].ToString(), 
                    System.Windows.Forms.Application.StartupPath, NNgu)) return false;
            }
            catch { return false; }
            return true;

        }

        private DataTable LoadNNPGSTTDHKT(int NNgu, DateTime TNgay, DateTime DNgay)
        {
            DataTable vtb = new DataTable();
            for (int i = 0; i < 14; i++)
            {
                vtb.Columns.Add();
            }
            vtb.Columns[0].ColumnName = "TIEU_DE";
            vtb.Columns[1].ColumnName = "TU_NGAY";
            vtb.Columns[2].ColumnName = "DEN_NGAY";
            vtb.Columns[3].ColumnName = "DieuKienLoc";
            vtb.Columns[4].ColumnName = "BoPhan";
            vtb.Columns[5].ColumnName = "ThongSoGiamSat";
            vtb.Columns[6].ColumnName = "GiaTri";
            vtb.Columns[7].ColumnName = "Dat";
            vtb.Columns[8].ColumnName = "NgayGSCuoi";
            vtb.Columns[9].ColumnName = "ChuKy";
            vtb.Columns[10].ColumnName = "NgayGSKe";
            vtb.Columns[11].ColumnName = "KetQuaKT";
            vtb.Columns[12].ColumnName = "DiaDiem";
            vtb.Columns[13].ColumnName = "ThietBi";

            DataRow vRowTitle = vtb.NewRow();
            vRowTitle["TIEU_DE"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "TIEU_DE", NNgu);
            vRowTitle["TIEU_DE"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "TIEU_DE", NNgu);
            vRowTitle["TU_NGAY"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "TU_NGAY", NNgu) + " " + TNgay.ToShortDateString();
            vRowTitle["DEN_NGAY"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "DEN_NGAY", NNgu) + " " + DNgay.ToShortDateString();
            vRowTitle["DieuKienLoc"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "DieuKienLoc", NNgu) + " ALL ";
            vRowTitle["BoPhan"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "BoPhan", NNgu);
            vRowTitle["ThongSoGiamSat"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "ThongSoGiamSat", NNgu);
            vRowTitle["GiaTri"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "GiaTri", NNgu);
            vRowTitle["Dat"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "Dat", NNgu);
            vRowTitle["NgayGSCuoi"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "NgayGSCuoi", NNgu);
            vRowTitle["ChuKy"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "ChuKy", NNgu);
            vRowTitle["NgayGSKe"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "NgayGSKe", NNgu);
            vRowTitle["KetQuaKT"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "KetQuaKT", NNgu);
            vRowTitle["DiaDiem"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "DiaDiem", NNgu);
            vRowTitle["ThietBi"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "ThietBi", NNgu);
            vtb.Rows.Add(vRowTitle);
            return vtb;
        }

    }
}
