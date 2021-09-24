using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.ApplicationBlocks.Data;
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;


namespace VSMail.MClass
{
    class MLoadReport
    {
        private DataSet Datasource = new DataSet();

        public Boolean AutoExporttoPDF(string CrystalPath, string CrystalName, string fileName, string SavePath, int NNgu, out int iTinhTrang)
        {
            // iTinhTrang = 0 khong co du lieu. 1 co du lieu.  2 loi
            iTinhTrang = 0;
            try
            {
                if (string.IsNullOrEmpty(SavePath))
                {
                    iTinhTrang = 2;
                    return false;
                }
                AddInformaitionCompany(NNgu, CrystalName);
                //Datasource.WriteXml(System.Windows.Forms.Application.StartupPath + "\\XML\\" + CrystalName.Trim() + ".xml", XmlWriteMode.WriteSchema);
                ReportDocument DocReport = new ReportDocument();
                DocReport.Load(CrystalPath + CrystalName.Trim() + ".rpt");
                DocReport.SetDataSource(Datasource);
                SetLanguageReport(DocReport, NNgu, CrystalName);
                if (Commons.Modules.bDoiFontReport)
                    Commons.Modules.ObjSystems.MDoiFontCrystalReports(DocReport);

                ExportOptions exportOpts = new ExportOptions();
                PdfRtfWordFormatOptions pdfFormatOpts = new PdfRtfWordFormatOptions();
                DiskFileDestinationOptions diskOpts = new DiskFileDestinationOptions();
                exportOpts = DocReport.ExportOptions;
                exportOpts.ExportFormatType = ExportFormatType.PortableDocFormat;
                exportOpts.FormatOptions = pdfFormatOpts;


                exportOpts.ExportDestinationType = ExportDestinationType.DiskFile;
                exportOpts.DestinationOptions = diskOpts;
                try
                {
                    Commons.Modules.ObjSystems.Xoahinh(SavePath + "\\" + fileName + ".pdf");
                }
                catch { }
                DocReport.ExportToDisk(ExportFormatType.PortableDocFormat, SavePath + "\\" + fileName + ".pdf");

            }
            catch {
                iTinhTrang = 2;
                return false; }
            return true;
        }

        private void AddInformaitionCompany(int NNgu, string rptName)
        {
            DataTable tbrptHeader = new DataTable();
            string vSelect = string.Empty;
            if (NNgu == 0)
            {
                Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptVTPT_NHO_HON_TON_TOI_THIEU", "TEN_KHO", NNgu);

                vSelect = "SELECT TEN_CTY_TIENG_VIET AS THONG_TIN_CTY ,DIA_CHI_VIET AS DIA_CHI_CTY , Phone AS DIEN_THOAI ," +
                "Fax , LOGO ,LE_PHAI_LOGO AS LE_TRAI_LOGO , LE_TREN_LOGO , WIDTH , HEIGHT , '" +
                Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, rptName, "PRINT_DATE", NNgu) + "' as NGAY_IN , '" +
                Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, rptName, "PAGE", NNgu) + "' AS PAGE , '" +
                Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, rptName, "OF", NNgu) + "' AS OFPAGE FROM THONG_TIN_CHUNG ";
            }
            else
            {
                vSelect = "SELECT TEN_CTY_TIENG_ANH AS THONG_TIN_CTY , DIA_CHI_ANH AS DIA_CHI_CTY , Phone AS DIEN_THOAI ," +
                "Fax , LOGO ,LE_PHAI_LOGO AS LE_TRAI_LOGO , LE_TREN_LOGO , WIDTH , HEIGHT , '" + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, rptName, "PRINT_DATE", NNgu) + "' as NGAY_IN , '" + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, rptName, "PAGE", NNgu) + "' AS PAGE , '" + Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, rptName, "OF", NNgu) + "' AS OFPAGE FROM THONG_TIN_CHUNG ";
            }
            tbrptHeader.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, vSelect));
            tbrptHeader.TableName = "rptTitlereport";
            if (tbrptHeader.Rows.Count > 0)
            {
                tbrptHeader.Columns["THONG_TIN_CTY"].MaxLength = 1000;
                tbrptHeader.Rows[0]["THONG_TIN_CTY"] = tbrptHeader.Rows[0]["THONG_TIN_CTY"].ToString().Trim() + "\n" + tbrptHeader.Rows[0]["DIA_CHI_CTY"].ToString().Trim() + "\n" + "Telephone: " + tbrptHeader.Rows[0]["DIEN_THOAI"].ToString().Trim() + "  Fax: " + tbrptHeader.Rows[0]["Fax"].ToString().Trim();
                tbrptHeader.Columns["NGAY_IN"].ReadOnly = false;
                tbrptHeader.Columns["NGAY_IN"].MaxLength = 128;
                tbrptHeader.Rows[0]["NGAY_IN"] = tbrptHeader.Rows[0]["NGAY_IN"].ToString().Trim() + System.DateTime.Now.ToString("dd/MM/yyyy");
            }
            tbrptHeader.Columns.Remove(tbrptHeader.Columns["DIA_CHI_CTY"]);
            tbrptHeader.Columns.Remove(tbrptHeader.Columns["DIEN_THOAI"]);
            tbrptHeader.Columns.Remove(tbrptHeader.Columns["Fax"]);
            try
            {
                Datasource.Tables.Remove(tbrptHeader.TableName);
            }
            catch { }
            Datasource.Tables.Add(tbrptHeader.Copy());
        }

        private void SetLanguageReport(CrystalDecisions.CrystalReports.Engine.ReportDocument rptDocument, int NNgu, string rptName)
        {
            DataTable tbrptLanguage = new DataTable();
            string vSelect = String.Empty;
            if (NNgu == 0)
            {
                vSelect = "SELECT KEYWORD, VIETNAM AS CAPTION FROM LANGUAGES WHERE FORM = '" + rptName + "' AND FORM_HAY_REPORT = 1";
            }
            else
            {
                vSelect = "SELECT KEYWORD, ENGLISH AS CAPTION FROM LANGUAGES WHERE FORM = '" + rptName + "' AND FORM_HAY_REPORT = 1";
            }

            tbrptLanguage.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, vSelect));
            if (tbrptLanguage.Rows.Count > 0)
            {
                foreach (CrystalDecisions.CrystalReports.Engine.ReportObject rptObject in rptDocument.ReportDefinition.ReportObjects)
                {
                    if (rptObject.Kind == CrystalDecisions.Shared.ReportObjectKind.TextObject)
                    {
                        foreach (DataRow rLanguage in tbrptLanguage.Rows)
                        {
                            if (rptObject.Name.ToUpper().Trim().Equals(rLanguage["KEYWORD"].ToString().ToUpper().Trim()))
                            {
                                ((CrystalDecisions.CrystalReports.Engine.TextObject)rptObject).Text = rLanguage["CAPTION"].ToString().Trim();
                            }
                        }
                    }
                }
            }
        }

        public void AddDataTableSource(DataTable tbSource)
        {
            try
            {
                try
                {
                    Datasource.Tables.Remove(tbSource.TableName);
                }
                catch { }
                Datasource.Tables.Add(tbSource.Copy());
            }
            catch { }
        }

    }
}
