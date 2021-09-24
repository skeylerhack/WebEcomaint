using System;
using System.Linq;
using System.Data;
using Microsoft.ApplicationBlocks.Data;
using System.Windows.Forms;

namespace VSMail.MClass
{
    class MBaoCao
    {
        
        #region InVTPT
        public Boolean InVTPT(DataTable dtSch, out int iCoDuLieu, out string sLoi)
        {
            iCoDuLieu = 1;
            sLoi = "";
            try
            {
                int LPT, MsKho, NNgu;
                string sStmp, sUserName;
                sStmp = dtSch.Rows[0]["DK_BAOCAO"].ToString();
                sUserName = dtSch.Rows[0]["USERNAME"].ToString();

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
                    try
                    {
                        TbVTPTSLNHTTT.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_VTPT_SLNH_SLTTT",
                            NNgu, LPT, KhongKho, MsKho, sUserName));
                    }
                    catch
                    {
                        TbVTPTSLNHTTT.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_VTPT_SLNH_SLTTT",
                            NNgu, LPT, KhongKho, MsKho));
                    }

                }
                catch (Exception ex)
                {
                    sLoi = ex.Message.ToString();
                }
                if (TbVTPTSLNHTTT.Rows.Count <= 0)
                {
                    iCoDuLieu = 0;
                    return false;
                }

                DataTable vtbLg = new DataTable();
                DataSet dvBC = new DataSet();

                VSMail.MClass.MLoadReport Mload = new VSMail.MClass.MLoadReport();
                TbVTPTSLNHTTT.TableName = "VTPT_NHO_HON_TON_TOI_THIEU";
                vtbLg = LoadNNVTPT(NNgu, LPT);
                vtbLg.TableName = "TIEU_DE_VTPT_NHO_HON_TON_TOI_THIEU";
                Mload.AddDataTableSource(TbVTPTSLNHTTT);
                Mload.AddDataTableSource(vtbLg);
                return Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptVTPT_NHO_HON_TON_TOI_THIEU",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString(), System.Windows.Forms.Application.StartupPath, NNgu, out  iCoDuLieu);
            }
            catch (Exception ex)
            {
                sLoi = ex.Message.ToString();
                iCoDuLieu = 2;
                return false;
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

        #endregion

        #region InGSTT
        public Boolean InGSTT(DataTable dtSch, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
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

                if (TbTSGSTT.Rows.Count <= 0)
                {
                    iCoDuLieu = 0;
                    return false;
                }
                DataTable vtbLg = new DataTable();
                DataSet dvBC = new DataSet();

                VSMail.MClass.MLoadReport Mload = new VSMail.MClass.MLoadReport();
                TbTSGSTT.TableName = "TINH_TRANG_THIET_BI";
                vtbLg = LoadNNPGSTTDHKT(NNgu, TNgay, DNgay);
                vtbLg.TableName = "TIEU_DE_TINH_TRANG_THIET_BI";
                Mload.AddDataTableSource(TbTSGSTT);
                Mload.AddDataTableSource(vtbLg);

                return Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptTINH_TRANG_THIET_BI",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString(),
                    System.Windows.Forms.Application.StartupPath, NNgu, out iCoDuLieu);
            }
            catch
            {
                iCoDuLieu = 2;
                return false; }

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

        #endregion

        #region InPBTCTH
        public Boolean InPBTCTH(DataTable dtSch, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
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

                if (tbData.Rows.Count <= 0)
                {
                    iCoDuLieu = 0;
                    return false;
                }
                DataTable vtbLg = new DataTable();
                DataSet dvBC = new DataSet();

                VSMail.MClass.MLoadReport Mload = new VSMail.MClass.MLoadReport();
                tbData.TableName = "BAO_TRI_DINH_KY_CAN_THUC_HIEN";
                vtbLg = LoadNNBTDKCTH(NNgu, TNgay, DNgay);
                vtbLg.TableName = "TIEU_DE_BAO_TRI_DINH_KY_CAN_THUC_HIEN";
                Mload.AddDataTableSource(tbData);
                Mload.AddDataTableSource(vtbLg);

                return Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptBAO_TRI_DINH_KY_CAN_THUC_HIEN",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString(), 
                    System.Windows.Forms.Application.StartupPath, NNgu, out iCoDuLieu);
            }
            catch
            {
                iCoDuLieu = 2;
                return false; }
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
        #endregion

        #region Phieu Bao Tri Qua Han Ket Thuc

        public Boolean InPBTQHKT(DataTable dtSch, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                DataTable TbPBTQHKT = new DataTable();                
                string sUserName, sThietBi;
                int NNgu;
                sThietBi = "";
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
                        i++;
                    }
                }

                TbPBTQHKT.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_PBQHKT",
                    sUserName, NNgu, "-1", -1, "-1", sThietBi, "-1", "-1", "-1"));
                if (TbPBTQHKT.Rows.Count <= 0)
                {
                    iCoDuLieu = 0;
                    return false;
                }
                DataTable vtbLg = new DataTable();
                DataSet dvBC = new DataSet();

                VSMail.MClass.MLoadReport Mload = new VSMail.MClass.MLoadReport();
                TbPBTQHKT.TableName = "PHIEU_BAO_TRI_QUA_HAN_KT";
                vtbLg = LoadNNPBTQHKetThuc(NNgu);
                vtbLg.TableName = "TIEU_DE_PHIEU_BAO_TRI_QUA_HAN_KT";
                Mload.AddDataTableSource(TbPBTQHKT);
                Mload.AddDataTableSource(vtbLg);

                return Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptPHIEU_BAO_TRI_QUA_HAN_KT",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString(),
                    System.Windows.Forms.Application.StartupPath, NNgu, out iCoDuLieu);
            }
            catch
            {
                iCoDuLieu = 2;
                return false; }
        }

        private DataTable LoadNNPBTQHKetThuc(int NNgu)
        {
            DataTable vtb = new DataTable();
            for (int i = 0; i < 9; i++)
            {
                vtb.Columns.Add();
            }
            vtb.Columns[0].ColumnName = "TIEU_DE";
            vtb.Columns[1].ColumnName = "DieuKienLoc";
            vtb.Columns[2].ColumnName = "MSPhieuBaoTri";
            vtb.Columns[3].ColumnName = "LoaiBT";
            vtb.Columns[4].ColumnName = "Ten_May";
            vtb.Columns[5].ColumnName = "NgayChuanCuoi";
            vtb.Columns[6].ColumnName = "ChuKy";
            vtb.Columns[7].ColumnName = "NgayBDKeTiep";
            vtb.Columns[8].ColumnName = "TenNhaXuong";

            DataRow vRowTitle = vtb.NewRow();
            vRowTitle["TIEU_DE"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "TIEU_DE", NNgu);
            //vRowTitle["DieuKienLoc"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "DieuKienLoc", NNgu) + "  " + CboKL.Text + ": " + CboNX.Text + " - " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "LoaiThietBi", NNgu) + ": " + CboLTB.Text;
            vRowTitle["MSPhieuBaoTri"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "MSPhieuBaoTri", NNgu);
            vRowTitle["LoaiBT"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "LoaiBT", NNgu);
            vRowTitle["Ten_May"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "Ten_May", NNgu);
            vRowTitle["NgayChuanCuoi"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "NgayChuanCuoi", NNgu);
            vRowTitle["NgayBDKeTiep"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "NgayBDKeTiep", NNgu);
            vRowTitle["TenNhaXuong"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptPHIEU_BAO_TRI_QUA_HAN_KT", "TenNhaXuong", NNgu);
            vtb.Rows.Add(vRowTitle);
            return vtb;
        }
        #endregion

        #region Phieu Bao Tri Trong Ngay
        public Boolean InPBTTrongNgay(DataTable dtSch, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                DataTable dtData = new DataTable();                
                string sUserName, sThietBi;
                int NNgu;
                sThietBi = "";
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
                        i++;
                    }
                }
                dtData.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_PBTTN", sUserName,
                    NNgu, "-1", -1, "-1", sThietBi, "-1", "-1", "-1"));
                #region Kiem co du lieu
                try
                {
                    if (dtData.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch { }
                #endregion
                DataTable vtbLg = new DataTable();
                DataSet dvBC = new DataSet();

                VSMail.MClass.MLoadReport Mload = new VSMail.MClass.MLoadReport();
                dtData.TableName = "BAO_TRI_TRONG_NGAY";
                vtbLg = LoadNNPBTTrongNgay(NNgu);
                vtbLg.TableName = "TIEU_DE_BAO_TRI_TRONG_NGAY";
                Mload.AddDataTableSource(dtData);
                Mload.AddDataTableSource(vtbLg);

                return Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptBAO_TRI_TRONG_NGAY",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString(),
                    System.Windows.Forms.Application.StartupPath, NNgu, out iCoDuLieu);
            }
            catch
            {
                iCoDuLieu = 2;
                return false; }
        }

        private DataTable LoadNNPBTTrongNgay(int NNgu)
        {
            DataTable vtb = new DataTable();
            for (int i = 0; i < 9; i++)
            {
                vtb.Columns.Add();
            }
            vtb.Columns[0].ColumnName = "TIEU_DE";
            vtb.Columns[1].ColumnName = "DieuKienLoc";
            vtb.Columns[2].ColumnName = "MSPhieuBaoTri";
            vtb.Columns[3].ColumnName = "LoaiBT";
            vtb.Columns[4].ColumnName = "Ten_May";
            vtb.Columns[5].ColumnName = "NgayChuanCuoi";
            vtb.Columns[6].ColumnName = "ChuKy";
            vtb.Columns[7].ColumnName = "NgayBDKeTiep";
            vtb.Columns[8].ColumnName = "TenNhaXuong";

            DataRow vRowTitle = vtb.NewRow();
            vRowTitle["TIEU_DE"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "TIEU_DE", NNgu);
            //vRowTitle["DieuKienLoc"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "DieuKienLoc", NNgu) + "  " + CboKL.Text + ": " + CboNX.Text + " - " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTINH_TRANG_THIET_BI", "LoaiThietBi", NNgu) + ": " + CboLTB.Text;
            vRowTitle["MSPhieuBaoTri"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "MSPhieuBaoTri", NNgu);
            vRowTitle["LoaiBT"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "LoaiBT", NNgu);
            vRowTitle["Ten_May"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "Ten_May", NNgu);
            vRowTitle["NgayChuanCuoi"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "NgayChuanCuoi", NNgu);
            vRowTitle["ChuKy"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "ChuKy", NNgu);
            vRowTitle["NgayBDKeTiep"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "NgayBDKeTiep", NNgu);
            vRowTitle["TenNhaXuong"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBAO_TRI_TRONG_NGAY", "TenNhaXuong", NNgu);
            vtb.Rows.Add(vRowTitle);
            return vtb;
        }
        #endregion

        #region Thiet Bi Den han hieu Chuan
        public Boolean InThietBiDenHanHieuChuan(DataTable dtSch, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            DataTable tbData = new DataTable();
            DataTable tbTmp = new DataTable();
            try
            {
                DateTime TNgay, DNgay;
                string sUserName, sThietBi, sLoaiHC;
                int NNgu, iSNgay;
                Boolean SauNgayBD;
                sThietBi = "";
                SauNgayBD = false;
                iSNgay = 0;
                sLoaiHC = "0";
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

                        if (i == 1) sLoaiHC = s.Trim();

                        if (i == 2)
                            if (s.Trim() == "0") SauNgayBD = false; else SauNgayBD = true;

                        if (i == 3) iSNgay = int.Parse(s);
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

                tbData.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_TBDHHC", sUserName,
                    NNgu, TNgay, DNgay, "-1", -1, "-1", sThietBi, "-1", "-1", "-1"));

                foreach (DataColumn Dgvcl in tbData.Columns)
                {
                    //Dgvcl.DataPropertyName = Dgvcl.Name.Replace("_1", String.Empty);
                    Dgvcl.ColumnName = Dgvcl.ColumnName + "_1"; //Dgvcl.ColumnName.Replace("_1", String.Empty);
                }

                tbTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_DCDDHHC", sUserName,
                    NNgu, TNgay, DNgay, "-1", -1, "-1", sThietBi, sUserName, "-1", "-1", "-1"));


                DataView DtvHC = new DataView();
                switch (sLoaiHC)
                {
                    case "0":
                        DtvHC = new DataView(tbTmp, "NOI = 1", String.Empty, DataViewRowState.CurrentRows);
                        break;
                    case "1":
                        DtvHC = new DataView(tbTmp, "NOI = 0", String.Empty, DataViewRowState.CurrentRows);
                        break;
                    case "2":
                        DtvHC = new DataView(tbTmp, "NOI = 2", String.Empty, DataViewRowState.CurrentRows);
                        break;
                    case "3":
                        DtvHC = new DataView(tbTmp, "NOI = 3", String.Empty, DataViewRowState.CurrentRows);
                        break;
                    default:
                        DtvHC = new DataView(tbTmp, String.Empty, String.Empty, DataViewRowState.CurrentRows);
                        break;
                }

                foreach (DataColumn Dgvcl in tbTmp.Columns)
                {
                    //Dgvcl.DataPropertyName = Dgvcl.Name.Replace("_1", String.Empty);
                    Dgvcl.ColumnName = Dgvcl.ColumnName + "_11"; //Dgvcl.ColumnName.Replace("_1", String.Empty);
                }
                try
                {
                    if ((tbData.Rows.Count + tbTmp.Rows.Count) <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch { }
                DataTable vtbLg = new DataTable();
                DataSet dvBC = new DataSet();

                VSMail.MClass.MLoadReport Mload = new VSMail.MClass.MLoadReport();
                tbData.TableName = "THIET_BI_DEN_HAN_HIEU_CHUAN";
                tbTmp.TableName = "DUNG_CU_DO_DEN_HAN_HIEU_CHUAN";
                vtbLg = LoadNNTBDenHanHC(NNgu, TNgay, DNgay);
                vtbLg.TableName = "TIEU_DE_THIET_BI_DEN_HAN_HIEU_CHUAN";

                Mload.AddDataTableSource(tbData);
                Mload.AddDataTableSource(tbTmp);
                Mload.AddDataTableSource(vtbLg);
                return Mload.AutoExporttoPDF(System.Windows.Forms.Application.StartupPath + "\\reports\\", "rptTHIET_BI_DEN_HAN_HIEU_CHUAN",
                    dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString(),
                    System.Windows.Forms.Application.StartupPath, NNgu, out iCoDuLieu);
            }
            catch
            {
                iCoDuLieu = 2;
                return false; }
        }

        private DataTable LoadNNTBDenHanHC(int NNgu, DateTime TNgay, DateTime DNgay)
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
            vtb.Columns[4].ColumnName = "ThietBiDenHan";
            vtb.Columns[5].ColumnName = "ThietBi";
            vtb.Columns[6].ColumnName = "ViTri";
            vtb.Columns[7].ColumnName = "NgayChuanCuoi";
            vtb.Columns[8].ColumnName = "ChuKy";
            vtb.Columns[9].ColumnName = "NgayChuanKeTiep";
            vtb.Columns[10].ColumnName = "Noi";
            vtb.Columns[11].ColumnName = "TenNhaXuong";
            vtb.Columns[12].ColumnName = "MaVatTu";
            vtb.Columns[13].ColumnName = "TenVatTu";

            DataRow vRowTitle = vtb.NewRow();
            vRowTitle["TIEU_DE"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "TIEU_DE", NNgu);
            vRowTitle["TU_NGAY"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "TU_NGAY", NNgu) + "  " + TNgay.ToShortDateString();
            vRowTitle["DEN_NGAY"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "DEN_NGAY", NNgu) + "  " + DNgay.ToShortDateString();
            //vRowTitle["DieuKienLoc"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "DieuKienLoc", NNgu) + "  " + CboKL.Text + ": " + CboNX.Text + " - " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "LoaiThietBi", NNgu) + ": " + CboLTB.Text;
            vRowTitle["ThietBiDenHan"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "ThietBiDenHan", NNgu);
            vRowTitle["ThietBi"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "ThietBi", NNgu);
            vRowTitle["ViTri"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "ViTri", NNgu);
            vRowTitle["NgayChuanCuoi"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "NgayChuanCuoi", NNgu);
            vRowTitle["ChuKy"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "ChuKy", NNgu);
            vRowTitle["NgayChuanKeTiep"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "NgayChuanKeTiep", NNgu);
            vRowTitle["Noi"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "Noi", NNgu);
            vRowTitle["TenNhaXuong"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "TenNhaXuong", NNgu);
            vRowTitle["MaVatTu"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "MaVatTu", NNgu);
            vRowTitle["TenVatTu"] = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptTHIET_BI_DEN_HAN_HIEU_CHUAN", "TenVatTu", NNgu);
            vtb.Rows.Add(vRowTitle);
            return vtb;
        }
        #endregion

        #region ucMailBieuDoChiPhiTheoNX -- BDCPTNX
        public Boolean BDCPTNXInBieuDoChiPhiTheoNX(DataTable dtSch, DevExpress.XtraGrid.GridControl grd,
            DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            string sSql, sUserName, sMsNXuong,sStmp, sBCao, sStm1;
            DateTime TNgay, DNgay;            
            int NNgu,iLoaiBC, iSNgay, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5;            
            Boolean SauNgayBD;
            DataTable dtTmp = new DataTable();

            sStm1 = "";
            SauNgayBD = false;
            iSNgay = 0;
            iLoaiBC = 0;
            sSql = "";
            LChiPhi1 = 1;
            LChiPhi2 = 1;
            LChiPhi3 = 1;
            LChiPhi4 = 1;
            LChiPhi5 = 1;
            sMsNXuong = "-1";


            NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
            sUserName = dtSch.Rows[0]["USERNAME"].ToString();

            if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
            {
                
                sBCao = "";
                sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                string[] chuoi_tach = sStmp.Split(new Char[] { ',' });
                int i = 0;

                foreach (string s in chuoi_tach)
                {
                    if (i == 0) if (s.Trim() == "0") SauNgayBD = false; else SauNgayBD = true;

                    if (i == 1) iSNgay = int.Parse(s);

                    if (i == 2)
                    {
                        if (s == "0") iLoaiBC = 0;
                        if (s == "1") iLoaiBC = 1;
                        if (s == "2") iLoaiBC = 2;
                        if (s == "3") iLoaiBC = 3;
                    }

                    if (i == 3) sMsNXuong = s;

                    


                    if (i == 4)
                        if (s.Trim() == "0") LChiPhi1 = 0; else LChiPhi1 = 1;
                    if (i == 5)
                        if (s.Trim() == "0") LChiPhi2 = 0; else LChiPhi2 = 1;
                    if (i == 6)
                        if (s.Trim() == "0") LChiPhi3 = 0; else LChiPhi3 = 1;
                    if (i == 7)
                        if (s.Trim() == "0") LChiPhi4 = 0; else LChiPhi4 = 1;
                    if (i == 8)
                        if (s.Trim() == "0") LChiPhi5 = 0; else LChiPhi5 = 1;
                    if (i == 9)
                    {
                        sStm1 = sBCao.Substring(1, sBCao.Length - 1);
                        sStm1 = sStmp.Replace(sStm1, "");
                        if (sStm1 == ",ALL") break;
                        sStm1 = sStm1.Substring(1, sStm1.Length - 2);
                        break;
                    }

                    i++;
                    sBCao = sBCao + "," + s;
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
            //TNgay = DateTime.Parse("01/01/2010");
            sSql = "";
            string BTDuLieu;
            BTDuLieu = "ZZZ_BDCP_CHON_MAIL" + sUserName;
            Commons.Modules.ObjSystems.XoaTable(BTDuLieu);
            sSql = "";
            if (iLoaiBC == 0)
            {
                sSql = "SELECT CONVERT(BIT,1) AS CHON, MS_N_XUONG,TEN_N_XUONG INTO " + BTDuLieu + " FROM NHA_XUONG 	" +
                            " WHERE ISNULL(MS_CHA,'-1') = '" + sMsNXuong + "'";
                if (sStm1.ToUpper() != ",ALL".ToUpper())
                    sSql += "AND MS_N_XUONG IN ('" + sStm1.Replace(",", "','") + "')";
            }
            if (iLoaiBC == 1)
            {
                sSql = "SELECT CONVERT(BIT,1) AS CHON, 	MS_HE_THONG, TEN_HE_THONG  INTO " + BTDuLieu + " FROM HE_THONG ";
                if (sStm1.ToUpper() != ",ALL".ToUpper())
                    sSql += " WHERE MS_HE_THONG IN (" + sStm1 + ")";
            }
            if (iLoaiBC == 2)
            {
                sSql = "SELECT  CONVERT(BIT,1) AS CHON,MS_BP_CHIU_PHI,TEN_BP_CHIU_PHI  INTO " + BTDuLieu + " FROM BO_PHAN_CHIU_PHI ";
                if (sStm1.ToUpper() != ",ALL".ToUpper())
                    sSql += "  WHERE MS_BP_CHIU_PHI IN (" + sStm1 + ")";
            }
            if (iLoaiBC == 3)
            {
                sSql = "SELECT  CONVERT(BIT,1) AS CHON,MS_LOAI_MAY, TEN_LOAI_MAY  INTO " + BTDuLieu + " FROM LOAI_MAY ";
                if (sStm1.ToUpper() != ",ALL".ToUpper())
                    sSql += " WHERE MS_LOAI_MAY IN ('" + sStm1.Replace(",", "','") + "')";
            }
            
            SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);
            sSql = sSql.Replace("INTO " + BTDuLieu, "");

            dtTmp = new DataTable();
            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));

            sSql = BDCPTNXTaoDuLieuBieuDoChiPhiTheoNX(TNgay, DNgay, grd, iLoaiBC, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5, dtTmp, sUserName);

            int iSMay = 0;
            try
            { iSMay = dtTmp.Rows.Count; }
            catch { iSMay = 0; }

            if (sSql == "")
            {
                iCoDuLieu = 2;
                return false;
            }
            dtTmp = new DataTable();
            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
            try
            {
                if (dtTmp.Rows.Count <= 0)
                {
                    iCoDuLieu = 0;
                    return false;
                }
            }
            catch { }

            dtTmp.Columns["STT"].ReadOnly = false;

            for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
            {
                dtTmp.Rows[i][0] = (i + 1).ToString();
            }

            Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
            Commons.Modules.ObjSystems.MLoadNNXtraGrid(grv, "ucBieuDoChiPhiTheoNX");

            string sPath, SavePath;
            sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
            SavePath = Application.StartupPath;

            if (!BDCPTNXInDuLieuBieuDoChiPhiTheoNX(grd, grv, sPath, SavePath, NNgu, TNgay, DNgay,
                Convert.ToBoolean(LChiPhi1), Convert.ToBoolean(LChiPhi2), Convert.ToBoolean(LChiPhi3),
                Convert.ToBoolean(LChiPhi4), Convert.ToBoolean(LChiPhi5), out iCoDuLieu)) return false;

            Commons.Modules.ObjSystems.XoaTable("ZZZ_BDCP_CHON_MAIL" + sUserName);
            Commons.Modules.ObjSystems.XoaTable(BTDuLieu);
            Commons.Modules.ObjSystems.XoaTable("ZZZ_DL_MAIL" + TNgay.Month.ToString() + sUserName);
            
            if (iLoaiBC == 0)
            {
                for (int i = 0; i < iSMay; i++)
                {
                    Commons.Modules.ObjSystems.XoaTable("ZZZ_DL" + i.ToString() + TNgay.Month.ToString() + sUserName);
                }
            }
            else
            {
                Commons.Modules.ObjSystems.XoaTable("ZZZ_DL_MAIL" + TNgay.Month.ToString() + sUserName);
            }


            return true;
        }

        private string BDCPTNXTaoDuLieuBieuDoChiPhiTheoNX(DateTime TNgay, DateTime DNgay, DevExpress.XtraGrid.GridControl grd, int iLoaiBC,
            int LChiPhi1, int LChiPhi2, int LChiPhi3, int LChiPhi4, int LChiPhi5, DataTable dtTmp, string sUserName)
        {
            if (dtTmp.Rows.Count == 0) return "";

#region Lay du lieu chon in
            string BTDuLieu;
            BTDuLieu = "ZZZ_BDCP_CHON_MAIL" + sUserName;
#endregion

            string sMa, sTen;
            sMa = "";
            sTen = "";


            string BTam, sSql;
            BTam = "";
            sSql = "";
            DataTable dtDLieu = new DataTable();
            #region Nha Xuong
            if (iLoaiBC == 0)
            {
                for (int i = 0; i < dtTmp.Rows.Count; i++)
                {
                    BTam = "ZZZ_DL" + i.ToString() + TNgay.Month.ToString() + sUserName;
                    dtDLieu = new DataTable();
                    dtDLieu = BDCPTNXTaoDuLieuInBieuDoChiPhiTheoNX(TNgay, DNgay, dtTmp.Rows[i][1].ToString(),iLoaiBC,
                                    LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5);
                    Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtDLieu, "");
                    sSql = sSql + (sSql == "" ? "" : " UNION ") + " SELECT * FROM " + BTam;
                }
                sSql += " ORDER BY TONG_CP DESC ";

            #endregion
            }
            else
            {
                if (iLoaiBC == 1)
                {
                    sTen = "TEN_HE_THONG";
                    sMa = "MS_HE_THONG";
                }
                if (iLoaiBC == 2)
                {
                    sTen = "TEN_BP_CHIU_PHI";
                    sMa = "MS_BP_CHIU_PHI";
                }
                if (iLoaiBC == 3)
                {
                    sTen = "TEN_LOAI_MAY";
                    sMa = "MS_LOAI_MAY";
                }
                dtDLieu = new DataTable();
                dtDLieu = BDCPTNXTaoDuLieuInBieuDoChiPhiTheoNX(TNgay, DNgay, "",iLoaiBC,
                                LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5);
                BTam = "ZZZ_DL_MAIL" + TNgay.Month.ToString() + sUserName;
                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtDLieu, "");

                sSql = " SELECT STT, " + sTen + ", ROUND(CHI_PHI_CO_KH,0) AS CHI_PHI_CO_KH, ROUND(CHI_PHI_KHO_KH,0) AS CHI_PHI_KHO_KH, ROUND(TONG_CP,0) AS TONG_CP " +
                            " FROM " + BTam + " WHERE   " + sMa + " IN ( SELECT DISTINCT " + sMa + " FROM " + BTDuLieu + " ) " +
                            " UNION SELECT NULL, " + sTen + ",  0, 0, 0 " +
                            " FROM " + BTDuLieu + " WHERE  " +
                            " " + sMa + " NOT IN ( SELECT DISTINCT " + sMa + " FROM " + BTam + " )  " +
                            " ORDER BY TONG_CP DESC , " + sTen + " ";

            }
            return sSql;



        }


        private DataTable BDCPTNXTaoDuLieuInBieuDoChiPhiTheoNX(DateTime TuNgay, DateTime DenNgay, string MaSo, int iLoaiBC,
            int LChiPhi1, int LChiPhi2, int LChiPhi3, int LChiPhi4, int LChiPhi5)
        {
            try
            {

                DataTable dtTmp = new DataTable();
                string sTmp;
                sTmp = "";

                if (iLoaiBC == 0)
                    sTmp = "MBieuDoChiPhiNhaXuongTheoXuong";
                if (iLoaiBC == 1)
                    sTmp = "MBieuDoChiPhiHeThongTheoXuong";
                if (iLoaiBC == 2)
                    sTmp = "MBieuDoChiPhiBPCPTheoXuong";
                if (iLoaiBC == 3)
                    sTmp = "MBieuDoChiPhiLoaiMayTheoXuong";

                if (iLoaiBC == 0)
                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, sTmp,
                        TuNgay, DenNgay, LChiPhi1, LChiPhi2,LChiPhi3, LChiPhi4,LChiPhi5, MaSo));
                else
                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, sTmp,
                        TuNgay, DenNgay, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5));
                return dtTmp;
            }
            catch
            { return null; }
        }


        private Boolean BDCPTNXInDuLieuBieuDoChiPhiTheoNX(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, string SavePath, int NNgu, DateTime TNgay, DateTime DNgay,
            Boolean iLCPhi1, Boolean iLCPhi2, Boolean iLCPhi3, Boolean iLCPhi4, Boolean iLCPhi5, out int iTinhTrang)
        {
            iTinhTrang = 1;

            if (sPath == "")
            {
                iTinhTrang = 2;
                return false;
            }
            Excel.Application xlApp = new Excel.Application();
            Excel.Workbooks xlWBooks;
            Excel.Workbook xlWBook;
            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;
                grd.ExportToXls(sPath);
                xlWBooks = xlApp.Workbooks;
                xlWBook = xlWBooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWSheet = (Excel.Worksheet)xlWBook.Sheets[1];



                Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet, 1, 3, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWSheet, 0, 0, 100, 45, SavePath);
                Commons.Modules.MExcel.ThemDong(xlWSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 5, Dong);

                int SCot;

                SCot = (TCot > 9 ? 9 : TCot);

                Dong++;

                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoChiPhiTheoNX", "TieuDe", NNgu), Dong, 1, "@", 16, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;
                string stmp = "";

                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblTNgay", NNgu) + " : " + TNgay.ToString("dd/MM/yyyy") + " " +
                    Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDNgay", NNgu) + " : " + DNgay.ToString("dd/MM/yyyy");
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 2, "@", 10, true, true, Dong, SCot);





                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblLoaiChiPhi", NNgu) + " : ";
                if (iLCPhi1) stmp = stmp + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPPhuTung", NNgu);
                if (iLCPhi2) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPVatTu", NNgu);
                if (iLCPhi3) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPNhanCong", NNgu);
                if (iLCPhi4) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPDichVu", NNgu);
                if (iLCPhi5) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPKhac", NNgu);
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 2, "@", 10, true, true, Dong, SCot);

                int DongBD;
                DongBD = Dong + 3;
                Excel.Range title;
                Dong++;
                Dong++;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                //title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));
                //title.Interior.Color = xlWSheet.get_Range(xlWSheet.Cells[Dong - 1, 1], xlWSheet.Cells[Dong - 1, 1]).Interior.Color;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;


                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWBook, xlWSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, 5, 1, 5, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, 9, 1, 9, 1);
                title.RowHeight = 9;



                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "##", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 35, "@", true, Dong + 1, 2, TDong + Dong, 2);

                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 20, "#,##0", true, Dong + 1, 3, TDong + Dong, 3);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 20, "#,##0", true, Dong + 1, 4, TDong + Dong, 4);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 20, "#,##0", true, Dong + 1, 5, TDong + Dong, 5);
                SCot = 7;



                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong + 1, SCot, Dong + 1, SCot);
                BDCPTNXLoadBieuDoBieuDoChiPhiTheoNX(xlWSheet, Dong + TDong, 10, "", 1,
                    Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 671.25, 395.25, NNgu);

                xlWBook.Save();
                xlWBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);

            }
            catch
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                return false;
            }
            return true;

        }

        private void BDCPTNXLoadBieuDoBieuDoChiPhiTheoNX(Excel.Worksheet ExcelSheets, int iDong, int iColumKT, string sTitle, int iSoLan, double iLeft,
            double iTop, double iWidth, double iHeight, int NNgu)
        {
            try
            {
                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 3);
                double iLan = (iSoLan - 1) % 3;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;
                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);


                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Series xlSeries = xlSeriesCollection.NewSeries();
                var _with1 = xlSeries;
                _with1.AxisGroup = Excel.XlAxisGroup.xlPrimary;
                _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoNX", "KH", NNgu);
                _with1.Values = ExcelSheets.get_Range("C11", (iDong > 61 ? "C61" : "C" + iDong.ToString()));
                _with1.XValues = ExcelSheets.get_Range("B11", (iDong > 61 ? "B61" : "B" + iDong.ToString())); //"B33");

                Excel.Series xlSeries1 = xlSeriesCollection.NewSeries();
                var _with2 = xlSeries1;
                _with2.AxisGroup = Excel.XlAxisGroup.xlSecondary;
                _with2.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoNX", "KKH", NNgu);
                _with2.Values = ExcelSheets.get_Range("D11", (iDong > 61 ? "D61" : "D" + iDong.ToString())); //"G33");
                _with2.XValues = ExcelSheets.get_Range("B11", (iDong > 61 ? "B61" : "B" + iDong.ToString())); //"B33");
                xlChart.Refresh();

                xlChart.HasTitle = true;
                xlChart.ChartTitle.Text = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoNX", "TieuDe", NNgu);// "=Sheet1!$A$" + (vDong + 1);                 //"=A" + vDong;

                xlChart.Legend.Position = Excel.XlLegendPosition.xlLegendPositionBottom;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                xlChart.Refresh();


            }
            catch
            { }
        }

        #endregion

        #region ucMailBieuDoChiPhiTheoNXThang -- BDCPTNXThang
        public Boolean BDCPTNXTInBieuDoChiPhiTheoNXThang(DataTable dtSch, DevExpress.XtraGrid.GridControl grd,
            DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu, out string sLoi)
        {
            sLoi = "";
            iCoDuLieu = 1;
            #region Khai Bao Bien
            string sSql, sUserName, sMsNXuong, sStmp, sBCao, sStm1;
            DateTime TThang, DThang;
            DateTime TNgay, DNgay;
            int NNgu, iLoaiBC, iSNgay, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5;
            Boolean SauNgayBD;
            DataTable dtTmp = new DataTable();
            sStm1 = "";
            SauNgayBD = false;
            iSNgay = 0;
            iLoaiBC = 0;
            sSql = "";
            LChiPhi1 = 1;
            LChiPhi2 = 1;
            LChiPhi3 = 1;
            LChiPhi4 = 1;
            LChiPhi5 = 1;
            sMsNXuong = "-1";

            NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
            sUserName = dtSch.Rows[0]["USERNAME"].ToString();

            #endregion

            #region Lay dieu kien bao cao
            if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
            {

                sBCao = "";
                sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                string[] chuoi_tach = sStmp.Split(new Char[] { ',' });
                int i = 0;

                foreach (string s in chuoi_tach)
                {
                    if (i == 0) if (s.Trim() == "0") SauNgayBD = false; else SauNgayBD = true;

                    if (i == 1) iSNgay = int.Parse(s);

                    if (i == 2)
                    {
                        if (s == "0") iLoaiBC = 0;
                        if (s == "1") iLoaiBC = 1;
                        if (s == "2") iLoaiBC = 2;
                        if (s == "3") iLoaiBC = 3;
                    }

                    if (i == 3) sMsNXuong = s;




                    if (i == 4)
                        if (s.Trim() == "0") LChiPhi1 = 0; else LChiPhi1 = 1;
                    if (i == 5)
                        if (s.Trim() == "0") LChiPhi2 = 0; else LChiPhi2 = 1;
                    if (i == 6)
                        if (s.Trim() == "0") LChiPhi3 = 0; else LChiPhi3 = 1;
                    if (i == 7)
                        if (s.Trim() == "0") LChiPhi4 = 0; else LChiPhi4 = 1;
                    if (i == 8)
                        if (s.Trim() == "0") LChiPhi5 = 0; else LChiPhi5 = 1;
                    if (i == 9)
                    {
                        sStm1 = sBCao.Substring(1, sBCao.Length - 1);
                        sStm1 = sStmp.Replace(sStm1, "");
                        if (sStm1 == ",ALL") break;
                        sStm1 = sStm1.Substring(1, sStm1.Length - 2);
                        break;
                    }

                    i++;
                    sBCao = sBCao + "," + s;
                }
            }

            //If SauNgayBD = true nghia la in tu ngay bat dau in (tu ngay) + them so ngay ra den ngay
            //If SauNgayBD = false nghia la Ngay bat dau in la den ngay - di so ngay ra tu ngay.
            if (SauNgayBD)
            {
                TThang = Convert.ToDateTime( DateTime.Now.Month + "/" + DateTime.Now.Year);
                DThang = TThang.AddMonths(iSNgay).AddDays(-1);
            }
            else
            {
                DThang = Convert.ToDateTime( DateTime.Now.Month + "/" + DateTime.Now.Year);
                TThang = DThang.AddMonths(-iSNgay + 1);

                //DThang = Convert.ToDateTime( DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(1).AddDays(-1);
                //TThang = DThang.AddMonths(-iSNgay).AddDays(1);
                //Convert.ToDateTime( DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(-iSNgay + 1);
            }


            sSql = "";
            string BTDuLieu;
            BTDuLieu = "ZZZ_BDCPTNXT_CHON_MAIL" + sUserName;
            Commons.Modules.ObjSystems.XoaTable(BTDuLieu);
            sSql = "";
            if (iLoaiBC == 0)
            {
                sSql = "SELECT CONVERT(BIT,1) AS CHON, MS_N_XUONG,TEN_N_XUONG INTO " + BTDuLieu + " FROM NHA_XUONG 	" +
                            " WHERE ISNULL(MS_CHA,'-1') = '" + sMsNXuong + "'";
                if (sStm1.ToUpper() != ",ALL".ToUpper())
                    sSql += "AND MS_N_XUONG IN ('" + sStm1.Replace(",", "','") + "')";
            }
            if (iLoaiBC == 1)
            {
                sSql = "SELECT CONVERT(BIT,1) AS CHON, 	MS_HE_THONG, TEN_HE_THONG  INTO " + BTDuLieu + " FROM HE_THONG ";
                if (sStm1.ToUpper() != ",ALL".ToUpper())
                    sSql += " WHERE MS_HE_THONG IN (" + sStm1 + ")";
            }
            if (iLoaiBC == 2)
            {
                sSql = "SELECT  CONVERT(BIT,1) AS CHON,MS_BP_CHIU_PHI,TEN_BP_CHIU_PHI  INTO " + BTDuLieu + " FROM BO_PHAN_CHIU_PHI ";
                if (sStm1.ToUpper() != ",ALL".ToUpper())
                    sSql += "  WHERE MS_BP_CHIU_PHI IN (" + sStm1 + ")";
            }
            if (iLoaiBC == 3)
            {
                sSql = "SELECT  CONVERT(BIT,1) AS CHON,MS_LOAI_MAY, TEN_LOAI_MAY  INTO " + BTDuLieu + " FROM LOAI_MAY ";
                if (sStm1.ToUpper() != ",ALL".ToUpper())
                    sSql += " WHERE MS_LOAI_MAY IN ('" + sStm1.Replace(",", "','") + "')";
            }

            SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);
            sSql = sSql.Replace("INTO " + BTDuLieu, "");

            dtTmp = new DataTable();
            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));


            #endregion

            #region Tao Du Lieu
            try
            {

                #region Bao Cao Theo Thang
                string BTam, BangTam, sThang, sThangNull, sThangAvg, sTmp;
                sThang = "";
                sThangAvg = "";
                sThangNull = "";
                BangTam = "ZZZ_BDCP_THANG_MAIL";
                sTmp = "";
                for (DateTime Thang = TThang; Thang <= DThang; )
                {

                    TNgay = Convert.ToDateTime( Thang.Month + "/" + Thang.Year);
                    DNgay = TNgay.AddMonths(1).AddDays(-1);


                    BTam = "ZZZ_BDCP_THANG_MAIL" + TNgay.ToString("MMyyyy") + sUserName;
                    sThang = sThang + " , [" + Thang.ToString("MM/yy") + "] ";
                    sThangNull = sThangNull + " , ISNULL([" + Thang.ToString("MM/yy") + "],0) AS [" + Thang.ToString("MM/yy") + "] ";
                    sThangAvg = sThangAvg + " + ISNULL([" + Thang.ToString("MM/yy") + "],0) ";

                    sSql = BDCPTNXThangTaoDuLieu(TNgay, DNgay, dtTmp, iLoaiBC, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5, sUserName);

                    if (sSql != "")
                    {
                        Commons.Modules.ObjSystems.XoaTable(BTam);
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);
                        sTmp = sTmp + (sTmp == "" ? "" : " UNION ") + "SELECT * " + (sTmp == "" ? " INTO " + BangTam : "") +
                                " FROM " + BTam + " ";
                    }

                    Thang = Thang.AddMonths(1);


                }
                Commons.Modules.ObjSystems.XoaTable(BangTam);
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sTmp);



                if (iLoaiBC == 0) sTmp = "TEN_N_XUONG";
                if (iLoaiBC == 1) sTmp = "TEN_HE_THONG";
                if (iLoaiBC == 2) sTmp = "TEN_BP_CHIU_PHI";
                if (iLoaiBC == 3) sTmp = "TEN_LOAI_MAY";

                sSql = " SELECT * FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_CP FROM " +
                            "   ( SELECT STT," + sTmp + ", " + sThangNull.Substring(3, sThangNull.Length - 3) +
                            " 	  FROM  " +
                            " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                            " 		PIVOT (SUM(TONG_CP) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                            " 		 )) AS PVT)  " +
                            "    A  ) B ORDER BY TONG_CP DESC ";


                if (sSql == "")
                {
                    iCoDuLieu = 2;
                    return false;
                }
                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));

                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }
                

                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    BTam = "ZZZ_BDCP_THANG_MAIL" + Thang.ToString("MMyyyy") + sUserName;
                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                    if (iLoaiBC == 0)
                    {
                        for (int i = 0; i < dtTmp.Rows.Count; i++)
                        {
                            Commons.Modules.ObjSystems.XoaTable("ZZZ_DL_MAIL" + i.ToString() + TNgay.Month.ToString() + sUserName);
                        }
                    }
                    else
                        BTam = "ZZZ_DL_MAIL" + TNgay.Month.ToString() + sUserName;

                    Thang = Thang.AddMonths(1);
                }
                Commons.Modules.ObjSystems.XoaTable(BangTam);
                Commons.Modules.ObjSystems.XoaTable(BTDuLieu);
                Commons.Modules.ObjSystems.XoaTable("ZZZ_BDCP_CHON_MAIL" + sUserName);
                Commons.Modules.ObjSystems.XoaTable("ZZZ_BPCPLM_MAIL" + sUserName);


                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch { }
                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, false, true);
                grv.Columns["STT"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoChiPhiTheoNX", "STT", NNgu);
                grv.Columns[sTmp].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoChiPhiTheoNX", sTmp, NNgu);
                grv.Columns["TONG_CP"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoChiPhiTheoNX", "TONG_CP", NNgu);
                #endregion


                string sPath, SavePath;
                sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                SavePath = Application.StartupPath;
                return BDCPTNXThangInDuLieu(sPath, SavePath, NNgu, TThang, DThang, iLoaiBC, grd, grv, 
                    LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5,out iCoDuLieu, out sLoi);
            }
            catch
            {
                iCoDuLieu = 2;
                return false;
            }
            #endregion

        }

        private string BDCPTNXThangTaoDuLieu(DateTime TNgay, DateTime DNgay,DataTable dtChonIn, int iLoaiBC,
            int LChiPhi1, int LChiPhi2, int LChiPhi3, int LChiPhi4, int LChiPhi5, string sUserName)
        {
            #region Lay du lieu chon in
            string BTDuLieu;
            BTDuLieu = "ZZZ_BDCP_CHON_MAIL" + sUserName;
            Commons.Modules.ObjSystems.XoaTable("ZZZ_BPCPLM_MAIL" + sUserName);
            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTDuLieu, dtChonIn, "");

            if (dtChonIn.Rows.Count == 0)
            {
                return "";
            }
            #endregion

            string sMa, sTen;
            sMa = "";
            sTen = "";


            string BTam, sSql;
            BTam = "";
            sSql = "";
            DataTable dtDLieu = new DataTable();
            #region Nha Xuong
            if (iLoaiBC == 0)
            {
                for (int i = 0; i < dtChonIn.Rows.Count; i++)
                {
                    BTam = "ZZZ_DL_MAIL" + i.ToString() + TNgay.Month.ToString() + sUserName;
                    dtDLieu = new DataTable();
                    dtDLieu = BDCPTNXThangTaoDuLieuIn(TNgay, DNgay, dtChonIn.Rows[i][1].ToString(), iLoaiBC, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5);
                    Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtDLieu, "");
                    sSql = sSql + (sSql == "" ? "" : " UNION ") + " SELECT * FROM " + BTam;
                }
                sSql = " SELECT AVG(STT) AS STT ,TEN_N_XUONG, SUM(TONG_CP ) AS TONG_CP, N'" + TNgay.ToString("MM/yy") + "' AS THANG  " +
                        " INTO ZZZ_BDCP_THANG_MAIL" + TNgay.ToString("MMyyyy") + sUserName + " FROM (" + sSql + ") A GROUP BY TEN_N_XUONG";
            #endregion
            }
            else
            {
                if (iLoaiBC == 1)
                {
                    sTen = "TEN_HE_THONG";
                    sMa = "MS_HE_THONG";
                }
                if (iLoaiBC == 2)
                {
                    sTen = "TEN_BP_CHIU_PHI";
                    sMa = "MS_BP_CHIU_PHI";
                }
                if (iLoaiBC == 3)
                {
                    sTen = "TEN_LOAI_MAY";
                    sMa = "MS_LOAI_MAY";
                }
                dtDLieu = new DataTable();
                dtDLieu = BDCPTNXThangTaoDuLieuIn(TNgay, DNgay, "", iLoaiBC, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5);
                BTam = "ZZZ_DL_MAIL" + TNgay.Month.ToString() + sUserName;
                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtDLieu, "");

                sSql = "SELECT AVG(STT) AS STT, " + sTen + ", SUM(TONG_CP) AS TONG_CP,N'" + TNgay.ToString("MM/yy") + "' AS THANG " +
                            " INTO ZZZ_BDCP_THANG_MAIL" + TNgay.ToString("MMyyyy") + sUserName +
                            " FROM " + BTam + " WHERE   " + sMa + " IN ( SELECT DISTINCT " + sMa + " FROM " + BTDuLieu + " ) " +
                            " GROUP BY " + sTen + "" +
                            " UNION SELECT NULL, " + sTen + ",  0, N'" + TNgay.ToString("MM/yy") + "' AS THANG " +
                            " FROM " + BTDuLieu + " WHERE  " +
                            " " + sMa + " NOT IN ( SELECT DISTINCT " + sMa + " FROM " + BTam + " )  " +
                            " ORDER BY TONG_CP DESC , " + sTen + " ";

            }



            return sSql;



        }


        private DataTable BDCPTNXThangTaoDuLieuIn(DateTime TuNgay, DateTime DenNgay, string MaSo, int iLoaiBC,
            int LChiPhi1, int LChiPhi2, int LChiPhi3, int LChiPhi4, int LChiPhi5)
        {
            try
            {
//LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5;
                DataTable dtTmp = new DataTable();
                string sTmp;
                sTmp = "";

                if (iLoaiBC == 0)
                    sTmp = "MBieuDoChiPhiNhaXuongTheoXuong";
                if (iLoaiBC == 1)
                    sTmp = "MBieuDoChiPhiHeThongTheoXuong";
                if (iLoaiBC == 2)
                    sTmp = "MBieuDoChiPhiBPCPTheoXuong";
                if (iLoaiBC == 3)
                    sTmp = "MBieuDoChiPhiLoaiMayTheoXuong";

                if (iLoaiBC == 0)
                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, sTmp,
                        TuNgay, DenNgay, LChiPhi1 == 1 ? 1 : 0, LChiPhi2 == 1 ? 1 : 0,
                        LChiPhi3 == 1 ? 1 : 0, LChiPhi4 == 1 ? 1 : 0,
                        LChiPhi5 == 1 ? 1 : 0, MaSo));
                else
                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, sTmp,
                        TuNgay, DenNgay, LChiPhi1 == 1 ? 1 : 0, LChiPhi2 == 1 ? 1 : 0,
                        LChiPhi3 == 1 ? 1 : 0, LChiPhi4 == 1 ? 1 : 0,
                        LChiPhi5 == 1 ? 1 : 0));
                return dtTmp;
            }
            catch
            { return null; }
        }


        private Boolean BDCPTNXThangInDuLieu(string sPath, string SavePath, int NNgu, DateTime TThang, DateTime DThang, int iLoaiBC, 
            DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            int LChiPhi1, int LChiPhi2, int LChiPhi3, int LChiPhi4, int LChiPhi5, out int iTinhTrang, out string sLoi )
        {
            iTinhTrang = 1;
            sLoi = "";
            if (sPath == "")
            {
                iTinhTrang = 2; 
                return false;
            }
            Excel.Application xlApp = new Excel.Application();
            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;
                sLoi = "1";
                grd.ExportToXls(sPath);   
                System.Globalization.CultureInfo oldCultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
                System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
                Excel.Workbooks xlWBooks = xlApp.Workbooks;
                Excel.Workbook xlWBook = xlWBooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                sLoi = "3";
                Excel.Worksheet xlWSheet = (Excel.Worksheet)xlWBook.Sheets[1];
                
                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;
                xlApp.Cells.Font.Name = "Tahoma";
                xlApp.Cells.Font.Size = 10;

                Dong = TDong + 2;

                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoNX", "TongCong", NNgu)
                    , Dong, 1, "@", 10, true, Excel.XlHAlign.xlHAlignRight, Excel.XlVAlign.xlVAlignCenter, true, Dong, 2);

                for (int cot = 3; cot <= TCot; cot++)
                    Commons.Modules.MExcel.MFuntion(xlWSheet, "SUM", Dong, cot, Dong, cot, Dong-(TDong),
                        cot, Dong - 1, cot, 10, true, 10, "#,##0", Excel.XlHAlign.xlHAlignRight, Excel.XlVAlign.xlVAlignCenter);

                try
                {
                    Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet, 1, 3, 1, TCot);
                    Commons.Modules.MExcel.TaoLogo(xlWSheet, 0, 0, 100, 45, SavePath);
                    Commons.Modules.MExcel.ThemDong(xlWSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 5, Dong);
                }
                catch { }
                int SCot;

                SCot = (TCot > 9 ? 9 : TCot);

                Dong++;

                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoChiPhiTheoNX", "TieuDe", NNgu), Dong, 1, "@", 16, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;
                string stmp = "";
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblTThang", NNgu) + " : " + TThang.ToString("MM/yyyy") + " " +
                    Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDThang", NNgu) + " : " + DThang.ToString("MM/yyyy");
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 2, "@", 10, true, true, Dong, SCot);





                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblLoaiChiPhi", NNgu) + " : ";
                if (LChiPhi1 == 1) stmp = stmp + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPPhuTung", NNgu);
                if (LChiPhi2 == 1) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPVatTu", NNgu);
                if (LChiPhi3 == 1) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPNhanCong", NNgu);
                if (LChiPhi4 == 1) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPDichVu", NNgu);
                if (LChiPhi5 == 1) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPKhac", NNgu);
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 2, "@", 10, true, true, Dong, SCot);

                int DongBD;
                DongBD = Dong + 3;
                Excel.Range title;
                Dong++;
                Dong++;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                //title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));
                //title.Interior.Color = xlWSheet.get_Range(xlWSheet.Cells[Dong - 1, 1], xlWSheet.Cells[Dong - 1, 1]).Interior.Color;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWBook, xlWSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);

                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;
                xlApp.Cells.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, 5, 1, 5, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, 9, 1, 9, 1);
                title.RowHeight = 9;



                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "##", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 35, "@", true, Dong + 1, 2, TDong + Dong, 2);


                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 30, "@", true, Dong + 1, 2, TDong + Dong, 2);
                for (int i = 3; i <= TCot; i++)
                    Commons.Modules.MExcel.ColumnWidth(xlWSheet, 12, "#,##0", true, Dong + 1, i, TDong + Dong, i);
                SCot = TCot + 1;



                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong + 1, TCot + 2, Dong + 1, TCot + 2);
                double iLeft; double iTop;
                double iWidth; double iHeight;

                iLeft = Convert.ToDouble(title.Left);
                iTop = Convert.ToDouble(title.Top);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong + 1, TCot + 2, Dong + 10, TCot + 2);
                iHeight = Convert.ToDouble(title.Height);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong + 1, TCot + 2, Dong + 10, TCot + 2 + 7);
                iWidth = Convert.ToDouble(title.Width);
                Boolean dCuoi;
                dCuoi = false;
                for (int i = 11; i <= Dong + TDong + 1; i++)
                {
                    if (i == Dong + TDong + 1)
                        dCuoi = true;
                    BDCPTNXThangLoadBieuDo(xlWSheet, i, TCot, "", i - 10, iLeft, iTop, iWidth, iHeight, dCuoi, NNgu);

                }

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong + TDong + 1, TCot);
                title.Borders.LineStyle = 1;

                xlWBook.Save();
                xlWBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);

            }
            catch (Exception ex)
            {
                sLoi = "4-" + sLoi + "-" + ex.Message;
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                return false;   
            }
            return true;

        }


        private void BDCPTNXThangLoadBieuDo(Excel.Worksheet ExcelSheets, int iDong, int iColumKT, string sTitle, int iSoLan, double iLeft,
            double iTop, double iWidth, double iHeight, int NNgu)
        {
            try
            {
                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 3);
                double iLan = (iSoLan - 1) % 3;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;

                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);


                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Series xlSeries = xlSeriesCollection.NewSeries();

                var _with1 = xlSeries;
                _with1.AxisGroup = Excel.XlAxisGroup.xlPrimary;
                _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoNX", "KH", NNgu);
                _with1.Values = ExcelSheets.get_Range("C11", (iDong > 61 ? "C61" : "C" + iDong.ToString()));
                _with1.XValues = ExcelSheets.get_Range("B11", (iDong > 61 ? "B61" : "B" + iDong.ToString())); //"B33");

                Excel.Series xlSeries1 = xlSeriesCollection.NewSeries();
                var _with2 = xlSeries1;
                _with2.AxisGroup = Excel.XlAxisGroup.xlSecondary;
                _with2.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoNX", "KKH", NNgu);
                _with2.Values = ExcelSheets.get_Range("D11", (iDong > 61 ? "D61" : "D" + iDong.ToString())); //"G33");
                _with2.XValues = ExcelSheets.get_Range("B11", (iDong > 61 ? "B61" : "B" + iDong.ToString())); //"B33");
                xlChart.Refresh();

                xlChart.HasTitle = true;
                xlChart.ChartTitle.Text = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoNX", "TieuDe", NNgu);// "=Sheet1!$A$" + (vDong + 1);                 //"=A" + vDong;

                xlChart.Legend.Position = Excel.XlLegendPosition.xlLegendPositionBottom;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                xlChart.Refresh();


            }
            catch
            { }
        }

        private void BDCPTNXThangLoadBieuDo(Excel.Worksheet ExcelSheets, int iDong, int iColumKT, string sTitle, int iSoLan, double iLeft,
            double iTop, double iWidth, double iHeight, Boolean sCuoi, int NNgu)
        {
            try
            {
                double iSLan;
                double sLe;
                double sChan;
                double sKQ;

                iSLan = iSoLan;
                sKQ = 0;
                if (sCuoi)
                {
                    sChan = Math.Floor(iSLan / 10);
                    sLe = iSLan - sChan * 10;
                    if (sLe != 0)
                    {
                        sKQ = ((sChan + 1) * 10) + 1;

                    }


                    iSoLan = int.Parse(sKQ.ToString());


                }

                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 10);
                double iLan = (iSoLan - 1) % 10;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;

                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                Excel.Series xlSeries = xlSeriesCollection.NewSeries();


                var _with1 = xlSeries;
                _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "Thang", NNgu);// "=Sheet1!$A$" + (vDong + 1);                 //"=A" + vDong;
                _with1.Values = ExcelSheets.get_Range("C" + iDong, Commons.Modules.MExcel.MCotExcel(iColumKT - 1) + iDong); //"B33");
                _with1.XValues = ExcelSheets.get_Range("C10", Commons.Modules.MExcel.MCotExcel(iColumKT - 1) + "10");




                if (sCuoi)
                    xlChart.ChartTitle.Text = Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucDieuChinhThietBi", "TongCong", NNgu);
                else
                    xlChart.ChartTitle.Text = "=Sheet1!$B$" + (iDong);


                xlChart.Refresh();

                xlChart.HasTitle = true;
                xlChart.Legend.Position = Excel.XlLegendPosition.xlLegendPositionBottom;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Axis ax = xlChart.Axes(Excel.XlAxisType.xlCategory, Excel.XlAxisGroup.xlPrimary) as Excel.Axis;

                ax.TickLabels.Orientation = Excel.XlTickLabelOrientation.xlTickLabelOrientationUpward;


                xlChart.Refresh();


            }
            catch
            { }
        }

        #endregion

        #region ucMailBieuDoChiPhiTheoTB
        public Boolean InBieuDoChiPhiTheoTB(DataTable dtSch, DevExpress.XtraGrid.GridControl grd,
            DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {

                DateTime TNgay, DNgay;
                string sUserName, sDiaDiem, sLoaiMay, sNhomMay;
                int NNgu, iSNgay, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5, iDayChuyen;
                Boolean SauNgayBD;
                sDiaDiem = "";
                SauNgayBD = false;
                iSNgay = 0;
                sLoaiMay = "-1";
                sNhomMay = "-1";

                LChiPhi1 = 1;
                LChiPhi2 = 1;
                LChiPhi3 = 1;
                LChiPhi4 = 1;
                LChiPhi5 = 1;
                iDayChuyen = -1;


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
                        if (i == 0) if (s.Trim() == "0") SauNgayBD = false; else SauNgayBD = true;

                        if (i == 1) iSNgay = int.Parse(s);

                        if (i == 2) sDiaDiem = s;

                        if (i == 3)
                            if (s.Trim() == "0") LChiPhi1 = 0; else LChiPhi1 = 1;
                        if (i == 4)
                            if (s.Trim() == "0") LChiPhi2 = 0; else LChiPhi2 = 1;
                        if (i == 5)
                            if (s.Trim() == "0") LChiPhi3 = 0; else LChiPhi3 = 1;
                        if (i == 6)
                            if (s.Trim() == "0") LChiPhi4 = 0; else LChiPhi4 = 1;
                        if (i == 7)
                            if (s.Trim() == "0") LChiPhi5 = 0; else LChiPhi5 = 1;

                        if (i == 8) iDayChuyen = int.Parse(s);
                        if (i == 9) sLoaiMay = s;
                        if (i == 10) sNhomMay = s;
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


                DataTable dtMay = new DataTable();
                dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT DISTINCT MS_MAY FROM MAY"));

                if (!Commons.Modules.ObjSystems.MCreateTableToDatatable(
                        Commons.IConnections.ConnectionString, "CHON_MAY_BDCP", dtMay, ""))
                {
                    iCoDuLieu = 2;
                    return false;
                }
                //TNgay = DateTime.Parse("01/01/2000");
                DataTable dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MBieuDoChiPhi",
                    TNgay, DNgay, "-1", "-1", "-1", sDiaDiem, iDayChuyen, sLoaiMay, sNhomMay,
                    LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5, 1, ""));

                #region Kiem co du lieu hay khong
                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch { }
                #endregion

                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 1; i < dtTmp.Rows.Count + 1; i++)
                {
                    dtTmp.Rows[i - 1][0] = i.ToString();
                }

                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, false, false, false,true,"ucBieuDoChiPhiTheoTB");

                string sPath, SavePath, sSql, sDayChuyen;
                sSql = "";
                sDayChuyen = "";
                sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                SavePath = Application.StartupPath;
                if (sDiaDiem == "-1") sDiaDiem = " < ALL > ";
                else
                {
                    sSql = "SELECT CASE " + NNgu.ToString() + " WHEN 0 THEN TEN_N_XUONG WHEN 1 THEN TEN_N_XUONG_A ELSE TEN_N_XUONG_H END AS TNX " +
                                " FROM NHA_XUONG WHERE MS_N_XUONG = '" + sDiaDiem + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sDiaDiem = dtMay.Rows[0]["TNX"].ToString();
                    }

                }

                if (iDayChuyen == -1) sDayChuyen = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_HE_THONG FROM HE_THONG WHERE MS_HE_THONG = 3";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sDayChuyen = dtMay.Rows[0]["TEN_HE_THONG"].ToString();
                    }

                }
                if (sLoaiMay == "-1") sLoaiMay = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_LOAI_MAY FROM LOAI_MAY WHERE MS_LOAI_MAY = '" + sLoaiMay + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sLoaiMay = dtMay.Rows[0]["TEN_LOAI_MAY"].ToString();
                    }

                }
                if (sNhomMay == "-1") sNhomMay = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_NHOM_MAY FROM NHOM_MAY WHERE MS_NHOM_MAY = '" + sNhomMay + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sNhomMay = dtMay.Rows[0]["TEN_NHOM_MAY"].ToString();
                    }

                }

                Commons.Modules.ObjSystems.XoaTable("CHON_MAY_BDCP");
                return InDuLieuBieuDoChiPhiTheoTB(grd, grv, sPath, SavePath, NNgu, TNgay, DNgay, sDiaDiem, sDayChuyen, sLoaiMay, sNhomMay,
                    Convert.ToBoolean(LChiPhi1), Convert.ToBoolean(LChiPhi2), Convert.ToBoolean(LChiPhi3),
                    Convert.ToBoolean(LChiPhi4), Convert.ToBoolean(LChiPhi5),out iCoDuLieu);
            }
            catch
            {
                iCoDuLieu = 2;
                return false; }

        }

        private Boolean InDuLieuBieuDoChiPhiTheoTB(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, string SavePath, int NNgu, DateTime TNgay, DateTime DNgay, String sDiaDiem,String sDayChuyen, String sLoaiMay,
            String sNhomMay, Boolean iLCPhi1, Boolean iLCPhi2, Boolean iLCPhi3, Boolean iLCPhi4, Boolean iLCPhi5, out int iTinhTrang)
        {
            iTinhTrang = 1;
            if (sPath == "") return false;
            Excel.Application xlApp = new Excel.Application();
            Excel.Workbooks xlWBooks;
            Excel.Workbook xlWBook;

            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;

                grd.ExportToXls(sPath);
                xlWBooks = xlApp.Workbooks;
                xlWBook = xlWBooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWSheet = (Excel.Worksheet)xlWBook.Sheets[1];

                Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet, 1, 3, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWSheet, 0, 0, 100, 45, SavePath);
                Commons.Modules.MExcel.ThemDong(xlWSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 9, Dong);
                 
                int SCot;

                // SCot = (TCot > 16 ? 14 : (TCot <= 6 ? TCot : TCot - 2));
                SCot = TCot;
                Dong++;

                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "TieuDe", NNgu)
                    , Dong, 1, "@", 16, true, Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;
                string stmp = "";

                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblTNgay", NNgu) + " : " + TNgay.ToString("dd/MM/yyyy") + " " +
                    Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDNgay", NNgu) + " : " + DNgay.ToString("dd/MM/yyyy");
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDDiem", NNgu) + " : " + sDiaDiem;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDChuyen", NNgu) + " : " + sDayChuyen;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblLMay", NNgu) + " : " + sLoaiMay;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblNhomMay", NNgu) + " : " + sNhomMay;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblLoaiChiPhi", NNgu) + " : ";
                if (iLCPhi1) stmp = stmp + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPPhuTung", NNgu);
                if (iLCPhi2) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPVatTu", NNgu);
                if (iLCPhi3) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPNhanCong", NNgu);
                if (iLCPhi4) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPDichVu", NNgu);
                if (iLCPhi5) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "LCPKhac", NNgu);
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                int DongBD;
                DongBD = Dong + 3;
                Excel.Range title;
                Dong++;
                Dong++;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;

                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWBook, xlWSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong - 1, 1, Dong - 1, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, 5, 1, 5, 1);
                title.RowHeight = 9;

                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "@", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 14, "@", true, Dong + 1, 2, TDong + Dong, 2);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 20, "@", true, Dong + 1, 3, TDong + Dong, 3);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 21, "@", true, Dong + 1, 4, TDong + Dong, 4);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 25, "@", true, Dong + 1, 5, TDong + Dong, 5);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 15, "#,##0.00", true, Dong + 1, 6, TDong + Dong, 6);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 15, "#,##0.00", true, Dong + 1, 7, TDong + Dong, 7);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 15, "#,##0.00", true, Dong + 1, 8, TDong + Dong, 8);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong + 1, 10, Dong + 1, 10);

                LoadBieuDoBieuDoChiPhiTheoTB(xlWSheet, Dong + TDong, 10, "", 1, 
                    Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 450, 350,NNgu);

                xlWBook.Save();
                xlWBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
            }
            catch
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                return false;   

            }

            return true;
            
        }

        private void LoadBieuDoBieuDoChiPhiTheoTB(Excel.Worksheet ExcelSheets, int vDong, int iColum, string sTitle, int iSoLan, double iLeft,
            double iTop, double iWidth, double iHeight, int NNgu)
        {
            try
            {
                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 3);
                double iLan = (iSoLan - 1) % 3;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;

                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);


                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Series xlSeries = xlSeriesCollection.NewSeries();

                var _with1 = xlSeries;
                _with1.AxisGroup = Excel.XlAxisGroup.xlPrimary;
                _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "KH", NNgu);
                _with1.Values = ExcelSheets.get_Range("F15", (vDong > 34 ? "F34" : "F" + vDong.ToString()));
                _with1.XValues = ExcelSheets.get_Range("B15", (vDong > 34 ? "B34" : "B" + vDong.ToString())); //"B33");

                Excel.Series xlSeries1 = xlSeriesCollection.NewSeries();
                var _with2 = xlSeries1;
                _with2.AxisGroup = Excel.XlAxisGroup.xlSecondary;
                _with2.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "KKH", NNgu);
                _with2.Values = ExcelSheets.get_Range("G15", (vDong > 34 ? "G34" : "G" + vDong.ToString())); //"G33");
                _with2.XValues = ExcelSheets.get_Range("B15", (vDong > 34 ? "B34" : "B" + vDong.ToString())); //"B33");
                xlChart.Refresh();

                xlChart.HasTitle = true;
                //xlChart.ChartTitle.Text = ExcelSheets.get_Range("D12", LayCot(iColum - 1) + "12");     //sTitle;
                xlChart.ChartTitle.Text = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "TieuDe", NNgu);// "=Sheet1!$A$" + (vDong + 1);                 //"=A" + vDong;

                xlChart.Legend.Position = Excel.XlLegendPosition.xlLegendPositionBottom;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                xlChart.Refresh();
            }
            catch
            { }
        }

        #endregion

        #region ucMailBieuDoChiPhiTheoTBThang
        public Boolean InBieuDoChiPhiTheoTBThang(DataTable dtSch, DevExpress.XtraGrid.GridControl grd,
            DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                DateTime TNgay, DNgay;
                string sUserName, sDiaDiem, sLoaiMay, sNhomMay;
                int NNgu, iSNgay, LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5, iDayChuyen;
                Boolean SauNgayBD;
                sDiaDiem = "";
                SauNgayBD = false;
                iSNgay = 0;
                sLoaiMay = "-1";
                sNhomMay = "-1";

                LChiPhi1 = 1;
                LChiPhi2 = 1;
                LChiPhi3 = 1;
                LChiPhi4 = 1;
                LChiPhi5 = 1;
                iDayChuyen = -1;


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
                        if (i == 0) if (s.Trim() == "0") SauNgayBD = false; else SauNgayBD = true;

                        if (i == 1) iSNgay = int.Parse(s);

                        if (i == 2) sDiaDiem = s;

                        if (i == 3)
                            if (s.Trim() == "0") LChiPhi1 = 0; else LChiPhi1 = 1;
                        if (i == 4)
                            if (s.Trim() == "0") LChiPhi2 = 0; else LChiPhi2 = 1;
                        if (i == 5)
                            if (s.Trim() == "0") LChiPhi3 = 0; else LChiPhi3 = 1;
                        if (i == 6)
                            if (s.Trim() == "0") LChiPhi4 = 0; else LChiPhi4 = 1;
                        if (i == 7)
                            if (s.Trim() == "0") LChiPhi5 = 0; else LChiPhi5 = 1;

                        if (i == 8) iDayChuyen = int.Parse(s);
                        if (i == 9) sLoaiMay = s;
                        if (i == 10) sNhomMay = s;
                        i++;
                    }
                }



                //If SauNgayBD = true nghia la in tu ngay bat dau in (tu ngay) + them so ngay ra den ngay
                //If SauNgayBD = false nghia la Ngay bat dau in la den ngay - di so ngay ra tu ngay.
                if (SauNgayBD)
                {
                    TNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year);
                    DNgay = TNgay.AddMonths(iSNgay).AddDays(-1);
                }
                else
                {
                    DNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(1).AddDays(-1);
                    TNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(-iSNgay + 1);
                }

                string sDK;
                sDK = dtSch.Rows[0]["DK_BAOCAO"].ToString();
                string[] DK = sDK.Split(new Char[] { '@' });
                sDK = DK.GetValue(1).ToString();

                DataTable dtMay = new DataTable();
                dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MGetMayBieuDoChiPhi",
                        TNgay, DNgay, "-1", "-1", "-1", sDiaDiem, iDayChuyen, sLoaiMay, sNhomMay));


                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString,
                            "CHON_MAY_BDCP", dtMay, "");

                string sSql = "";

                if (sDK != "ALL")
                {
                    sDK = "'" + sDK.Replace(",", "','") + "'";
                    sSql = "UPDATE CHON_MAY_BDCP SET CHON = 1  WHERE MS_MAY IN (" + sDK + ") ";
                }
                else
                {
                    sSql = "UPDATE CHON_MAY_BDCP SET CHON = 1 ";
                }

                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                sSql = "SELECT * FROM CHON_MAY_BDCP WHERE CHON = 1";
                dtMay = new DataTable();
                dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                if (dtMay.Rows.Count == 0)
                {
                    iCoDuLieu = 0;
                    return false;
                }

                DateTime TThang, DThang;
                TThang = TNgay;
                DThang = DNgay;
                string BTam, sThang, BangTam, sThangNull, sThangAvg;
                BTam = "";
                sThang = "";
                sSql = "";
                sThangAvg = "";
                BangTam = "ZZZBDCPTT_MAIL" + Commons.Modules.UserName;
                sThangNull = "";
                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                    DNgay = TNgay.AddMonths(1).AddDays(-1);
                    DataTable dtTmp = new DataTable();
                    BTam = "ZZZBDCPTT_MAIL" + Commons.Modules.UserName + Thang.ToString("MMyy");
                    sThang = sThang + " , [" + Thang.ToString("MM/yy") + "] ";
                    sThangNull = sThangNull + " , ISNULL([" + Thang.ToString("MM/yy") + "],0) AS [" + Thang.ToString("MM/yy") + "] ";
                    sThangAvg = sThangAvg + " + ISNULL([" + Thang.ToString("MM/yy") + "],0) ";

                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MBieuDoChiPhi",
                        TNgay, DNgay, "-1", "-1", "-1", sDiaDiem, iDayChuyen, sLoaiMay, sNhomMay,
                        LChiPhi1, LChiPhi2, LChiPhi3, LChiPhi4, LChiPhi5, 2, Thang.ToString("MM/yy")));

                    if (sSql == "")
                        sSql = " SELECT STT,MS_MAY,TEN_MAY,TONG_CP,THANG INTO " + BangTam + " FROM " + BTam;
                    else
                        sSql += " UNION SELECT STT,MS_MAY,TEN_MAY,TONG_CP,THANG " + BangTam + " FROM " + BTam;

                    if (!Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtTmp, ""))
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                    Thang = Thang.AddMonths(1);
                }

                Commons.Modules.ObjSystems.XoaTable(BangTam);
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                sSql = "  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_CP FROM " +
                "   ( SELECT STT,MS_MAY , TEN_MAY, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                " 	  FROM  " +
                " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                " 		PIVOT (SUM(TONG_CP) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                " 		 )) AS PVT)  " +
                "    A  ORDER BY A.MS_MAY ";

                DataTable _table = new DataTable();
                _table.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                _table.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= _table.Rows.Count - 1; i++)
                {
                    _table.Rows[i][0] = (i + 1).ToString();
                }


                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    BTam = "ZZZBDCPTT_MAIL" + Commons.Modules.UserName + Thang.ToString("MMyy");
                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    Thang = Thang.AddMonths(1);
                }
                Commons.Modules.ObjSystems.XoaTable(BangTam);

                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, _table, false, true, false, false);
                Commons.Modules.ObjSystems.XoaTable("CHON_MAY_BDCP");                
                grv.Columns["STT"].Caption = Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "STT", NNgu);
                grv.Columns["MS_MAY"].Caption = Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "MS_MAY", NNgu);
                grv.Columns["TEN_MAY"].Caption = Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "TEN_MAY", NNgu);
                grv.Columns["TONG_CP"].Caption = Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "TONG_CP", NNgu);

                string sPath, SavePath, sDayChuyen;
                sSql = "";
                sDayChuyen = "";
                sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                SavePath = Application.StartupPath;
                if (sDiaDiem == "-1") sDiaDiem = " < ALL > ";
                else
                {
                    sSql = "SELECT CASE " + NNgu.ToString() + " WHEN 0 THEN TEN_N_XUONG WHEN 1 THEN TEN_N_XUONG_A ELSE TEN_N_XUONG_H END AS TNX " +
                                " FROM NHA_XUONG WHERE MS_N_XUONG = '" + sDiaDiem + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sDiaDiem = dtMay.Rows[0]["TNX"].ToString();
                    }

                }

                if (iDayChuyen == -1) sDayChuyen = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_HE_THONG FROM HE_THONG WHERE MS_HE_THONG = 3";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sDayChuyen = dtMay.Rows[0]["TEN_HE_THONG"].ToString();
                    }

                }
                if (sLoaiMay == "-1") sLoaiMay = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_LOAI_MAY FROM LOAI_MAY WHERE MS_LOAI_MAY = '" + sLoaiMay + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sLoaiMay = dtMay.Rows[0]["TEN_LOAI_MAY"].ToString();
                    }

                }
                if (sNhomMay == "-1") sNhomMay = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_NHOM_MAY FROM NHOM_MAY WHERE MS_NHOM_MAY = '" + sNhomMay + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sNhomMay = dtMay.Rows[0]["TEN_NHOM_MAY"].ToString();
                    }

                }

                Commons.Modules.ObjSystems.XoaTable("CHON_MAY_BDCP");

                return InDuLieuBieuDoChiPhiTheoTBThang(grd, grv, sPath, SavePath, NNgu, TThang, DThang, sDiaDiem, sDayChuyen, sLoaiMay, sNhomMay,
                    Convert.ToBoolean(LChiPhi1), Convert.ToBoolean(LChiPhi2), Convert.ToBoolean(LChiPhi3),
                    Convert.ToBoolean(LChiPhi4), Convert.ToBoolean(LChiPhi5), out iCoDuLieu);

            }
            catch {
                iCoDuLieu = 2;
                return false; }
        }

        private Boolean InDuLieuBieuDoChiPhiTheoTBThang(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, string SavePath, int NNgu, DateTime TNgay, DateTime DNgay, String sDiaDiem,String sDayChuyen, String sLoaiMay,
            String sNhomMay, Boolean iLCPhi1, Boolean iLCPhi2, Boolean iLCPhi3, Boolean iLCPhi4, Boolean iLCPhi5, out int iTinhTrang)
        {
            iTinhTrang = 1;
            if (sPath == "")
            {
                iTinhTrang = 2; 
                return false;
            }
            Excel.Application xlApp = new Excel.Application();
            Excel.Workbooks xlWBooks;
            Excel.Workbook xlWBook; 
            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount + 1;
                int Dong = 1;
                grd.ExportToXls(sPath);
                System.Globalization.CultureInfo oldCultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
                System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
                xlWBooks = xlApp.Workbooks;
                xlWBook = xlWBooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWSheet = (Excel.Worksheet)xlWBook.Sheets[1];
                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;
                xlApp.Cells.Font.Name = "Tahoma";
                xlApp.Cells.Font.Size = 10;


                Dong = Dong + TDong;

                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "TongCong", NNgu)
                    , Dong, 1, "@", 10, true, Excel.XlHAlign.xlHAlignRight, Excel.XlVAlign.xlVAlignCenter, true, Dong, 3);

                for (int cot = 4; cot <= TCot; cot++)
                    Commons.Modules.MExcel.MFuntion(xlWSheet, "SUM", Dong, cot, Dong, cot, Dong - TDong + 1, cot, Dong - 1, cot, 10, true, 10, "#,##0");
                Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet, 1, 3, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWSheet, 0, 0, 100, 45, Application.StartupPath);
                Commons.Modules.MExcel.ThemDong(xlWSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 9, Dong);

                int SCot;

                SCot = (TCot > 10 ? 10 : TCot);
                Dong++;
                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "TieuDe", NNgu)
                    , Dong, 1, "@", 16, true, Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;
                string stmp = "";
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblTThang", NNgu) + " : " + TNgay.ToString("MM/yyyy") + " " +
                        Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblDThang", NNgu) + " : " + DNgay.ToString("MM/yyyy");
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblDDiem", NNgu) + " : " + sDiaDiem;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblDChuyen", NNgu) + " : " + sDayChuyen;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblLMay", NNgu) + " : " + sLoaiMay;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblNhomMay", NNgu) + " : " + sNhomMay;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblLoaiChiPhi", NNgu) + " : ";
                if (iLCPhi1) stmp = stmp + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "LCPPhuTung", NNgu);
                if (iLCPhi2) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "LCPVatTu", NNgu);
                if (iLCPhi3) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "LCPNhanCong", NNgu);
                if (iLCPhi4) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "LCPDichVu", NNgu);
                if (iLCPhi5) stmp = stmp + ", " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "LCPKhac", NNgu);

                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                int DongBD;
                DongBD = Dong + 3;
                Excel.Range title;
                Dong++;
                Dong++;
                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                //title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));
                //title.Interior.Color = xlWSheet.get_Range(xlWSheet.Cells[Dong - 1, 1], xlWSheet.Cells[Dong - 1, 1]).Interior.Color;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;

                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWBook, xlWSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);

                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;


                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;


                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong - 1, 1, Dong - 1, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, 5, 1, 5, 1);
                title.RowHeight = 9;


                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "##", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 14, "@", true, Dong + 1, 2, TDong + Dong, 2);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 20, "@", true, Dong + 1, 3, TDong + Dong, 3);
                for (int i = 4; i <= TCot; i++)
                    Commons.Modules.MExcel.ColumnWidth(xlWSheet, 12, "#,##0", true, Dong + 1, i, TDong + Dong, i);

                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "@", true, Dong + 1, TCot + 1, TDong + Dong, TCot + 1);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong + 1, TCot + 2, Dong + 1, TCot + 2);
                double iLeft; double iTop;
                double iWidth; double iHeight;

                iLeft = Convert.ToDouble(title.Left);
                iTop = Convert.ToDouble(title.Top);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong + 1, TCot + 2, Dong + 10, TCot + 2);
                iHeight = Convert.ToDouble(title.Height);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong + 1, TCot + 2, Dong + 10, TCot + 2 + 7);
                iWidth = Convert.ToDouble(title.Width);
                Boolean dCuoi;
                dCuoi = false;
                for (int i = 15; i <= Dong + TDong; i++)
                {
                    if (i == Dong + TDong)
                    {
                        dCuoi = true;

                    }
                    LoadBieuDoBieuDoChiPhiTheoTBThang(xlWSheet, i, TCot, "", i - 14, iLeft, iTop, iWidth, iHeight, dCuoi, NNgu);

                }
                xlApp.DisplayAlerts = false;
                xlWBook.Save();
                xlWBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);                
            }
            catch
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                return false;   

            }
            return true;
        }


        private void LoadBieuDoBieuDoChiPhiTheoTBThang(Excel.Worksheet ExcelSheets, int iDong, int iColumKT, string sTitle, int iSoLan,
                double iLeft, double iTop, double iWidth, double iHeight, Boolean sCuoi, int NNgu)
        {
            try
            {
                double iSLan;
                double sLe;
                double sChan;
                double sKQ;

                iSLan = iSoLan;
                sKQ = 0;
                if (sCuoi)
                {
                    sChan = Math.Floor(iSLan / 10);
                    sLe = iSLan - sChan * 10;
                    if (sLe != 0)
                    {
                        sKQ = ((sChan + 1) * 10) + 1;

                    }


                    iSoLan = int.Parse(sKQ.ToString());


                }

                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 10);
                double iLan = (iSoLan - 1) % 10;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;

                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                Excel.Series xlSeries = xlSeriesCollection.NewSeries();

                var _with1 = xlSeries;
                _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "Thang", NNgu);// "=Sheet1!$A$" + (vDong + 1);                 //"=A" + vDong;
                _with1.Values = ExcelSheets.get_Range("D" + iDong, Commons.Modules.MExcel.MCotExcel(iColumKT - 1) + iDong); //"B33");
                _with1.XValues = ExcelSheets.get_Range("D14", Commons.Modules.MExcel.MCotExcel(iColumKT - 1) + "14");


                if (sCuoi)
                    xlChart.ChartTitle.Text = Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "TongCong", NNgu);
                else
                    xlChart.ChartTitle.Text = "=Sheet1!$B$" + (iDong);


                xlChart.Refresh();
                xlChart.HasTitle = true;
                xlChart.Legend.Position = Excel.XlLegendPosition.xlLegendPositionBottom;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Axis ax = xlChart.Axes(Excel.XlAxisType.xlCategory, Excel.XlAxisGroup.xlPrimary) as Excel.Axis;

                ax.TickLabels.Orientation = Excel.XlTickLabelOrientation.xlTickLabelOrientationUpward;
                xlChart.Refresh();

            }
            catch
            { }
        }

        #endregion

        #region ucMailBieuDoTGNMayTheoMay -- BDTGNMTM
        public Boolean BDTGNMTMInBieuDoTGNMayTheoMay(DataTable dtSch,DevExpress.XtraGrid.GridControl grd,
            DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                string sUserName, sDDiem, sStmp, sBCao, sStm1, sLMay, sNMay;
                DateTime TNgay, DNgay;
                int NNgu, iSNgay, iLoaiBC, iDChuyen;
                Boolean SauNgayBD;
                DataTable dtTmp = new DataTable();
                iLoaiBC = 0;
                sStm1 = "";
                sDDiem = "";
                sLMay = "";
                sNMay = "";
                iDChuyen = -1;
                SauNgayBD = false;
                iSNgay = 0;


                NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
                sUserName = dtSch.Rows[0]["USERNAME"].ToString();

                if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
                {

                    sBCao = "";
                    sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                    string[] chuoi_tach = sStmp.Split(new Char[] { ',' });
                    int i = 0;

                    foreach (string s in chuoi_tach)
                    {
                        if (i == 0) if (s.Trim() == "0") SauNgayBD = false; else SauNgayBD = true;

                        if (i == 1) iSNgay = int.Parse(s);
                        if (i == 2) sDDiem = s;

                        if (i == 3) iLoaiBC = int.Parse(s);
                        if (i == 4) iDChuyen = int.Parse(s);
                        if (i == 5) sLMay = s;
                        if (i == 6) sNMay = s;
                        if (i == 7)
                        {
                            sStm1 = sBCao.Substring(1, sBCao.Length - 1);
                            sStm1 = sStmp.Replace(sStm1, "");
                            if (sStm1 == ",ALL") break;
                            sStm1 = sStm1.Substring(1, sStm1.Length - 2);
                            break;
                        }

                        i++;
                        sBCao = sBCao + "," + s;
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




                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MBDTGNgungMayTheoMay",
                    TNgay, DNgay, "-1", "-1", "-1", sDDiem, iDChuyen, sLMay, sNMay));
                string BTam, BTamChon;
                BTam = "ZZZ_TGNM_MAIL" + sUserName;
                BTamChon = "ZZZ_TGNM_CHON_MAIL" + sUserName;

                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtTmp, "");

                #region Lay du lieu chon in
                string sSql = "";
                Commons.Modules.ObjSystems.XoaTable(BTamChon);
                sSql = "SELECT CONVERT(BIT,1) AS CHON ,MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, HU_HONG, BTDK, CONVERT(NVARCHAR,MS_NGUYEN_NHAN) AS MS_NN " +
                    " INTO " + BTamChon + " FROM dbo.NGUYEN_NHAN_DUNG_MAY ";
                if (sStm1 != ",ALL")
                    sSql += " WHERE MS_NGUYEN_NHAN IN (" + sStm1 + ") ";
                #endregion
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                sSql = "";
                if (iLoaiBC == 0)
                    sSql = " SELECT A.*, SO_LAN , CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR FROM " +
                                " (SELECT CONVERT(INT,NULL) AS STT, A.MS_MAY,	TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI,THOI_GIAN_SUA_CHUA,THOI_GIAN_SUA FROM " +
                                " (SELECT MS_MAY , SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA ,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA  " +
                                " FROM " + BTam + " A INNER JOIN " + BTamChon + " B ON A.MS_NGUYEN_NHAN = B.MS_NGUYEN_NHAN  " +
                                " GROUP BY MS_MAY  " +
                                " ) A INNER JOIN MAY C ON A.MS_MAY = C.MS_MAY             ) A LEFT JOIN ( " +
                                " SELECT     MS_MAY, COUNT(DISTINCT MS_LAN) AS SO_LAN " +
                                " FROM         dbo.THOI_GIAN_NGUNG_MAY WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "'  " +
                                " GROUP BY MS_MAY " +
                                " ) C ON A.MS_MAY = C.MS_MAY ORDER BY THOI_GIAN_SUA_CHUA DESC";

                if (iLoaiBC == 1)
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_MAY,	TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI,THOI_GIAN_SUA_CHUA  FROM " +
                                " (SELECT MS_MAY , SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA " +
                                " FROM " + BTam + " A INNER JOIN " + BTamChon + " B ON A.MS_NGUYEN_NHAN = B.MS_NGUYEN_NHAN  " +
                                " GROUP BY MS_MAY  " +
                                " ) A INNER JOIN MAY C ON A.MS_MAY = C.MS_MAY  ORDER BY THOI_GIAN_SUA_CHUA DESC";

                if (iLoaiBC == 2)
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_MAY,	TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI,THOI_GIAN_SUA  FROM " +
                                " (SELECT MS_MAY ,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA  " +
                                " FROM " + BTam + " A INNER JOIN " + BTamChon + " B ON A.MS_NGUYEN_NHAN = B.MS_NGUYEN_NHAN  " +
                                " GROUP BY MS_MAY  " +
                                " ) A INNER JOIN MAY C ON A.MS_MAY = C.MS_MAY  ORDER BY THOI_GIAN_SUA DESC";

                if (iLoaiBC == 3)
                    sSql = " SELECT STT,A.MS_MAY,TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI,SO_LAN FROM " +
                                " (SELECT CONVERT(INT,NULL) AS STT, A.MS_MAY,	TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI FROM " +
                                " (SELECT MS_MAY  " +
                                " FROM " + BTam + " A INNER JOIN " + BTamChon + " B ON A.MS_NGUYEN_NHAN = B.MS_NGUYEN_NHAN  " +
                                " GROUP BY MS_MAY  " +
                                " ) A INNER JOIN MAY C ON A.MS_MAY = C.MS_MAY             ) A LEFT JOIN ( " +
                                " SELECT     MS_MAY, COUNT(DISTINCT MS_LAN) AS SO_LAN " +
                                " FROM         dbo.THOI_GIAN_NGUNG_MAY WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "'  " +
                                " GROUP BY MS_MAY " +
                                " ) C ON A.MS_MAY = C.MS_MAY ORDER BY SO_LAN DESC";

                if (iLoaiBC == 4)
                    sSql = " SELECT STT,A.MS_MAY,TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI,THOI_GIAN_SUA_CHUA, SO_LAN , CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR FROM " +
                                " (SELECT CONVERT(INT,NULL) AS STT, A.MS_MAY,	TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI,THOI_GIAN_SUA_CHUA FROM " +
                                " (SELECT MS_MAY , SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA   " +
                                " FROM " + BTam + " A INNER JOIN " + BTamChon + " B ON A.MS_NGUYEN_NHAN = B.MS_NGUYEN_NHAN  " +
                                " GROUP BY MS_MAY  " +
                                " ) A INNER JOIN MAY C ON A.MS_MAY = C.MS_MAY             ) A LEFT JOIN ( " +
                                " SELECT     MS_MAY, COUNT(DISTINCT MS_LAN) AS SO_LAN " +
                                " FROM         dbo.THOI_GIAN_NGUNG_MAY WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "'  " +
                                " GROUP BY MS_MAY " +
                                " ) C ON A.MS_MAY = C.MS_MAY ORDER BY MTTR DESC";

                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }
                #region Kiem co du lieu
                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch { }
                #endregion
                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
                Commons.Modules.ObjSystems.MLoadNNXtraGrid(grv, "ucBieuDoTGNMayTheoMay");

                string sPath, SavePath;
                sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                SavePath = Application.StartupPath;
                string sDayChuyen = "";
                DataTable dtMay = new DataTable();

                if (sDDiem == "-1") sDDiem = " < ALL > ";
                else
                {
                    sSql = "SELECT CASE " + NNgu.ToString() + " WHEN 0 THEN TEN_N_XUONG WHEN 1 THEN TEN_N_XUONG_A ELSE TEN_N_XUONG_H END AS TNX " +
                                " FROM NHA_XUONG WHERE MS_N_XUONG = '" + sDDiem + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sDDiem = dtMay.Rows[0]["TNX"].ToString();
                    }

                }

                if (iDChuyen == -1) sDayChuyen = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_HE_THONG FROM HE_THONG WHERE MS_HE_THONG = " + iDChuyen;
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sDayChuyen = dtMay.Rows[0]["TEN_HE_THONG"].ToString();
                    }

                }
                if (sLMay == "-1") sLMay = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_LOAI_MAY FROM LOAI_MAY WHERE MS_LOAI_MAY = '" + sLMay + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sLMay = dtMay.Rows[0]["TEN_LOAI_MAY"].ToString();
                    }

                }
                if (sNMay == "-1") sNMay = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_NHOM_MAY FROM NHOM_MAY WHERE MS_NHOM_MAY = '" + sNMay + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sNMay = dtMay.Rows[0]["TEN_NHOM_MAY"].ToString();
                    }

                }
                Commons.Modules.ObjSystems.XoaTable("ZZZ_TGNM_MAIL" + sUserName);
                Commons.Modules.ObjSystems.XoaTable("ZZZ_TGNM_CHON_MAIL" + sUserName);

                if (!BDTGNMTMInDuLieu(grd, grv, sPath, SavePath, NNgu, TNgay, DNgay, iLoaiBC, sDDiem, sDayChuyen, sLMay, sNMay, out iCoDuLieu)) return false;

                return true;
            }
            catch
            {
                iCoDuLieu = 2;
                return false; }
        }

        private Boolean BDTGNMTMInDuLieu(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, string SavePath, int NNgu, DateTime TNgay, DateTime DNgay, int iLoaiBC,
            string sDiaDiem, string sDayChuyen, string sLoaiMay, string sNhomMay, out int iTinhTrang)
        {
            iTinhTrang = 1;
            if (sPath == "")
            {
                iTinhTrang = 2;
                return false;
            }
            Excel.Application xlApp = new Excel.Application();
            Excel.Workbooks xlWBooks;
            Excel.Workbook xlWBook;
            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;

                grd.ExportToXls(sPath);
                xlWBooks = xlApp.Workbooks;
                xlWBook = xlWBooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWSheet = (Excel.Worksheet)xlWBook.Sheets[1];

                Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet, 1, 3, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWSheet, 0, 0, 100, 45, SavePath);
                Commons.Modules.MExcel.ThemDong(xlWSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 8, Dong);

                int SCot;

                SCot = TCot;// (TCot > 9 ? 9 : TCot);

                Dong++;
                string stmp = "";
                if (iLoaiBC == 0) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TieuDe", NNgu);
                if (iLoaiBC == 1) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TieuDeTGNM", NNgu);
                if (iLoaiBC == 2) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TieuDeTGSC", NNgu);
                if (iLoaiBC == 3) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TieuDeSoLan", NNgu);
                if (iLoaiBC == 4) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TieuDeMTTR", NNgu);

                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 1, "@", 16, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblTNgay", NNgu) + " : " + TNgay.ToString("dd/MM/yyyy") + " " +
                            Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDNgay", NNgu) + " : " + DNgay.ToString("dd/MM/yyyy");
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 1, "@", 10, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDDiem", NNgu) + " : " + sDiaDiem;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDChuyen", NNgu) + " : " + sDayChuyen;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblLMay", NNgu) + " : " + sLoaiMay;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblNhomMay", NNgu) + " : " + sNhomMay;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);


                int DongBD;
                DongBD = Dong + 3;
                Excel.Range title;
                Dong = Dong + 2;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;

                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWBook, xlWSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);
                title = Commons.Modules.MExcel.GetRange(xlWSheet, 5, 1, 5, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong - 1, 1, Dong - 1, 1);
                title.RowHeight = 9;

                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "##", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 14, "@", true, Dong + 1, 2, TDong + Dong, 2);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 20, "@", true, Dong + 1, 3, TDong + Dong, 3);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 12, "@", true, Dong + 1, 4, TDong + Dong, 4);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 27, "@", true, Dong + 1, 5, TDong + Dong, 5);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 35, "@", true, Dong + 1, 6, TDong + Dong, 6);

                for (int i = 7; i <= grv.Columns.Count; i++)
                    Commons.Modules.MExcel.ColumnWidth(xlWSheet, 12, "#,##0", true, Dong + 1, i, TDong + Dong, i);

                SCot = 7;
                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD, TCot + 2, DongBD, TCot + 2);
                string TDe;

                if (iLoaiBC == 0)
                {
                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TDTGNM", NNgu);
                    BDTGNMTMLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "G", TDe);

                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TGSC", NNgu);
                    BDTGNMTMLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 2, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "H", TDe);

                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "SLNM", NNgu);
                    BDTGNMTMLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 3, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "I", TDe);

                    TDe = "MTTR";
                    BDTGNMTMLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 4, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "J", TDe);
                }

                if (iLoaiBC == 1)
                {
                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TDTGNM", NNgu);
                    BDTGNMTMLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "G", TDe);
                }

                if (iLoaiBC == 2)
                {
                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "TGSC", NNgu);
                    BDTGNMTMLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "G", TDe);
                }

                if (iLoaiBC == 3)
                {
                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoMay", "SLNM", NNgu);
                    BDTGNMTMLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "G", TDe);
                }


                if (iLoaiBC == 4)
                {
                    TDe = "MTTR";
                    BDTGNMTMLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "I", TDe);
                }

                xlApp.DisplayAlerts = false;
                xlWBook.Save();
                xlWBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                
            }
            catch
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                return false;
            }
            return true;

        }

        private void BDTGNMTMLoadBieuDo(Excel.Worksheet ExcelSheets, int iDong, int iColumKT, string sTitle, int iSoLan, double iLeft,
            double iTop, double iWidth, double iHeight, string CotDL, string TDBCao)
        {
            try
            {

                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 2);
                double iLan = (iSoLan - 1) % 2;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;

                if (iSoLan > 2) iTop = iTop + 9;
                if (iSoLan == 2 || iSoLan == 4) iLeft = iLeft + 9;

                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);


                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Series xlSeries = xlSeriesCollection.NewSeries();
                var _with1 = xlSeries;

                _with1.AxisGroup = Excel.XlAxisGroup.xlPrimary;
                //_with1.Name = TDBCao;
                _with1.Values = ExcelSheets.get_Range(CotDL + "14", (iDong > 34 ? CotDL + "33" : CotDL + iDong.ToString()));
                _with1.XValues = ExcelSheets.get_Range("B14", (iDong > 34 ? "B33" : "B" + iDong.ToString()));

                xlChart.HasTitle = true;

                xlChart.ChartTitle.Text = TDBCao;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                xlChart.Legend.Delete();
                xlChart.Refresh();


            }
            catch
            { }
        }

        #endregion

        #region ucMailBieuDoTGNMayTheoMayThang -- BDTGNMTMThang
        public Boolean BDTGNMTMThangInBieuDoTGNMayTheoMayThang(DataTable dtSch,
            DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            #region Khai Bao Bien
            string sSql, sUserName, sMsNXuong, sStmp, sBCao, sStm1, sLMay,sNMay;
            DateTime TThang, DThang;
            DateTime TNgay, DNgay;
            int NNgu, iLoaiBC, iSNgay, iHThong;
            Boolean SauNgayBD;
            DataTable dtTmp = new DataTable();
            DataTable dtNNNMay = new DataTable();
            DataTable dtMay = new DataTable();
            sStm1 = "";
            SauNgayBD = false;
            iSNgay = 0;
            iLoaiBC = 0;
            sSql = "";
            sMsNXuong = "-1";
            iHThong = -1;
            sLMay = "-1";
            sNMay = "-1";

            NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
            sUserName = dtSch.Rows[0]["USERNAME"].ToString();

            #endregion

            #region Lay dieu kien bao cao

            if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
            {
                sBCao = "";
                sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                string[] chuoi_tach = sStmp.Split(new Char[] { '@' });
                int i = 0;
                foreach (string s in chuoi_tach)
                {
                    if (i == 0)
                    {
                        sBCao = s;
                        string[] sChuoiBC = sBCao.Split(new Char[] { ',' });
                        if (sChuoiBC.GetValue(0).ToString().Trim() == "0") SauNgayBD = false; else SauNgayBD = true;


                        iSNgay = int.Parse(sChuoiBC.GetValue(1).ToString());
                        sMsNXuong = sChuoiBC.GetValue(2).ToString();
                        iLoaiBC = int.Parse(sChuoiBC.GetValue(3).ToString());
                        iHThong = int.Parse(sChuoiBC.GetValue(4).ToString());
                        sLMay = sChuoiBC.GetValue(5).ToString();
                        sNMay = sChuoiBC.GetValue(6).ToString();
                    }
                    if (i == 1)
                    {
                        if (SauNgayBD)
                        {
                            TThang = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year);
                            DThang = TThang.AddMonths(iSNgay).AddDays(-1);
                        }
                        else
                        {
                            DThang = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year);
                            TThang = DThang.AddMonths(-iSNgay + 1);

                        }
                        if (s == "ALL")
                        {
                            dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MGetMayThoiGianNgungMay",
                                TThang, DThang, "-1", "-1", "-1", sMsNXuong, iHThong, sLMay, sNMay));
                        }
                        else
                        {
                            sSql = "'" + s.Replace(",", "','") + "'";
                            sSql = "SELECT MS_MAY FROM MAY WHERE MS_MAY IN (" + sSql + ")";
                            dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                        }

                    }
                    if (i == 2)
                    {
                        sStm1 = s;
                        sSql = "'" + s.Replace(",", "','") + "'";

                        if (s == "ALL")
                            sSql = "SELECT CONVERT(BIT,1) AS CHON ,MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, HU_HONG, BTDK, " +
                                    " CONVERT(NVARCHAR,MS_NGUYEN_NHAN) AS MS_NN FROM dbo.NGUYEN_NHAN_DUNG_MAY ORDER BY TEN_NGUYEN_NHAN";

                        else
                            sSql = "SELECT * FROM NGUYEN_NHAN_DUNG_MAY WHERE MS_NGUYEN_NHAN IN (" + sSql + ") ";


                        dtNNNMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                        break;

                    }
                    i++;
                }
            }
            else
            {
                iCoDuLieu = 0;
                return false;
            }

            if (SauNgayBD)
            {
                TThang = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year);
                DThang = TThang.AddMonths(iSNgay).AddDays(-1);
            }
            else
            {
                DThang = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(1).AddDays(-1);
                TThang = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(-iSNgay + 1);
            }

            string BaoCao = "";
            if (iLoaiBC == 0) BaoCao = "THOI_GIAN_SUA_CHUA";
            if (iLoaiBC == 1) BaoCao = "THOI_GIAN_SUA";
            if (iLoaiBC == 2) BaoCao = "SO_LAN";
            if (iLoaiBC == 3) BaoCao = "MTTR";
            string BTamMay, BTamTGNM;

            #region Lay du lieu chon in TGNM
            BTamTGNM = "ZZZ_TGNM_CHON_MAIL" + sUserName;
            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTamTGNM, dtNNNMay, "");

            #endregion TGNM
            #region Lay du lieu chon in MAY
            BTamMay = "ZZZ_TGNM_MAY_CHON_MAIL" + sUserName;
            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTamMay, dtMay, "");

            #endregion

            #endregion

            string BTam, sThang, BangTam, sThangNull, sThangAvg;
            sSql = "";
            sThang = "";
            sThangAvg = "";
            BangTam = "BDTGNM_MAIL" + sUserName;
            sThangNull = "";
            BTam = "";
            for (DateTime Thang = TThang; Thang <= DThang; )
            {
                TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                DNgay = TNgay.AddMonths(1).AddDays(-1);
                BTam = "ZZZ_TGNM_MAIL" + Thang.ToString("MMyyyy") + Commons.Modules.UserName;
                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MBDTGNgungMayTheoMay",
                        TNgay, DNgay, "-1", "-1", "-1",sMsNXuong, iHThong, sLMay, sNMay));
                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtTmp, "");


                sThang = sThang + " , [" + Thang.ToString("MM/yy") + "] ";
                sThangNull = sThangNull + " , ISNULL([" + Thang.ToString("MM/yy") + "],0) AS [" + Thang.ToString("MM/yy") + "] ";
                sThangAvg = sThangAvg + " + ISNULL([" + Thang.ToString("MM/yy") + "],0) ";

                if (iLoaiBC == 3)
                    sSql = sSql + (sSql == "" ? "" : " UNION ") + "SELECT TTNM.MS_MAY, " +
                                " ISNULL(CASE ISNULL(SUM(THOI_GIAN_SUA_CHUA),0) WHEN 0 THEN 0 ELSE SUM(THOI_GIAN_SUA_CHUA) /SUM(SO_LAN) END,0) AS MTTR," +
                                " N'" + TNgay.ToString("MM/yy") + "' AS THANG " +
                                " FROM " + BTam + " TTNM LEFT JOIN (SELECT  A.MS_NGUYEN_NHAN,   A.MS_MAY, COUNT(DISTINCT MS_LAN) AS SO_LAN  " +
                                " FROM THOI_GIAN_NGUNG_MAY A " +
                                " INNER JOIN " + BTamTGNM + " B ON A.MS_NGUYEN_NHAN  = B.MS_NGUYEN_NHAN " +
                                " WHERE A.NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' " +
                                " AND '" + DNgay.ToString("MM/dd/yyyy") + "'  GROUP BY A.MS_MAY,A.MS_NGUYEN_NHAN ) TGNML ON TTNM.MS_MAY = TGNML.MS_MAY " +
                                " AND TTNM.MS_NGUYEN_NHAN = TGNML.MS_NGUYEN_NHAN GROUP BY TTNM.MS_MAY ";
                else
                    sSql = sSql + (sSql == "" ? "" : " UNION ") + "SELECT TTNM.MS_MAY, ISNULL(SUM(" + BaoCao + "),0) AS " + BaoCao + " , " +
                                " ISNULL(CASE ISNULL(SUM(THOI_GIAN_SUA_CHUA),0) WHEN 0 THEN 0 ELSE SUM(THOI_GIAN_SUA_CHUA) /SUM(SO_LAN) END,0) AS MTTR," +
                                " N'" + TNgay.ToString("MM/yy") + "' AS THANG " +
                                " FROM " + BTam + " TTNM LEFT JOIN (SELECT  A.MS_NGUYEN_NHAN,   A.MS_MAY, COUNT(DISTINCT MS_LAN) AS SO_LAN  " +
                                " FROM THOI_GIAN_NGUNG_MAY A " +
                                " INNER JOIN " + BTamTGNM + " B ON A.MS_NGUYEN_NHAN  = B.MS_NGUYEN_NHAN " +
                                " WHERE A.NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' " +
                                " AND '" + DNgay.ToString("MM/dd/yyyy") + "'  GROUP BY A.MS_MAY,A.MS_NGUYEN_NHAN ) TGNML ON TTNM.MS_MAY = TGNML.MS_MAY " +
                                " AND TTNM.MS_NGUYEN_NHAN = TGNML.MS_NGUYEN_NHAN GROUP BY TTNM.MS_MAY ";

                Thang = Thang.AddMonths(1);
            }
            sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_MAY,	TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI,THOI_GIAN , THANG INTO " + BangTam + " FROM " +
            " ( " +
            " SELECT A.MS_MAY,SUM(" + BaoCao + ") AS THOI_GIAN, THANG FROM " +
            " ( " + sSql + " ) A INNER JOIN " + BTamMay + " C ON A.MS_MAY = C.MS_MAY " +
            " GROUP BY A.MS_MAY, THANG ) A INNER JOIN MAY C ON A.MS_MAY = C.MS_MAY ";

            Commons.Modules.ObjSystems.XoaTable(BangTam);
            SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

            string sBTam;
            sBTam = "ZZZ_TGNM_MAY_THANG" + Commons.Modules.UserName;
            TNgay = TThang;
            DNgay = DThang;
            BTam = "ZZZ_BDTGNM_TONG_THANG_MAIL" + Commons.Modules.UserName;
            string sBTamTong;
            sBTamTong = "ZZZ_TGNM_MAY_THANG_TONG_MAIL" + Commons.Modules.UserName;

            if (iLoaiBC != 3)
            {
                if (iLoaiBC == 2)
                {
                    sSql = " SELECT * INTO " + sBTam + " FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                "   ( SELECT STT,MS_MAY,TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                " 	  FROM  " +
                                " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                " 		PIVOT (SUM(THOI_GIAN) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                " 		 )) AS PVT)  " +
                                "    A  ) B ORDER BY TONG_TG DESC ";
                    Commons.Modules.ObjSystems.XoaTable(sBTam);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);
                    dtTmp = new DataTable();
                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MBDTGNgungMayTheoMay",
                            TNgay, DNgay, "-1", "-1", "-1", sMsNXuong, iHThong, sLMay, sNMay));
                    Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtTmp, "");

                    Commons.Modules.ObjSystems.XoaTable(sBTamTong);
                    sSql = "SELECT TTNM.MS_MAY, ISNULL(SUM(SO_LAN),0) AS SO_LAN INTO " + sBTamTong +
                                " FROM " + BTam + " TTNM LEFT JOIN (SELECT  A.MS_NGUYEN_NHAN,   A.MS_MAY, COUNT(DISTINCT A.MS_LAN) AS SO_LAN  " +
                                " FROM THOI_GIAN_NGUNG_MAY  A " +
                                " INNER JOIN " + BTamTGNM + " B ON A.MS_NGUYEN_NHAN  = B.MS_NGUYEN_NHAN " +
                                " WHERE A.NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' " +
                                " AND '" + DNgay.ToString("MM/dd/yyyy") + "'  GROUP BY A.MS_MAY,A.MS_NGUYEN_NHAN ) TGNML ON TTNM.MS_MAY = TGNML.MS_MAY " +
                                " AND  TTNM.MS_NGUYEN_NHAN = TGNML.MS_NGUYEN_NHAN GROUP BY TTNM.MS_MAY";
                    Commons.Modules.ObjSystems.XoaTable(sBTamTong);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sSql = " UPDATE " + sBTam + " SET TONG_TG = SO_LAN FROM " + sBTam + " A INNER JOIN  " + sBTamTong + " B ON A.MS_MAY = B.MS_MAY";
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);
                    sSql = " SELECT  STT,MS_MAY,TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI, " + sThangNull.Substring(3, sThangNull.Length - 3) + " , TONG_TG " +
                                " FROM  " + sBTam + " ORDER BY TONG_TG DESC";

                }
                else
                {
                    sSql = " SELECT * FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                    "   ( SELECT STT,MS_MAY,TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                    " 	  FROM  " +
                    " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                    " 		PIVOT (SUM(THOI_GIAN) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                    " 		 )) AS PVT)  " +
                    "    A  ) B ORDER BY TONG_TG DESC ";

                }
            }
            else
            {
                sSql = " SELECT * INTO " + sBTam + " FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                            "   ( SELECT STT,MS_MAY,TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                            " 	  FROM  " +
                            " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                            " 		PIVOT (SUM(THOI_GIAN) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                            " 		 )) AS PVT)  " +
                            "    A  ) B ORDER BY TONG_TG DESC ";
                Commons.Modules.ObjSystems.XoaTable(sBTam);
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);
                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MBDTGNgungMayTheoMay",
                        TNgay, DNgay, "-1", "-1", "-1", sMsNXuong, iHThong, sLMay, sNMay));
                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtTmp, "");

                Commons.Modules.ObjSystems.XoaTable(sBTamTong);
                sSql = "SELECT TTNM.MS_MAY, ISNULL(SUM(SO_LAN),0) AS SO_LAN , " +
                            " ISNULL(CASE ISNULL(SUM(THOI_GIAN_SUA_CHUA),0) WHEN 0 THEN 0 ELSE SUM(THOI_GIAN_SUA_CHUA) / SUM(SO_LAN) END,0) AS MTTR INTO " + sBTamTong +
                            " FROM " + BTam + " TTNM LEFT JOIN (SELECT  A.MS_NGUYEN_NHAN,   A.MS_MAY, COUNT(DISTINCT A.MS_LAN) AS SO_LAN  " +
                            " FROM THOI_GIAN_NGUNG_MAY  A " +
                            " INNER JOIN " + BTamTGNM + " B ON A.MS_NGUYEN_NHAN  = B.MS_NGUYEN_NHAN " +
                            " WHERE A.NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' " +
                            " AND '" + DNgay.ToString("MM/dd/yyyy") + "'  GROUP BY A.MS_MAY,A.MS_NGUYEN_NHAN ) TGNML ON TTNM.MS_MAY = TGNML.MS_MAY " +
                            " AND  TTNM.MS_NGUYEN_NHAN = TGNML.MS_NGUYEN_NHAN GROUP BY TTNM.MS_MAY";
                Commons.Modules.ObjSystems.XoaTable(sBTamTong);
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                sSql = " UPDATE " + sBTam + " SET TONG_TG = MTTR FROM " + sBTam + " A INNER JOIN  " + sBTamTong + " B ON A.MS_MAY = B.MS_MAY";
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);
                sSql = " SELECT  STT,MS_MAY,TEN_MAY,MODEL,MO_TA,NHIEM_VU_THIET_BI, " + sThangNull.Substring(3, sThangNull.Length - 3) + " , TONG_TG " +
                            " FROM  " + sBTam + " ORDER BY TONG_TG DESC";
            }

            dtTmp = new DataTable();
            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
            
            #region Kiem co du lieu
            try
            {
                if (dtTmp.Rows.Count <= 0)
                {
                    iCoDuLieu = 0;
                    return false;
                }
            }
            catch { }
            #endregion


            dtTmp.Columns["STT"].ReadOnly = false;
            for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
            {
                dtTmp.Rows[i][0] = (i + 1).ToString();
            }

            Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);

            grv.Columns["STT"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                "ucBieuDoTGNMayTheoThang", "STT", NNgu);
            grv.Columns["MS_MAY"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                "ucBieuDoTGNMayTheoThang", "MS_MAY", NNgu);
            grv.Columns["TEN_MAY"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                "ucBieuDoTGNMayTheoThang", "TEN_MAY", NNgu);
            grv.Columns["TONG_TG"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                "ucBieuDoTGNMayTheoThang", "TONG_TG", NNgu);

            grv.Columns["MODEL"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                "ucBieuDoTGNMayTheoThang", "MODEL", NNgu);
            grv.Columns["MO_TA"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                "ucBieuDoTGNMayTheoThang", "MO_TA", NNgu);
            grv.Columns["NHIEM_VU_THIET_BI"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                "ucBieuDoTGNMayTheoThang", "NHIEM_VU_THIET_BI", NNgu);



            string sPath, SavePath;
            sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
            SavePath = Application.StartupPath;
            string sHeThong = "";
            dtMay = new DataTable();

            if (sMsNXuong == "-1") sMsNXuong = " < ALL > ";
            else
            {
                sSql = "SELECT CASE " + NNgu.ToString() + " WHEN 0 THEN TEN_N_XUONG WHEN 1 THEN TEN_N_XUONG_A ELSE TEN_N_XUONG_H END AS TNX " +
                            " FROM NHA_XUONG WHERE MS_N_XUONG = '" + sMsNXuong + "' ";
                dtMay = new DataTable();
                dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                if (dtMay.Rows.Count != 0)
                {
                    sMsNXuong = dtMay.Rows[0]["TNX"].ToString();
                }

            }

            if (iHThong == -1) sHeThong = " < ALL > ";
            else
            {
                sSql = "SELECT TEN_HE_THONG FROM HE_THONG WHERE MS_HE_THONG = " + iHThong;
                dtMay = new DataTable();
                dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                if (dtMay.Rows.Count != 0)
                {
                    sHeThong = dtMay.Rows[0]["TEN_HE_THONG"].ToString();
                }

            }
            if (sLMay == "-1") sLMay = " < ALL > ";
            else
            {
                sSql = "SELECT TEN_LOAI_MAY FROM LOAI_MAY WHERE MS_LOAI_MAY = '" + sLMay + "' ";
                dtMay = new DataTable();
                dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                if (dtMay.Rows.Count != 0)
                {
                    sLMay = dtMay.Rows[0]["TEN_LOAI_MAY"].ToString();
                }

            }
            if (sNMay == "-1") sNMay = " < ALL > ";
            else
            {
                sSql = "SELECT TEN_NHOM_MAY FROM NHOM_MAY WHERE MS_NHOM_MAY = '" + sNMay + "' ";
                dtMay = new DataTable();
                dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                if (dtMay.Rows.Count != 0)
                {
                    sNMay = dtMay.Rows[0]["TEN_NHOM_MAY"].ToString();
                }

            }
            if (!BDTGNMTMThangInDuLieu(grd, grv, sPath, SavePath, NNgu, TThang, DThang, iLoaiBC, sMsNXuong, sHeThong, sLMay, sNMay, out iCoDuLieu)) return false;

            for (DateTime Thang = TThang; Thang <= DThang; )
            {
                BTam = "ZZZ_TGNM_MAIL" + Thang.ToString("MMyyyy") + Commons.Modules.UserName;
                Commons.Modules.ObjSystems.XoaTable(BTam);
                Thang = Thang.AddMonths(1);
            }

            Commons.Modules.ObjSystems.XoaTable(BTamMay);
            Commons.Modules.ObjSystems.XoaTable(BTamTGNM);
            Commons.Modules.ObjSystems.XoaTable("BDTGNM_MAIL" + sUserName);
            Commons.Modules.ObjSystems.XoaTable("ZZZ_BDTGNM_TONG_THANG_MAIL" + Commons.Modules.UserName);
            Commons.Modules.ObjSystems.XoaTable("ZZZ_TGNM_MAY_THANG_TONG_MAIL" + Commons.Modules.UserName);


            return true;
        }


        private Boolean BDTGNMTMThangInDuLieu(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, string SavePath, int NNgu, DateTime TThang, DateTime DThang, int iLoaiBC,
            string sDiaDiem, string sDayChuyen, string sLoaiMay, string sNhomMay, out int iTinhTrang)
        {
            iTinhTrang = 1;

            if (sPath == "")
            {
                iTinhTrang = 2;
                return false;
            }
            Excel.Application xlApp = new Excel.Application();

            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;

                grd.ExportToXls(sPath);
                Excel.Workbooks xlWBooks = xlApp.Workbooks;
                Excel.Workbook xlWBook = xlWBooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWSheet = (Excel.Worksheet)xlWBook.Sheets[1];

                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;
                xlApp.Cells.Font.Name = "Tahoma";
                xlApp.Cells.Font.Size = 10;

                Dong = Dong + TDong + 1;

                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "TongCong", NNgu)
                    , Dong, 1, "@", 10, true, Excel.XlHAlign.xlHAlignRight, Excel.XlVAlign.xlVAlignCenter, true, Dong, 6);

                for (int cot = 7; cot <= TCot; cot++)
                    Commons.Modules.MExcel.MFuntion(xlWSheet, "SUM", Dong, cot, Dong, cot, 2, cot, Dong - 1, cot, 10, true, 10, "#,##0");

                TDong = TDong + 1;

                Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet, 1, 3, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWSheet, 0, 0, 100, 45, Application.StartupPath);
                Commons.Modules.MExcel.ThemDong(xlWSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 8, Dong);

                int SCot;

                SCot = (TCot > 8 ? 8 : TCot);

                Dong++;
                string stmp = "";


                if (iLoaiBC == 0)
                    stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "TieuDeTGNM", NNgu);
                if (iLoaiBC == 1)
                    stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "TieuDeTGSC", NNgu);
                if (iLoaiBC == 2)
                    stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "TieuDeSLNM", NNgu);
                if (iLoaiBC == 3)
                    stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "TieuDeMTTR", NNgu);

                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 1, "@", 16, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;

                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "lblTThang", NNgu) + " : " + TThang.ToString("MM/yyyy") + " " +
                        Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "lblDThang", NNgu) + " : " + DThang.ToString("MM/yyyy");
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 1, "@", 10, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDDiem", NNgu) + " : " + sDiaDiem;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblDChuyen", NNgu) + " : " + sDayChuyen;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblLMay", NNgu) + " : " + sLoaiMay; 
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);


                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoTB", "lblNhomMay", NNgu) + " : " + sNhomMay;
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 3, "@", 10, true, true, Dong, SCot);


                int DongBD;
                DongBD = Dong + 3;
                Excel.Range title;
                Dong = Dong + 2;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;

                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWBook, xlWSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);
                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;
                title = Commons.Modules.MExcel.GetRange(xlWSheet, 5, 1, 5, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong - 1, 1, Dong - 1, 1);
                title.RowHeight = 9;

                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "##", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 14, "@", true, Dong + 1, 2, TDong + Dong, 2);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 20, "@", true, Dong + 1, 3, TDong + Dong, 3);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 12, "@", true, Dong + 1, 4, TDong + Dong, 4);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 35, "@", true, Dong + 1, 5, TDong + Dong, 5);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 35, "@", true, Dong + 1, 6, TDong + Dong, 6);

                for (int i = 7; i <= TCot - 1; i++)
                    Commons.Modules.MExcel.ColumnWidth(xlWSheet, 6, "#,##0", true, Dong + 1, i, TDong + Dong, i);

                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 10, "#,##0", true, Dong + 1, TCot, TDong + Dong, TCot);

                SCot = 7;

                Boolean dCuoi;
                dCuoi = false;


                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD, TCot + 2, DongBD, TCot + 2);
                double iLeft; double iTop;
                double iWidth; double iHeight;

                iLeft = Convert.ToDouble(title.Left);
                iTop = Convert.ToDouble(title.Top);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD, TCot + 2, DongBD + 9, TCot + 2);
                iHeight = Convert.ToDouble(title.Height);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD, TCot + 2, DongBD + 9, TCot + 2 + 7);
                iWidth = Convert.ToDouble(title.Width);



                for (int i = 14; i <= Dong + TDong; i++)
                {
                    if (i == Dong + TDong)
                        dCuoi = true;
                    BDTGNMTMThangLoadBieuDo(xlWSheet, i, TCot, "", i - 13, iLeft, iTop, iWidth, iHeight, dCuoi,NNgu,iLoaiBC);
                }
                xlApp.DisplayAlerts = false;
                xlWBook.Save();
                xlWBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);

            }
            catch
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                return false;
            }
            return true;


        }

        private void BDTGNMTMThangLoadBieuDo(Excel.Worksheet ExcelSheets, int iDong, int iColumKT, string sTitle, int iSoLan,
            double iLeft, double iTop, double iWidth, double iHeight, Boolean sCuoi, int NNgu, int iLoaiBC)
        {
            try
            {
                double iSLan;
                double sLe;
                double sChan;
                double sKQ;

                iSLan = iSoLan;
                sKQ = 0;
                if (sCuoi)
                {
                    sChan = Math.Floor(iSLan / 10);
                    sLe = iSLan - sChan * 10;
                    if (sLe != 0)
                    {
                        sKQ = ((sChan + 1) * 10) + 1;

                    }

                    if (iSoLan != 1) iSoLan = int.Parse(sKQ.ToString());


                }

                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 10);
                double iLan = (iSoLan - 1) % 10;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;

                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                Excel.Series xlSeries = xlSeriesCollection.NewSeries();

                var _with1 = xlSeries;
                if (iLoaiBC == 0)
                    _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "TGNM", NNgu);
                if (iLoaiBC == 1)
                    _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "TGSC", NNgu);
                if (iLoaiBC == 2)
                    _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "SLNM", NNgu);
                if (iLoaiBC == 3)
                    _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "MTTR", NNgu);


                _with1.Values = ExcelSheets.get_Range("G" + iDong, Commons.Modules.MExcel.MCotExcel(iColumKT - 1) + iDong);
                _with1.XValues = ExcelSheets.get_Range("G13", Commons.Modules.MExcel.MCotExcel(iColumKT - 1) + "13");




                if (sCuoi)
                    xlChart.ChartTitle.Text = Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoThang", "TongCong", NNgu);
                else
                    xlChart.ChartTitle.Text = "=Sheet1!$B$" + (iDong);


                xlChart.Refresh();

                xlChart.HasTitle = true;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Axis ax = xlChart.Axes(Excel.XlAxisType.xlCategory, Excel.XlAxisGroup.xlPrimary) as Excel.Axis;
                ax.TickLabels.Orientation = Excel.XlTickLabelOrientation.xlTickLabelOrientationUpward;
                xlChart.Refresh();
            }
            catch
            { }
        }

        #endregion

        #region ucMailBieuDoTGNMayTheoNX -- BDTGNMTNX
        public Boolean BDTGNMTNXInBieuDoTGNMayTheoNX(DataTable dtSch,
            DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                string sBCao, sStmp,sUserName, sNXuong;
                DateTime TNgay, DNgay;
                int NNgu, iSNgay, iLoaiBC, iKieuBC;
                Boolean SauNgayBD;
                DataTable dtTmp = new DataTable();
                DataTable dtNX = new DataTable();
                sBCao = "";
                sStmp = "";
                iLoaiBC = 0;
                sNXuong = "-1";
                iKieuBC = 0;
                SauNgayBD = false;
                iSNgay = 0;
                string BTamChon, BTamChonNN;
                NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
                sUserName = dtSch.Rows[0]["USERNAME"].ToString();
                BTamChon = "ZZZ_BC_NX_CHON" + sUserName;
                BTamChonNN = "ZZZ_NM_NX_CHON" + sUserName;

                if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
                {

                    sBCao = "";
                    sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                    string[] chuoi_tach = sStmp.Split(new Char[] { '@' });
                    int i = 0;

                    foreach (string s in chuoi_tach)
                    {
                        if (i == 0)
                        {
                            sBCao = s;
                            string[] sChuoiBC = sBCao.Split(new Char[] { ',' });
                            if (sChuoiBC.GetValue(0).ToString().Trim() == "0") SauNgayBD = false; else SauNgayBD = true;
                            iSNgay = int.Parse(sChuoiBC.GetValue(1).ToString());
                            iLoaiBC = int.Parse(sChuoiBC.GetValue(2).ToString());
                            iKieuBC = int.Parse(sChuoiBC.GetValue(3).ToString());
                            sNXuong = sChuoiBC.GetValue(4).ToString();
                        }
                        if (i == 1)
                        {


                            dtNX = new DataTable();
                            dtNX.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MGetBCaoThoiGianNgungMay", sNXuong, iLoaiBC));
                            if (s.ToUpper() != "ALL".ToUpper())
                            {
                                sStmp = s;
                                if (dtNX.Columns[1].ColumnName != "MS_HE_THONG")
                                    sStmp = "'" + s.Replace(",", "','") + "'";
                                string s111 = "";
                                s111 = "UPDATE " + BTamChon + " SET CHON = 0 " +
                                    " WHERE " + dtNX.Columns[1].ColumnName + " NOT IN (" + sStmp + ")";

                                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString,
                                        BTamChon, dtNX, "");
                                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text,
                                    "UPDATE " + BTamChon + " SET CHON = 0 " +
                                    " WHERE " + dtNX.Columns[1].ColumnName + " NOT IN (" + sStmp + ") ");

                                dtNX.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text,
                                    "SELECT * FROM " + BTamChon + " ORDER BY " + dtNX.Columns[1].ColumnName));


                                dtNX = new DataTable();
                                dtNX.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MGetBCaoThoiGianNgungMay", sNXuong, iLoaiBC));

                            }

                            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTamChon, dtNX, "");
                        }
                        if (i == 2)
                        {
                            string sSql = "";
                            if (s.ToUpper() == "ALL".ToUpper())
                                sSql = "SELECT CONVERT(BIT,1) AS CHON ,MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, HU_HONG, BTDK, CONVERT(NVARCHAR,MS_NGUYEN_NHAN) AS MS_NN " +
                                    " FROM dbo.NGUYEN_NHAN_DUNG_MAY ORDER BY TEN_NGUYEN_NHAN";
                            else
                            {
                                sSql = "SELECT CONVERT(BIT,1) AS CHON ,MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, HU_HONG, BTDK, CONVERT(NVARCHAR,MS_NGUYEN_NHAN) AS MS_NN " +
                                        " FROM dbo.NGUYEN_NHAN_DUNG_MAY WHERE MS_NGUYEN_NHAN IN(" + s + " ) UNION " +
                                        "SELECT CONVERT(BIT,0) AS CHON ,MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, HU_HONG, BTDK, CONVERT(NVARCHAR,MS_NGUYEN_NHAN) AS MS_NN " +
                                        " FROM dbo.NGUYEN_NHAN_DUNG_MAY WHERE MS_NGUYEN_NHAN NOT IN(" + s + " ) ORDER BY TEN_NGUYEN_NHAN ";
                            }

                            dtTmp = new DataTable();
                            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTamChonNN, dtTmp, "");
                        }
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



                if (iLoaiBC == 0)
                    if (!BDTGNMTNXTaoBCNXuong(grd, grv, BTamChon, BTamChonNN, dtNX, TNgay, DNgay, iLoaiBC, iKieuBC, out iCoDuLieu)) return false;                    
                if (iLoaiBC == 1) 
                    if (!BDTGNMTNXTaoBCDayChuyen(grd, grv, BTamChon, BTamChonNN, TNgay, DNgay, iLoaiBC, iKieuBC, out  iCoDuLieu)) return false;
                if (iLoaiBC == 2)
                    if (!BDTGNMTNXTaoBCLoaiTB(grd, grv, BTamChon, BTamChonNN, TNgay, DNgay, iLoaiBC, iKieuBC, out iCoDuLieu)) return false;
                
                string sPath, SavePath;
                sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                SavePath = Application.StartupPath;

                if (!BDTGNMTNXInDuLieu(grd, grv, sPath, NNgu, TNgay, DNgay, iLoaiBC, iKieuBC, out iCoDuLieu)) return false;
                Commons.Modules.ObjSystems.XoaTable("ZZZ_BC_NX_CHON" + sUserName);
                Commons.Modules.ObjSystems.XoaTable("ZZZ_NM_NX_CHON" + sUserName);

                return true;
            }
            catch {
                iCoDuLieu = 2;
                return false; }
        }
        private Boolean BDTGNMTNXTaoBCNXuong(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string BTamChon, string BTamChonNN, DataTable dtTmp, DateTime TNgay, DateTime DNgay, int iLoaiBC, int iKieuBC, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            string sSql;
            string sTmp;

            try
            {
                sSql = "";
                foreach (DataRow dRow in dtTmp.Rows)
                {
                    sSql = sSql + (sSql == "" ? "" : " UNION ") + " SELECT *, N'" + dRow["TEN_N_XUONG"].ToString() + "' AS TXC, N'" + dRow["MS_N_XUONG"].ToString() + "' AS NXC FROM [dbo].[MashjGetNXUser]('-1','" + dRow["MS_N_XUONG"].ToString() + "')";
                }

                if (iKieuBC == 0)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " ( " + sSql + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  NXC,TXC ";
                    sTmp = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sTmp = sTmp.Replace("CONVERT(INT,NULL) AS STT,", "");
                    sSql = " SELECT STT,A.NXC,A.TXC,THOI_GIAN_SUA_CHUA,THOI_GIAN_SUA,SO_LAN," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sTmp + ") B ON A.NXC = B.NXC ORDER BY THOI_GIAN_SUA_CHUA  DESC";
                }

                if (iKieuBC == 1)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " ( " + sSql + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  NXC,TXC ORDER BY THOI_GIAN_SUA_CHUA DESC";
                }
                if (iKieuBC == 2)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " ( " + sSql + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  NXC,TXC ORDER BY THOI_GIAN_SUA  DESC";
                }
                if (iKieuBC == 3)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, COUNT(DISTINCT MS_LAN) AS SO_LAN " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " ( " + sSql + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  NXC,TXC  ORDER BY SO_LAN DESC";

                }
                if (iKieuBC == 4)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA" +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " ( " + sSql + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  NXC,TXC ";
                    sTmp = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sTmp = sTmp.Replace("CONVERT(INT,NULL) AS STT,", "");
                    sSql = " SELECT STT,A.NXC,A.TXC,THOI_GIAN_SUA_CHUA,SO_LAN," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sTmp + ") B ON A.NXC = B.NXC ORDER BY MTTR  DESC";
                }

                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }
                #region Kiem Co Du lieu
                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch
                { }
                #endregion
                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
                Commons.Modules.ObjSystems.MLoadNNXtraGrid(grv, "ucBieuDoTGNMayTheoNX");
            }
            catch
            {
                iCoDuLieu = 2;
                return false;
            }
            return true;

        }

        private Boolean BDTGNMTNXTaoBCDayChuyen(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string BTamChon, string BTamChonNN, DateTime TNgay, DateTime DNgay, int iLoaiBC, int iKieuBC, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                string sSql, sTmp;
                sSql = "";
                if (iKieuBC == 0)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA  " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG  ";

                    sTmp = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sTmp = sTmp.Replace("CONVERT(INT,NULL) AS STT,", "");
                    sSql = " SELECT STT,A.MS_HE_THONG,A.TEN_HE_THONG,THOI_GIAN_SUA_CHUA,THOI_GIAN_SUA,SO_LAN," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sTmp + ") B ON A.MS_HE_THONG = B.MS_HE_THONG " +
                                " ORDER BY THOI_GIAN_SUA_CHUA DESC , THOI_GIAN_SUA DESC , SO_LAN DESC, MTTR DESC";
                }
                if (iKieuBC == 1)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG ORDER BY THOI_GIAN_SUA_CHUA DESC";
                }

                if (iKieuBC == 2)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG ORDER BY THOI_GIAN_SUA DESC";
                }

                if (iKieuBC == 3)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, COUNT(DISTINCT MS_LAN) AS SO_LAN " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG ORDER BY SO_LAN DESC";
                }
                if (iKieuBC == 4)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA" +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG  ";

                    sTmp = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sTmp = sTmp.Replace("CONVERT(INT,NULL) AS STT,", "");
                    sSql = " SELECT STT,A.MS_HE_THONG,A.TEN_HE_THONG,THOI_GIAN_SUA_CHUA,SO_LAN," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sTmp + ") B ON A.MS_HE_THONG = B.MS_HE_THONG ORDER BY MTTR DESC";
                }





                DataTable dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }
                #region Kiem Co Du lieu
                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch
                { }
                #endregion

                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
                Commons.Modules.ObjSystems.MLoadNNXtraGrid(grv, "ucBieuDoTGNMayTheoNX");
            }
            catch
            {
                iCoDuLieu = 2;
                return false;
            }
            return true;

        }

        private Boolean BDTGNMTNXTaoBCLoaiTB(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string BTamChon, string BTamChonNN, DateTime TNgay, DateTime DNgay, int iLoaiBC, int iKieuBC, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                string sSql, sTmp;
                sSql = "";
                sTmp = "";
                if (iKieuBC == 0)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA  " +
                                " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY  ";

                    sTmp = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sTmp = sTmp.Replace("CONVERT(INT,NULL) AS STT,", "");
                    sSql = " SELECT STT,A.MS_LOAI_MAY,A.TEN_LOAI_MAY,THOI_GIAN_SUA_CHUA,THOI_GIAN_SUA,SO_LAN," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sTmp + ") B ON A.MS_LOAI_MAY = B.MS_LOAI_MAY ORDER BY THOI_GIAN_SUA_CHUA DESC";
                }

                if (iKieuBC == 1)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA " +
                                " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY  ORDER BY THOI_GIAN_SUA_CHUA DESC ";
                }
                if (iKieuBC == 2)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY,SUM(THOI_GIAN_SUA) AS THOI_GIAN_SUA  " +
                                " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY  ORDER BY THOI_GIAN_SUA DESC ";
                }
                if (iKieuBC == 3)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY,COUNT(DISTINCT MS_LAN) AS SO_LAN  " +
                                " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY  ORDER BY SO_LAN DESC ";
                }

                if (iKieuBC == 4)
                {
                    sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA" +
                                " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY  ";

                    sTmp = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sTmp = sTmp.Replace("CONVERT(INT,NULL) AS STT,", "");
                    sSql = " SELECT STT,A.MS_LOAI_MAY,A.TEN_LOAI_MAY,THOI_GIAN_SUA_CHUA,SO_LAN," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sTmp + ") B ON A.MS_LOAI_MAY = B.MS_LOAI_MAY ORDER BY MTTR DESC";
                }

                DataTable dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }
                #region Kiem Co Du lieu
                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch
                { }
                #endregion

                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
                Commons.Modules.ObjSystems.MLoadNNXtraGrid(grv, "ucBieuDoTGNMayTheoNX");
            }
            catch
            {
                iCoDuLieu = 2;
                return false;
            }
            return true;
        }

        private Boolean BDTGNMTNXInDuLieu(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, int NNgu, DateTime TNgay, DateTime DNgay, int iLoaiBC, int iKieuBC, out int iTinhTrang)
        {
            iTinhTrang = 1;
            
            Excel.Application xlApp = new Excel.Application();
            Excel.Workbooks xlWBooks;
            Excel.Workbook xlWBook;
            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;

                grd.ExportToXls(sPath);
                xlWBooks = xlApp.Workbooks;
                xlWBook = xlWBooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWSheet = (Excel.Worksheet)xlWBook.Sheets[1];
                
                Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet, 1, 3, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWSheet, 0, 0, 100, 45, Application.StartupPath);
                Commons.Modules.MExcel.ThemDong(xlWSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 4, Dong);

                int SCot;

                SCot = TCot;// (TCot > 9 ? 9 : TCot);
                string sTm;
                sTm = "";

                Dong++;
                string stmp = "";
                if (iLoaiBC == 0) stmp = "TieuDeNX";
                if (iLoaiBC == 1) stmp = "TieuDeDC";
                if (iLoaiBC == 2) stmp = "TieuDeLTB";

                if (iKieuBC == 1) sTm = "TieuDeTGSC";
                if (iKieuBC == 2) sTm = "TieuDeTGS";
                if (iKieuBC == 3) sTm = "TieuDeSL";
                if (iKieuBC == 4) sTm = "MTTR";


                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNX", stmp, NNgu) + (iKieuBC == 0 ? "" : " ") +
                    (iKieuBC == 0 ? "" : Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNX", sTm, NNgu)), Dong, 1, "@", 16, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                
                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNX", "lblTNgay", NNgu) + " : " + TNgay.ToString("dd/MM/yyyy") + " " +
                    Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNX", "lblDNgay", NNgu) + " : " + DNgay.ToString("dd/MM/yyyy");
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 1, "@", 10, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);


                int DongBD;
                DongBD = Dong + 3;
                Excel.Range title;
                Dong = Dong + 2;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                
                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;


                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWBook, xlWSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);
                title = Commons.Modules.MExcel.GetRange(xlWSheet, 5, 1, 5, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, Dong - 1, 1, Dong - 1, 1);
                title.RowHeight = 9;


                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "##", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 14, "@", true, Dong + 1, 2, TDong + Dong, 2);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 20, "@", true, Dong + 1, 3, TDong + Dong, 3);

                SCot = 7;
                for (int i = 4; i <= grv.Columns.Count; i++)
                    Commons.Modules.MExcel.ColumnWidth(xlWSheet, 12, "#,##0", true, Dong + 1, i, TDong + Dong, i);



                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD, TCot + 2, DongBD, TCot + 2);
                string TDe;

                if (iKieuBC == 0)
                {
                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNX", "TDTGSC", NNgu);
                    BDTGNMTNXLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "D", TDe);

                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNX", "TGS", NNgu);
                    BDTGNMTNXLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 2, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "E", TDe);

                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNX", "SLNM", NNgu);
                    BDTGNMTNXLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 3, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "F", TDe);

                    TDe = "MTTR";
                    BDTGNMTNXLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 4, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "G", TDe);
                }

                if (iKieuBC == 1)
                {
                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNX", "TDTGSC", NNgu);
                    BDTGNMTNXLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "D", TDe);
                }

                if (iKieuBC == 2)
                {
                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNX", "TGS", NNgu);
                    BDTGNMTNXLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "D", TDe);
                }

                if (iKieuBC == 3)
                {
                    TDe = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNX", "SLNM", NNgu);
                    BDTGNMTNXLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "D", TDe);
                }


                if (iKieuBC == 4)
                {
                    TDe = "MTTR";
                    BDTGNMTNXLoadBieuDo(xlWSheet, Dong + TDong, 10, "", 1, Convert.ToDouble(title.Left), Convert.ToDouble(title.Top), 500, 200, "F", TDe);
                }
                xlApp.DisplayAlerts = false;
                xlWBook.Save();
                xlWBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);


            }
            catch
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                return false;

            }

            return true;
        }

        private void BDTGNMTNXLoadBieuDo(Excel.Worksheet ExcelSheets, int iDong, int iColumKT, string sTitle, int iSoLan, double iLeft,
            double iTop, double iWidth, double iHeight, string CotDL, string TDBCao)
        {
            try
            {

                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 2);
                double iLan = (iSoLan - 1) % 2;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;

                if (iSoLan > 2) iTop = iTop + 9;
                if (iSoLan == 2 || iSoLan == 4) iLeft = iLeft + 9;

                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);


                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Series xlSeries = xlSeriesCollection.NewSeries();
                

                var _with1 = xlSeries;

                _with1.AxisGroup = Excel.XlAxisGroup.xlPrimary;

                //_with1.Name = TDBCao;
                _with1.Values = ExcelSheets.get_Range(CotDL + "10", (iDong > 30 ? CotDL + "29" : CotDL + iDong.ToString()));
                _with1.XValues = ExcelSheets.get_Range("C10", (iDong > 30 ? "C29" : "C" + iDong.ToString()));

                
                xlChart.HasTitle = true;

                xlChart.ChartTitle.Text = TDBCao;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                xlChart.Legend.Delete();
                xlChart.Refresh();


            }
            catch
            { }
        }

        #endregion

        #region ucBieuDoTGNMayTheoNXThang -- BDTGNMTNXThang
        public Boolean BDTGNMTNXThangInBieuDoTGNMayTheoNXThang(DataTable dtSch,
            DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                #region Lay Dieu Kien Tao Bao Cao
                string sBCao, sStmp, sUserName, sNXuong;
                DateTime TNgay, DNgay;
                int NNgu, iSNgay, iLoaiBC, iKieuBC;
                Boolean SauNgayBD;
                DataTable dtTmp = new DataTable();
                sBCao = "";
                sStmp = "";
                iLoaiBC = 0;
                sNXuong = "-1";
                iKieuBC = 0;
                SauNgayBD = false;
                iSNgay = 0;

                string BTamChon, BTamChonNN;



                NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
                sUserName = dtSch.Rows[0]["USERNAME"].ToString();
                BTamChon = "ZZZ_BC_NX_CHON" + sUserName;
                BTamChonNN = "ZZZ_NM_NX_CHON" + sUserName;
                
                if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
                {

                    sBCao = "";
                    sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                    string[] chuoi_tach = sStmp.Split(new Char[] { '@' });
                    int i = 0;

                    foreach (string s in chuoi_tach)
                    {
                        if (i == 0)
                        {
                            sBCao = s;
                            string[] sChuoiBC = sBCao.Split(new Char[] { ',' });
                            if (sChuoiBC.GetValue(0).ToString().Trim() == "0") SauNgayBD = false; else SauNgayBD = true;
                            iSNgay = int.Parse(sChuoiBC.GetValue(1).ToString());
                            iLoaiBC = int.Parse(sChuoiBC.GetValue(2).ToString());
                            iKieuBC = int.Parse(sChuoiBC.GetValue(3).ToString());
                            sNXuong = sChuoiBC.GetValue(4).ToString();
                        }
                        if (i == 1)
                        {


                            dtTmp = new DataTable();
                            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MGetBCaoThoiGianNgungMay", sNXuong, iLoaiBC));
                            if (s.ToUpper() != "ALL".ToUpper())
                            {
                                sStmp = s;
                                if (dtTmp.Columns[1].ColumnName != "MS_HE_THONG")
                                    sStmp = "'" + s.Replace(",", "','") + "'";
                                string s111 = "";
                                s111 = "UPDATE " + BTamChon + " SET CHON = 0 " +
                                    " WHERE " + dtTmp.Columns[1].ColumnName + " NOT IN (" + sStmp + ")";

                                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString,
                                        BTamChon, dtTmp, "");
                                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text,
                                    "UPDATE " + BTamChon + " SET CHON = 0 " +
                                    " WHERE " + dtTmp.Columns[1].ColumnName + " NOT IN (" + sStmp + ") ");

                                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text,
                                    "SELECT * FROM " + BTamChon + " ORDER BY " + dtTmp.Columns[1].ColumnName));


                                dtTmp = new DataTable();
                                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MGetBCaoThoiGianNgungMay", sNXuong, iLoaiBC));

                            }

                            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTamChon, dtTmp, "");
                        }
                        if (i == 2)
                        {
                            string sSql = "";
                            if (s.ToUpper() == "ALL".ToUpper())
                                sSql = "SELECT CONVERT(BIT,1) AS CHON ,MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, HU_HONG, BTDK, CONVERT(NVARCHAR,MS_NGUYEN_NHAN) AS MS_NN " +
                                    " FROM dbo.NGUYEN_NHAN_DUNG_MAY ORDER BY TEN_NGUYEN_NHAN";
                            else
                            {
                                sSql = "SELECT CONVERT(BIT,1) AS CHON ,MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, HU_HONG, BTDK, CONVERT(NVARCHAR,MS_NGUYEN_NHAN) AS MS_NN " +
                                        " FROM dbo.NGUYEN_NHAN_DUNG_MAY WHERE MS_NGUYEN_NHAN IN(" + s + " ) UNION " +
                                        "SELECT CONVERT(BIT,0) AS CHON ,MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN, HU_HONG, BTDK, CONVERT(NVARCHAR,MS_NGUYEN_NHAN) AS MS_NN " +
                                        " FROM dbo.NGUYEN_NHAN_DUNG_MAY WHERE MS_NGUYEN_NHAN NOT IN(" + s + " ) ORDER BY TEN_NGUYEN_NHAN ";
                            }

                            dtTmp = new DataTable();
                            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTamChonNN, dtTmp, "");
                        }
                        i++;
                    }
                }

                //If SauNgayBD = true nghia la in tu ngay bat dau in (tu ngay) + them so ngay ra den ngay
                //If SauNgayBD = false nghia la Ngay bat dau in la den ngay - di so ngay ra tu ngay.


                if (SauNgayBD)
                {
                    TNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year);
                    DNgay = TNgay.AddMonths(iSNgay).AddDays(-1);
                }
                else
                {
                    DNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(1).AddDays(-1);
                    TNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(-iSNgay + 1);
                }

                #endregion

                if (iLoaiBC == 0)
                {
                    dtTmp = new DataTable();
                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT * FROM " + BTamChon));
                    if (!BDTGNMTNXThangTaoBCNXuong(grd, grv, BTamChon, BTamChonNN, dtTmp, TNgay, DNgay, iLoaiBC, iKieuBC, NNgu, out iCoDuLieu)) return false;
                }
                if (iLoaiBC == 1) if (!BDTGNMTNXThangTaoBCDayChuyen(grd, grv, BTamChon, BTamChonNN, TNgay, DNgay, iLoaiBC, iKieuBC, NNgu, out iCoDuLieu)) return false;
                if (iLoaiBC == 2) if (!BDTGNMTNXThangTaoBCLoaiTB(grd, grv, BTamChon, BTamChonNN, TNgay, DNgay, iLoaiBC, iKieuBC, NNgu, out iCoDuLieu)) return false;
                string sPath, SavePath;
                sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                SavePath = Application.StartupPath;

                if (!BDTGNMTNXThangInDuLieu(grd, grv, sPath, NNgu, TNgay, DNgay, iLoaiBC, iKieuBC, out iCoDuLieu)) return false;

                Commons.Modules.ObjSystems.XoaTable("ZZZ_BC_NX_CHON" + sUserName);
                Commons.Modules.ObjSystems.XoaTable("ZZZ_NM_NX_CHON" + sUserName);
                return true;
            }
            catch {
                iCoDuLieu = 2;
                return false; }
        }

        private Boolean BDTGNMTNXThangTaoBCNXuong(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string BTamChon, string BTamChonNN, DataTable dtTmp, DateTime TThang, DateTime DThang, int iLoaiBC, int iKieuBC, int NNgu, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                #region Tao Du Lieu
                string sSql;
                DateTime TNgay, DNgay;
                string BTam, BangTam, sThang, sThangNull, sThangAvg, sTmp;
                sThang = "";
                sThangAvg = "";
                sThangNull = "";
                BangTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + Commons.Modules.UserName;
                sTmp = "";
                string sT;
                sT = "";
                foreach (DataRow dRow in dtTmp.Rows)
                {
                    sT = sT + (sT == "" ? "" : " UNION ") + " SELECT *, N'" + dRow["TEN_N_XUONG"].ToString() + "' AS TXC, N'" + dRow["MS_N_XUONG"].ToString() + "' AS NXC FROM [dbo].[MashjGetNXUser]('-1','" + dRow["MS_N_XUONG"].ToString() + "')";
                }
                string sTm;
                sTm = "";
                sSql = "";
                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                    DNgay = TNgay.AddMonths(1).AddDays(-1);
                    sSql = "";
                    BTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + TNgay.ToString("MMyyyy") + Commons.Modules.UserName;

                    if (iKieuBC == 0)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, SUM(THOI_GIAN_SUA_CHUA) AS TONG_TG, " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " ( " + sT + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  NXC,TXC ";
                    }


                    if (iKieuBC == 1)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, SUM(THOI_GIAN_SUA) AS TONG_TG, " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " ( " + sT + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  NXC,TXC ";
                    }
                    if (iKieuBC == 2)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, COUNT(DISTINCT MS_LAN) AS TONG_TG, " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " ( " + sT + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  NXC,TXC  ";

                    }
                    if (iKieuBC == 3)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA" +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " ( " + sT + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  NXC,TXC ";
                        sTm = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                        sTm = sTm.Replace("CONVERT(INT,NULL) AS STT,", "");
                        sSql = " SELECT STT,A.NXC,A.TXC,THOI_GIAN_SUA_CHUA,SO_LAN," +
                        " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                        " FROM (" + sSql + ") A LEFT JOIN (" + sTm + ") B ON A.NXC = B.NXC ";

                        sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC , SUM(MTTR) AS TONG_TG, " +
                            " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam + " FROM ( " + sSql + " ) A GROUP BY NXC,TXC ";
                    }
                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sTmp = sTmp + (sTmp == "" ? "" : " UNION ") + "SELECT * " + (sTmp == "" ? " INTO " + BangTam : "") +
                            " FROM " + BTam + " ";


                    sThang = sThang + " , [" + Thang.ToString("MM/yy") + "] ";
                    sThangNull = sThangNull + " , ISNULL([" + Thang.ToString("MM/yy") + "],0) AS [" + Thang.ToString("MM/yy") + "] ";
                    sThangAvg = sThangAvg + " + ISNULL([" + Thang.ToString("MM/yy") + "],0) ";

                    Thang = Thang.AddMonths(1);

                }

                Commons.Modules.ObjSystems.XoaTable(BangTam);
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sTmp);
                string sBT, sBTam;
                sBT = "ZZZ_MAIL_TGNMX" + Commons.Modules.UserName;
                sBTam = "ZZZ_MAIL_TGNMX_TONG" + Commons.Modules.UserName;
                TNgay = TThang;
                DNgay = DThang;

                if (iKieuBC != 3)
                {
                    if (iKieuBC == 2)
                    {
                        sSql = " SELECT * INTO " + sBT + " FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                    "   ( SELECT STT,NXC,TXC, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                    " 	  FROM  " +
                                    " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                    " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                    " 		 )) AS PVT)  " +
                                    "    A  ) B ORDER BY TONG_TG DESC ";

                        Commons.Modules.ObjSystems.XoaTable(sBT);
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                        sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, COUNT(DISTINCT MS_LAN) AS TONG_TG INTO " + sBTam +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " ( " + sT + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  NXC,TXC  ";
                        Commons.Modules.ObjSystems.XoaTable(sBTam);
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);




                        sSql = "UPDATE " + sBT + " SET " + sBT + ".TONG_TG = B.TONG_TG FROM " + sBT + " A INNER JOIN " + sBTam + " B ON B.NXC = A.NXC";
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                        sSql = " SELECT STT,NXC,TXC, " + sThangNull.Substring(3, sThangNull.Length - 3) + ", TONG_TG FROM " + sBT + " ORDER BY TONG_TG DESC ";


                    }
                    else
                        sSql = " SELECT * FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                    "   ( SELECT STT,TXC, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                    " 	  FROM  " +
                                    " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                    " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                    " 		 )) AS PVT)  " +
                                    "    A  ) B ORDER BY TONG_TG DESC ";
                }
                else
                {
                    sSql = " SELECT * INTO " + sBT + " FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                "   ( SELECT STT,NXC,TXC, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                " 	  FROM  " +
                                " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                " 		 )) AS PVT)  " +
                                "    A  ) B ORDER BY TONG_TG DESC ";
                    Commons.Modules.ObjSystems.XoaTable(sBT);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);


                    sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA" +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " ( " + sT + " ) B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN INNER JOIN NHA_XUONG D ON A.MS_N_XUONG = D.MS_N_XUONG   " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  NXC,TXC ";
                    sTm = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sTm = sTm.Replace("CONVERT(INT,NULL) AS STT,", "");
                    sSql = " SELECT STT,A.NXC,A.TXC,THOI_GIAN_SUA_CHUA,SO_LAN," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sTm + ") B ON A.NXC = B.NXC ";

                    sSql = " SELECT CONVERT(INT,NULL) AS STT, NXC,TXC , SUM(MTTR) AS TONG_TG INTO " + sBTam + " FROM ( " + sSql + " ) A GROUP BY NXC,TXC ";

                    Commons.Modules.ObjSystems.XoaTable(sBTam);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);


                    sSql = "UPDATE " + sBT + " SET " + sBT + ".TONG_TG = B.TONG_TG FROM " + sBT + " A INNER JOIN " + sBTam + " B ON B.NXC = A.NXC";
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sSql = " SELECT STT,NXC,TXC, " + sThangNull.Substring(3, sThangNull.Length - 3) + ", TONG_TG FROM " + sBT + " ORDER BY TONG_TG DESC ";
                }



                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));

                #endregion

                #region Kiem Co Du lieu
                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch
                { }
                #endregion

                #region In Du Lieu 
                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }

                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
                grv.Columns["STT"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "STT", NNgu);
                grv.Columns["TXC"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "TXC", NNgu);
                grv.Columns["TONG_TG"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "TONG_TG", NNgu);



                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                    BTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + TNgay.ToString("MMyyyy") + Commons.Modules.UserName;
                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    Thang = Thang.AddMonths(1);
                }
                Commons.Modules.ObjSystems.XoaTable(BangTam);
                Commons.Modules.ObjSystems.XoaTable("ZZZ_MAIL_TGNMX" + Commons.Modules.UserName);
                Commons.Modules.ObjSystems.XoaTable("ZZZ_MAIL_TGNMX_TONG" + Commons.Modules.UserName);
                #endregion
            }
            catch {
                iCoDuLieu = 2;
                return false;
            }
            return true;

        }

        private Boolean BDTGNMTNXThangTaoBCDayChuyen(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string BTamChon, string BTamChonNN, DateTime TThang, DateTime DThang, int iLoaiBC, int iKieuBC, int NNgu, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                #region Tao Du Lieu
                string sSql, sT;

                DateTime TNgay, DNgay;
                string BTam, BangTam, sThang, sThangNull, sThangAvg, sTmp;

                sT = "";
                sThang = "";
                sThangAvg = "";
                sThangNull = "";
                BangTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + Commons.Modules.UserName;

                sTmp = "";
                sSql = "";
                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                    DNgay = TNgay.AddMonths(1).AddDays(-1);
                    sSql = "";
                    BTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + TNgay.ToString("MMyyyy") + Commons.Modules.UserName;
                    if (iKieuBC == 0)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, SUM(THOI_GIAN_SUA_CHUA) AS TONG_TG, " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG ";
                    }

                    if (iKieuBC == 1)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, SUM(THOI_GIAN_SUA) AS TONG_TG, " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG ";
                    }

                    if (iKieuBC == 2)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, COUNT(DISTINCT MS_LAN) AS TONG_TG, " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG ";
                    }
                    if (iKieuBC == 3)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,B.TEN_HE_THONG, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA " +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  A.MS_HE_THONG ,B.TEN_HE_THONG ";

                        sT = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                        sT = sT.Replace("CONVERT(INT,NULL) AS STT,", "");

                        sSql = " SELECT CONVERT(INT,NULL) AS STT,A.MS_HE_THONG,A.TEN_HE_THONG," +
                                    " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS TONG_TG, " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM (" + sSql + ") A LEFT JOIN (" + sT + ") B ON A.MS_HE_THONG = B.MS_HE_THONG ORDER BY " +
                                    " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END ";
                    }

                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sTmp = sTmp + (sTmp == "" ? "" : " UNION ") + "SELECT * " + (sTmp == "" ? " INTO " + BangTam : "") +
                            " FROM " + BTam + " ";


                    sThang = sThang + " , [" + Thang.ToString("MM/yy") + "] ";
                    sThangNull = sThangNull + " , ISNULL([" + Thang.ToString("MM/yy") + "],0) AS [" + Thang.ToString("MM/yy") + "] ";
                    sThangAvg = sThangAvg + " + ISNULL([" + Thang.ToString("MM/yy") + "],0) ";

                    Thang = Thang.AddMonths(1);
                }

                Commons.Modules.ObjSystems.XoaTable(BangTam);
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sTmp);
                string sBT, sBTamTong;
                sBT = "ZZZ_MAIL_TGNMXDC" + Commons.Modules.UserName;
                sBTamTong = "ZZZ_MAIL_TGNMXDC_TONG" + Commons.Modules.UserName;
                TNgay = TThang;
                DNgay = DThang;

                if (iKieuBC != 3)
                {
                    if (iKieuBC == 2)
                    {
                        sSql = " SELECT * INTO " + sBT + " FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                    "   ( SELECT STT,MS_HE_THONG,TEN_HE_THONG, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                    " 	  FROM  " +
                                    " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                    " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                    " 		 )) AS PVT)  " +
                                    "    A  ) B ORDER BY TONG_TG DESC ";
                        Commons.Modules.ObjSystems.XoaTable(sBT);
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                        sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, COUNT(DISTINCT MS_LAN) AS SO_LAN INTO " + sBTamTong +
                                    " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                    " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG ";
                        Commons.Modules.ObjSystems.XoaTable(sBTamTong);
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                        sSql = " UPDATE " + sBT + " SET TONG_TG = SO_LAN FROM " + sBT + " A INNER JOIN " + sBTamTong + " B ON A.MS_HE_THONG = B.MS_HE_THONG ";
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                        sSql = " SELECT STT,TEN_HE_THONG, " + sThangNull.Substring(3, sThangNull.Length - 3) + " ,TONG_TG " +
                                    " 	  FROM  " + sBT + " ORDER BY TONG_TG DESC ";

                    }
                    else
                        sSql = " SELECT * FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                    "   ( SELECT STT,TEN_HE_THONG, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                    " 	  FROM  " +
                                    " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                    " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                    " 		 )) AS PVT)  " +
                                    "    A  ) B ORDER BY TONG_TG DESC ";

                }
                else
                {
                    sSql = " SELECT * INTO " + sBT + " FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                "   ( SELECT STT,MS_HE_THONG,TEN_HE_THONG, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                " 	  FROM  " +
                                " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                " 		 )) AS PVT)  " +
                                "    A  ) B ORDER BY TONG_TG DESC ";
                    Commons.Modules.ObjSystems.XoaTable(sBT);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sSql = " SELECT CONVERT(INT,NULL) AS STT, A.MS_HE_THONG,TEN_HE_THONG, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA " +
                                " FROM THOI_GIAN_NGUNG_MAY A  INNER JOIN " +
                                " " + BTamChon + " B ON A.MS_HE_THONG = B.MS_HE_THONG INNER JOIN  " + BTamChonNN + " C " +
                                " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                " GROUP BY  A.MS_HE_THONG,TEN_HE_THONG  ";
                    sT = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sT = sT.Replace("CONVERT(INT,NULL) AS STT,", "");

                    sSql = " SELECT CONVERT(INT,NULL) AS STT,A.MS_HE_THONG,A.TEN_HE_THONG," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR " +
                                " INTO " + sBTamTong +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sT + ") B ON A.MS_HE_THONG = B.MS_HE_THONG ORDER BY " +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END ";
                    Commons.Modules.ObjSystems.XoaTable(sBTamTong);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sSql = " UPDATE " + sBT + " SET TONG_TG = MTTR FROM " + sBT + " A INNER JOIN " + sBTamTong + " B ON A.MS_HE_THONG = B.MS_HE_THONG ";
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sSql = " SELECT STT,TEN_HE_THONG, " + sThangNull.Substring(3, sThangNull.Length - 3) + " ,TONG_TG " +
                                " 	  FROM  " + sBT + " ORDER BY TONG_TG DESC ";
                }


                DataTable dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                #endregion

                #region Kiem Co Du lieu
                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch
                { }
                #endregion

                #region In Du Lieu
                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }

                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
                grv.Columns["STT"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "STT", NNgu);
                grv.Columns["TEN_HE_THONG"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "TEN_HE_THONG", NNgu);
                grv.Columns["TONG_TG"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "TONG_TG", NNgu);


                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                    BTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + TNgay.ToString("MMyyyy") + Commons.Modules.UserName;
                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    Thang = Thang.AddMonths(1);
                }
                Commons.Modules.ObjSystems.XoaTable("ZZZ_MAIL_TGNMXDC" + Commons.Modules.UserName);
                Commons.Modules.ObjSystems.XoaTable("ZZZ_MAIL_TGNMXDC_TONG" + Commons.Modules.UserName);
                Commons.Modules.ObjSystems.XoaTable(BangTam);
                #endregion
            }
            catch {
                iCoDuLieu = 2;
                return false;
            }
            return true;
        }

        private Boolean BDTGNMTNXThangTaoBCLoaiTB(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string BTamChon, string BTamChonNN, DateTime TThang, DateTime DThang, int iLoaiBC, int iKieuBC, int NNgu, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            try
            {
                #region Tao Du Lieu
                string sSql, sT;
                DateTime TNgay, DNgay;
                string BTam, BangTam, sThang, sThangNull, sThangAvg, sTmp;
                sThang = "";
                sThangAvg = "";
                sThangNull = "";
                BangTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + Commons.Modules.UserName;
                sT = "";
                sTmp = "";
                sSql = "";
                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                    DNgay = TNgay.AddMonths(1).AddDays(-1);
                    sSql = "";
                    BTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + TNgay.ToString("MMyyyy") + Commons.Modules.UserName;
                    if (iKieuBC == 0)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY, SUM(THOI_GIAN_SUA_CHUA) AS TONG_TG , " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                    " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                    " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                    " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY   ";
                    }
                    if (iKieuBC == 1)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY,SUM(THOI_GIAN_SUA) AS TONG_TG ,  " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                    " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                    " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                    " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY   ";
                    }
                    if (iKieuBC == 2)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY,COUNT(DISTINCT MS_LAN) AS TONG_TG ,  " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                    " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                    " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                    " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY ";
                    }

                    if (iKieuBC == 3)
                    {
                        sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA " +
                                    " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                    " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                    " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                    " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY  ";

                        sT = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                        sT = sT.Replace("CONVERT(INT,NULL) AS STT,", "");

                        sSql = " SELECT CONVERT(INT,NULL) AS STT,A.MS_LOAI_MAY,A.TEN_LOAI_MAY," +
                                    " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS TONG_TG , " +
                                    " N'" + Thang.ToString("MM/yy") + "' AS THANG INTO " + BTam +
                                    " FROM (" + sSql + ") A LEFT JOIN (" + sT + ") B ON A.MS_LOAI_MAY = B.MS_LOAI_MAY " +
                                    "  ";
                    }

                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);


                    sTmp = sTmp + (sTmp == "" ? "" : " UNION ") + "SELECT * " + (sTmp == "" ? " INTO " + BangTam : "") +
                            " FROM " + BTam + " ";


                    sThang = sThang + " , [" + Thang.ToString("MM/yy") + "] ";
                    sThangNull = sThangNull + " , ISNULL([" + Thang.ToString("MM/yy") + "],0) AS [" + Thang.ToString("MM/yy") + "] ";
                    sThangAvg = sThangAvg + " + ISNULL([" + Thang.ToString("MM/yy") + "],0) ";

                    Thang = Thang.AddMonths(1);
                }

                Commons.Modules.ObjSystems.XoaTable(BangTam);
                SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sTmp);
                string BT;
                BT = "ZZZ_MAIL_LLOAI_TB" + Commons.Modules.UserName;
                BTam = "ZZZ_MAIL_LLOAI_TB_TONG" + Commons.Modules.UserName;
                TNgay = TThang;
                DNgay = DThang;


                if (iKieuBC != 3)
                {
                    if (iKieuBC == 2)
                    {
                        sSql = " SELECT * INTO " + BT + " FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                    "   ( SELECT STT,MS_LOAI_MAY,TEN_LOAI_MAY, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                    " 	  FROM  " +
                                    " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                    " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                    " 		 )) AS PVT)  " +
                                    "    A  ) B ORDER BY TONG_TG DESC ";
                        Commons.Modules.ObjSystems.XoaTable(BT);
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                        sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY,COUNT(DISTINCT MS_LAN) AS SO_LAN INTO " + BTam +
                                    " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                                    " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                                    " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                                    " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                                    " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY ";
                        Commons.Modules.ObjSystems.XoaTable(BTam);
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                        sSql = "UPDATE " + BT + " SET TONG_TG = SO_LAN FROM " + BT + " A INNER JOIN " + BTam + " B ON B.MS_LOAI_MAY = A.MS_LOAI_MAY";
                        SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                        sSql = " SELECT STT, TEN_LOAI_MAY, " + sThang.Substring(3, sThang.Length - 3) + ", TONG_TG FROM " + BT + " ORDER BY TONG_TG DESC ";

                    }
                    else
                    {
                        sSql = " SELECT * FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                    "   ( SELECT STT,TEN_LOAI_MAY, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                    " 	  FROM  " +
                                    " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                    " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                    " 		 )) AS PVT)  " +
                                    "    A  ) B ORDER BY TONG_TG DESC ";
                    }
                }
                else
                {
                    sSql = " SELECT * INTO " + BT + " FROM (  SELECT A.*, " + sThangAvg.Substring(3, sThangAvg.Length - 3) + " AS TONG_TG FROM " +
                                "   ( SELECT STT,MS_LOAI_MAY,TEN_LOAI_MAY, " + sThangNull.Substring(3, sThangNull.Length - 3) +
                                " 	  FROM  " +
                                " 	(	SELECT * FROM " + BangTam + " 	) P  " +
                                " 		PIVOT (SUM(TONG_TG) FOR THANG IN ( " + sThang.Substring(3, sThang.Length - 3) +
                                " 		 )) AS PVT)  " +
                                "    A  ) B ORDER BY TONG_TG DESC ";
                    Commons.Modules.ObjSystems.XoaTable(BT);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sSql = " SELECT CONVERT(INT,NULL) AS STT, B.MS_LOAI_MAY,TEN_LOAI_MAY, SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA" +
                    " FROM         dbo.THOI_GIAN_NGUNG_MAY AS A INNER JOIN " +
                    " dbo.MAY AS X ON A.MS_MAY = X.MS_MAY INNER JOIN " +
                    " dbo.NHOM_MAY AS Y ON X.MS_NHOM_MAY = Y.MS_NHOM_MAY INNER JOIN " +
                    " " + BTamChon + " B ON Y.MS_LOAI_MAY = B.MS_LOAI_MAY INNER JOIN  " + BTamChonNN + " C " +
                    " ON A.MS_NGUYEN_NHAN = C.MS_NGUYEN_NHAN " +
                    " WHERE NGAY BETWEEN '" + TNgay.ToString("MM/dd/yyyy") + "' AND '" + DNgay.ToString("MM/dd/yyyy") + "' " +
                    " GROUP BY  B.MS_LOAI_MAY,TEN_LOAI_MAY  ";

                    sTmp = sSql.Replace("SUM(THOI_GIAN_SUA_CHUA) AS THOI_GIAN_SUA_CHUA", "COUNT(DISTINCT MS_LAN) AS SO_LAN");
                    sTmp = sTmp.Replace("CONVERT(INT,NULL) AS STT,", "");
                    sSql = " SELECT STT,A.MS_LOAI_MAY,A.TEN_LOAI_MAY,THOI_GIAN_SUA_CHUA,SO_LAN," +
                                " CASE ISNULL(THOI_GIAN_SUA_CHUA ,0) WHEN 0 THEN 0 ELSE THOI_GIAN_SUA_CHUA / SO_LAN END AS MTTR INTO " + BTam +
                                " FROM (" + sSql + ") A LEFT JOIN (" + sTmp + ") B ON A.MS_LOAI_MAY = B.MS_LOAI_MAY ORDER BY MTTR DESC";
                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sSql = "UPDATE " + BT + " SET TONG_TG = MTTR FROM " + BT + " A INNER JOIN " + BTam + " B ON B.MS_LOAI_MAY = A.MS_LOAI_MAY";
                    SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql);

                    sSql = " SELECT STT, TEN_LOAI_MAY, " + sThang.Substring(3, sThang.Length - 3) + ", TONG_TG FROM " + BT + " ORDER BY TONG_TG DESC ";


                }
                DataTable dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                #endregion

                #region Kiem Co Du lieu
                try
                {
                    if (dtTmp.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch
                { }
                #endregion

                #region In Du Lieu
                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }

                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);

                grv.Columns["STT"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "STT", NNgu);
                grv.Columns["TEN_LOAI_MAY"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "TEN_LOAI_MAY", NNgu);
                grv.Columns["TONG_TG"].Caption = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBieuDoTGNMayTheoNXThang", "TONG_TG", NNgu);

                Commons.Modules.ObjSystems.XoaTable(BangTam);
                for (DateTime Thang = TThang; Thang <= DThang; )
                {
                    TNgay = Convert.ToDateTime(Thang.Month + "/" + Thang.Year);
                    BTam = "ZZZ_MAIL_BDTGNM_NX_THANG" + TNgay.ToString("MMyyyy") + Commons.Modules.UserName;
                    Commons.Modules.ObjSystems.XoaTable(BTam);
                    Thang = Thang.AddMonths(1);
                }
                if (iKieuBC == 3)
                {
                    Commons.Modules.ObjSystems.XoaTable("ZZZ_MAIL_LLOAI_TB" + Commons.Modules.UserName);
                    Commons.Modules.ObjSystems.XoaTable("ZZZ_MAIL_LLOAI_TB_TONG" + Commons.Modules.UserName);
                }

                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, true, true);
                Commons.Modules.ObjSystems.MLoadNNXtraGrid(grv, "ucBieuDoTGNMayTheoNX");
                #endregion
            }
            catch {
                iCoDuLieu = 2;
                return false;
            }
            return true;
        }

        private Boolean BDTGNMTNXThangInDuLieu(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, int NNgu, DateTime TNgay, DateTime DNgay, int iLoaiBC, int iKieuBC, out int iTinhTrang)
        {
            iTinhTrang = 1;
            Excel.Application xlApp = new Excel.Application();
            Excel.Workbooks xlWBooks;
            Excel.Workbook xlWBook;
            
            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;
                grd.ExportToXls(sPath);
                System.Globalization.CultureInfo oldCultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
                System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
                xlWBooks = xlApp.Workbooks;
                xlWBook = xlWBooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWSheet = (Excel.Worksheet)xlWBook.Sheets[1];
                
                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;
                xlApp.Cells.Font.Name = "Tahoma";
                xlApp.Cells.Font.Size = 10;

                Dong = TDong + 2;

                Commons.Modules.MExcel.DinhDang(xlWSheet, Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoNX", "TongCong", NNgu)
                    , Dong, 1, "@", 10, true, Excel.XlHAlign.xlHAlignRight, Excel.XlVAlign.xlVAlignCenter, true, Dong, 2);

                for (int cot = 3; cot <= TCot; cot++)
                    Commons.Modules.MExcel.MFuntion(xlWSheet, "SUM", Dong, cot, Dong, cot, Dong - TDong,
                        cot, Dong - 1, cot, 10, true, 10, "#,##0", Excel.XlHAlign.xlHAlignRight, Excel.XlVAlign.xlVAlignCenter);


                Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet, 1, 3, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWSheet, 0, 0, 100, 45, Application.StartupPath);
                Commons.Modules.MExcel.ThemDong(xlWSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown,4, Dong);

                int SCot;

                SCot = (TCot > 9 ? 9 : TCot);

                Dong++;
                string stmp = "";
                
                if (iKieuBC == 0) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNXThang", "TieuDeTGNM", NNgu);
                if (iKieuBC == 1) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNXThang", "TieuDeTGSC", NNgu);
                if (iKieuBC == 2) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNXThang", "TieuDeSoLan", NNgu);
                if (iKieuBC == 3) stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNXThang", "TieuDeMTTR", NNgu);

                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 1, "@", 16, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);

                Dong++;

                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNXThang", "lblTThang", NNgu) + " : " + TNgay.ToString("MM/yyyy") + " " +
                    Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNXThang", "lblDThang", NNgu) + " : " + DNgay.ToString("MM/yyyy");
                Commons.Modules.MExcel.DinhDang(xlWSheet, stmp, Dong, 1, "@", 10, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, SCot);
                Dong++;

                int DongBD;
                Excel.Range title;
                Dong++;
                Dong++;
                DongBD = Dong;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD - 1, 1, TDong + DongBD, TCot);
                title.Borders.LineStyle = 1;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD - 1, 1, DongBD-1, TCot);
                title.Font.Bold = true;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWBook, xlWSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);
                xlApp.Cells.RowHeight = 23;
                xlApp.Cells.ColumnWidth = 9;
                xlApp.Cells.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, 5, 1, 5, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD - 2, 1, DongBD - 2, 1);
                title.RowHeight = 9;

                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 5, "##", true, DongBD, 1, TDong + DongBD, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 35, "@", true, DongBD, 2, TDong + DongBD, 2);

                for (int i = 3; i < TCot; i++)
                    Commons.Modules.MExcel.ColumnWidth(xlWSheet, 12, "#,##0", true, DongBD, i, TDong + DongBD, i);

                Commons.Modules.MExcel.ColumnWidth(xlWSheet, 15, "#,##0", true, DongBD, TCot, TDong + DongBD, TCot);
                SCot = TCot + 1;

                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD, TCot + 2, DongBD, TCot + 2);
                double iLeft; double iTop;
                double iWidth; double iHeight;

                iLeft = Convert.ToDouble(title.Left);
                iTop = Convert.ToDouble(title.Top);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD, TCot + 2, DongBD + 9, TCot + 2);
                iHeight = Convert.ToDouble(title.Height);

                title = Commons.Modules.MExcel.GetRange(xlWSheet, DongBD, TCot + 2, DongBD + 9, TCot + 2 + 7);
                iWidth = Convert.ToDouble(title.Width);




                Boolean dCuoi;
                dCuoi = false;
                for (int i = DongBD; i <= DongBD + TDong ; i++)
                {
                    if (i == DongBD + TDong)
                        dCuoi = true;
                    BDTGNMTNXThangLoadBieuDo(xlWSheet, i, TCot, "", i - DongBD + 1, iLeft, iTop, iWidth, iHeight, dCuoi,NNgu);
                }


                xlApp.DisplayAlerts = false;
                xlWBook.Save();
                xlWBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
            }
            catch
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                return false;

            }

            return true;


        }

        private void BDTGNMTNXThangLoadBieuDo(Excel.Worksheet ExcelSheets, int iDong, int iColumKT, string sTitle, int iSoLan, double iLeft,
            double iTop, double iWidth, double iHeight, Boolean sCuoi, int NNgu)
        {

            try
            {
                double iSLan;
                double sLe;
                double sChan;
                double sKQ;

                iSLan = iSoLan;
                sKQ = 0;
                if (sCuoi)
                {
                    sChan = Math.Floor(iSLan / 10);
                    sLe = iSLan - sChan * 10;
                    if (sLe != 0)
                    {
                        sKQ = ((sChan + 1) * 10) + 1;
                    }
                    else
                    {
                        sKQ = iSoLan + 1;
                    }


                    iSoLan = int.Parse(sKQ.ToString());


                }

                double iTmp = (iSoLan - 1);
                iTmp = Math.Floor(iTmp / 10);
                double iLan = (iSoLan - 1) % 10;
                iLeft = iLeft + iLan * iWidth;
                iTop = iTop + iHeight * iTmp;

                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                Excel.Series xlSeries = xlSeriesCollection.NewSeries();

                var _with1 = xlSeries;
                _with1.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNXThang", "Thang", NNgu);// "=Sheet1!$A$" + (vDong + 1);                 //"=A" + vDong;
                _with1.Values = ExcelSheets.get_Range("C" + iDong, Commons.Modules.MExcel.MCotExcel(iColumKT - 1) + iDong); //"B33");
                _with1.XValues = ExcelSheets.get_Range("C9", Commons.Modules.MExcel.MCotExcel(iColumKT - 1) + "9");




                if (sCuoi)
                    xlChart.ChartTitle.Text = Commons.Modules.ObjLanguages.GetLanguage(
                    Commons.Modules.ModuleName, "ucBieuDoTGNMayTheoNXThang", "TongCong", NNgu);
                else
                    xlChart.ChartTitle.Text = "=Sheet1!$B$" + (iDong);


                xlChart.Refresh();
                xlChart.HasTitle = true;
                xlChart.Legend.Position = Excel.XlLegendPosition.xlLegendPositionBottom;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255)); 
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                Excel.Axis ax = xlChart.Axes(Excel.XlAxisType.xlCategory, Excel.XlAxisGroup.xlPrimary) as Excel.Axis;
                ax.TickLabels.Orientation = Excel.XlTickLabelOrientation.xlTickLabelOrientationUpward;
                xlChart.Refresh();
            }
            catch
            { }        
        
        }

        #endregion

        #region ucMailVatTuDeXuatChuaNhapKho VTDXCXK
        public Boolean VTDXCXKInThietBiDenHanHieuChuan(DataTable dtSch,
            DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            DataTable dtTmp = new DataTable();
            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text,
                "SELECT * FROM THONG_TIN_CHUNG WHERE ISNULL(DDH_DXMH,0) = 0"));
            if (dtTmp.Rows.Count > 0)
                return VTDXCXKLoadDLKhongDonHang(dtSch, grd, grv, out iCoDuLieu);
            else
            {
                iCoDuLieu = 0;
                return false;
            }
        }

        private Boolean VTDXCXKLoadDLKhongDonHang(DataTable dtSch,
            DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            DataTable tbData = new DataTable();
            DataTable tbTmp = new DataTable();
            try
            {
                DateTime TNgay, DNgay;
                string sUserName, sPBan, sMsKho;
                int NNgu, iSNgay;
                Boolean SauNgayBD;
                SauNgayBD = false;
                iSNgay = 0;
                sPBan = "-1";
                sMsKho = "ALL";
                NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
                sUserName = dtSch.Rows[0]["USERNAME"].ToString();

                if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
                {
                    string sStmp;
                    sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                    string[] chuoi_tach = sStmp.Split(new Char[] { ',' });


                    if (chuoi_tach.GetValue(0).ToString().Trim() == "0") SauNgayBD = false; else SauNgayBD = true;
                    iSNgay = int.Parse(chuoi_tach.GetValue(1).ToString());
                    sPBan = chuoi_tach.GetValue(2).ToString();
                    sMsKho = chuoi_tach.GetValue(3).ToString();
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
                DataTable dtTmp = new DataTable();
                string sSql;
                string sBT = "KHO_VTDX";
                Commons.Modules.ObjSystems.XoaTable(sBT);
                sSql = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                            "ucVatTuDeXuatChuaNhapKho", "KhongTheoKho", NNgu);
                if (sMsKho == "ALL")
                {
                    sSql = " SELECT CONVERT(BIT,1) AS CHON, MS_KHO , TEN_KHO , CONVERT(NVARCHAR(100),MS_KHO) AS MS_KHO_TIM , TEN_KHO AS TEN_KHO_TIM " +
                                " FROM IC_KHO UNION SELECT CONVERT(BIT,1), -1 , '" + sSql + "', '' , 'ZZZZZZ' ORDER BY TEN_KHO_TIM ";
                }
                else
                {
                    sSql = " SELECT * FROM (SELECT CONVERT(BIT,1) AS CHON, MS_KHO , TEN_KHO , CONVERT(NVARCHAR(100),MS_KHO) AS MS_KHO_TIM , TEN_KHO AS TEN_KHO_TIM " +
                                " FROM IC_KHO UNION SELECT CONVERT(BIT,1), -1 , '" + sSql + "', '' , 'ZZZZZZ' ) A " +
                                " WHERE MS_KHO IN ( " + sMsKho.Replace("@", ",").Substring (0,sMsKho.Replace("@", ",").Length-1) + ") ORDER BY TEN_KHO_TIM ";
                }
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));

                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, sBT, dtTmp, "");
                
                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetBCVatTuDeXuatChuaNhapKho", TNgay, DNgay, sPBan));
                Commons.Modules.ObjSystems.XoaTable("KHO_VTDX");

                if (dtTmp.Rows.Count == 0)
                {
                    iCoDuLieu = 0;
                    return false;
                }
                dtTmp.Columns["STT"].ReadOnly = false;
                for (int i = 0; i <= dtTmp.Rows.Count - 1; i++)
                {
                    dtTmp.Rows[i][0] = (i + 1).ToString();
                }
                iSNgay = Commons.Modules.TypeLanguage;
                Commons.Modules.TypeLanguage = NNgu;
                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, true, true, true, true, true, "ucVatTuDeXuatChuaNhapKho");
                Commons.Modules.TypeLanguage = iSNgay;

                string sPath, SavePath;
                sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                SavePath = Application.StartupPath;
                return VTDXCXKInDuLieuKhongDonHang(grd, grv, sPath, SavePath, NNgu, TNgay, DNgay, sPBan,out iCoDuLieu);
            }
            catch
            {
                iCoDuLieu = 2;
                return false; }
        }

        private Boolean VTDXCXKInDuLieuKhongDonHang(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, string SavePath, int NNgu, DateTime TNgay, DateTime DNgay, String sPBan, out int iCoDuLieu)
        {
            iCoDuLieu = 1;
            Excel.Application xlApp = new Excel.Application();
            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;
                grd.ExportToXls(sPath);

                System.Globalization.CultureInfo oldCultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
                System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
                

                Excel.Workbooks excelWorkbooks = xlApp.Workbooks;
                Excel.Workbook xlWorkBook = excelWorkbooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWorkSheet = (Excel.Worksheet)xlWorkBook.Sheets[1];
                Dong = Commons.Modules.MExcel.TaoTTChung(xlWorkSheet, 1, 4, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWorkSheet, 0, 0, 110, 45, Application.StartupPath);
                Commons.Modules.MExcel.ThemDong(xlWorkSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 5, Dong);
                Dong++;
                Commons.Modules.MExcel.DinhDang(xlWorkSheet, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "ucBaoCaoChiPhiChiTiet", "TieuDe", Commons.Modules.TypeLanguage), Dong, 1, "@", 16, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, 7);
                string stmp = "";
                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblTNgay", NNgu) + " : " + TNgay.ToString(oldCultureInfo.DateTimeFormat.ShortDatePattern) + " " +
                        Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblDNgay", NNgu) + " : " + DNgay.ToString(oldCultureInfo.DateTimeFormat.ShortDatePattern);
                Commons.Modules.MExcel.DinhDang(xlWorkSheet, stmp, Dong, 1, "@", 10, true,
                    Excel.XlHAlign.xlHAlignCenter, Excel.XlVAlign.xlVAlignCenter, true, Dong, 7);

                Dong++;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ucBieuDoChiPhiTheoThang", "lblPBan", NNgu) + " : " + sPBan;
                Commons.Modules.MExcel.DinhDang(xlWorkSheet, stmp, Dong, 2, "@", 10, true, true, Dong, 4);

                Dong++;
                Excel.Range title;
                Dong++;
                title = Commons.Modules.MExcel.GetRange(xlWorkSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));

                title = Commons.Modules.MExcel.GetRange(xlWorkSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));
                title.Interior.Color = xlWorkSheet.get_Range(xlWorkSheet.Cells[Dong + 1, 1], xlWorkSheet.Cells[Dong + 1, 1]).Interior.Color;
                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWorkBook, xlWorkSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);


                title = Commons.Modules.MExcel.GetRange(xlWorkSheet, Dong - 1, 1, Dong - 1, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWorkSheet, 5, 1, 5, 1);
                title.RowHeight = 9;
                
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 4, "##", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 12, "@", true, Dong + 1, 2, TDong + Dong, 2);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 30, "@", true, Dong + 1, 3, TDong + Dong, 3);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 12, "@", true, Dong + 1, 4, TDong + Dong, 5);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 45, "@", true, Dong + 1, 6, TDong + Dong, 6);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 14, "@", true, Dong + 1, 7, TDong + Dong, 8);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 10, oldCultureInfo.DateTimeFormat.ShortDatePattern, true, Dong + 1, 9, TDong + Dong, 10);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 13, "@", true, Dong + 1, 11, TDong + Dong, 13);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 12, "#,##0.00", true, Dong + 1, 14, TDong + Dong, 15);


                xlApp.DisplayAlerts = false;
                xlWorkBook.Save();
                xlWorkBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWorkSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWorkBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                KillSpecificExcelFileProcess();
            }
            catch 
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iCoDuLieu = 2;
                return false;
            }
            return true;
        }        
        #endregion

        #region ucMailChuaCoHoaDon CCHD
        public Boolean CCHDLoadDLChuaCoHoaDon(DataTable dtSch,
            DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            out int iCoDuLieu, out string sLoi)
        {
            iCoDuLieu = 1;
            sLoi = "";
            DataTable tbData = new DataTable();
            DataTable tbTmp = new DataTable();
            try
            {
                DateTime TNgay, DNgay;
                string sUserName, sMsKho;
                int NNgu, iSNgay, iNgayTre;
                Boolean SauNgayBD;
                SauNgayBD = false;
                iSNgay = 0;
                iNgayTre = 1;
                sMsKho = "ALL";
                NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
                sUserName = dtSch.Rows[0]["USERNAME"].ToString();

                if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
                {
                    string sStmp;
                    sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                    string[] chuoi_tach = sStmp.Split(new Char[] { ',' });


                    if (chuoi_tach.GetValue(0).ToString().Trim() == "0") SauNgayBD = false; else SauNgayBD = true;
                    iSNgay = int.Parse(chuoi_tach.GetValue(1).ToString());
                    iNgayTre = int.Parse(chuoi_tach.GetValue(2).ToString());
                    sMsKho = chuoi_tach.GetValue(3).ToString();
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
                
                string sSql;
                string sBT = "DS_CHUA_HD"  + Commons.Modules.UserName ;
                Commons.Modules.ObjSystems.XoaTable(sBT);
                if (sMsKho == "ALL")
                {
                    sSql = " SELECT CONVERT(BIT,1) AS CHON, MS_KHO INTO " + sBT + " FROM IC_KHO ";
                }
                else
                {
                    sSql = " SELECT CONVERT(BIT,1) AS CHON, MS_KHO INTO " + sBT + " FROM IC_KHO A WHERE MS_KHO IN ( " + 
                            sMsKho.Replace("@", ",").Substring(0, sMsKho.Replace("@", ",").Length - 1) + ") ";
                }
                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString,CommandType.Text,sSql);

                DataTable dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetDSPNChuaCoHoaDon",iNgayTre, Commons.Modules.UserName));
#region Kiem co Du Lieu
                try
                {
                    if (dtTmp.Rows.Count == 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch { }
#endregion
                iSNgay = Commons.Modules.TypeLanguage;
                Commons.Modules.TypeLanguage = NNgu;
                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, true, true, true, true, true, "ucMailChuaCoHoaDon");
                Commons.Modules.TypeLanguage = iSNgay;

                string sPath, SavePath;
                sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                SavePath = Application.StartupPath;
                return CCHDInChuaCoHoaDon(grd, grv, sPath, SavePath, NNgu, TNgay, DNgay, iNgayTre, dtSch.Rows[0]["ID_MAIL"].ToString(), 
                    out iCoDuLieu, out sLoi);
            }
            catch ( Exception ex)
            {
                sLoi = "1:" + ex.Message;
                iCoDuLieu = 2;
                return false; 
            }
        }

        private Boolean CCHDInChuaCoHoaDon(DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, string SavePath, int NNgu, DateTime TNgay, DateTime DNgay, int iNgayTre, string sBCao, 
            out int iCoDuLieu, out string sLoi)
        {
            sLoi = "";
            iCoDuLieu = 1;
            Excel.Application xlApp = new Excel.Application();
            try
            {
                int TCot = grv.Columns.Count;
                int TDong = grv.RowCount;
                int Dong = 1;
                sLoi = "1";
                grd.ExportToXls(sPath);
                sLoi = "2";
                System.Globalization.CultureInfo oldCultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
                System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");


                Excel.Workbooks excelWorkbooks = xlApp.Workbooks;
                Excel.Workbook xlWorkBook = excelWorkbooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWorkSheet = (Excel.Worksheet)xlWorkBook.Sheets[1];
                //if (System.Environment.MachineName.ToUpper() == "MASHIMARO") xlApp.Visible = true;                
                sLoi = "3";
                
                Commons.Modules.MExcel.ThemDong(xlWorkSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 5, Dong);
                Commons.Modules.MExcel.TaoLogo(xlWorkSheet, 0, 0, 110, 45, Application.StartupPath);
                Dong++;
                sLoi = "4";
                Commons.Modules.MExcel.DinhDang(xlWorkSheet, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    sBCao, "TieuDe", Commons.Modules.TypeLanguage), Dong, 4, "@", 16, true,
                    Excel.XlHAlign.xlHAlignLeft, Excel.XlVAlign.xlVAlignCenter, true, Dong, 4);
                string stmp = "";
                Dong = Dong + 2;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, sBCao, "NgayGio", NNgu) + " : " + 
                    System.DateTime.Now.Date.ToShortDateString();
                Commons.Modules.MExcel.DinhDang(xlWorkSheet, stmp, Dong, 2, "@", 10, true, true, Dong, 2);

                Dong = Dong + 2;
                Excel.Range title;
                
                title = Commons.Modules.MExcel.GetRange(xlWorkSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));

                title = Commons.Modules.MExcel.GetRange(xlWorkSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));
                title.Interior.Color = xlWorkSheet.get_Range(xlWorkSheet.Cells[Dong + 1, 1], xlWorkSheet.Cells[Dong + 1, 1]).Interior.Color;

                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWorkBook, xlWorkSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 40, 10, 95);

                if (System.Environment.MachineName.ToUpper() == "MASHIMARO") xlApp.Visible = true;

                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 4, "##", true, Dong, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 14, "@", true, Dong, 2, TDong + Dong, 2);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 16, "@", true, Dong, 3, TDong + Dong, 3);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 17, "@", true, Dong, 4, TDong + Dong, 4);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 10, oldCultureInfo.DateTimeFormat.ShortDatePattern, true, Dong, 5, TDong + Dong, 5);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 25, "@", true, Dong, 6, TDong + Dong, 6);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 16, "@", true, Dong, 7, TDong + Dong, 7);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 16, "@", true, Dong, 8, TDong + Dong, 8);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 13, "#,##0.00", true, Dong, 9, TDong + Dong, 9);
                Commons.Modules.MExcel.ColumnWidth(xlWorkSheet, 10, "##", true, Dong, 10, TDong + Dong, 10);

                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                                 sBCao, "DuoiTrai", Commons.Modules.TypeLanguage);
                xlWorkSheet.PageSetup.LeftFooter = stmp;
                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    sBCao, "Trang", Commons.Modules.TypeLanguage);
                xlWorkSheet.PageSetup.CenterFooter = stmp + " &P / &N";

                stmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    sBCao, "DuoiPhai", Commons.Modules.TypeLanguage);
                xlWorkSheet.PageSetup.RightFooter = stmp;

                xlWorkBook.Save();
                xlWorkBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlWorkSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWorkBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                KillSpecificExcelFileProcess();
            }
            catch( Exception ex)
            {
                sLoi = "2:" + sLoi + " ; "  + ex.Message;
                iCoDuLieu = 2;
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                return false;
            }
            return true;
        }
        #endregion



        //---------------------------------------------------





        //ucMailPhanTichTGNMay
        #region     "frmPhanTichNNNMTheoNNVeCo -- PTTGNMTMThang"
        public Boolean PhanTichTGNMTMThang(DataTable dtSch,
            DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv, out int iCoDuLieu, out string sLoi, out string sFile)
        {
            iCoDuLieu = 1;
            sLoi = "";
            sFile = "";
            try
            {
                #region Khai Bao Bien
                string sSql, sUserName, sMsNXuong, sStmp, sBCao, sLMay;
                DateTime TNgay, DNgay;
                int NNgu, iLoaiBC, iSNgay, iHThong;
                Boolean SauNgayBD;
                DataTable dtTmp = new DataTable();
                DataTable dtNNNMay = new DataTable();
                DataTable dtMay = new DataTable();
                SauNgayBD = false;
                iSNgay = 0;
                iLoaiBC = 0;
                sSql = "";
                sMsNXuong = "-1";
                iHThong = -1;
                sLMay = "-1";
                
                NNgu = int.Parse(dtSch.Rows[0]["NGON_NGU"].ToString());
                sUserName = dtSch.Rows[0]["USERNAME"].ToString();
                Commons.Modules.TypeLanguage = NNgu;
                #endregion

                #region Lay dieu kien bao cao

                if (dtSch.Rows[0]["DK_BAOCAO"].ToString() != "")
                {
                    sBCao = "";
                    sStmp = Convert.ToString(dtSch.Rows[0]["DK_BAOCAO"].ToString());
                    string[] chuoi_tach = sStmp.Split(new Char[] { '@' });
                    int i = 0;
                    foreach (string s in chuoi_tach)
                    {
                        if (i == 0)
                        {
                            sBCao = s;
                            string[] sChuoiBC = sBCao.Split(new Char[] { ',' });
                            if (sChuoiBC.GetValue(0).ToString().Trim() == "0") SauNgayBD = false; else SauNgayBD = true;

                            iSNgay = int.Parse(sChuoiBC.GetValue(1).ToString());
                            sMsNXuong = sChuoiBC.GetValue(2).ToString();
                            iLoaiBC = int.Parse(sChuoiBC.GetValue(3).ToString());
                            iHThong = int.Parse(sChuoiBC.GetValue(4).ToString());
                            sLMay = sChuoiBC.GetValue(5).ToString();
                            break;
                        }
                        i++;
                    }
                }
                else
                {
                    iCoDuLieu = 0;
                    return false;
                }

                if (iSNgay == 0)
                {
                    TNgay = Convert.ToDateTime("01/" + DateTime.Now.Month + "/" + DateTime.Now.Year);
                    DNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(1).AddDays(-1);
                }
                else
                {
                    if (SauNgayBD)
                    {
                        TNgay = Convert.ToDateTime("01/" + DateTime.Now.Month + "/" + DateTime.Now.Year);
                        DNgay = TNgay.AddMonths(iSNgay).AddDays(-1);
                    }
                    else
                    {
                        {

                            DNgay = Convert.ToDateTime("01/" + DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(1);
                            TNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(-iSNgay + 1);


                            TNgay = Convert.ToDateTime("01/01" + "/" + DateTime.Now.Year);
                            DNgay = Convert.ToDateTime(DateTime.Now.Month + "/" + DateTime.Now.Year).AddMonths(1).AddDays(-1);

                        }
                    }
                }

                #endregion
                DataTable dtData = new DataTable();
                sLoi = "1";
                #region Tao Data sheet 1
                dtData.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetNNNMTheoNN", sUserName, sMsNXuong,
                        iHThong, sLMay, "-1", TNgay, DNgay, NNgu, 0));
                if (iLoaiBC == 0)
                    dtData.DefaultView.Sort = "TG_NGUNG DESC";
                else
                    dtData.DefaultView.Sort = "TG_SUA DESC";

                dtData = dtData.DefaultView.ToTable();
                #endregion
                sLoi = "2";
                #region Kiem co du lieu
                try
                {
                    if (dtData.Rows.Count <= 0)
                    {
                        iCoDuLieu = 0;
                        return false;
                    }
                }
                catch { }
                #endregion
                sLoi = "3";
                #region Tao Data sheet 2
                dtTmp = new DataTable();
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "spBaoCaoDownTime", iLoaiBC,
                        TNgay, DNgay, sMsNXuong, iHThong, sLMay, sUserName, NNgu));
                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, false, true, true, "frmPhanTichNNNMTheoNNVeCo");
                #endregion
                sLoi = "4";


                string sPath, SavePath;
                #region "Tao chuoi BC"

                sFile = "PRO_DT_REPORT_" + DateTime.Now.AddDays(-1).ToString("yyyyMMdd") + ".xls";
                //sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
                sPath = Application.StartupPath + "\\" + sFile;
                SavePath = Application.StartupPath;
                Commons.Modules.ObjSystems.Xoahinh(sPath);

                string sHeThong = "";
                if (sMsNXuong == "-1") sMsNXuong = " < ALL > ";
                else
                {
                    sSql = "SELECT CASE " + NNgu.ToString() + " WHEN 0 THEN TEN_N_XUONG WHEN 1 THEN TEN_N_XUONG_A ELSE TEN_N_XUONG_H END AS TNX " +
                                " FROM NHA_XUONG WHERE MS_N_XUONG = '" + sMsNXuong + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sMsNXuong = dtMay.Rows[0]["TNX"].ToString();
                    }

                }

                if (iHThong == -1) sHeThong = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_HE_THONG FROM HE_THONG WHERE MS_HE_THONG = " + iHThong;
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sHeThong = dtMay.Rows[0]["TEN_HE_THONG"].ToString();
                    }

                }
                if (sLMay == "-1") sLMay = " < ALL > ";
                else
                {
                    sSql = "SELECT TEN_LOAI_MAY FROM LOAI_MAY WHERE MS_LOAI_MAY = '" + sLMay + "' ";
                    dtMay = new DataTable();
                    dtMay.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql));
                    if (dtMay.Rows.Count != 0)
                    {
                        sLMay = dtMay.Rows[0]["TEN_LOAI_MAY"].ToString();
                    }

                }
                #endregion
                sLoi = "5";

                dtData = dtData.DefaultView.ToTable();
                if (!PhanTichTGNMTMThangInDuLieu(dtData, dtTmp, grd, grv, sPath, SavePath, NNgu, TNgay, DNgay, iLoaiBC, sMsNXuong, sHeThong, sLMay,
                    out iCoDuLieu, out sLoi)) 
                {
                    return false;
                }
                return true;
            }
            catch(Exception ex)
            {
                sLoi = sLoi + " - " + ex.Message;
                return false;
            }            
        }

        private Boolean PhanTichTGNMTMThangInDuLieu(DataTable  dtData , DataTable dtTmp, DevExpress.XtraGrid.GridControl grd, DevExpress.XtraGrid.Views.Grid.GridView grv,
            string sPath, string SavePath, int NNgu, DateTime TThang, DateTime DThang, int iLoaiBC,
            string sDiaDiem, string sDayChuyen, string sLoaiMay, out int iTinhTrang, out string sLoi)
        {
            int iTop;
            iTop = 5;
            iTinhTrang = 1;
            sLoi = "11";
            if (sPath == "")
            {
                iTinhTrang = 2;
                return false;
            }
            Excel.Application xlApp = new Excel.Application();
            System.Globalization.CultureInfo oldCultureInfo = System.Threading.Thread.CurrentThread.CurrentCulture;
            System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
            sLoi = "12";
            try
            {
                grd.ExportToXls(sPath);
                Excel.Workbooks excelWorkbooks = xlApp.Workbooks;
                sLoi = "12xlWorkBook12";
                Excel.Workbook xlWorkBook = excelWorkbooks.Open(sPath, 0, false, 5, "", "", false, Excel.XlPlatform.xlWindows, "", true, false, 0, true);
                Excel.Worksheet xlWSheet2 = (Excel.Worksheet)xlWorkBook.Sheets[1];
                xlWSheet2.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmPhanTichNNNMTheoNNVeCo", "BCChiTiet", NNgu); 


                xlApp.Cells.Font.Name = "Calibri";
                xlApp.Cells.Font.Size = 11;
                xlApp.Cells.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;
                
                xlApp.DisplayAlerts = false;
                sLoi = "13";

                #region "TaoSheet1"

                Excel.Range title;
                int TCot = dtTmp.Columns.Count - 1;
                int TDong = dtTmp.Rows.Count;
                int Dong = 1;





                Commons.Modules.MExcel.ThemDong(xlWSheet2, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 3, Dong);
                Dong = Commons.Modules.MExcel.TaoTTChung(xlWSheet2, 1, 5, 1, TCot);
                Commons.Modules.MExcel.TaoLogo(xlWSheet2, 0, 0, 110, 45, SavePath);


                string sTmp = "";
                sTmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,
                    "frmPhanTichNNNMTheoNNVeCo", "bcTieuDeDownTimeInProduction", NNgu);

                Dong = Dong + 1;
                Commons.Modules.MExcel.DinhDang(xlWSheet2, sTmp, Dong, 1, "@", 16, true, Excel.XlHAlign.xlHAlignCenter,
                    Excel.XlVAlign.xlVAlignCenter, true, Dong, TCot);

                Dong = Dong + 2;

                title = Commons.Modules.MExcel.GetRange(xlWSheet2, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));
                title.Interior.Color = xlWSheet2.get_Range(xlWSheet2.Cells[Dong - 1, 1], xlWSheet2.Cells[Dong - 1, 1]).Interior.Color;

                title = Commons.Modules.MExcel.GetRange(xlWSheet2, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;
                title.VerticalAlignment = Microsoft.Office.Interop.Excel.XlVAlign.xlVAlignCenter;
                title.WrapText = true;

                xlApp.DisplayAlerts = false;
                xlApp.AlertBeforeOverwriting = false;

                for (int i = 9; i < dtTmp.Rows.Count + 9; i++)
                {
                    string sGiaTri;
                    sGiaTri = dtTmp.Rows[i - 9][15].ToString();
                    int iDong;
                    iDong = i + int.Parse(sGiaTri) - 1;

                    title = Commons.Modules.MExcel.GetRange(xlWSheet2, i, 1, iDong, 1);
                    title.MergeCells = true;
                    title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;


                    title = Commons.Modules.MExcel.GetRange(xlWSheet2, i, 2, iDong, 2);
                    title.MergeCells = true;
                    title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;


                    title = Commons.Modules.MExcel.GetRange(xlWSheet2, i, 3, iDong, 3);
                    title.MergeCells = true;
                    title.Font.Bold = true;
                    title.Font.Size = 25;

                    title.HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter;
                    title.VerticalAlignment = Excel.XlVAlign.xlVAlignCenter;

                    i = iDong;
                }



                title = Commons.Modules.MExcel.GetRange(xlWSheet2, 1, TCot + 1, 1, TCot + 1);
                title.EntireColumn.Delete();


                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWorkBook, xlWSheet2, false, true, true,
                        true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlPortrait, 30, 30, 30, 30, 50, 50, 100);

                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 4, "##", true, Dong + 1, 1, TDong + Dong, 1);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 11, oldCultureInfo.DateTimeFormat.ShortDatePattern, true, Dong + 1, 2, TDong + Dong, 2);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 13, "#,##0", true, Dong + 1, 3, TDong + Dong, 3);

                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 11, "@", true, Dong + 1, 4, TDong + Dong, TCot);


                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 7, "@", true, 1, 4, 1, 4);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 22, "@", true, 1, 5, 1, 6);

                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 6, "hh:mm", true, Dong + 1, 7, TDong + Dong, 8);
                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 8, "#,##0", true, Dong + 1, 9, TDong + Dong, 9);

                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 13, "@", true, 1, 10, 1, 10);


                Commons.Modules.MExcel.ColumnWidth(xlWSheet2, 30, "@", true, 1, 11, 1, 15);



                title = Commons.Modules.MExcel.GetRange(xlWSheet2, 5, 1, 5, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlWSheet2, 7, 1, 7, 1);
                title.RowHeight = 9;

                //xlWSheet2.Rows.a
                xlWSheet2.Rows.AutoFit();
                #endregion

                #region Sheet2

                //sheet2

                xlWorkBook.Sheets.Add(System.Reflection.Missing.Value, xlWorkBook.Worksheets[xlWorkBook.Worksheets.Count],
                       System.Reflection.Missing.Value,
                       System.Reflection.Missing.Value);

                xlWSheet2.Move(System.Reflection.Missing.Value, xlWorkBook.Sheets[xlWorkBook.Sheets.Count]);
                Excel.Worksheet xlSheet = (Excel.Worksheet)xlWorkBook.Sheets[1];
                xlSheet.Name = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmPhanTichNNNMTheoNNVeCo", "BCTongHop", NNgu);
                xlSheet.Activate();


                dtData = dtData.DefaultView.ToTable();
                Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtData, false, true, false, true, true, "frmPhanTichNNNMTheoNNVeCo");
                if (iLoaiBC == 0)
                {
                    grv.Columns["TG_NGUNG"].Visible = true;
                    grv.Columns["TG_SUA"].Visible = false;

                }
                else
                {
                    grv.Columns["TG_NGUNG"].Visible = false;
                    grv.Columns["TG_SUA"].Visible = true;
                }
                grv.OptionsView.ColumnAutoWidth = true;
                grv.Columns["TG_NGUNG"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                grv.Columns["TG_NGUNG"].DisplayFormat.FormatString = "{0:N" + Commons.Modules.iSoLeSL.ToString() + "}";
                grv.Columns["TG_SUA"].DisplayFormat.FormatType = DevExpress.Utils.FormatType.Numeric;
                grv.Columns["TG_SUA"].DisplayFormat.FormatString = "{0:N" + Commons.Modules.iSoLeSL.ToString() + "}";





                dtTmp = new DataTable();
                dtTmp = dtData.Clone();
                dtTmp.Columns[1].DataType = typeof(string);

                for (int i = 0; i < dtData.Rows.Count; i++)
                {
                    DataRow dr = dtTmp.NewRow();
                    dr[0] = grv.GetRowCellValue(i, grv.Columns[0]);
                    if (iLoaiBC == 0)
                    {
                        if (Boolean.Parse(grv.GetRowCellValue(i, grv.Columns[1]).ToString()))
                            dr[1] = "þ";
                        else
                            dr[1] = "o";
                    }
                    else
                        dr[1] = grv.GetRowCellValue(i, grv.Columns[1]);

                    if (iLoaiBC == 0)
                        dr[2] = grv.GetRowCellValue(i, grv.Columns[2]);
                    else
                        dr[2] = grv.GetRowCellValue(i, grv.Columns[3]);
                    dtTmp.Rows.Add(dr);
                }
                dtTmp.Columns.RemoveAt(dtTmp.Columns.Count - 1);
                dtTmp.AcceptChanges();
                iTop = dtTmp.Rows.Count;

                try
                {
                    Commons.Modules.ObjSystems.MLoadXtraGrid(grd, grv, dtTmp, false, true, false, true,true, "frmPhanTichNNNMTheoNNVeCo");
                }
                catch { }
                xlSheet.Activate();
                TCot = dtTmp.Columns.Count;
                TDong = grv.RowCount;
                
                Dong = 1;

                title = Commons.Modules.MExcel.GetRange(xlSheet, 1, 1, grv.RowCount + 1, dtTmp.Columns.Count);
                Commons.Modules.MExcel.MExportExcel(dtTmp, xlSheet, title);

                Dong = Commons.Modules.MExcel.TaoTTChung(xlSheet, 1, 3, 1, TCot + 5);
                Commons.Modules.MExcel.TaoLogo(xlSheet, 0, 0, 110, 45, Application.StartupPath);

                if (iLoaiBC == 0)
                    Commons.Modules.MExcel.ThemDong(xlSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 8, Dong);
                if (iLoaiBC == 1 || iLoaiBC == 2 || iLoaiBC == 3)
                    Commons.Modules.MExcel.ThemDong(xlSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 6, Dong);
                if (iLoaiBC == 4)
                    Commons.Modules.MExcel.ThemDong(xlSheet, Microsoft.Office.Interop.Excel.XlInsertShiftDirection.xlShiftDown, 7, Dong);

                Dong++;
                
                sTmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName,"frmPhanTichNNNMTheoNNVeCo", "lblTitle", NNgu);
                Commons.Modules.MExcel.DinhDang(xlSheet, sTmp, Dong, 1, "@", 16, true, Excel.XlHAlign.xlHAlignCenter,
                    Excel.XlVAlign.xlVAlignCenter, true, Dong, TCot);

                Dong++;
                sTmp = "";
                sTmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmPhanTichNNNMTheoNNVeCo", "lblFromDate", NNgu) + " : " + 
                    TThang.Date.ToShortDateString() + " " + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmPhanTichNNNMTheoNNVeCo", "lblToDate", NNgu) + " : " + DThang.Date.ToShortDateString();
                Commons.Modules.MExcel.DinhDang(xlSheet, sTmp, Dong, 1, "@", 12, true, Excel.XlHAlign.xlHAlignCenter,
                    Excel.XlVAlign.xlVAlignCenter, true, Dong, TCot);

                Dong++;

                sTmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmPhanTichNNNMTheoNNVeCo", "lblDiaDiem", NNgu) + " : " + sDiaDiem;
                Commons.Modules.MExcel.DinhDang(xlSheet, sTmp, Dong, 2, "@", 10, true, true, Dong, TCot);

                if (iLoaiBC == 0)
                {
                    Dong++;
                    sTmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmPhanTichNNNMTheoNNVeCo", "lblDChuyen", NNgu) + " : " + sDayChuyen;
                    Commons.Modules.MExcel.DinhDang(xlSheet, sTmp, Dong, 2, "@", 10, true, true, Dong, TCot);
                    Dong++;
                    sTmp = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "frmPhanTichNNNMTheoNNVeCo", "lblLoaiMay", NNgu) + " : " + sLoaiMay;
                    Commons.Modules.MExcel.DinhDang(xlSheet, sTmp, Dong, 2, "@", 10, true, true, Dong, TCot);
                    Dong++;

                    title = Commons.Modules.MExcel.GetRange(xlSheet, 14, 2, 13 + TDong, 2);
                    title.Font.Name = "Wingdings";
                    title.Font.Size = 12;
                    title.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;
                    title.VerticalAlignment = Microsoft.Office.Interop.Excel.XlVAlign.xlVAlignCenter;

                }

                Dong++;

                Dong++;
                Commons.Modules.MExcel.DinhDang(xlSheet, grv.Columns[0].Caption, Dong, 1, "@", 10, true, true, Dong, 1);
                Commons.Modules.MExcel.DinhDang(xlSheet, grv.Columns[1].Caption, Dong, 2, "@", 10, true, true, Dong, 2);
                Commons.Modules.MExcel.DinhDang(xlSheet, grv.Columns[2].Caption, Dong, 3, "@", 10, true, true, Dong, 3);

                title = Commons.Modules.MExcel.GetRange(xlSheet, Dong, 1, Dong + TDong, TCot);
                title.Borders.LineStyle = 1;
                title.Borders.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 0, 0));
                title.Interior.Color = xlSheet.get_Range(xlSheet.Cells[Dong - 1, 1], xlSheet.Cells[Dong - 1, 1]).Interior.Color;

                title = Commons.Modules.MExcel.GetRange(xlSheet, Dong, 1, Dong, TCot);
                title.Font.Bold = true;
                title.HorizontalAlignment = Microsoft.Office.Interop.Excel.XlHAlign.xlHAlignCenter;
                title.VerticalAlignment = Microsoft.Office.Interop.Excel.XlVAlign.xlVAlignCenter;
                title.WrapText = true;


                xlApp.DisplayAlerts = false;
                xlApp.AlertBeforeOverwriting = false;
                Commons.Modules.MExcel.ExcelEnd(xlApp, xlWorkBook, xlSheet, false, true, true,
                    true, Excel.XlPaperSize.xlPaperA4, Excel.XlPageOrientation.xlLandscape, 30, 30, 30, 30, 50, 50, 100);


                title = Commons.Modules.MExcel.GetRange(xlSheet, Dong - 1, 1, Dong - 1, 1);
                title.RowHeight = 9;

                title = Commons.Modules.MExcel.GetRange(xlSheet, 5, 1, 5, 1);
                title.RowHeight = 9;

                if (iLoaiBC == 0)
                {
                    Commons.Modules.MExcel.ColumnWidth(xlSheet, 23, "@", true, Dong + 1, 2, TDong + Dong, 2);
                    Commons.Modules.MExcel.ColumnWidth(xlSheet, 23, "@", true, Dong + 1, 1, TDong + Dong, 1);
                }
                else
                {
                    Commons.Modules.MExcel.ColumnWidth(xlSheet, 33, "@", true, Dong + 1, 2, TDong + Dong, 2);
                    Commons.Modules.MExcel.ColumnWidth(xlSheet, 13, "@", true, Dong + 1, 1, TDong + Dong, 1);
                }
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 11, "#,##0", true, Dong + 1, 3, TDong + Dong, 3);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 7, "", true, Dong + 1, 4, TDong + Dong, 4);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 8.71, "", true, Dong + 1, 5, TDong + Dong, 5);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 7, "", true, Dong + 1, 6, TDong + Dong, 6);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 8, "", true, Dong + 1, 7, TDong + Dong, 7);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 14, "", true, Dong + 1, 8, TDong + Dong, 8);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 14, "", true, Dong + 1, 9, TDong + Dong, 9);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 13, "", true, Dong + 1, 10, TDong + Dong, 10);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 14, "", true, Dong + 1, 11, TDong + Dong, 11);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 15, "", true, Dong + 1, 12, TDong + Dong, 12);
                Commons.Modules.MExcel.ColumnWidth(xlSheet, 20, "", true, Dong + 1, 13, TDong + Dong, 13);

                int iDongBD = 14;
                if (iLoaiBC == 0)
                    iDongBD = 14;
                if (iLoaiBC == 1 || iLoaiBC == 2 || iLoaiBC == 3)
                    iDongBD = 12;
                if (iLoaiBC == 4)
                    iDongBD = 13;

                int iTongDong = iDongBD + iTop - 1;
                if (grv.RowCount + iDongBD <= iTongDong) iTongDong = iDongBD + grv.RowCount - 1;

                title = Commons.Modules.MExcel.GetRange(xlSheet, 5, 4, 5, 4);



                PhanTichTGNMTMThangLoadBieuDo(grv, xlSheet, iDongBD, iTongDong, Convert.ToDouble(title.Left) + 15, Convert.ToDouble(title.Top), 386.92, 235.55,iLoaiBC );

                #endregion
                sLoi = "14";


                xlApp.DisplayAlerts = false;
                xlWorkBook.Save();
                xlWorkBook.Close(Type.Missing, Type.Missing, Type.Missing);
                xlApp.DisplayAlerts = false;
                xlApp.Quit();

                Commons.Modules.ObjSystems.MReleaseObject(xlSheet);
                Commons.Modules.ObjSystems.MReleaseObject(xlWSheet2);
                Commons.Modules.ObjSystems.MReleaseObject(xlWorkBook);
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                KillSpecificExcelFileProcess();

            }
            catch (Exception ex)
            {
                xlApp.DisplayAlerts = false;
                xlApp.Quit();
                Commons.Modules.ObjSystems.MReleaseObject(xlApp);
                iTinhTrang = 2;
                sLoi = sPath + "\n" + ex.Message;

                return false;
            }
            return true;
        }




        private void PhanTichTGNMTMThangLoadBieuDo(DevExpress.XtraGrid.Views.Grid.GridView grv, Excel.Worksheet ExcelSheets, int iDongBD, int iTongDong, double iLeft, double iTop, double iWidth, double iHeight, int iLoaiBC)
        {
            try
            {
                Excel.ChartObjects chartObjs = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj = chartObjs.Add(iLeft, iTop, iWidth, iHeight);
                Excel.Chart xlChart = chartObj.Chart;
                Excel.SeriesCollection xlSeriesCollection = (Excel.SeriesCollection)xlChart.SeriesCollection(Type.Missing);
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;

                Excel.Series xlSeries = xlSeriesCollection.NewSeries();

                var _with1 = xlSeries;
                if (iLoaiBC == 0)
                    _with1.Name = grv.Columns[0].Caption;
                else
                    _with1.Name = grv.Columns[1].Caption;

                _with1.AxisGroup = Excel.XlAxisGroup.xlPrimary;
                _with1.Values = ExcelSheets.get_Range("C" + iDongBD.ToString(), (iTongDong > 61 ? "C61" : "C" + iTongDong.ToString()));
                if (iLoaiBC == 0 || iLoaiBC == 4)
                {
                    _with1.XValues = ExcelSheets.get_Range("A" + iDongBD.ToString(), (iTongDong > 61 ? "A61" : "A" + iTongDong.ToString())); //"B33");
                }
                else
                {
                    _with1.XValues = ExcelSheets.get_Range("B" + iDongBD.ToString(), (iTongDong > 61 ? "B61" : "B" + iTongDong.ToString())); //"B33");
                }

                xlChart.HasTitle = false;
                xlChart.Legend.Position = Excel.XlLegendPosition.xlLegendPositionBottom;
                xlChart.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart.ChartType = Excel.XlChartType.xlColumnStacked;
                xlChart.Refresh();


                Excel.ChartObjects chartObjs1 = (Excel.ChartObjects)ExcelSheets.ChartObjects(Type.Missing);
                Excel.ChartObject chartObj1 = chartObjs1.Add(iLeft, 300, iWidth, iHeight);
                Excel.Chart xlChart1 = chartObj1.Chart;
                Excel.SeriesCollection xlSeriesCollection1 = (Excel.SeriesCollection)xlChart1.SeriesCollection(Type.Missing);
                xlChart1.ChartType = Excel.XlChartType.xlPie;

                Excel.Series xlSeries1 = xlSeriesCollection1.NewSeries();

                var _with11 = xlSeries1;

                _with11.AxisGroup = Excel.XlAxisGroup.xlPrimary;
                _with11.Values = ExcelSheets.get_Range("C" + iDongBD.ToString(), (iTongDong > 61 ? "C61" : "C" + iTongDong.ToString()));

                if (iLoaiBC == 0 || iLoaiBC == 4)
                {
                    _with11.XValues = ExcelSheets.get_Range("A" + iDongBD.ToString(), (iTongDong > 61 ? "A61" : "A" + iTongDong.ToString()));
                }
                else
                {
                    _with11.XValues = ExcelSheets.get_Range("B" + iDongBD.ToString(), (iTongDong > 61 ? "B61" : "B" + iTongDong.ToString()));
                }


                xlChart1.HasTitle = false;
                xlChart1.Legend.Position = Excel.XlLegendPosition.xlLegendPositionRight;
                xlChart1.ChartArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(10, 10, 255));
                xlChart1.PlotArea.Interior.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart1.PlotArea.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(0, 255, 255));
                xlChart1.Legend.Border.Color = System.Drawing.ColorTranslator.ToOle(System.Drawing.Color.FromArgb(255, 255, 255));
                xlChart1.ChartType = Excel.XlChartType.xlPie;
                xlChart1.Refresh();

            }
            catch
            { }
        }



        #endregion

        private void KillSpecificExcelFileProcess()
        {
            var processes = from p in System.Diagnostics.Process.GetProcessesByName("EXCEL")
                            select p;

            foreach (var process in processes)
            {
                //if (process.MainWindowTitle == "Microsoft Excel - " + excelFileName)
                    process.Kill();
            }

        }






    }
}
