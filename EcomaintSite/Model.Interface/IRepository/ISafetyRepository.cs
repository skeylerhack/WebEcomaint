﻿using Model.Data;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
namespace Model.Interface.IRepository
{
    public interface ISafetyRepository
    {
        IEnumerable<ChooseListHazard> ChooseListHazard(string tngay, string dngay);
        HazardReportViewModel GetListByID(string ID);
        string GetSoPhieuHazard();
        List<HazardReportViewModel.HazardReport1ViewModel> GetListDetail(string ID);
        int AddInsertHazardrepot(HazardReportViewModel model);
        bool EditHazardrepot(HazardReportViewModel model);
        bool Delete(int ID);
        bool fnCheckAdminUser(string UserName);
        bool fnCheckApprovalUser(string UserName,string form);
        bool CheckSameDepartment(string CreateBy, string ReportParent);
        bool fnCheckCancelApproval(string UserName, string ID);

        string fnGetListMailApproval(string ID, string ReportParent, string Username);
        string fnGetListMailIncharge(string ID);
        string fnGetListMailApprovalAndCreatedBy(string ID);

        string fnGET_DEAR_APPROVAL(string ID, string Username, string ReportParent);
        string fnGET_DEAR_INCHARGE(string ID, string Username, string ReportParent);
        string fnGetApproval(string ID, string User, string ReportParent);
        string GET_DEAR_APPROVAL_CREATE_BY(string ID, string UserName, string ReportParent);
        string fnGetReporter(string ID, string User, string ReportParent);
        DataTable fnGetListAction(string ID);
        DataTable fnGetListActionDone(string ID, string reportID);
        ST_HazardReport HazardReport(int ID);
        string GetDepartmentbyReportParent(string User);
        string GetIDSafery(string Username);
        string GetIDDepartment(string Username);
        

        #region stopcard
        string GetSoPhieuStopCart();
        IEnumerable<ChooseListStopCard> ChooseListStopCard(string tngay, string dngay);
        StopCardViewModel GetListStopCardByID(string ID);
        List<StopCardViewModel.StopCard1ViewModel> GetListStopCardDetail1(string ID);
        List<StopCardViewModel.StopCard2ViewModel> GetListStopCardDetail2(string ID);
        int AddStopCard(StopCardViewModel model);
        bool EditStopCard(StopCardViewModel model);
        bool DeleteStopCard(int ID);
        string fnGetListMailApprovalST(string ID, string ReportParent, string Username);
        string fnGetListMailApprovalAndCreatedByST(string ID);
        string fnGetListMailInchargeST(string ID);
        DataTable fnGetListActionST(string ID);
        DataTable fnGetListActionDoneST(string ID, string reportID, string reportID2);
        string fnGET_DEAR_APPROVALST(string ID, string Username, string ReportParent);
        string fnGET_DEAR_INCHARGEST(string ID, string Username, string ReportParent);
        string GET_DEAR_APPROVAL_CREATE_BYST(string ID, string UserName, string ReportParent);
        ST_StopCard StopCard(int ID);
        #endregion

        #region Leader Ship
        List<LeaderShipViewModel> GetListLeaderShipDetails(string User, DateTime DateCreate);
        bool SaveLeaderShipDetails(List<LeaderShipViewModel> model, string User, DateTime NgayTao);
        bool DeleteLeaderShipDetails(string User, DateTime NgayTao);

        #endregion

    }
}
