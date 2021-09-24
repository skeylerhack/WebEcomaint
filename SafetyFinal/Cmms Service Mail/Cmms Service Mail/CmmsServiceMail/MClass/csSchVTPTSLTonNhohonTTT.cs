using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks.Data;

namespace CmmsServiceMail.MClass
{
    class csSchVTPTSLTonNhohonTTT
    {
        public void InVTPT(DataTable dtSch)
        {
            int LPT, MsKho, NNgu;
            string sStmp;
            sStmp = dtSch.Rows[0]["DK_BAOCAO"].ToString();
            string[] chuoi_tach = sStmp.Split(new Char[] { ',' });
            int i = 0;
            LPT = -1;
            MsKho = -1;


            foreach (string s in chuoi_tach)
            {

                if (i == 0) LPT = int.Parse(s);
                if (i == 1) MsKho = int.Parse(s);
                i++;
            }
            NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());

            string KhongKho;

            KhongKho = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmReminder_new", "KhongKho", NNgu);


            DataTable TbVTPTSLNHTTT = new DataTable();
            try
            {
                TbVTPTSLNHTTT.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_VTPT_SLNH_SLTTT",
                    NNgu, LPT, KhongKho, MsKho));
            }
            catch { }


            DataTable vtbLg = new DataTable();
            DataSet dvBC = new DataSet();


            if (TbVTPTSLNHTTT.Rows.Count > 0)
            {
                CmmsServiceMail.MClass.MLoadReport Mload = new CmmsServiceMail.MClass.MLoadReport();
                TbVTPTSLNHTTT.TableName = "VTPT_NHO_HON_TON_TOI_THIEU";
                vtbLg = LoadNNVTPT(NNgu, LPT);
                vtbLg.TableName = "TIEU_DE_VTPT_NHO_HON_TON_TOI_THIEU";
                Mload.AddDataTableSource(TbVTPTSLNHTTT);
                Mload.AddDataTableSource(vtbLg);
                Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptVTPT_NHO_HON_TON_TOI_THIEU",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + dtSch.Rows[0]["ID"].ToString(), System.Windows.Forms.Application.StartupPath, NNgu);
            }

        }

        private DataTable LoadNNVTPT(int NNgu, int LPT)
        {
            DataTable vtb = new DataTable();
            for (int i = 0; i < 12; i++)
            {
                vtb.Columns.Add();
            }
            vtb.Columns[0].ColumnName = "TIEU_DE";
            vtb.Columns[1].ColumnName = "DieuKienLoc";
            vtb.Columns[2].ColumnName = "MS_VTPT";
            vtb.Columns[3].ColumnName = "TEN_VTPT";
            vtb.Columns[4].ColumnName = "LOAI_VTPT";
            vtb.Columns[5].ColumnName = "TON_TOI_THIEU";
            vtb.Columns[6].ColumnName = "TON_HIEN_TAI";
            vtb.Columns[7].ColumnName = "VAT_TU";
            vtb.Columns[8].ColumnName = "STT";

            vtb.Columns[9].ColumnName = "MS_PT_NCC";
            vtb.Columns[10].ColumnName = "QUY_CACH";
            vtb.Columns[11].ColumnName = "TEN_KHO";


            DataRow vRowTitle = vtb.NewRow();

            string TenLPT;
            TenLPT = "";
            if (LPT == -1) TenLPT = " < ALL > ";
            else
            {
                if (NNgu == 0)
                {
                    if (LPT == 0) TenLPT = "Phụ tùng";
                    if (LPT == 1) TenLPT = "Vật tư";

                }
                else
                {
                    if (LPT == 0) TenLPT = "Spare part";
                    if (LPT == 1) TenLPT = "Material";
                }
            }

            vRowTitle["TIEU_DE"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "TIEU_DE", NNgu);
            vRowTitle["DieuKienLoc"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "DieuKienLoc", NNgu) +
                Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "LoaiThietBi", NNgu) + ": " + TenLPT;
            vRowTitle["MS_VTPT"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "MS_VTPT", NNgu);
            vRowTitle["TEN_VTPT"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "TEN_VTPT", NNgu);
            vRowTitle["LOAI_VTPT"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "LOAI_VTPT", NNgu);
            vRowTitle["TON_TOI_THIEU"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "TON_TOI_THIEU", NNgu);
            vRowTitle["TON_HIEN_TAI"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "TON_HIEN_TAI", NNgu);
            vRowTitle["VAT_TU"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "VAT_TU", NNgu);
            vRowTitle["STT"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "STT", NNgu);
            vRowTitle["MS_PT_NCC"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "MS_PT_NCC", NNgu);
            vRowTitle["QUY_CACH"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "QUY_CACH", NNgu);
            vRowTitle["TEN_KHO"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "TEN_KHO", NNgu);


            vtb.Rows.Add(vRowTitle);

            return vtb;
        }


    }
}
