using Biz.Lib.Helpers;
using Model.Data;
using Model.Interface.IRepository;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;

namespace Model.Repository.Repository
{
    public class SafetyRepository : ISafetyRepository, IDisposable
    {
        Model.Data.Model1 db;
        public SafetyRepository() => db = new Model1();
        public SafetyRepository(Model1 context) => db = context;
        public ST_HazardReport HazardReport(int ID) => db.ST_HazardReport.Where(x => x.ID == ID).FirstOrDefault();
        public IEnumerable<ChooseListHazard> ChooseListHazard(string tngay, string dngay)
        {
            List<ChooseListHazard> list = null;
            try
            {
                List<SqlParameter> listParameter = new List<SqlParameter>();
                listParameter.Add(new SqlParameter("ACTION", "LIST"));
                listParameter.Add(new SqlParameter("TUNGAY", tngay));
                listParameter.Add(new SqlParameter("DENNGAY", dngay));
                listParameter.Add(new SqlParameter("NGUOIPHUTRACH", "All"));
                listParameter.Add(new SqlParameter("NGUOIBAOCAO", "All"));
                listParameter.Add(new SqlParameter("PHONGBAN", -1));
                listParameter.Add(new SqlParameter("TRANGTHAI", "All"));
                listParameter.Add(new SqlParameter("LOAISC", ""));
                listParameter.Add(new SqlParameter("LOAISC2", ""));
                listParameter.Add(new SqlParameter("REPORT_PARENT", " "));
                listParameter.Add(new SqlParameter("DOCNUM", ""));
                listParameter.Add(new SqlParameter("External_N", "All"));
                listParameter.Add(new SqlParameter("IS_DELETE", false));
                listParameter.Add(new SqlParameter("NGUOILIENQUAN1", " "));
                listParameter.Add(new SqlParameter("NGUOILIENQUAN2", ""));
                listParameter.Add(new SqlParameter("STOP_WORK", "ALL"));
                list = DBUtils.ExecuteSPList<ChooseListHazard>("VS_ST_HazardReport", listParameter, AppName.Model1);
            }
            catch (Exception ex)
            {
            }
            return list;
        }
        #region Hazard report
        public List<HazardReportViewModel.HazardReport1ViewModel> GetListDetail(string ID)
        {
            List<HazardReportViewModel.HazardReport1ViewModel> list = null;
            try
            {
                List<SqlParameter> listParameter = new List<SqlParameter>();
                listParameter.Add(new SqlParameter("ID", ID));
                list = DBUtils.ExecuteSPList<HazardReportViewModel.HazardReport1ViewModel>("VS_ST_HazardReport1", listParameter, AppName.Model1);
            }
            catch (Exception ex)
            {
            }
            return list;
        }
        public HazardReportViewModel GetListByID(string ID)
        {
            List<HazardReportViewModel> list = null;
            try
            {
                List<SqlParameter> listParameter = new List<SqlParameter>();
                listParameter.Add(new SqlParameter("ACTION", "GET_BY_ID"));
                listParameter.Add(new SqlParameter("ID", ID));
                list = DBUtils.ExecuteSPList<HazardReportViewModel>("VS_ST_HazardReport", listParameter, AppName.Model1);
                return list[0];
            }
            catch
            {
                return null;
            }
        }
        public string GetSoPhieuHazard()
        {
            string resulst = "";
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DOCNUM");
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                        resulst = ds.Tables[0].Rows[0][0].ToString();
                }
            }
            catch
            {
                resulst = "";
            }
            return resulst;
        }
        public int AddInsertHazardrepot(HazardReportViewModel model)
        {
            try
            {
                ST_HazardReport hazard = new ST_HazardReport();
                hazard.Acount = model.Acount;
                hazard.BelongContractor = model.BelongContractor;
                hazard.BelongToBSPort = model.BelongToBSPort;
                hazard.COMMENT = model.COMMENT;
                hazard.Commercial = model.Commercial;
                hazard.CreatedBy = model.CreatedBy;
                hazard.Createdtime = Convert.ToDateTime(model.sCreatedtime, new CultureInfo("vi-vn"));
                hazard.Department = model.Department;
                hazard.Description = model.Description;
                hazard.DocDate = Convert.ToDateTime(model.sDocDate, new CultureInfo("vi-vn"));
                hazard.DocNum = model.DocNum;
                hazard.DocTime = Convert.ToDateTime(model.DocTime, new CultureInfo("vi-vn"));
                hazard.Environment = model.Environment;

                hazard.HPES1 = model.HPES1;
                hazard.HPES2 = model.HPES2;
                hazard.HPES3 = model.HPES3;
                hazard.HPES4 = model.HPES4;
                hazard.HPES5 = model.HPES4;
                hazard.HPES6 = model.HPES6;

                hazard.HR = model.HR;
                hazard.ID = model.ID;
                hazard.Image_1 = model.Image_1;
                hazard.IS_DELETE = model.IS_DELETE;
                hazard.Location = model.Location;
                hazard.NearMiss = model.NearMiss;
                hazard.NGUOILIENQUAN1 = model.NGUOILIENQUAN1;
                hazard.NGUOILIENQUAN2 = model.NGUOILIENQUAN2;
                hazard.Operation = model.Operation;
                hazard.Other = model.Other;
                hazard.Picture = model.Picture;
                hazard.Procu = model.Procu;

                hazard.RANDOM = model.NGUOILIENQUAN2;
                hazard.REPORT_PARENT = model.REPORT_PARENT;
                hazard.SatetySuggestion = model.SatetySuggestion;
                hazard.Stopwork = model.Stopwork;

                hazard.Tally = model.Tally;
                hazard.TechHSE = model.TechHSE;
                hazard.TT = model.TT;
                hazard.UnsafeBehevior = model.UnsafeBehevior;
                hazard.UnsafeCondition = model.UnsafeCondition;
                hazard.APPROVAL_USER = model.APPROVAL_USER;
                hazard.IS_APPROVED = model.IS_APPROVED;
                db.ST_HazardReport.Add(hazard);
                db.SaveChanges();


                List<ST_HazardReport1> Hazard1 = new List<ST_HazardReport1>();
                model.ListHarzard1.ForEach(x =>
                {
                    Hazard1.Add(new ST_HazardReport1
                    {
                        HazardReportID = hazard.ID,
                        LOAIYEUCAU = x.LOAIYEUCAU,
                        MUCUUTIEN = x.MUCUUTIEN,
                        NGUYENNHAN = x.NGUYENNHAN,
                        PersonIncharge = x.PersonIncharge,
                        PersonReport = x.PersonReport,
                        PreventiveAction = x.PreventiveAction,
                        Status = x.Status,
                        THIETBI = x.THIETBI,
                        CompletedDate = x.CompletedDate,
                        Deadline = x.Deadline,
                        Description = x.Description,
                        ID = x.ID
                    });
                });
                db.ST_HazardReport1.AddRange(Hazard1);
                db.SaveChanges();
                return hazard.ID;
            }
            catch
            {
                return -1;
            }
        }
        public bool EditHazardrepot(HazardReportViewModel model)
        {
            try
            {
                ST_HazardReport hazard = new ST_HazardReport();
                hazard.APPROVAL_USER = model.APPROVAL_USER;
                hazard.Acount = model.Acount;
                hazard.BelongContractor = model.BelongContractor;
                hazard.BelongToBSPort = model.BelongToBSPort;
                hazard.COMMENT = model.COMMENT;
                hazard.Commercial = model.Commercial;
                hazard.CreatedBy = model.CreatedBy;
                hazard.Createdtime = Convert.ToDateTime(model.sCreatedtime, new CultureInfo("vi-vn"));
                hazard.Department = model.Department;
                hazard.Description = model.Description;
                hazard.DocDate = Convert.ToDateTime(model.sDocDate, new CultureInfo("vi-vn"));
                hazard.DocNum = model.DocNum;
                hazard.DocTime = Convert.ToDateTime(model.DocTime, new CultureInfo("vi-vn"));
                hazard.Environment = model.Environment;

                hazard.HPES1 = model.HPES1;
                hazard.HPES2 = model.HPES2;
                hazard.HPES3 = model.HPES3;
                hazard.HPES4 = model.HPES4;
                hazard.HPES5 = model.HPES5;
                hazard.HPES6 = model.HPES6;

                hazard.HR = model.HR;
                hazard.ID = model.ID;
                hazard.Image_1 = model.Image_1;
                hazard.IS_APPROVED = model.IS_APPROVED;
                hazard.IS_DELETE = model.IS_DELETE;
                hazard.Location = model.Location;
                hazard.NearMiss = model.NearMiss;
                hazard.NGUOILIENQUAN1 = model.NGUOILIENQUAN1;
                hazard.NGUOILIENQUAN2 = model.NGUOILIENQUAN2;
                hazard.Operation = model.Operation;
                hazard.Other = model.Other;
                hazard.Picture = model.Picture;
                hazard.Procu = model.Procu;

                hazard.RANDOM = model.NGUOILIENQUAN2;
                hazard.REPORT_PARENT = model.REPORT_PARENT;
                hazard.SatetySuggestion = model.SatetySuggestion;
                hazard.Stopwork = model.Stopwork;

                hazard.Tally = model.Tally;
                hazard.TechHSE = model.TechHSE;
                hazard.TT = model.TT;
                hazard.UnsafeBehevior = model.UnsafeBehevior;
                hazard.UnsafeCondition = model.UnsafeCondition;


                db.ST_HazardReport.Attach(hazard);
                db.Entry(hazard).Property(x => x.Acount).IsModified = true;
                db.Entry(hazard).Property(x => x.BelongContractor).IsModified = true;
                db.Entry(hazard).Property(x => x.BelongToBSPort).IsModified = true;
                db.Entry(hazard).Property(x => x.COMMENT).IsModified = true;
                db.Entry(hazard).Property(x => x.Commercial).IsModified = true;
                db.Entry(hazard).Property(x => x.Description).IsModified = true;
                db.Entry(hazard).Property(x => x.Environment).IsModified = true;
                db.Entry(hazard).Property(x => x.External).IsModified = true;
                db.Entry(hazard).Property(x => x.HPES1).IsModified = true;
                db.Entry(hazard).Property(x => x.HPES2).IsModified = true;
                db.Entry(hazard).Property(x => x.HPES3).IsModified = true;
                db.Entry(hazard).Property(x => x.HPES4).IsModified = true;
                db.Entry(hazard).Property(x => x.HPES5).IsModified = true;
                db.Entry(hazard).Property(x => x.HPES6).IsModified = true;
                db.Entry(hazard).Property(x => x.HR).IsModified = true;
                db.Entry(hazard).Property(x => x.ID).IsModified = true;
                db.Entry(hazard).Property(x => x.Image_1).IsModified = true;
                db.Entry(hazard).Property(x => x.Location).IsModified = true;
                db.Entry(hazard).Property(x => x.NearMiss).IsModified = true;
                db.Entry(hazard).Property(x => x.NGUOILIENQUAN1).IsModified = true;
                db.Entry(hazard).Property(x => x.NGUOILIENQUAN2).IsModified = true;
                db.Entry(hazard).Property(x => x.Operation).IsModified = true;
                db.Entry(hazard).Property(x => x.Other).IsModified = true;
                db.Entry(hazard).Property(x => x.Procu).IsModified = true;
                db.Entry(hazard).Property(x => x.RANDOM).IsModified = true;
                db.Entry(hazard).Property(x => x.REPORT_PARENT).IsModified = true;
                db.Entry(hazard).Property(x => x.SatetySuggestion).IsModified = true;
                db.Entry(hazard).Property(x => x.Stopwork).IsModified = true;
                db.Entry(hazard).Property(x => x.Tally).IsModified = true;
                db.Entry(hazard).Property(x => x.TechHSE).IsModified = true;
                db.Entry(hazard).Property(x => x.TT).IsModified = true;
                db.Entry(hazard).Property(x => x.UnsafeBehevior).IsModified = true;
                db.Entry(hazard).Property(x => x.UnsafeCondition).IsModified = true;
                db.Entry(hazard).Property(x => x.Department).IsModified = true;
                db.Entry(hazard).Property(x => x.IS_APPROVED).IsModified = true;
                db.Entry(hazard).Property(x => x.APPROVAL_USER).IsModified = true;

                List<ST_HazardReport1> Hazard1 = new List<ST_HazardReport1>();

                model.ListHarzard1.ForEach(x =>
                {
                    Hazard1.Add(new ST_HazardReport1
                    {
                        HazardReportID = hazard.ID,
                        LOAIYEUCAU = x.LOAIYEUCAU,
                        MUCUUTIEN = x.MUCUUTIEN,
                        NGUYENNHAN = x.NGUYENNHAN,
                        PersonIncharge = x.PersonIncharge,
                        PersonReport = x.PersonReport,
                        PreventiveAction = x.PreventiveAction,
                        Status = x.Status,
                        THIETBI = x.THIETBI,
                        CompletedDate = x.CompletedDate,
                        Deadline = x.Deadline,
                        Description = x.Description,
                        ID = x.ID
                    });
                });
                if (Hazard1.Count(x => x.ID < 0) > 0)
                {
                    db.ST_HazardReport1.AddRange(Hazard1.Where(x => x.ID < -1).ToList());
                }
                else
                {

                    foreach (ST_HazardReport1 item in Hazard1)
                    {
                        if (item.ID > 0)
                        {
                            db.ST_HazardReport1.Attach(item);
                            db.Entry(item).Property(x => x.LOAIYEUCAU).IsModified = true;
                            db.Entry(item).Property(x => x.MUCUUTIEN).IsModified = true;
                            db.Entry(item).Property(x => x.NGUYENNHAN).IsModified = true;
                            db.Entry(item).Property(x => x.PersonIncharge).IsModified = true;
                            db.Entry(item).Property(x => x.PersonReport).IsModified = true;
                            db.Entry(item).Property(x => x.PreventiveAction).IsModified = true;
                            db.Entry(item).Property(x => x.THIETBI).IsModified = true;
                            db.Entry(item).Property(x => x.Description).IsModified = true;
                            db.Entry(item).Property(x => x.Status).IsModified = true;
                            db.Entry(item).Property(x => x.CompletedDate).IsModified = true;
                        }
                    }
                    db.SaveChanges();
                    var result = db.ST_HazardReport1.Where(p => p.HazardReportID == hazard.ID);
                    foreach (var item in result)
                    {
                        if (Hazard1.Count(x => x.ID == item.ID) == 0)
                        {
                            db.ST_HazardReport1.Remove(item);
                        }
                    }
                }
                db.SaveChanges();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool Delete(int ID)
        {
            try
            {
                db.ST_HazardReport1.RemoveRange(db.ST_HazardReport1.Where(x => x.HazardReportID == ID));
                db.ST_HazardReport.Remove(db.ST_HazardReport.Where(x => x.ID == ID).FirstOrDefault());
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }

        }

        public bool fnCheckAdminUser(string UserName)
        {//cac user trong nhom GROUP_ID=49  moi co quyen dyuyet
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "CHECK_ADMIN_USER");
                sqlcom.Parameters.AddWithValue("USER", UserName);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return false;
                else if (ds.Tables[0].Rows.Count > 0)
                    return true;
                else
                    return false;
            }
            catch
            {
                return false;
            }
        }
        public bool fnCheckApprovalUser(string UserName, string form)
        {//User nao duoc duyet form nao
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "CHECK_APPROVAL_USER");
                sqlcom.Parameters.AddWithValue("FORMID", "FrmHazardReport");
                sqlcom.Parameters.AddWithValue("APPROVAL_USER", UserName);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return false;
                else if (ds.Tables[0].Rows.Count > 0)
                    return true;
                else
                    return false;
            }
            catch (Exception generatedExceptionName)
            {
                return false;
            }
        }
        public bool CheckSameDepartment(string CreateBy, string ReportParent)
        {//khoong cung phong bang nen khong co quyen duyet
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEPT");
                sqlcom.Parameters.AddWithValue("CreatedBy", CreateBy);
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", ReportParent);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return false;
                else if (ds.Tables[0].Rows.Count > 0)
                    return true;
                else
                    return false;
            }
            catch
            {
                return false;
            }
        }
        public bool fnCheckCancelApproval(string UserName, string ID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "CHECK_CANCEL_APPROVAL");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("APPROVAL_USER", UserName);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return false;
                else if (ds.Tables[0].Rows.Count > 0)
                    return true;
                else
                    return false;
            }
            catch
            {
                return false;
            }
        }

        public string fnGetListMailApproval(string ID, string ReportParent, string Username)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", Username);
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", ReportParent);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch (Exception ex)
            {
                return "";
            }
        }
        public string fnGetListMailApprovalAndCreatedBy(string ID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL_CREATE_BY");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch (Exception ex)
            {
                return "";
            }
        }
        public string GetIDSafery(string Username)
        {
            try
            {
                string ID = db.ST_Safety.Where(x => x.Userlogin.Equals(Username)).Select(x => x.ID).FirstOrDefault().ToString();
                return ID;
            }
            catch (Exception)
            {
                return "";
            }
        }
        public string GetDepartmentbyReportParent(string User)
        {
            try
            {
                string Department = db.ST_Safety.Where(x => x.Userlogin.Equals(User)).Select(x => x.Department).FirstOrDefault().ToString();
                return Department;
            }
            catch (Exception)
            {
                return "";
            }
        }
        public string fnGetListMailIncharge(string ID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_INCHARGE");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public string fnGET_DEAR_APPROVAL(string ID, string Username, string ReportParent)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", Username);
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", ReportParent);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public string fnGET_DEAR_INCHARGE(string ID, string Username, string ReportParent)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_INCHARGE");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", Username);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public string fnGetApproval(string ID, string User, string ReportParent)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORTER_APPROVAL");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", User);
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", ReportParent);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public string GET_DEAR_APPROVAL_CREATE_BY(string ID, string UserName, string ReportParent)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL_CREATE_BY");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", UserName);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public string fnGetReporter(string ID, string User, string ReportParent)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORTER");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", User);
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", ReportParent);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public DataTable fnGetListAction(string ID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_ACTION");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return new DataTable();
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0];
                else
                    return new DataTable();
            }
            catch
            {
                return new DataTable();
            }
        }
        public DataTable fnGetListActionDone(string ID, string reportID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_ACTION_DONE");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("RID", reportID);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return new DataTable();
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0];
                else
                    return new DataTable();
            }
            catch
            {
                return new DataTable();
            }
        }
        #endregion

        #region StopCard
        public string GetSoPhieuStopCart()
        {
            string resulst = "";
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DOCNUM");
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_StopCard";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count > 0)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                        resulst = ds.Tables[0].Rows[0][0].ToString();
                }
            }
            catch
            {
                resulst = "";
            }
            return resulst;
        }

        public IEnumerable<ChooseListStopCard> ChooseListStopCard(string tngay, string dngay)
        {
            List<ChooseListStopCard> list = null;
            try
            {
                List<SqlParameter> listParameter = new List<SqlParameter>();
                listParameter.Add(new SqlParameter("ACTION", "LIST"));
                listParameter.Add(new SqlParameter("TUNGAY", tngay));
                listParameter.Add(new SqlParameter("DENNGAY", dngay));
                listParameter.Add(new SqlParameter("NGUOIPHUTRACH", "All"));
                listParameter.Add(new SqlParameter("NGUOIBAOCAO", "All"));
                listParameter.Add(new SqlParameter("REPORT_PARENT", " "));
                listParameter.Add(new SqlParameter("TRANGTHAI", "All"));
                listParameter.Add(new SqlParameter("DOCNUM", ""));
                listParameter.Add(new SqlParameter("LOAISC", ""));
                listParameter.Add(new SqlParameter("External_N", "All"));
                listParameter.Add(new SqlParameter("PHONGBAN", -1));
                listParameter.Add(new SqlParameter("IS_DELETE", false));
                listParameter.Add(new SqlParameter("NGUOILIENQUAN1", " "));
                listParameter.Add(new SqlParameter("NGUOILIENQUAN2", ""));

                list = DBUtils.ExecuteSPList<ChooseListStopCard>("VS_ST_StopCard", listParameter, AppName.Model1);
            }
            catch
            {
            }
            return list;
        }
        public StopCardViewModel GetListStopCardByID(string ID)
        {
            List<StopCardViewModel> list = null;
            try
            {
                List<SqlParameter> listParameter = new List<SqlParameter>();
                listParameter.Add(new SqlParameter("ACTION", "GET_BY_ID"));
                listParameter.Add(new SqlParameter("ID", ID));
                list = DBUtils.ExecuteSPList<StopCardViewModel>("VS_ST_StopCard", listParameter, AppName.Model1);
                return list[0];
            }
            catch
            {
                return null;
            }
        }

        public List<StopCardViewModel.StopCard1ViewModel> GetListStopCardDetail1(string ID)
        {
            List<StopCardViewModel.StopCard1ViewModel> list = null;
            try
            {
                List<SqlParameter> listParameter = new List<SqlParameter>();
                listParameter.Add(new SqlParameter("ID", ID));
                list = DBUtils.ExecuteSPList<StopCardViewModel.StopCard1ViewModel>("VS_ST_StopCard1", listParameter, AppName.Model1);
            }
            catch (Exception ex)
            {
            }
            return list;
        }

        public List<StopCardViewModel.StopCard2ViewModel> GetListStopCardDetail2(string ID)
        {
            List<StopCardViewModel.StopCard2ViewModel> list = null;
            try
            {
                List<SqlParameter> listParameter = new List<SqlParameter>();
                listParameter.Add(new SqlParameter("ID", ID));
                list = DBUtils.ExecuteSPList<StopCardViewModel.StopCard2ViewModel>("VS_ST_StopCard2", listParameter, AppName.Model1);
            }
            catch (Exception ex)
            {
            }
            return list;
        }


        public int AddStopCard(StopCardViewModel model)
        {
            try
            {
                ST_StopCard stop = new ST_StopCard();
                stop.ID = model.ID;
                stop.DocNum = model.DocNum;
                stop.DocDate = Convert.ToDateTime(model.sDocDate, new CultureInfo("vi-vn"));
                stop.DocTime = Convert.ToDateTime(model.DocTime, new CultureInfo("vi-vn"));
                stop.AdjPerPPE = model.AdjPerPPE;

                stop.StopJob = model.StopJob;

                stop.ChangingPosition = model.ChangingPosition;

                stop.RearrangingJob = model.RearrangingJob;

                stop.AttachingGrouds = model.AttachingGrouds;

                stop.PerformingLocks = model.PerformingLocks;

                stop.OtherReaction = model.OtherReaction;

                stop.Head = model.Head;

                stop.ArmsAndHands = model.ArmsAndHands;

                stop.EyesAndFace = model.EyesAndFace;

                stop.Trunk = model.Trunk;

                stop.Ears = model.Ears;

                stop.LegsAndFeet = model.LegsAndFeet;

                stop.RespiratorySystem = model.RespiratorySystem;

                stop.OtherPPE = model.OtherPPE;

                stop.HPES1 = model.HPES1;

                stop.HPES2 = model.HPES2;

                stop.HPES3 = model.HPES3;

                stop.HPES4 = model.HPES4;

                stop.HPES5 = model.HPES5;

                stop.HPES6 = model.HPES6;

                stop.StrikingAgaintObjects = model.StrikingAgaintObjects;

                stop.ChokingHazardousAir = model.ChokingHazardousAir;

                stop.CaughtInOn = model.CaughtInOn;

                stop.Inhaling = model.Inhaling;

                stop.Falling = model.Falling;

                stop.RepettiveMotions = model.RepettiveMotions;

                stop.Contacting = model.Contacting;

                stop.PositionsToWork = model.PositionsToWork;

                stop.ContactSharpObject = model.ContactSharpObject;

                stop.FlyingObjects = model.FlyingObjects;

                stop.ContactingElectric = model.ContactingElectric;

                stop.EmployeeWork = model.EmployeeWork;

                stop.NotRight = model.NotRight;

                stop.Unknow = model.Unknow;

                stop.UsedIncorrectly = model.UsedIncorrectly;

                stop.NotUnderstood = model.NotUnderstood;

                stop.InUnsafeCondition = model.InUnsafeCondition;

                stop.NotFlowed = model.NotFlowed;

                stop.NotAequate = model.NotAequate;

                stop.OtherProcedure = model.OtherProcedure;

                stop.OtherTools = model.OtherTools;

                stop.NotIsolate = model.NotIsolate;

                stop.ToolAndEquipment = model.ToolAndEquipment;

                stop.NoCollectGarbage = model.NoCollectGarbage;

                stop.EmergencyExit = model.EmergencyExit;

                stop.Slip = model.Slip;

                stop.OtherOderLine = model.OtherOderLine;

                stop.CreatedBy = model.CreatedBy;

                stop.External = model.External;

                stop.DUNG_CU_THIET_BI = model.DUNG_CU_THIET_BI;

                stop.KHU_VUC_LAM_VIEC = model.KHU_VUC_LAM_VIEC;

                stop.MOI_TRUONG_LAM_VIEC = model.MOI_TRUONG_LAM_VIEC;

                stop.SACH_SE_NGAN_NAP = model.SACH_SE_NGAN_NAP;

                stop.LOAI_CONG_VIEC = model.LOAI_CONG_VIEC;

                stop.HO_TEN_CA_NHAN_TO_NHOM = model.HO_TEN_CA_NHAN_TO_NHOM;

                stop.HANH_DONG_HANH_VI_AN_TOAN = model.HANH_DONG_HANH_VI_AN_TOAN;

                stop.HANH_VI_KHONG_AN_TOAN = model.HANH_VI_KHONG_AN_TOAN;

                stop.KHAC_PHUC_TUC_THI = "";

                stop.APPROVAL_USER = model.APPROVAL_USER;

                stop.IS_APPROVED = model.IS_APPROVED;

                stop.TOtherOrderliness = model.TOtherOrderliness;

                stop.TOtherPPE = model.TOtherPPE;

                stop.TOtherProcedure = model.TOtherProcedure;

                stop.TOtherReactions = model.TOtherReactions;

                stop.TOtherToolAndEquipment = model.TOtherToolAndEquipment;

                stop.Description = model.Description;

                stop.REPORT_PARENT = model.REPORT_PARENT;
                stop.IS_DELETE = model.IS_DELETE;

                stop.NGUOILIENQUAN1 = model.NGUOILIENQUAN1;

                stop.NGUOILIENQUAN2 = model.NGUOILIENQUAN2;
                stop.Image_1 = model.Image_1;

                db.ST_StopCard.Add(stop);
                db.SaveChanges();


                List<ST_StopCard1> stop1 = new List<ST_StopCard1>();
                model.StopCard1.ForEach(x =>
                        {
                            stop1.Add(new ST_StopCard1
                            {
                                StopCardID = stop.ID,
                                LOAIYEUCAU = x.LOAIYEUCAU,
                                MUCUUTIEN = x.MUCUUTIEN,
                                NGUYENNHAN = x.NGUYENNHAN,
                                PersonIncharge = x.PersonIncharge,
                                PersonReport = x.PersonReport,
                                PreventiveAction = x.PreventiveAction,
                                Status = x.Status,
                                THIETBI = x.THIETBI,
                                CompletedDate = x.CompletedDate,
                                Deadline = x.Deadline,
                                Description = x.Description,
                                ID = x.ID
                            });
                        });
                db.ST_StopCard1.AddRange(stop1);
                db.SaveChanges();


                List<ST_StopCard2> stop2 = new List<ST_StopCard2>();
                model.StopCard2.ForEach(x =>
                {
                    stop2.Add(new ST_StopCard2
                    {
                        StopCardID = stop.ID,
                        LOAIYEUCAU = x.LOAIYEUCAU,
                        MUCUUTIEN = x.MUCUUTIEN,
                        NGUYENNHAN = x.NGUYENNHAN,
                        PersonIncharge = x.PersonIncharge,
                        PersonReport = x.PersonReport,
                        PermanentAction = x.PermanentAction,
                        Status = x.Status,
                        THIETBI = x.THIETBI,
                        CompletedDate = x.CompletedDate,
                        Deadline = x.Deadline,
                        Description = x.Description,
                        ID = x.ID
                    });
                });
                db.ST_StopCard2.AddRange(stop2);
                db.SaveChanges();

                return stop.ID;
            }
            catch
            {
                return -1;
            }
        }
        public bool EditStopCard(StopCardViewModel model)
        {
            try
            {

                ST_StopCard stop = new ST_StopCard();
                stop.ID = model.ID;
                stop.DocNum = model.DocNum;
                stop.DocDate = Convert.ToDateTime(model.sDocDate, new CultureInfo("vi-vn"));
                stop.DocTime = Convert.ToDateTime(model.DocTime, new CultureInfo("vi-vn"));
                stop.AdjPerPPE = model.AdjPerPPE;
                stop.StopJob = model.StopJob;
                stop.ChangingPosition = model.ChangingPosition;
                stop.RearrangingJob = model.RearrangingJob;
                stop.AttachingGrouds = model.AttachingGrouds;
                stop.PerformingLocks = model.PerformingLocks;
                stop.OtherReaction = model.OtherReaction;
                stop.Head = model.Head;
                stop.ArmsAndHands = model.ArmsAndHands;
                stop.EyesAndFace = model.EyesAndFace;
                stop.Trunk = model.Trunk;
                stop.Ears = model.Ears;
                stop.LegsAndFeet = model.LegsAndFeet;
                stop.RespiratorySystem = model.RespiratorySystem;
                stop.OtherPPE = model.OtherPPE;
                stop.HPES1 = model.HPES1;
                stop.HPES2 = model.HPES2;
                stop.HPES3 = model.HPES3;
                stop.HPES4 = model.HPES4;
                stop.HPES5 = model.HPES5;
                stop.HPES6 = model.HPES6;
                stop.StrikingAgaintObjects = model.StrikingAgaintObjects;
                stop.ChokingHazardousAir = model.ChokingHazardousAir;
                stop.CaughtInOn = model.CaughtInOn;
                stop.Inhaling = model.Inhaling;
                stop.Falling = model.Falling;
                stop.RepettiveMotions = model.RepettiveMotions;
                stop.Contacting = model.Contacting;
                stop.PositionsToWork = model.PositionsToWork;
                stop.ContactSharpObject = model.ContactSharpObject;
                stop.FlyingObjects = model.FlyingObjects;
                stop.ContactingElectric = model.ContactingElectric;
                stop.EmployeeWork = model.EmployeeWork;
                stop.NotRight = model.NotRight;
                stop.Unknow = model.Unknow;
                stop.UsedIncorrectly = model.UsedIncorrectly;
                stop.NotUnderstood = model.NotUnderstood;
                stop.InUnsafeCondition = model.InUnsafeCondition;
                stop.NotFlowed = model.NotFlowed;
                stop.NotAequate = model.NotAequate;
                stop.OtherProcedure = model.OtherProcedure;
                stop.OtherTools = model.OtherTools;
                stop.NotIsolate = model.NotIsolate;
                stop.ToolAndEquipment = model.ToolAndEquipment;
                stop.NoCollectGarbage = model.NoCollectGarbage;
                stop.EmergencyExit = model.EmergencyExit;
                stop.Slip = model.Slip;
                stop.OtherOderLine = model.OtherOderLine;
                stop.CreatedBy = model.CreatedBy;
                stop.External = model.External;
                stop.DUNG_CU_THIET_BI = model.DUNG_CU_THIET_BI;
                stop.KHU_VUC_LAM_VIEC = model.KHU_VUC_LAM_VIEC;
                stop.MOI_TRUONG_LAM_VIEC = model.MOI_TRUONG_LAM_VIEC;
                stop.SACH_SE_NGAN_NAP = model.SACH_SE_NGAN_NAP;
                stop.LOAI_CONG_VIEC = model.LOAI_CONG_VIEC;
                stop.HO_TEN_CA_NHAN_TO_NHOM = model.HO_TEN_CA_NHAN_TO_NHOM;
                stop.HANH_DONG_HANH_VI_AN_TOAN = model.HANH_DONG_HANH_VI_AN_TOAN;
                stop.HANH_VI_KHONG_AN_TOAN = model.HANH_VI_KHONG_AN_TOAN;
                stop.KHAC_PHUC_TUC_THI = model.KHAC_PHUC_TUC_THI;
                stop.APPROVAL_USER = model.APPROVAL_USER;
                stop.IS_APPROVED = model.IS_APPROVED;
                stop.TOtherOrderliness = model.TOtherOrderliness;
                stop.TOtherPPE = model.TOtherPPE;
                stop.TOtherProcedure = model.TOtherProcedure;
                stop.TOtherReactions = model.TOtherReactions;
                stop.TOtherToolAndEquipment = model.TOtherToolAndEquipment;
                stop.Description = model.Description;
                stop.REPORT_PARENT = model.REPORT_PARENT;
                stop.IS_DELETE = model.IS_DELETE;
                stop.NGUOILIENQUAN1 = model.NGUOILIENQUAN1;
                stop.NGUOILIENQUAN2 = model.NGUOILIENQUAN2;
                stop.Image_1 = model.Image_1;


                db.ST_StopCard.Attach(stop);

                db.Entry(stop).Property(x => x.AdjPerPPE).IsModified = true;
                db.Entry(stop).Property(x => x.StopJob).IsModified = true;
                db.Entry(stop).Property(x => x.ChangingPosition).IsModified = true;
                db.Entry(stop).Property(x => x.RearrangingJob).IsModified = true;
                db.Entry(stop).Property(x => x.AttachingGrouds).IsModified = true;
                db.Entry(stop).Property(x => x.PerformingLocks).IsModified = true;
                db.Entry(stop).Property(x => x.OtherReaction).IsModified = true;
                db.Entry(stop).Property(x => x.Head).IsModified = true;
                db.Entry(stop).Property(x => x.ArmsAndHands).IsModified = true;
                db.Entry(stop).Property(x => x.EyesAndFace).IsModified = true;
                db.Entry(stop).Property(x => x.Trunk).IsModified = true;
                db.Entry(stop).Property(x => x.Ears).IsModified = true;
                db.Entry(stop).Property(x => x.LegsAndFeet).IsModified = true;
                db.Entry(stop).Property(x => x.RespiratorySystem).IsModified = true;
                db.Entry(stop).Property(x => x.OtherPPE).IsModified = true;
                db.Entry(stop).Property(x => x.HPES1).IsModified = true;
                db.Entry(stop).Property(x => x.HPES2).IsModified = true;
                db.Entry(stop).Property(x => x.HPES3).IsModified = true;
                db.Entry(stop).Property(x => x.HPES4).IsModified = true;
                db.Entry(stop).Property(x => x.HPES5).IsModified = true;
                db.Entry(stop).Property(x => x.HPES6).IsModified = true;
                db.Entry(stop).Property(x => x.StrikingAgaintObjects).IsModified = true;
                db.Entry(stop).Property(x => x.ChokingHazardousAir).IsModified = true;
                db.Entry(stop).Property(x => x.CaughtInOn).IsModified = true;
                db.Entry(stop).Property(x => x.Inhaling).IsModified = true;
                db.Entry(stop).Property(x => x.Falling).IsModified = true;
                db.Entry(stop).Property(x => x.RepettiveMotions).IsModified = true;
                db.Entry(stop).Property(x => x.Contacting).IsModified = true;
                db.Entry(stop).Property(x => x.PositionsToWork).IsModified = true;
                db.Entry(stop).Property(x => x.ContactSharpObject).IsModified = true;
                db.Entry(stop).Property(x => x.FlyingObjects).IsModified = true;
                db.Entry(stop).Property(x => x.ContactingElectric).IsModified = true;
                db.Entry(stop).Property(x => x.EmployeeWork).IsModified = true;
                db.Entry(stop).Property(x => x.NotRight).IsModified = true;
                db.Entry(stop).Property(x => x.Unknow).IsModified = true;
                db.Entry(stop).Property(x => x.UsedIncorrectly).IsModified = true;
                db.Entry(stop).Property(x => x.NotUnderstood).IsModified = true;
                db.Entry(stop).Property(x => x.InUnsafeCondition).IsModified = true;
                db.Entry(stop).Property(x => x.NotFlowed).IsModified = true;
                db.Entry(stop).Property(x => x.NotAequate).IsModified = true;
                db.Entry(stop).Property(x => x.OtherProcedure).IsModified = true;
                db.Entry(stop).Property(x => x.OtherTools).IsModified = true;
                db.Entry(stop).Property(x => x.NotIsolate).IsModified = true;
                db.Entry(stop).Property(x => x.ToolAndEquipment).IsModified = true;
                db.Entry(stop).Property(x => x.NoCollectGarbage).IsModified = true;
                db.Entry(stop).Property(x => x.EmergencyExit).IsModified = true;
                db.Entry(stop).Property(x => x.Slip).IsModified = true;
                db.Entry(stop).Property(x => x.OtherOderLine).IsModified = true;
                db.Entry(stop).Property(x => x.CreatedBy).IsModified = true;
                db.Entry(stop).Property(x => x.External).IsModified = true;
                db.Entry(stop).Property(x => x.DUNG_CU_THIET_BI).IsModified = true;
                db.Entry(stop).Property(x => x.KHU_VUC_LAM_VIEC).IsModified = true;
                db.Entry(stop).Property(x => x.MOI_TRUONG_LAM_VIEC).IsModified = true;
                db.Entry(stop).Property(x => x.SACH_SE_NGAN_NAP).IsModified = true;
                db.Entry(stop).Property(x => x.LOAI_CONG_VIEC).IsModified = true;
                db.Entry(stop).Property(x => x.HO_TEN_CA_NHAN_TO_NHOM).IsModified = true;
                db.Entry(stop).Property(x => x.HANH_DONG_HANH_VI_AN_TOAN).IsModified = true;
                db.Entry(stop).Property(x => x.HANH_VI_KHONG_AN_TOAN).IsModified = true;
                db.Entry(stop).Property(x => x.KHAC_PHUC_TUC_THI).IsModified = true;
                db.Entry(stop).Property(x => x.APPROVAL_USER).IsModified = true;
                db.Entry(stop).Property(x => x.IS_APPROVED).IsModified = true;
                db.Entry(stop).Property(x => x.TOtherOrderliness).IsModified = true;
                db.Entry(stop).Property(x => x.TOtherPPE).IsModified = true;
                db.Entry(stop).Property(x => x.TOtherProcedure).IsModified = true;
                db.Entry(stop).Property(x => x.TOtherReactions).IsModified = true;
                db.Entry(stop).Property(x => x.TOtherToolAndEquipment).IsModified = true;
                db.Entry(stop).Property(x => x.Description).IsModified = true;
                db.Entry(stop).Property(x => x.REPORT_PARENT).IsModified = true;
                db.Entry(stop).Property(x => x.IS_DELETE).IsModified = true;
                db.Entry(stop).Property(x => x.NGUOILIENQUAN1).IsModified = true;
                db.Entry(stop).Property(x => x.NGUOILIENQUAN2).IsModified = true;
                db.Entry(stop).Property(x => x.Image_1).IsModified = true;

                List<ST_StopCard1> stop1 = new List<ST_StopCard1>();

                model.StopCard1.ForEach(x =>
                {
                    stop1.Add(new ST_StopCard1
                    {
                        StopCardID = stop.ID,
                        LOAIYEUCAU = x.LOAIYEUCAU,
                        MUCUUTIEN = x.MUCUUTIEN,
                        NGUYENNHAN = x.NGUYENNHAN,
                        PersonIncharge = x.PersonIncharge,
                        PersonReport = x.PersonReport,
                        PreventiveAction = x.PreventiveAction,
                        Status = x.Status,
                        THIETBI = x.THIETBI,
                        CompletedDate = x.CompletedDate,
                        Deadline = x.Deadline,
                        Description = x.Description,
                        ID = x.ID
                    });
                });
                if (stop1.Count(x => x.ID < 0) > 0)
                {
                    db.ST_StopCard1.AddRange(stop1.Where(x => x.ID < -1).ToList());
                }
                else
                {
                    foreach (ST_StopCard1 item in stop1)
                    {
                        if (item.ID > 0)
                        {
                            db.ST_StopCard1.Attach(item);
                            db.Entry(item).Property(x => x.LOAIYEUCAU).IsModified = true;
                            db.Entry(item).Property(x => x.MUCUUTIEN).IsModified = true;
                            db.Entry(item).Property(x => x.NGUYENNHAN).IsModified = true;
                            db.Entry(item).Property(x => x.PersonIncharge).IsModified = true;
                            db.Entry(item).Property(x => x.PersonReport).IsModified = true;
                            db.Entry(item).Property(x => x.PreventiveAction).IsModified = true;
                            db.Entry(item).Property(x => x.THIETBI).IsModified = true;
                            db.Entry(item).Property(x => x.Description).IsModified = true;
                            db.Entry(item).Property(x => x.Status).IsModified = true;
                            db.Entry(item).Property(x => x.CompletedDate).IsModified = true;
                        }
                    }
                    db.SaveChanges();
                    var result = db.ST_StopCard1.Where(p => p.StopCardID == stop.ID);
                    foreach (var item in result)
                    {
                        if (stop1.Count(x => x.ID == item.ID) == 0)
                        {
                            db.ST_StopCard1.Remove(item);
                        }
                    }
                }
                db.SaveChanges();


                List<ST_StopCard2> stop2 = new List<ST_StopCard2>();
                model.StopCard2.ForEach(x =>
                {
                    stop2.Add(new ST_StopCard2
                    {
                        StopCardID = stop.ID,
                        LOAIYEUCAU = x.LOAIYEUCAU,
                        MUCUUTIEN = x.MUCUUTIEN,
                        NGUYENNHAN = x.NGUYENNHAN,
                        PersonIncharge = x.PersonIncharge,
                        PersonReport = x.PersonReport,
                        PermanentAction = x.PermanentAction,
                        Status = x.Status,
                        THIETBI = x.THIETBI,
                        CompletedDate = x.CompletedDate,
                        Deadline = x.Deadline,
                        Description = x.Description,
                        ID = x.ID
                    });
                });
                if (stop2.Count(x => x.ID < 0) > 0)
                {
                    db.ST_StopCard2.AddRange(stop2.Where(x => x.ID < -1).ToList());
                }
                else
                {
                    foreach (ST_StopCard2 item in stop2)
                    {
                        if (item.ID > 0)
                        {
                            db.ST_StopCard2.Attach(item);
                            db.Entry(item).Property(x => x.LOAIYEUCAU).IsModified = true;
                            db.Entry(item).Property(x => x.MUCUUTIEN).IsModified = true;
                            db.Entry(item).Property(x => x.NGUYENNHAN).IsModified = true;
                            db.Entry(item).Property(x => x.PersonIncharge).IsModified = true;
                            db.Entry(item).Property(x => x.PersonReport).IsModified = true;
                            db.Entry(item).Property(x => x.PermanentAction).IsModified = true;
                            db.Entry(item).Property(x => x.THIETBI).IsModified = true;
                            db.Entry(item).Property(x => x.Description).IsModified = true;
                            db.Entry(item).Property(x => x.Status).IsModified = true;
                            db.Entry(item).Property(x => x.CompletedDate).IsModified = true;
                        }
                    }
                    db.SaveChanges();
                    var result = db.ST_StopCard2.Where(p => p.StopCardID == stop.ID);
                    foreach (var item in result)
                    {
                        if (stop2.Count(x => x.ID == item.ID) == 0)
                        {
                            db.ST_StopCard2.Remove(item);
                        }
                    }
                }
                db.SaveChanges();


                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
        public bool DeleteStopCard(int ID)
        {
            try
            {
                db.ST_StopCard2.RemoveRange(db.ST_StopCard2.Where(x => x.StopCardID == ID));
                db.ST_StopCard1.RemoveRange(db.ST_StopCard1.Where(x => x.StopCardID == ID));
                db.ST_StopCard.Remove(db.ST_StopCard.Where(x => x.ID == ID).FirstOrDefault());
                db.SaveChanges();
                return true;
            }
            catch
            {
                return false;
            }

        }
        public string fnGetListMailApprovalST(string ID, string ReportParent, string Username)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", Username);
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", ReportParent);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_StopCard";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch (Exception ex)
            {
                return "";
            }
        }
        public string fnGetListMailApprovalAndCreatedByST(string ID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL_CREATE_BY");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_StopCard";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch (Exception ex)
            {
                return "";
            }
        }
        public string fnGetListMailInchargeST(string ID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_INCHARGE");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_StopCard";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public DataTable fnGetListActionDoneST(string ID, string reportID,string reportID2)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_ACTION_DONE");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("RID", reportID);
                sqlcom.Parameters.AddWithValue("RID2", reportID2);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_HazardReport";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return new DataTable();
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0];
                else
                    return new DataTable();
            }
            catch
            {
                return new DataTable();
            }
        }
        public DataTable fnGetListActionST(string ID)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_ACTION");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_StopCard";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return new DataTable();
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0];
                else
                    return new DataTable();
            }
            catch
            {
                return new DataTable();
            }
        }

        public string fnGET_DEAR_APPROVALST(string ID, string Username, string ReportParent)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", Username);
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", ReportParent);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_StopCard";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }
        public string fnGET_DEAR_INCHARGEST(string ID, string Username, string ReportParent)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_INCHARGE");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", Username);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_StopCard";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }

        public string GET_DEAR_APPROVAL_CREATE_BYST(string ID, string UserName, string ReportParent)
        {
            try
            {
                DataTable dt = new DataTable();
                SqlCommand sqlcom = new SqlCommand();
                SqlConnection con = new SqlConnection(DBUtils.BizConnectionString());
                if (con.State == ConnectionState.Closed)
                    con.Open();
                sqlcom.Connection = con;
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL_CREATE_BY");
                sqlcom.Parameters.AddWithValue("ID", ID);
                sqlcom.Parameters.AddWithValue("USER", UserName);
                sqlcom.CommandType = CommandType.StoredProcedure;
                sqlcom.CommandText = "VS_ST_StopCard";
                SqlDataAdapter da = new SqlDataAdapter(sqlcom);
                DataSet ds = new DataSet();
                da.Fill(ds);
                if (ds.Tables.Count == 0)
                    return "";
                else if (ds.Tables[0].Rows.Count > 0)
                    return ds.Tables[0].Rows[0][0].ToString();
                else
                    return "";
            }
            catch
            {
                return "";
            }
        }

        public ST_StopCard StopCard(int ID) => db.ST_StopCard.Where(x => x.ID == ID).FirstOrDefault();


        #endregion

        #region Leader Ship
        public List<LeaderShipViewModel>  GetListLeaderShipDetails(string User,DateTime DateCreate)
        {
            List<LeaderShipViewModel> list = null;
            try
            {
                List<SqlParameter> listParameter = new List<SqlParameter>();
                listParameter.Add(new SqlParameter("USER_NAME", User));
                listParameter.Add(new SqlParameter("DateCreate", DateCreate));
                list = DBUtils.ExecuteSPList<LeaderShipViewModel>("VS_LEADERSHIPDETAILS1", listParameter, AppName.Model1);
                return list;
            }
            catch
            {
                return null;
            }
        }

        public bool SaveLeaderShipDetails(List<LeaderShipViewModel> model,string User, DateTime NgayTao)
        {
            try
            {
                List<LeadershipDetail> listDetails = new List<LeadershipDetail>();
                model.ForEach(x=>{
                    listDetails.Add(new LeadershipDetail { 
                    IDLeadership = x.IDLeadership,
                    DateCreate = NgayTao,
                    UserName = User,
                    Yes =x.Yes,
                    No =x.No,
                    NA =x.NA
                    });
                });
                db.LeadershipDetails.RemoveRange(db.LeadershipDetails.Where(x=>x.UserName == User && DbFunctions.TruncateTime(x.DateCreate) == DbFunctions.TruncateTime(NgayTao)));
                db.LeadershipDetails.AddRange(listDetails);
                return true;
            }
            catch
            {
                return false;
            }

        }

        #endregion


        private bool disposed = false;
        protected void Dispose(bool disposing)
        {
            if (!this.disposed)
            {
                if (disposing)
                {
                    db.Dispose();
                }
            }
            this.disposed = true;
        }

        public void Dispose()
        {
            Dispose(true);
            GC.SuppressFinalize(this);
        }
    }
}