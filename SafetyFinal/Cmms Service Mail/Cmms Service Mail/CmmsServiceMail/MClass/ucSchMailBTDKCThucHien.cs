using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks.Data;

namespace CmmsServiceMail.MClass
{
    class ucSchMailBTDKCThucHien
    {
        public void InPBTCTT(DataTable dtSch)
        {
            DataTable tbData = new DataTable();
            try
            {
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

                tbData.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_BTDK_NHAC_VIEC", sUserName,
                    TNgay, DNgay, "-1", "-1", -1, sThietBi, sUserName, "-1", "-1", "-1"));


                DataTable vtbLg = new DataTable();
                DataSet dvBC = new DataSet();

                CmmsServiceMail.MClass.MLoadReport Mload = new CmmsServiceMail.MClass.MLoadReport();
                tbData.TableName = "BAO_TRI_DINH_KY_CAN_THUC_HIEN";
                vtbLg = LoadNNBTDKCTH(NNgu, TNgay, DNgay);
                vtbLg.TableName = "TIEU_DE_BAO_TRI_DINH_KY_CAN_THUC_HIEN";
                Mload.AddDataTableSource(tbData);
                Mload.AddDataTableSource(vtbLg);
                Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + dtSch.Rows[0]["ID"].ToString(), System.Windows.Forms.Application.StartupPath, NNgu);
            }
            catch { }


        }

        private DataTable LoadNNBTDKCTH(int NNgu, DateTime TNgay, DateTime DNgay)
        {
            DataTable vtb = new DataTable();
            for (int i = 0; i < 12; i++)
            {
                vtb.Columns.Add();
            }
            vtb.Columns[0].ColumnName = "TIEU_DE";
            vtb.Columns[1].ColumnName = "TU_NGAY";
            vtb.Columns[2].ColumnName = "DEN_NGAY";
            vtb.Columns[3].ColumnName = "DieuKienLoc";
            vtb.Columns[4].ColumnName = "MS_MAY";
            vtb.Columns[5].ColumnName = "TEN_MAY";
            vtb.Columns[6].ColumnName = "LOAI_BT";
            vtb.Columns[7].ColumnName = "NgayChuanCuoi";
            vtb.Columns[8].ColumnName = "ChuKy";
            vtb.Columns[9].ColumnName = "NgayChuanKeTiep";
            vtb.Columns[10].ColumnName = "TenNhaXuong";
            vtb.Columns[11].ColumnName = "TenNhomMay";

            DataRow vRowTitle = vtb.NewRow();

            vRowTitle["TIEU_DE"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "TIEU_DE", NNgu);
            vRowTitle["TU_NGAY"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "TU_NGAY", NNgu) + " " + TNgay.Date.ToShortDateString();
            vRowTitle["DEN_NGAY"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "DEN_NGAY", NNgu) + " " + DNgay.Date.ToShortDateString();
            //vRowTitle["DieuKienLoc"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "ThietBi", NNgu) + "  " + CboKL.Text + ": " + CboNX.Text + " - " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "LoaiThietBi", NNgu) + ": " + CboLTB.Text;
            vRowTitle["MS_MAY"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "MS_MAY", NNgu);
            vRowTitle["TEN_MAY"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "TEN_MAY", NNgu);
            vRowTitle["LOAI_BT"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "LOAI_BT", NNgu);
            vRowTitle["NgayChuanCuoi"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "NgayChuanCuoi", NNgu);
            vRowTitle["ChuKy"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "ChuKy", NNgu);
            vRowTitle["NgayChuanKeTiep"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "NgayChuanKeTiep", NNgu);
            vRowTitle["TenNhaXuong"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "TenNhaXuong", NNgu);
            vRowTitle["TenNhomMay"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN", "TenNhomMay", NNgu);
            vtb.Rows.Add(vRowTitle);
            return vtb;
        }

    }
}
