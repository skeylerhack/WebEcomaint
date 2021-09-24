'Cap nhat ngay 28/03/2014 by Hoe
'    thêm 2 nút lệnh No control , full readonly trong tab form

' 20/05/2014  Nhat
'   Them Nhom To Phong Ban 

' 26/05/2014 Nhat
'   Them copy phan quyen + user chuc nang


Imports Commons.VS.Classes.Admin
Imports VS.Object
Imports System.Data.SqlClient
Imports Microsoft.ApplicationBlocks.Data

Imports Commons.VS.Security

Public Class frmNhomquyen
#Region "BIẾN"

    Private blnThem As Integer = -1
    Private intRow2 As Integer = 0
    Private bCo31 As Boolean = False
    Private bCo32 As Boolean = False
    Private bCol33 As Boolean = False
    Private intRow31 As Integer = 0
    Private intRow32 As Integer = 0
    Private intRow33 As Integer = 0
    Private bCo41 As Boolean = False
    Private bCo42 As Boolean = False
    Private intRow41 As Integer = 0
    Private intRow42 As Integer = 0
    Private bCo61 As Boolean = False
    Private bCo62 As Boolean = False
    Private intRow61 As Integer = 0
    Private intRow62 As Integer = 0
    Private bCo11 As Boolean = False
    Private intRow11 As Integer = 0
    Private bCo51 As Boolean = False
    Private bCo52 As Boolean = False
    Private intRow51 As Integer = 0
    Private intRow52 As Integer = 0
    Private bSua As Boolean = False
    Private bBPCP As Boolean = False


    Private Isnull As Boolean

    Private strUserName As String = ""
#End Region
    Dim isFirst As Boolean = False
    Private sql As String
    Private dtNNgu As DataTable


    Private Sub frmNhomquyen_FormClosing(ByVal sender As Object, ByVal e As System.Windows.Forms.FormClosingEventArgs) Handles Me.FormClosing
        Commons.Modules.ObjSystems.XoaTable("REPORT_DATA" + Commons.Modules.UserName)
        Commons.Modules.ObjSystems.XoaTable("LIC_DATA_REPORT" + Commons.Modules.UserName)
    End Sub

    Private Sub frmNhomquyen_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Commons.Modules.PermisString = Commons.Modules.ObjGroups.GetNHOM_FORM_QUYEN(Commons.Modules.UserName, Me.Name)
        LoadListUser()
        Me.KeyPreview = True
        cboLoaiLic.Display = "TEN_LIC"
        cboLoaiLic.Value = "TYPE_LIC"
        cboLoaiLic.StoreName = "MGetLicType"
        cboLoaiLic.Param = Commons.Modules.TypeLanguage
        cboLoaiLic.BindDataSource()

        BindData()
        If grdListOfGroup.RowCount > 0 Then
            txtGroupID.Text = grdListOfGroup.Rows(0).Cells("GROUP_ID").Value
            txtGroupName.Text = grdListOfGroup.Rows(0).Cells("GROUP_NAME").Value
            txtDescription.Text = grdListOfGroup.Rows(0).Cells("DESCRIPTION").Value
            cboLoaiLic.SelectedValue = grdListOfGroup.Rows(0).Cells("TYPE_LIC").Value
        End If


        VisibleButton(True)
        LockData(True)

        BindData2()

        BindData31()
        BindData33()

        VisibleButton31(True)
        BindData32()
        VisibleButton32(True)

        BindData41()
        VisibleButton41(True)
        BindData42()
        VisibleButton42(True)

        BindData61()
        VisibleButton61(True)

        BindData62()
        VisibleButton62(True)

        BindDataBPCP()
        VisibleButtonBPCP(True)

        BindData11()
        VisibleButton11(True)

        BindData51()
        EnableControl(False)

        Bind_cboLoaibaocao()
        Bind_Report()

        LoadcmbDepartment()
        LoadcmbNV()
        BindData1(txtGroupID.Text)

        VisibleButton51(True)
        VisibleButton52(True)
        If Me.grdListOfGroup.RowCount > 0 Then
            Me.grdListOfGroup.Rows(0).Cells("GROUP_NAME").Selected = True
        End If
        Try
            Commons.Modules.PermisString = Commons.Modules.ObjGroups.GetNHOM_FORM_QUYEN(Commons.Modules.UserName, Me.Name)
            If Commons.Modules.PermisString.Equals("Read only") Then
                EnableControlAll(False)
            Else
                EnableControlAll(True)
            End If

            LoadUserDN()
            LoadNN()
        Catch ex As Exception

        End Try

    End Sub

    Private Function GetNN(ByVal dtNN As DataTable, ByVal sKeyWord As String) As String
        If dtNN Is Nothing Then
            Return ""
            Exit Function
        End If

        Dim sNN As String = ""
        Try
            If CInt(dtNN.Rows(0)(2).ToString) <> Commons.Modules.TypeLanguage Then LoadNN()
            sNN = CType(dtNN.Select("KEYWORD = '" & sKeyWord & "'"), DataRow())(0)(1).ToString()


        Catch ex As Exception
            sNN = ""
        End Try

        If sNN = "" Then
            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, (" INSERT INTO [LANGUAGES]([MS_MODULE],[FORM],[KEYWORD],[VIETNAM],[ENGLISH],[CHINESE]," & _
                    " [FORM_HAY_REPORT],[VIETNAM_OR],[ENGLISH_OR],[CHINESE_OR]) " & _
                    " VALUES(N'" + Commons.Modules.ModuleName + "',N'" + Me.Name + "',N'" + sKeyWord + "',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@'," & _
                    " 0,N'@" + sKeyWord + "@',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@')"))
            sNN = "@" + sKeyWord + "@"
        End If

        Return sNN

    End Function

    Private Sub LoadDataNN()
        dtNNgu = New DataTable
        dtNNgu.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT KEYWORD , CASE " & Commons.Modules.TypeLanguage & _
                " WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END AS NN , CONVERT(INT," & Commons.Modules.TypeLanguage.ToString & ") AS NNGU " & _
                " FROM LANGUAGES WHERE FORM = N'" & Me.Name & "' "))

    End Sub

    Private Sub LoadNN()
        LoadDataNN()
        'Btn1ChonDC.Text = GetNN(dtNNgu, Btn1ChonDC.Name)
        'Btn1ChonDD.Text = GetNN(dtNNgu, Btn1ChonDD.Name)
        'Btn2KhongChonDC.Text = GetNN(dtNNgu, Btn2KhongChonDC.Name)
        'Btn3KhongChonDD.Text = GetNN(dtNNgu, Btn3KhongChonDD.Name)
        'Btn4TroVe.Text = GetNN(dtNNgu, Btn4TroVe.Name)
        btnAdd.Text = GetNN(dtNNgu, btnAdd.Name)
        BtnChonAll.Text = GetNN(dtNNgu, BtnChonAll.Name)
        'BtnChonAll31.Text = GetNN(dtNNgu, BtnChonAll31.Name)
        'BtnChonAll32.Text = GetNN(dtNNgu, BtnChonAll32.Name)
        'BtnChonAll41.Text = GetNN(dtNNgu, BtnChonAll41.Name)
        'BtnChonAll42.Text = GetNN(dtNNgu, BtnChonAll42.Name)
        BtnChonAll51.Text = GetNN(dtNNgu, BtnChonAll51.Name)
        'BtnChonAll61.Text = GetNN(dtNNgu, BtnChonAll61.Name)
        'BtnChonAll62.Text = GetNN(dtNNgu, BtnChonAll62.Name)
        'btnChonAllBPCP.Text = GetNN(dtNNgu, btnChonAllBPCP.Name)
        btnChuyenNhom.Text = GetNN(dtNNgu, btnChuyenNhom.Name)

        'btnCopyBPCP.Text = GetNN(dtNNgu, btnCopyBPCP.Name)
        btnCopyChucNangUser.Text = GetNN(dtNNgu, btnCopyChucNangUser.Name)
        btnCopyForm.Text = GetNN(dtNNgu, btnCopyForm.Name)
        btnCopyMenu.Text = GetNN(dtNNgu, btnCopyMenu.Name)
        'btnCopyNhomHT.Text = GetNN(dtNNgu, btnCopyNhomHT.Name)
        'btnCopyNhomKho.Text = GetNN(dtNNgu, btnCopyNhomKho.Name)
        'btnCopyNhomLMay.Text = GetNN(dtNNgu, btnCopyNhomLMay.Name)
        'btnCopyNhomLoaiCV.Text = GetNN(dtNNgu, btnCopyNhomLoaiCV.Name)
        'btnCopyNhomLoaiPT.Text = GetNN(dtNNgu, btnCopyNhomLoaiPT.Name)
        'btnCopyNhomNX.Text = GetNN(dtNNgu, btnCopyNhomNX.Name)
        'btnCopyNhomReport.Text = GetNN(dtNNgu, btnCopyNhomReport.Name)
        'btnCopyNhomToPhongBan.Text = GetNN(dtNNgu, btnCopyNhomToPhongBan.Name)
        btnDelete.Text = GetNN(dtNNgu, btnDelete.Name)
        BtnGhi11.Text = GetNN(dtNNgu, BtnGhi11.Name)
        BtnGhi2.Text = GetNN(dtNNgu, BtnGhi2.Name)
        'BtnGhi31.Text = GetNN(dtNNgu, BtnGhi31.Name)
        'BtnGhi32.Text = GetNN(dtNNgu, BtnGhi32.Name)
        'BtnGhi41.Text = GetNN(dtNNgu, BtnGhi41.Name)
        'BtnGhi42.Text = GetNN(dtNNgu, BtnGhi42.Name)
        BtnGhi51.Text = GetNN(dtNNgu, BtnGhi51.Name)
        BtnGhi52.Text = GetNN(dtNNgu, BtnGhi52.Name)
        'BtnGhi61.Text = GetNN(dtNNgu, BtnGhi61.Name)
        'BtnGhi62.Text = GetNN(dtNNgu, BtnGhi62.Name)
        'btnGhi8.Text = GetNN(dtNNgu, btnGhi8.Name)
        'btnGhiBPCP.Text = GetNN(dtNNgu, btnGhiBPCP.Name)
        BtnKhong.Text = GetNN(dtNNgu, BtnKhong.Name)
        BtnKhong11.Text = GetNN(dtNNgu, BtnKhong11.Name)
        'BtnKhong31.Text = GetNN(dtNNgu, BtnKhong31.Name)
        'BtnKhong32.Text = GetNN(dtNNgu, BtnKhong32.Name)
        'BtnKhong41.Text = GetNN(dtNNgu, BtnKhong41.Name)
        'BtnKhong42.Text = GetNN(dtNNgu, BtnKhong42.Name)
        BtnKhong51.Text = GetNN(dtNNgu, BtnKhong51.Name)
        BtnKhong52.Text = GetNN(dtNNgu, BtnKhong52.Name)
        'BtnKhong61.Text = GetNN(dtNNgu, BtnKhong61.Name)
        'BtnKhong62.Text = GetNN(dtNNgu, BtnKhong62.Name)
        'btnKhongAllBPCP.Text = GetNN(dtNNgu, btnKhongAllBPCP.Name)
        'btnKhongBPCP.Text = GetNN(dtNNgu, btnKhongBPCP.Name)
        'BtnKhongChon31.Text = GetNN(dtNNgu, BtnKhongChon31.Name)
        BtnKhongChonAll.Text = GetNN(dtNNgu, BtnKhongChonAll.Name)
        'BtnKhongchonAll32.Text = GetNN(dtNNgu, BtnKhongchonAll32.Name)
        'BtnKhongChonAll41.Text = GetNN(dtNNgu, BtnKhongChonAll41.Name)
        'BtnKhongChonAll42.Text = GetNN(dtNNgu, BtnKhongChonAll42.Name)
        BtnKhongChonAll51.Text = GetNN(dtNNgu, BtnKhongChonAll51.Name)
        'BtnKhongChonAll61.Text = GetNN(dtNNgu, BtnKhongChonAll61.Name)
        'BtnKhongChonAll62.Text = GetNN(dtNNgu, BtnKhongChonAll62.Name)
        btnSave.Text = GetNN(dtNNgu, btnSave.Name)
        BtnSua.Text = GetNN(dtNNgu, BtnSua.Name)
        BtnSua51.Text = GetNN(dtNNgu, BtnSua51.Name)
        BtnThem11.Text = GetNN(dtNNgu, BtnThem11.Name)
        'BtnThem31.Text = GetNN(dtNNgu, BtnThem31.Name)
        'BtnThem32.Text = GetNN(dtNNgu, BtnThem32.Name)
        'BtnThem41.Text = GetNN(dtNNgu, BtnThem41.Name)
        'BtnThem42.Text = GetNN(dtNNgu, BtnThem42.Name)
        BtnThem51.Text = GetNN(dtNNgu, BtnThem51.Name)
        BtnThem52.Text = GetNN(dtNNgu, BtnThem52.Name)
        'BtnThem61.Text = GetNN(dtNNgu, BtnThem61.Name)
        'BtnThem62.Text = GetNN(dtNNgu, BtnThem62.Name)
        'btnThemBPCP.Text = GetNN(dtNNgu, btnThemBPCP.Name)
        BtnThoat.Text = GetNN(dtNNgu, BtnThoat.Name)
        BtnXoa11.Text = GetNN(dtNNgu, BtnXoa11.Name)
        'BtnXoa31.Text = GetNN(dtNNgu, BtnXoa31.Name)
        'BtnXoa32.Text = GetNN(dtNNgu, BtnXoa32.Name)
        'BtnXoa41.Text = GetNN(dtNNgu, BtnXoa41.Name)
        'BtnXoa42.Text = GetNN(dtNNgu, BtnXoa42.Name)
        BtnXoa51.Text = GetNN(dtNNgu, BtnXoa51.Name)
        BtnXoa52.Text = GetNN(dtNNgu, BtnXoa52.Name)
        'BtnXoa61.Text = GetNN(dtNNgu, BtnXoa61.Name)
        'BtnXoa62.Text = GetNN(dtNNgu, BtnXoa62.Name)
        'btnXoaBPCP.Text = GetNN(dtNNgu, btnXoaBPCP.Name)
        'chkAccess.Text = GetNN(dtNNgu, chkAccess.Name)
        chkActive.Text = GetNN(dtNNgu, chkActive.Name)
        chkAll.Text = GetNN(dtNNgu, chkAll.Name)
        'chkDenyAll.Text = GetNN(dtNNgu, chkDenyAll.Name)
        chkFullReadonly.Text = GetNN(dtNNgu, chkFullReadonly.Name)
        chkNoControl.Text = GetNN(dtNNgu, chkNoControl.Name)



        'GroupBox1.Text = GetNN(dtNNgu, GroupBox1.Name)
        'grpBoPhanChiuPhi.Text = GetNN(dtNNgu, grpBoPhanChiuPhi.Name)
        grpDanhsachform.Text = GetNN(dtNNgu, grpDanhsachform.Name)
        'grpDanhsachKho.Text = GetNN(dtNNgu, grpDanhsachKho.Name)
        grpDanhsachusers.Text = GetNN(dtNNgu, grpDanhsachusers.Name)
        grpListOfGroup.Text = GetNN(dtNNgu, grpListOfGroup.Name)
        'grpListofReport.Text = GetNN(dtNNgu, grpListofReport.Name)
        grpListofusers.Text = GetNN(dtNNgu, grpListofusers.Name)
        grpListUser.Text = GetNN(dtNNgu, grpListUser.Name)
        grpNhapThongTinUser.Text = GetNN(dtNNgu, grpNhapThongTinUser.Name)
        'grpPermissionReport.Text = GetNN(dtNNgu, grpPermissionReport.Name)
        grpQuyen.Text = GetNN(dtNNgu, grpQuyen.Name)
        'grpQuyenTrenDayTruyen.Text = GetNN(dtNNgu, grpQuyenTrenDayTruyen.Name)
        'grpQuyenTrenKhuVuc.Text = GetNN(dtNNgu, grpQuyenTrenKhuVuc.Name)
        'grpQuyenTrenLoaiCongViec.Text = GetNN(dtNNgu, grpQuyenTrenLoaiCongViec.Name)
        'grpQuyenTrenLoaiMay.Text = GetNN(dtNNgu, grpQuyenTrenLoaiMay.Name)
        grpQuyentrenmenu.Text = GetNN(dtNNgu, grpQuyentrenmenu.Name)
        'grpQuyenTrennoiSuDungVatTu.Text = GetNN(dtNNgu, grpQuyenTrennoiSuDungVatTu.Name)
        grpQuyenXetDuyet.Text = GetNN(dtNNgu, grpQuyenXetDuyet.Name)

        lblCNhan.Text = GetNN(dtNNgu, lblCNhan.Name)
        lblConfirmPassword.Text = GetNN(dtNNgu, lblConfirmPassword.Name)
        lblDepartment.Text = GetNN(dtNNgu, lblDepartment.Name)
        lblDescription.Text = GetNN(dtNNgu, lblDescription.Name)
        lblDescription5.Text = GetNN(dtNNgu, lblDescription5.Name)

        lblFullName.Text = GetNN(dtNNgu, lblFullName.Name)
        lblGroupName.Text = GetNN(dtNNgu, lblGroupName.Name)
        lblMail.Text = GetNN(dtNNgu, lblMail.Name)

        lblPassword.Text = GetNN(dtNNgu, lblPassword.Name)

        lblTenUser.Text = GetNN(dtNNgu, lblTenUser.Name)
        lblTitleGroup.Text = GetNN(dtNNgu, lblTitleGroup.Name)
        lblTypeLic.Text = GetNN(dtNNgu, lblTypeLic.Name)
        lblUsername.Text = GetNN(dtNNgu, lblUsername.Name)


        'rad_Access.Text = GetNN(dtNNgu, rad_Access.Name)
        'rad_noAccess.Text = GetNN(dtNNgu, rad_noAccess.Name)
        rdFullAccess.Text = GetNN(dtNNgu, rdFullAccess.Name)

        rdNoAccess.Text = GetNN(dtNNgu, rdNoAccess.Name)

        rdReadOnly.Text = GetNN(dtNNgu, rdReadOnly.Name)


        'tabBPCP.Text = GetNN(dtNNgu, tabBPCP.Name)
        'TabEquipmentData.Text = GetNN(dtNNgu, TabEquipmentData.Name)
        TabFormusing.Text = GetNN(dtNNgu, TabFormusing.Name)
        tabListUser.Text = GetNN(dtNNgu, tabListUser.Name)
        TabMenu.Text = GetNN(dtNNgu, TabMenu.Name)
        'tabReport.Text = GetNN(dtNNgu, tabReport.Name)
        tabUserDangNhap.Text = GetNN(dtNNgu, tabUserDangNhap.Name)
        TabUsergroups.Text = GetNN(dtNNgu, TabUsergroups.Name)
        TabUsers.Text = GetNN(dtNNgu, TabUsers.Name)
        'TabWarehouse.Text = GetNN(dtNNgu, TabWarehouse.Name)
        'TabWork.Text = GetNN(dtNNgu, TabWork.Name)

        RefeshLanguage01()
        RefeshLanguage02()
        RefeshLanguage2()
        RefeshLanguage11()
        RefeshLanguage31()
        RefeshLanguage32()
        RefeshLanguage33()
        RefeshLanguage41()
        RefeshLanguage42()
        RefeshLanguage51()
        RefeshLanguage52()
        RefeshLanguage61()
        RefeshLanguage62()

        RefeshLanguageBPCP()
        refreshLangugue_of_grdReport()

        LoadNNDataGrid(dtNNgu, grdUser)

        LoadNNDataGrid(dtNNgu, grdListUser)


    End Sub


    Private Sub LoadNNDataGrid(ByVal dtNN As DataTable, ByVal grd As DataGridView)
        For Each col As DataGridViewColumn In grd.Columns
            col.HeaderText = GetNN(dtNN, col.Name)
        Next
        grd.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        grd.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
    End Sub

    Sub RefeshLanguage01()

        Me.grdListOfGroup.Columns("GROUP_NAME").HeaderText = GetNN(dtNNgu, "GROUP_NAME")
        Me.grdListOfGroup.Columns("DESCRIPTION").HeaderText = GetNN(dtNNgu, "DESCRIPTION")
        Me.grdListOfGroup.Columns("TEN_LIC").HeaderText = GetNN(dtNNgu, "TEN_LIC")
    End Sub
    Sub RefeshLanguage02()
        Me.grdDanhsachuser.Columns("USERNAME").HeaderText = GetNN(dtNNgu, "USERNAME")
        Me.grdDanhsachuser.Columns("FULL_NAME").HeaderText = GetNN(dtNNgu, "FULL_NAME")
        Me.grdDanhsachuser.Columns("DESCRIPTION").HeaderText = GetNN(dtNNgu, "DESCRIPTION")
        Me.grdDanhsachuser.Columns("TEN_TO").HeaderText = GetNN(dtNNgu, "TEN_TO")
        Me.grdDanhsachuser.Columns("HO_TEN").HeaderText = GetNN(dtNNgu, "HO_TEN")
        Me.grdDanhsachuser.Columns("USER_MAIL").HeaderText = GetNN(dtNNgu, "USER_MAIL")
        Me.grdDanhsachuser.Columns("ACTIVE").HeaderText = GetNN(dtNNgu, "ACTIVE")
    End Sub
    Sub RefeshLanguage2()

        Me.grdDanhsachform.Columns("TEN_FORM").HeaderText = GetNN(dtNNgu, "TEN_FORM")
        Me.grdDanhsachform.Columns("QUYEN").HeaderText = GetNN(dtNNgu, "QUYEN")
    End Sub
    Sub RefeshLanguage11()
        Try
            Me.grdQuyentrenmenu.Columns("MENU_NAME").HeaderText = GetNN(dtNNgu, "MENU_NAME")
            Me.grdQuyentrenmenu.Columns("MENU_NAME").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
            Me.grdQuyentrenmenu.Columns("CHON").HeaderText = GetNN(dtNNgu, "CHON")
        Catch ex As Exception

        End Try

    End Sub
    Sub RefeshLanguage31()

        Try
            'Me.grdQuyenTrenKhuVuc.Columns("TeN_N_XUONG").HeaderText = GetNN(dtNNgu, "TeN_N_XUONG")
            'Me.grdQuyenTrenKhuVuc.Columns("MS_N_XUONG").HeaderText = GetNN(dtNNgu, "MS_N_XUONG")
            'Me.grdQuyenTrenKhuVuc.Columns("TINH").HeaderText = GetNN(dtNNgu, "TINH")
            'Me.grdQuyenTrenKhuVuc.Columns("QUAN").HeaderText = GetNN(dtNNgu, "QUAN")
            'Me.grdQuyenTrenKhuVuc.Columns("DIA_CHI").HeaderText = GetNN(dtNNgu, "DIA_CHI")
            'Me.grdQuyenTrenKhuVuc.Columns("CHON").HeaderText = GetNN(dtNNgu, "CHON")
        Catch ex As Exception

        End Try

    End Sub
    Sub RefeshLanguage32()
        Try
            'Me.grdQuyenTrenLoaiMay.Columns("TEN_LOAI_MAY").HeaderText = GetNN(dtNNgu, "TEN_LOAI_MAY")
            'Me.grdQuyenTrenLoaiMay.Columns("CHON2").HeaderText = GetNN(dtNNgu, "CHON")
        Catch ex As Exception
        End Try

    End Sub
    Sub RefeshLanguage33()

        Try
            'Me.grdQuyenTrenDayTruyen.Columns("TEN_HE_THONG").HeaderText = GetNN(dtNNgu, "TEN_HE_THONG")
            'Me.grdQuyenTrenDayTruyen.Columns("CHON1").HeaderText = GetNN(dtNNgu, "CHON")
        Catch ex As Exception

        End Try

    End Sub
    Sub RefeshLanguage41()

        Try
            'Me.grdQuyenTrenLoaiCongViec.Columns("TEN_LOAI_CV").HeaderText = GetNN(dtNNgu, "TEN_LOAI_CV")
            'Me.grdQuyenTrenLoaiCongViec.Columns("CHON").HeaderText = GetNN(dtNNgu, "CHON")
        Catch ex As Exception

        End Try

    End Sub
    Sub RefeshLanguage42()
        Try
            'Me.grdQuyenTrennoiSuDungVatTu.Columns("TEN_LOAI_PT").HeaderText = GetNN(dtNNgu, "TEN_LOAI_PT")
            'Me.grdQuyenTrennoiSuDungVatTu.Columns("CHON").HeaderText = GetNN(dtNNgu, "CHON")
        Catch ex As Exception

        End Try

    End Sub
    Sub RefeshLanguage51()
        Try

            Me.grdDanhsachusers.Columns("USERNAME").HeaderText = GetNN(dtNNgu, "USERNAME")
            Me.grdDanhsachusers.Columns("FULL_NAME").HeaderText = GetNN(dtNNgu, "FULL_NAME")
            Me.grdDanhsachusers.Columns("TEN_TO").HeaderText = GetNN(dtNNgu, "TEN_TO")
            Me.grdDanhsachusers.Columns("USER_MAIL").HeaderText = GetNN(dtNNgu, "USER_MAIL")
            Me.grdDanhsachusers.Columns("HO_TEN").HeaderText = GetNN(dtNNgu, "HO_TEN")
        Catch ex As Exception

        End Try
    End Sub
    Sub RefeshLanguage52()

        Try
            Me.grdDanhsachQuyenxetduyet.Columns("TEN_CHUC_NANG").HeaderText = GetNN(dtNNgu, "TEN_CHUC_NANG")
            Me.grdDanhsachQuyenxetduyet.Columns("CHON").HeaderText = GetNN(dtNNgu, "CHON")
        Catch ex As Exception

        End Try

    End Sub

    Sub EnableControlAll(ByVal chon As Boolean)
        btnAdd.Enabled = chon
        BtnThem11.Enabled = chon
        'BtnThem31.Enabled = chon
        'BtnThem32.Enabled = chon
        'BtnThem41.Enabled = chon
        'BtnThem42.Enabled = chon
        BtnThem51.Enabled = chon
        BtnThem52.Enabled = chon
        'BtnThem61.Enabled = chon
        BtnXoa11.Enabled = chon
        'BtnXoa31.Enabled = chon
        'BtnXoa32.Enabled = chon
        'BtnXoa41.Enabled = chon
        'BtnXoa42.Enabled = chon
        BtnXoa51.Enabled = chon
        BtnXoa52.Enabled = chon
        'BtnXoa61.Enabled = chon
        BtnGhi2.Enabled = chon
        'btnGhi8.Enabled = chon
        BtnSua51.Enabled = chon
        BtnSua.Enabled = chon
        btnDelete.Enabled = chon
    End Sub

    Sub LoadcboGroupID()
        cboGroupID.Display = "GROUP_NAME"
        cboGroupID.Value = "GROUP_ID"
        cboGroupID.StoreName = "GetNHOMs"
        cboGroupID.BindDataSource()
    End Sub

#Region "user groups"
    Sub BindData(Optional ByVal iNhom As String = "-1")
        Dim index As Integer
        Dim dt As New DataTable()
        Try
            dt.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "MGetNhom", Commons.Modules.TypeLanguage))
        Catch ex As Exception
        End Try
        dt.PrimaryKey = New DataColumn() {dt.Columns("GROUP_NAME")}
        index = dt.Rows.IndexOf(dt.Rows.Find(iNhom))

        grdListOfGroup.DataSource = dt
        If iNhom <> "-1" Then
            Try
                grdListOfGroup.CurrentCell = grdListOfGroup.Rows(index).Cells("GROUP_NAME")
            Catch ex As Exception
            End Try
        End If

        grdListOfGroup.Columns("GROUP_ID").Visible = False
        grdListOfGroup.Columns("TYPE_LIC").Visible = False
        If grdListOfGroup.Rows.Count > 0 Then
            btnDelete.Enabled = True
        Else
            btnDelete.Enabled = False
        End If
        Try
            Me.grdListOfGroup.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
            Me.grdListOfGroup.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        Catch ex As Exception

        End Try
    End Sub
    Sub BindData1(ByVal intGroupID As Integer)
        Try
            grdDanhsachuser.DataSource = New Commons.OGroups().GetUSERofGROUPs(intGroupID)
            grdDanhsachuser.Columns("GROUP_ID").Visible = False
            grdDanhsachuser.Columns("PASS").Visible = False
            grdDanhsachuser.Columns("MS_TO").Visible = False
            grdDanhsachuser.Columns("MS_CONG_NHAN").Visible = False
            grdDanhsachuser.Columns("USERNAME").Width = 100
            grdDanhsachuser.Columns("FULL_NAME").Width = 100
            grdDanhsachuser.Columns("DESCRIPTION").Width = 150
            grdDanhsachuser.Columns("TEN_TO").Width = 100
            grdDanhsachuser.Columns("HO_TEN").Width = 150
            grdDanhsachuser.Columns("USERNAME").Frozen = True

            grdDanhsachuser.Columns("FULL_NAME").AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
            grdDanhsachuser.Columns("DESCRIPTION").AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
            grdDanhsachuser.Columns("HO_TEN").AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
            grdDanhsachuser.Columns("TEN_TO").AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
            grdDanhsachuser.Columns("USER_MAIL").AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells

        Catch ex As Exception

        End Try
        Try
            Me.grdDanhsachuser.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
            Me.grdDanhsachuser.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        Catch ex As Exception

        End Try

    End Sub
    Sub ShowData_New()
        Try
            txtGroupID.Text = grdListOfGroup.CurrentRow.Cells("GROUP_ID").Value
            cboGroupID.SelectedValue = grdListOfGroup.CurrentRow.Cells("GROUP_ID").Value
            txtGroupName.Text = grdListOfGroup.CurrentRow.Cells("GROUP_NAME").Value
            txtDescription.Text = grdListOfGroup.CurrentRow.Cells("DESCRIPTION").Value
            cboLoaiLic.SelectedValue = grdListOfGroup.CurrentRow.Cells("TYPE_LIC").Value

        Catch ex As Exception

        End Try
    End Sub
    Sub VisibleButton(ByVal chon As Boolean)
        btnAdd.Visible = chon
        btnDelete.Visible = chon
        btnSave.Visible = Not chon
        BtnKhong.Visible = Not chon
        grdListOfGroup.Enabled = chon
        grdListOfGroup.ReadOnly = True
        grdDanhsachuser.ReadOnly = True
        BtnSua.Visible = chon
        BtnThoat.Enabled = chon
    End Sub
    Sub LockData(ByVal chon As Boolean)
        txtGroupName.ReadOnly = chon
        txtDescription.ReadOnly = chon
        cboLoaiLic.TextReadonly = chon

        cboLoaiLic.Enabled = Not chon
    End Sub
    Sub Refresh88()
        txtGroupName.Text = ""
        txtDescription.Text = ""
        txtGroupID.Text = ""
        cboLoaiLic.SelectedValue = "1"
    End Sub
#End Region
#Region "event user groups "
    Private Sub BindDataLast()
        Refresh5()
        ShowData_New()


        Try
            BindData1(grdListOfGroup.CurrentRow.Cells("GROUP_ID").Value)
        Catch ex As Exception
            BindData1(cboGroupID.SelectedValue)
        End Try

        BindData11()
        BindData2()
        BindData31()
        BindData32()
        BindData33()
        BindData41()
        BindData42()
        BindData51()
        Bind_Report()
        BindData61()
        BindData62()
        BindDataBPCP()
        Bind_Report()

        If Commons.Modules.PermisString.Equals("Read only") Then
            EnableControlAll(False)
        Else
            EnableControlAll(True)
        End If
    End Sub

    Private Sub btnAdd_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        txtGroupName.Visible = True
        cboGroupID.Visible = False
        blnThem = 0
        VisibleButton(False)
        LockData(False)
        Refresh88()
        Refresh5()
        BindData52()
        txtGroupName.Focus()
    End Sub

    Private Sub BtnKhong_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnKhong.Click
        VisibleButton(True)
        LockData(True)
        blnThem = -1
        bSua = False
        Try
            txtGroupID.Text = grdListOfGroup.CurrentRow.Cells("GROUP_ID").Value
            cboGroupID.SelectedValue = grdListOfGroup.CurrentRow.Cells("GROUP_ID").Value
            txtGroupName.Text = grdListOfGroup.CurrentRow.Cells("GROUP_NAME").Value
            txtDescription.Text = grdListOfGroup.CurrentRow.Cells("DESCRIPTION").Value
            cboLoaiLic.SelectedValue = grdListOfGroup.CurrentRow.Cells("TYPE_LIC").Value

        Catch ex As Exception

        End Try
        BindData(txtGroupName.Text)
        Try
            BindData1(txtGroupID.Text)
        Catch ex As Exception
        End Try
        BindData11()
        BindData2()
        BindData31()
        BindData32()
        BindData33()
        BindData41()
        BindData42()
        BindData51()
        Bind_Report()
        BindData61()
        BindData62()
        BindDataBPCP()
        Try
            txtGroupID.Text = grdListOfGroup.CurrentRow.Cells("GROUP_ID").Value
            cboGroupID.SelectedValue = grdListOfGroup.CurrentRow.Cells("GROUP_ID").Value
            txtGroupName.Text = grdListOfGroup.CurrentRow.Cells("GROUP_NAME").Value
            txtDescription.Text = grdListOfGroup.CurrentRow.Cells("DESCRIPTION").Value
            cboLoaiLic.SelectedValue = grdListOfGroup.CurrentRow.Cells("TYPE_LIC").Value

        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnSave_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSave.Click
        Dim objNHOMInfo As New Commons.IGroups()
        If txtGroupName.Text = "" Then
            MsgBox(GetNN(dtNNgu, "MsgKiemtraNULL"), MsgBoxStyle.Exclamation)
            txtGroupName.Focus()
            Exit Sub
        End If
        If cboLoaiLic.Text = "" Then
            MsgBox(GetNN(dtNNgu, "ChuaNhapLoaiLic"), MsgBoxStyle.Exclamation)
            cboLoaiLic.Focus()
            Exit Sub
        End If

        If bSua Then
            objNHOMInfo.GROUP_NAME = txtGroupName.Text
            objNHOMInfo.DESCRIPTION = txtDescription.Text
            objNHOMInfo.GROUP_ID = txtGroupID.Text
            objNHOMInfo.TYPE_LIC = cboLoaiLic.SelectedValue

            If Commons.Modules.ObjGroups.CheckExistTEN_NHOM(txtGroupID.Text, txtGroupName.Text.Trim).Read Then
                MsgBox(GetNN(dtNNgu, "MsgSameName"), MsgBoxStyle.OkOnly + MsgBoxStyle.Information, Me.Name)
                txtGroupName.Focus()
                Exit Sub
            End If

            Commons.Modules.ObjGroups.UpdateNHOM(objNHOMInfo, Me.Name, 2)
            sql = txtGroupName.Text
            bSua = False
            VisibleButton(True)
            blnThem = -1
            LockData(True)
            BindData(sql)
            BindData1(txtGroupID.Text)
            BindData11()
            BindData2()
            BindData31()
            BindData32()
            BindData33()
            BindData41()
            BindData42()
            BindData51()
            BindData61()
            BindData62()
            BindDataBPCP()
        Else
            objNHOMInfo.GROUP_NAME = txtGroupName.Text
            objNHOMInfo.DESCRIPTION = txtDescription.Text
            objNHOMInfo.TYPE_LIC = cboLoaiLic.SelectedValue

            If Commons.Modules.ObjGroups.CheckGROUP_NAME(txtGroupName.Text.Trim).Read Then
                MsgBox(GetNN(dtNNgu, "MsgSameName"), MsgBoxStyle.OkOnly + MsgBoxStyle.Information, Me.Name)
                txtGroupName.Focus()
                Exit Sub
            End If
            Dim GROUP_ID As Integer
            GROUP_ID = Commons.Modules.ObjGroups.AddNHOM(objNHOMInfo)

            Try
                SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOG", _
                    GROUP_ID, Me.Name, Commons.Modules.UserName, 1)
            Catch ex As Exception
            End Try

            VisibleButton(True)
            LockData(True)
            blnThem = -1
            BindData()
            txtGroupID.Text = GROUP_ID
            BindData1(txtGroupID.Text)
            BindData11()
            BindData2()
            BindData31()
            BindData32()
            BindData33()
            BindData41()
            BindData42()
            BindData51()
            BindData61()
            BindData62()
            BindDataBPCP()
        End If
        LoadListUser()
    End Sub

    Private Sub btnDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        If Commons.Modules.ObjGroups.CheckExistGROUP_ID(txtGroupID.Text) Then
            MsgBox(GetNN(dtNNgu, "MsgKiemtra"), MsgBoxStyle.Exclamation)
            Exit Sub
        End If
        If grdListOfGroup.Rows.Count > 0 Then
            Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
            If Traloi = vbYes Then
                SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOG", txtGroupID.Text, Me.Name, Commons.Modules.UserName, 3)

                Commons.Modules.ObjGroups.DeleteNHOMs(txtGroupID.Text)
                LoadcboGroupID()
                BindData()
                BindData1(txtGroupID.Text)
                BindData11()
                BindData2()
                BindData31()
                BindData32()
                BindData33()
                BindData41()
                BindData42()
                BindData51()
                BindData61()
                BindData62()
                BindDataBPCP()
            End If
        End If
    End Sub

    Private Sub TabNhomQuyen_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCopy2.SelectedIndexChanged

        If blnThem > -1 Then
            btnCopy2.SelectedIndex = blnThem
        End If

        If btnCopy2.SelectedTab.Name.ToUpper = "tabUserDangNhap".ToUpper Then
            LoadUserDN()
        End If
    End Sub
    Private Sub BtnSua_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnSua.Click
        txtGroupName.Visible = True
        cboGroupID.Visible = False
        blnThem = 0
        bSua = True
        VisibleButton(False)
        LockData(False)
        txtGroupName.Focus()
    End Sub
#End Region
#Region "form using"
    Sub BindData2()

        Dim dtTmp As New DataTable

        Dim sSql As String
        Dim sBT, sBTamLic As String
        sBT = "FORM_DATA" + Commons.Modules.UserName
        sBTamLic = "LIC_DATA" + Commons.Modules.UserName

        GiaiMaTable(sBTamLic, "LIC_FORM", "FORM_NAME")

        Commons.Modules.ObjSystems.XoaTable(sBT)


        If txtGroupName.Text <> "" Then
            dtTmp = New Commons.OGroups().GetCHI_TIET_FORM_QUYEN(txtGroupID.Text, Commons.Modules.TypeLanguage)
            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, sBT, dtTmp, "")

            sSql = "SELECT A.FORM_NAME, TEN_FORM , QUYEN FROM " + sBTamLic + " A INNER JOIN " + sBT + " B ON A.FORM_NAME = B.FORM_NAME  WHERE LEFT(LTRIM(TEN_FORM),1)='1' AND A.FORM_NAME NOT IN ('frmImportExcel','frmExportExcel','frmFormsetting','frmReportmailsetting') ORDER BY TEN_FORM"
            dtTmp = New DataTable
            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql))


            grdDanhsachform.DataSource = dtTmp
            grdDanhsachform.Columns("FORM_NAME").Visible = False
            If grdDanhsachform.Rows.Count > 0 Then
                BtnGhi2.Enabled = True
            Else
                BtnGhi2.Enabled = False
            End If
            Try
                grdDanhsachform.Columns("TEN_FORM").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
                grdDanhsachform.Columns("TEN_FORM").Width = 361
                grdDanhsachform.Columns("QUYEN").Width = 100
            Catch ex As Exception
            End Try
            Try
                Me.grdDanhsachform.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
                Me.grdDanhsachform.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
            Catch ex As Exception
            End Try
            RefeshLanguage2()
        End If
        Commons.Modules.ObjSystems.XoaTable(sBT)
        Commons.Modules.ObjSystems.XoaTable(sBTamLic)

    End Sub
#End Region
#Region "event form using"

    Private Sub BtnGhi2_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnGhi2.Click

        Dim iRow As Integer = grdDanhsachform.CurrentRow.Index
        Dim error1 As Integer = 0
        If chkAll.Checked Or chkNoControl.Checked Or chkFullReadonly.Checked Then
            If chkAll.Checked Then
                Try
                    For i As Integer = 0 To grdDanhsachform.Rows.Count - 1
                        error1 = i
                        If IsDBNull(grdDanhsachform.Rows(i).Cells("QUYEN").Value) Then
                            Commons.Modules.ObjGroups.AddNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, "Full access")
                            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 1)
                        Else
                            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 2)
                            Commons.Modules.ObjGroups.UpdateNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, "Full access")
                        End If
                    Next
                    chkAll.Checked = False
                Catch ex As Exception
                    MessageBox.Show(error1.ToString + ex.ToString)
                End Try
            ElseIf chkNoControl.Checked Then
                Try
                    For i As Integer = 0 To grdDanhsachform.Rows.Count - 1
                        error1 = i
                        If IsDBNull(grdDanhsachform.Rows(i).Cells("QUYEN").Value) Then
                            Commons.Modules.ObjGroups.AddNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, "No access")
                            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 1)
                        Else
                            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 2)
                            Commons.Modules.ObjGroups.UpdateNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, "No access")
                        End If
                    Next
                    chkNoControl.Checked = False
                Catch ex As Exception
                    MessageBox.Show(error1.ToString + ex.ToString)
                End Try
            ElseIf chkFullReadonly.Checked Then
                Try
                    For i As Integer = 0 To grdDanhsachform.Rows.Count - 1
                        error1 = i
                        If IsDBNull(grdDanhsachform.Rows(i).Cells("QUYEN").Value) Then
                            Commons.Modules.ObjGroups.AddNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, "Read only")
                            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 1)
                        Else
                            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 2)
                            Commons.Modules.ObjGroups.UpdateNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(i).Cells("FORM_NAME").Value, "Read only")
                        End If
                    Next
                    chkFullReadonly.Checked = False
                Catch ex As Exception
                    MessageBox.Show(error1.ToString + ex.ToString)
                End Try

            End If
        Else
            If rdNoAccess.Checked Then
                If IsDBNull(grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value) Then
                    Commons.Modules.ObjGroups.AddNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, "No access")
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 1)
                Else
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 2)
                    Commons.Modules.ObjGroups.UpdateNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, "No access")
                End If
            ElseIf rdReadOnly.Checked Then
                If IsDBNull(grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value) Then
                    Commons.Modules.ObjGroups.AddNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, "Read only")
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 1)
                Else
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 2)
                    Commons.Modules.ObjGroups.UpdateNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, "Read only")
                End If
            Else
                If IsDBNull(grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value) Then
                    Commons.Modules.ObjGroups.AddNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, "Full access")
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 1)
                Else
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_FORM_LOG", txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, Me.Name, Commons.Modules.UserName, 2)
                    Commons.Modules.ObjGroups.UpdateNHOM_FORM(txtGroupID.Text, grdDanhsachform.Rows(intRow2).Cells("FORM_NAME").Value, "Full access")
                End If
            End If
        End If
        BindData2()
        Commons.Modules.PermisString = Commons.Modules.ObjGroups.GetNHOM_FORM_QUYEN(Commons.Modules.UserName, Me.Name)
        If Commons.Modules.PermisString.Equals("Read only") Then
            EnableControlAll(False)
        Else
            EnableControlAll(True)
        End If
        grdDanhsachform.CurrentCell = grdDanhsachform.Rows(iRow).Cells("QUYEN")
    End Sub

    Private Sub grdDanhsachform_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdDanhsachform.RowEnter
        intRow2 = e.RowIndex
        If Not IsDBNull(grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value) Then
            If grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value = "Full access" Then
                rdFullAccess.Checked = True
            ElseIf grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value = "No access" Then
                rdNoAccess.Checked = True
            Else
                rdReadOnly.Checked = True
            End If
        Else
            rdFullAccess.Checked = False
            rdNoAccess.Checked = False
            rdReadOnly.Checked = False
        End If
    End Sub

    Private Sub grdDanhsachform_RowHeaderMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs) Handles grdDanhsachform.RowHeaderMouseClick
        intRow2 = e.RowIndex
        If Not IsDBNull(grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value) Then
            If grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value = "Full access" Then
                rdFullAccess.Checked = True
            ElseIf grdDanhsachform.Rows(intRow2).Cells("QUYEN").Value = "No access" Then
                rdNoAccess.Checked = True
            Else
                rdReadOnly.Checked = True
            End If
        Else
            rdFullAccess.Checked = False
            rdNoAccess.Checked = False
            rdReadOnly.Checked = False
        End If
    End Sub
#End Region
#Region "equipment data"
    Sub VisibleButton31(ByVal chon As Boolean)
        'BtnThem31.Visible = chon
        'BtnXoa31.Visible = chon
        'BtnGhi31.Visible = Not chon
        'btnCopyNhomHT.Visible = chon
        'btnCopyNhomNX.Visible = chon
        'BtnKhong31.Visible = Not chon
        'BtnChonAll31.Visible = Not chon
        'BtnKhongChon31.Visible = False
        'grdQuyenTrenKhuVuc.ReadOnly = chon
        'grdQuyenTrenDayTruyen.ReadOnly = chon
        BtnThoat.Enabled = chon
        'Btn1ChonDD.Visible = False
        'Btn1ChonDC.Visible = False
        'Btn3KhongChonDD.Visible = False
        'Btn2KhongChonDC.Visible = False
        'Btn4TroVe.Visible = False
    End Sub
    Sub VisibleButton32(ByVal chon As Boolean)
        'BtnThem32.Visible = chon
        'BtnXoa32.Visible = chon
        'BtnGhi32.Visible = Not chon
        'btnCopyNhomLMay.Visible = chon
        'BtnKhong32.Visible = Not chon
        'BtnChonAll32.Visible = Not chon
        'BtnKhongchonAll32.Visible = Not chon
        'grdQuyenTrenLoaiMay.ReadOnly = chon
        BtnThoat.Enabled = chon
    End Sub



    Sub BindData31()
        'grdQuyenTrenKhuVuc.AutoGenerateColumns = False
        Dim _dt As New DataTable
        If blnThem = -1 Then
            Try
                _dt.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetNHA_XUONG_QUYEN", txtGroupID.Text))
                _dt.Columns("CHON").ReadOnly = False
                'grdQuyenTrenKhuVuc.DataSource = _dt
                'grdQuyenTrenKhuVuc.DataSource = _dt

            Catch ex As Exception

            End Try


            'Try
            '    grdQuyenTrenKhuVuc.Columns("CHON").Visible = False

            'Catch ex As Exception
            'End Try
        Else
            Try
                _dt.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetNHOM_NHA_XUONG", txtGroupID.Text))

                _dt.Columns("CHON").ReadOnly = False
                _dt.Columns("MS_N_XUONG").ReadOnly = True
                _dt.Columns("TEN_N_XUONG").ReadOnly = True
                _dt.Columns("TINH").ReadOnly = True
                _dt.Columns("QUAN").ReadOnly = True
                _dt.Columns("DIA_CHI").ReadOnly = True
                'grdQuyenTrenKhuVuc.DataSource = _dt
                'grdQuyenTrenKhuVuc.DataSource = _dt

                'grdQuyenTrenKhuVuc.Columns("GROUP_ID").Visible = False

            Catch ex As Exception

            End Try
            'Try
            '    grdQuyenTrenKhuVuc.Columns("CHON").Visible = True

            'Catch ex As Exception
            'End Try
            'HienThi31()

        End If
        'Try
        '    grdQuyenTrenKhuVuc.Columns("MS_N_XUONG").Width = 100
        '    grdQuyenTrenKhuVuc.Columns("TINH").Width = 100
        '    grdQuyenTrenKhuVuc.Columns("QUAN").Width = 100
        '    grdQuyenTrenKhuVuc.Columns("DIA_CHI").Width = 250
        '    grdQuyenTrenKhuVuc.Columns("TEN_N_XUONG").Width = 250
        'Catch ex As Exception

        'End Try


        Dim sql As String = "SELECT PRIVATE FROM THONG_TIN_CHUNG"
        sql = SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, CommandType.Text, sql)
        'If sql <> "KIDO" Then
        '    Try
        '        grdQuyenTrenKhuVuc.Columns("MS_N_XUONG").Visible = False
        '        grdQuyenTrenKhuVuc.Columns("TINH").Visible = False
        '        grdQuyenTrenKhuVuc.Columns("QUAN").Visible = False
        '        grdQuyenTrenKhuVuc.Columns("DIA_CHI").Visible = False
        '        grdQuyenTrenKhuVuc.Columns("TEN_N_XUONG").Frozen = False
        '        grdQuyenTrenKhuVuc.Columns("TEN_N_XUONG").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
        '    Catch ex As Exception

        '    End Try
        'End If
        'If (grdQuyenTrenKhuVuc.RowCount > 0 Or grdQuyenTrenDayTruyen.Rows.Count > 0) Then
        '    BtnXoa31.Enabled = True
        'Else
        '    BtnXoa31.Enabled = False
        'End If
        'Try
        '    Me.grdQuyenTrenKhuVuc.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        '    Me.grdQuyenTrenKhuVuc.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        'Catch ex As Exception
        'End Try
        RefeshLanguage31()
    End Sub
    Sub BindData32()
        Dim _dt As New DataTable

        If blnThem = -1 Then
            Try


                _dt = New Commons.OGroups().GetNHOM_LOAI_MAY(txtGroupID.Text)
                _dt.Columns("CHON").ReadOnly = False

                'grdQuyenTrenLoaiMay.DataSource = _dt
            Catch ex As Exception

            End Try
            'Try
            '    grdQuyenTrenLoaiMay.Columns("CHON2").Visible = False
            'Catch ex As Exception
            'End Try
        Else
            Try




                _dt = New Commons.OGroups().GetLOAI_MAY_QUYEN(txtGroupID.Text)
                _dt.Columns("CHON").ReadOnly = False
                _dt.Columns("TEN_LOAI_MAY").ReadOnly = True
                'grdQuyenTrenLoaiMay.DataSource = _dt
            Catch ex As Exception

            End Try

            'Try
            '    grdQuyenTrenLoaiMay.Columns("CHON2").Visible = True
            'Catch ex As Exception
            'End Try

        End If
        'grdQuyenTrenLoaiMay.Columns("MS_LOAI_MAY").Visible = False
        'If grdQuyenTrenLoaiMay.Rows.Count > 0 Then
        '    BtnXoa32.Enabled = True
        'Else
        '    BtnXoa32.Enabled = False
        'End If
        'Try
        '    grdQuyenTrenLoaiMay.Columns("TEN_LOAI_MAY").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
        '    Me.grdQuyenTrenLoaiMay.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        '    Me.grdQuyenTrenLoaiMay.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        'Catch ex As Exception
        'End Try
        RefeshLanguage32()
    End Sub
    '------------------------

    Sub BindData33()
        'grdQuyenTrenDayTruyen.AutoGenerateColumns = False
        Dim _dt As New DataTable
        If blnThem = -1 Then
            Try
                _dt = New Commons.OGroups().GetHE_THONG_QUYEN(txtGroupID.Text)
                _dt.Columns("CHON").ReadOnly = False
                'grdQuyenTrenDayTruyen.DataSource = _dt
            Catch ex As Exception

            End Try
            'Try
            '    grdQuyenTrenDayTruyen.Columns("CHON1").Visible = False
            'Catch ex As Exception
            'End Try
        Else
            Try


                _dt = New Commons.OGroups().GetNHOM_HE_THONG(txtGroupID.Text)
                _dt.Columns("CHON").ReadOnly = False
                _dt.Columns("TEN_HE_THONG").ReadOnly = True
                'grdQuyenTrenDayTruyen.DataSource = _dt
            Catch ex As Exception

            End Try

            'Try
            '    grdQuyenTrenDayTruyen.Columns("CHON1").Visible = True
            'Catch ex As Exception
            'End Try

        End If
        'grdQuyenTrenDayTruyen.Columns("MS_HE_THONG").Visible = False
        'If (grdQuyenTrenLoaiMay.Rows.Count > 0 Or grdQuyenTrenDayTruyen.Rows.Count > 0) Then
        '    BtnXoa31.Enabled = True
        'Else
        '    BtnXoa31.Enabled = False
        'End If
        'Try
        '    Me.grdQuyenTrenDayTruyen.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        '    Me.grdQuyenTrenDayTruyen.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        '    grdQuyenTrenDayTruyen.Columns("TEN_HE_THONG").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
        'Catch ex As Exception
        'End Try
        RefeshLanguage33()
    End Sub


#End Region
#Region "event equipment data"

    Private Sub BtnThem31_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 And txtGroupID.Text <> "" Then
            blnThem = 3
            VisibleButton31(False)
            BindData31()
            BindData33() ' grid
        End If
    End Sub

    Private Sub BtnKhong31_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        blnThem = -1
        VisibleButton31(True)
        BindData31()
        BindData33()
    End Sub
    ' Ghi
    Private Sub BtnGhi31_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrenKhuVuc.Rows.Count - 1

        '    If Not IsDBNull(grdQuyenTrenKhuVuc.Rows(i).Cells("GROUP_ID").Value) And Not grdQuyenTrenKhuVuc.Rows(i).Cells("CHON").Value Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_NHA_XUONG_LOG", grdQuyenTrenKhuVuc.Rows(i).Cells("GROUP_ID").Value, grdQuyenTrenKhuVuc.Rows(i).Cells("MS_N_XUONG").Value, Me.Name, Commons.Modules.UserName, 3)
        '        Commons.Modules.ObjGroups.DeleteNHOM_NHA_XUONG(grdQuyenTrenKhuVuc.Rows(i).Cells("GROUP_ID").Value, grdQuyenTrenKhuVuc.Rows(i).Cells("MS_N_XUONG").Value)
        '    ElseIf IsDBNull(grdQuyenTrenKhuVuc.Rows(i).Cells("GROUP_ID").Value) And grdQuyenTrenKhuVuc.Rows(i).Cells("CHON").Value Then
        '        Commons.Modules.ObjGroups.AddNHOM_NHA_XUONG(txtGroupID.Text, grdQuyenTrenKhuVuc.Rows(i).Cells("MS_N_XUONG").Value)
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_NHA_XUONG_LOG", txtGroupID.Text, grdQuyenTrenKhuVuc.Rows(i).Cells("MS_N_XUONG").Value, Me.Name, Commons.Modules.UserName, 1)
        '    End If
        'Next
        '' xu ly cho day truyen
        'For i As Integer = 0 To grdQuyenTrenDayTruyen.Rows.Count - 1

        '    If Not IsDBNull(grdQuyenTrenDayTruyen.Rows(i).Cells("GROUP_ID1").Value) And Not grdQuyenTrenDayTruyen.Rows(i).Cells("CHON1").Value Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_HE_THONG_CT_LOG", grdQuyenTrenDayTruyen.Rows(i).Cells("GROUP_ID1").Value, grdQuyenTrenDayTruyen.Rows(i).Cells("MS_HE_THONG").Value, Me.Name, Commons.Modules.UserName, 3)
        '        Commons.Modules.ObjGroups.DeleteNHOM_HE_THONG(grdQuyenTrenDayTruyen.Rows(i).Cells("GROUP_ID1").Value, grdQuyenTrenDayTruyen.Rows(i).Cells("MS_HE_THONG").Value)
        '    ElseIf IsDBNull(grdQuyenTrenDayTruyen.Rows(i).Cells("GROUP_ID1").Value) And grdQuyenTrenDayTruyen.Rows(i).Cells("CHON1").Value Then
        '        Commons.Modules.ObjGroups.AddNHOM_HE_THONG(txtGroupID.Text, grdQuyenTrenDayTruyen.Rows(i).Cells("MS_HE_THONG").Value)
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_HE_THONG_CT_LOG", txtGroupID.Text, grdQuyenTrenDayTruyen.Rows(i).Cells("MS_HE_THONG").Value, Me.Name, Commons.Modules.UserName, 1)
        '    End If
        'Next
        blnThem = -1
        VisibleButton31(True)
        BindData31()
        BindData33()
    End Sub
    Private Sub BtnKhongChon31_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrenKhuVuc.Rows.Count - 1
        '    grdQuyenTrenKhuVuc.Rows(i).Cells("CHON").Value = False
        'Next
        'For i As Integer = 0 To grdQuyenTrenDayTruyen.Rows.Count - 1
        '    grdQuyenTrenDayTruyen.Rows(i).Cells("CHON").Value = False
        'Next

    End Sub

    Private Sub BtnChonAll31_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'BtnChonAll31.Visible = False

        'BtnKhongChon31.Visible = False
        'BtnGhi31.Visible = False
        'BtnKhong31.Visible = False

        'Btn1ChonDD.Visible = True
        'Btn3KhongChonDD.Visible = True
        'Btn1ChonDC.Visible = True
        'Btn2KhongChonDC.Visible = True
        'Btn4TroVe.Visible = True






    End Sub
    Private Sub BtnXoa31_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 Then
            ' quyen tren khu vuc
            If (intRow31 >= 0) Then
                'If grdQuyenTrenKhuVuc.Rows.Count > 0 Then
                '    Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa31"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
                '    If Traloi = vbYes Then
                '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_NHA_XUONG_LOG", txtGroupID.Text, grdQuyenTrenKhuVuc.Rows(intRow31).Cells("MS_N_XUONG").Value, Me.Name, Commons.Modules.UserName, 3)
                '        Commons.Modules.ObjGroups.DeleteNHOM_NHA_XUONG(txtGroupID.Text, grdQuyenTrenKhuVuc.Rows(intRow31).Cells("MS_N_XUONG").Value)
                '        BindData31()

                '    End If
                'End If
            End If
            ' Quyen tren day truyen
            If (intRow33 >= 0) Then
                'If grdQuyenTrenDayTruyen.Rows.Count > 0 Then
                '    Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa33"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
                '    If Traloi = vbYes Then
                '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_HE_THONG_CT_LOG", txtGroupID.Text, grdQuyenTrenDayTruyen.Rows(intRow33).Cells("MS_HE_THONG").Value, Me.Name, Commons.Modules.UserName, 3)
                '        Commons.Modules.ObjGroups.DeleteNHOM_HE_THONG(txtGroupID.Text, grdQuyenTrenDayTruyen.Rows(intRow33).Cells("MS_HE_THONG").Value)
                '        BindData33()
                '    End If
                'End If
            End If

        End If
    End Sub



    Private Sub BtnThem32_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 And txtGroupID.Text <> "" Then
            blnThem = 3
            VisibleButton32(False)
            BindData32()
        End If
    End Sub

    Private Sub BtnXoa32_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 Then
            'If grdQuyenTrenLoaiMay.Rows.Count > 0 Then
            '    Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa32"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
            '    If Traloi = vbYes Then
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_MAY_CT_LOG", txtGroupID.Text, grdQuyenTrenLoaiMay.CurrentRow.Cells("MS_LOAI_MAY").Value, Me.Name, Commons.Modules.UserName, 3)
            '        Commons.Modules.ObjGroups.DeleteNHOM_LOAI_MAY(txtGroupID.Text, grdQuyenTrenLoaiMay.CurrentRow.Cells("MS_LOAI_MAY").Value)
            '        BindData32()
            '    End If
            'End If
        End If
    End Sub

    Private Sub BtnGhi32_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrenLoaiMay.Rows.Count - 1

        '    If Not IsDBNull(grdQuyenTrenLoaiMay.Rows(i).Cells("GROUP_ID2").Value) And Not grdQuyenTrenLoaiMay.Rows(i).Cells("CHON2").Value Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_MAY_CT_LOG", grdQuyenTrenLoaiMay.Rows(i).Cells("GROUP_ID2").Value, grdQuyenTrenLoaiMay.Rows(i).Cells("MS_LOAI_MAY").Value, Me.Name, Commons.Modules.UserName, 3)
        '        Commons.Modules.ObjGroups.DeleteNHOM_LOAI_MAY(grdQuyenTrenLoaiMay.Rows(i).Cells("GROUP_ID2").Value, grdQuyenTrenLoaiMay.Rows(i).Cells("MS_LOAI_MAY").Value)
        '    ElseIf IsDBNull(grdQuyenTrenLoaiMay.Rows(i).Cells("GROUP_ID2").Value) And grdQuyenTrenLoaiMay.Rows(i).Cells("CHON2").Value Then

        '        Commons.Modules.ObjGroups.AddNHOM_LOAI_MAY(txtGroupID.Text, grdQuyenTrenLoaiMay.Rows(i).Cells("MS_LOAI_MAY").Value)
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_MAY_CT_LOG", txtGroupID.Text, grdQuyenTrenLoaiMay.Rows(i).Cells("MS_LOAI_MAY").Value, Me.Name, Commons.Modules.UserName, 1)
        '    End If
        'Next
        blnThem = -1
        VisibleButton32(True)
        BindData32()
    End Sub
    Private Sub BtnKhongchonAll32_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrenLoaiMay.Rows.Count - 1
        '    grdQuyenTrenLoaiMay.Rows(i).Cells("CHON2").Value = False
        'Next
    End Sub

    Private Sub BtnChonAll32_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrenLoaiMay.Rows.Count - 1
        '    grdQuyenTrenLoaiMay.Rows(i).Cells("CHON2").Value = True
        'Next
    End Sub

    Private Sub BtnKhong32_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        blnThem = -1
        VisibleButton32(True)
        BindData32()
    End Sub
#End Region
#Region "work"
    Sub VisibleButton41(ByVal chon As Boolean)
        'BtnThem41.Visible = chon
        'BtnXoa41.Visible = chon
        'BtnGhi41.Visible = Not chon
        'btnCopyNhomLoaiCV.Visible = chon
        'BtnKhong41.Visible = Not chon
        'BtnChonAll41.Visible = Not chon
        'BtnKhongChonAll41.Visible = Not chon
        'grdQuyenTrenLoaiCongViec.ReadOnly = chon
        BtnThoat.Enabled = chon
    End Sub
    Sub VisibleButton42(ByVal chon As Boolean)
        'BtnThem42.Visible = chon
        'BtnXoa42.Visible = chon
        'BtnGhi42.Visible = Not chon
        'btnCopyNhomLoaiPT.Visible = chon
        'BtnKhong42.Visible = Not chon
        'BtnChonAll42.Visible = Not chon
        'BtnKhongChonAll42.Visible = Not chon
        'grdQuyenTrennoiSuDungVatTu.ReadOnly = chon
        BtnThoat.Enabled = chon
    End Sub
    Sub CreatechkGiatri41()
        Dim chkGiatri As New DataGridViewCheckBoxColumn()
        chkGiatri.Name = "CHON"
        'grdQuyenTrenLoaiCongViec.Columns.Insert(2, chkGiatri)
    End Sub
    Sub HienThi41()
        'For j As Integer = 0 To grdQuyenTrenLoaiCongViec.Rows.Count - 1
        '    If Not IsDBNull(grdQuyenTrenLoaiCongViec.Rows(j).Cells("GROUP_ID").Value) Then
        '        grdQuyenTrenLoaiCongViec.Rows(j).Cells("CHON").Value = True
        '    End If
        'Next
    End Sub
    Sub CreatechkGiatri42()
        Dim chkGiatri As New DataGridViewCheckBoxColumn()
        chkGiatri.Name = "CHON"
        'grdQuyenTrennoiSuDungVatTu.Columns.Insert(2, chkGiatri)
    End Sub
    Sub HienThi42()
        'For j As Integer = 0 To grdQuyenTrennoiSuDungVatTu.Rows.Count - 1
        '    If Not IsDBNull(grdQuyenTrennoiSuDungVatTu.Rows(j).Cells("GROUP_ID").Value) Then
        '        grdQuyenTrennoiSuDungVatTu.Rows(j).Cells("CHON").Value = True
        '    End If
        'Next
    End Sub
    Sub BindData41()
        If blnThem = -1 Then
            'Try
            '    grdQuyenTrenLoaiCongViec.DataSource = New Commons.OGroups().GetNHOM_LOAI_CONG_VIEC(txtGroupID.Text)

            '    grdQuyenTrenLoaiCongViec.Columns("CHON").Visible = False
            'Catch ex As Exception
            'End Try
        Else
            'Try
            '    grdQuyenTrenLoaiCongViec.DataSource = New Commons.OGroups().GetLOAI_CONG_VIEC_QUYEN(txtGroupID.Text)
            '    grdQuyenTrenLoaiCongViec.Columns("GROUP_ID").Visible = False




            '    grdQuyenTrenLoaiCongViec.Columns("CHON").Visible = True
            'Catch ex As Exception
            'End Try
            If Not bCo41 Then
                CreatechkGiatri41()
                bCo41 = True
            End If
            HienThi41()
        End If



        'If grdQuyenTrenLoaiCongViec.Rows.Count > 0 Then
        '    BtnXoa41.Enabled = True
        'Else
        '    BtnXoa41.Enabled = False
        'End If
        'Try
        '    grdQuyenTrenLoaiCongViec.Columns("MS_LOAI_CV").Visible = False
        '    Me.grdQuyenTrenLoaiCongViec.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        '    Me.grdQuyenTrenLoaiCongViec.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        'Catch ex As Exception
        'End Try
        RefeshLanguage41()
    End Sub
    Sub BindData42()
        If blnThem = -1 Then
            'Try
            '    grdQuyenTrennoiSuDungVatTu.DataSource = New Commons.OGroups().GetNHOM_LOAI_PHU_TUNG(txtGroupID.Text)
            '    grdQuyenTrennoiSuDungVatTu.Columns("CHON").Visible = False
            'Catch ex As Exception
            'End Try
        Else
            'Try
            '    grdQuyenTrennoiSuDungVatTu.DataSource = New Commons.OGroups().GetLOAI_PHU_TUNG_QUYEN(txtGroupID.Text)
            '    grdQuyenTrennoiSuDungVatTu.Columns("GROUP_ID").Visible = False
            'Catch ex As Exception
            'End Try
            If Not bCo42 Then
                CreatechkGiatri42()
                bCo42 = True
            End If
            'Try
            '    grdQuyenTrennoiSuDungVatTu.Columns("CHON").Visible = True
            'Catch ex As Exception
            'End Try
            HienThi42()
        End If

        'If grdQuyenTrennoiSuDungVatTu.Rows.Count > 0 Then
        '    BtnXoa42.Enabled = True
        'Else
        '    BtnXoa42.Enabled = False
        'End If
        'Try
        '    grdQuyenTrennoiSuDungVatTu.Columns("MS_LOAI_PT").Visible = False
        '    Me.grdQuyenTrennoiSuDungVatTu.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        '    Me.grdQuyenTrennoiSuDungVatTu.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        'Catch ex As Exception
        'End Try
        RefeshLanguage42()
    End Sub
#End Region
#Region "event work"

    Private Sub BtnThem41_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 And txtGroupID.Text <> "" Then
            blnThem = 4
            VisibleButton41(False)
            BindData41()
        End If
    End Sub

    Private Sub BtnXoa41_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 Then
            'If grdQuyenTrenLoaiCongViec.Rows.Count > 0 Then
            '    Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa41"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
            '    If Traloi = vbYes Then
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_CONG_VIEC_LOG", txtGroupID.Text, grdQuyenTrenLoaiCongViec.Rows(intRow41).Cells("MS_LOAI_CV").Value, Me.Name, Commons.Modules.UserName, 3)
            '        Commons.Modules.ObjGroups.DeleteNHOM_LOAI_CV(txtGroupID.Text, grdQuyenTrenLoaiCongViec.Rows(intRow41).Cells("MS_LOAI_CV").Value)
            '        BindData41()
            '    End If
            'End If
        End If
    End Sub

    Private Sub BtnGhi41_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrenLoaiCongViec.Rows.Count - 1

        '    If Not IsDBNull(grdQuyenTrenLoaiCongViec.Rows(i).Cells("GROUP_ID").Value) And Not grdQuyenTrenLoaiCongViec.Rows(i).Cells("CHON").Value Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_CONG_VIEC_LOG", grdQuyenTrenLoaiCongViec.Rows(i).Cells("GROUP_ID").Value, grdQuyenTrenLoaiCongViec.Rows(i).Cells("MS_LOAI_CV").Value, Me.Name, Commons.Modules.UserName, 3)
        '        Commons.Modules.ObjGroups.DeleteNHOM_LOAI_CV(grdQuyenTrenLoaiCongViec.Rows(i).Cells("GROUP_ID").Value, grdQuyenTrenLoaiCongViec.Rows(i).Cells("MS_LOAI_CV").Value)
        '    ElseIf IsDBNull(grdQuyenTrenLoaiCongViec.Rows(i).Cells("GROUP_ID").Value) And grdQuyenTrenLoaiCongViec.Rows(i).Cells("CHON").Value Then
        '        Commons.Modules.ObjGroups.AddNHOM_LOAI_CV(txtGroupID.Text, grdQuyenTrenLoaiCongViec.Rows(i).Cells("MS_LOAI_CV").Value)
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_CONG_VIEC_LOG", txtGroupID.Text, grdQuyenTrenLoaiCongViec.Rows(i).Cells("MS_LOAI_CV").Value, Me.Name, Commons.Modules.UserName, 1)
        '    End If
        'Next
        blnThem = -1
        VisibleButton41(True)
        BindData41()
    End Sub
    Private Sub BtnChonAll41_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrenLoaiCongViec.Rows.Count - 1
        '    grdQuyenTrenLoaiCongViec.Rows(i).Cells("CHON").Value = True
        'Next
    End Sub

    Private Sub BtnKhongChonAll41_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrenLoaiCongViec.Rows.Count - 1
        '    grdQuyenTrenLoaiCongViec.Rows(i).Cells("CHON").Value = False
        'Next
    End Sub
    Private Sub BtnKhong41_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        blnThem = -1
        VisibleButton41(True)
        BindData41()
    End Sub

    Private Sub BtnThem42_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 And txtGroupID.Text <> "" Then
            blnThem = 4
            VisibleButton42(False)
            BindData42()
        End If
    End Sub

    Private Sub BtnXoa42_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 Then
            'If grdQuyenTrennoiSuDungVatTu.Rows.Count > 0 Then
            '    Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa42"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
            '    If Traloi = vbYes Then
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_PHU_TUNG_LOG", txtGroupID.Text, grdQuyenTrennoiSuDungVatTu.Rows(intRow42).Cells("MS_LOAI_PT").Value, Me.Name, Commons.Modules.UserName, 3)
            '        Commons.Modules.ObjGroups.DeleteNHOM_LOAI_PHU_TUNG(txtGroupID.Text, grdQuyenTrennoiSuDungVatTu.Rows(intRow42).Cells("MS_LOAI_PT").Value)
            '        BindData42()
            '    End If
            'End If
        End If
    End Sub

    Private Sub BtnGhi42_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrennoiSuDungVatTu.Rows.Count - 1

        '    If Not IsDBNull(grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("GROUP_ID").Value) And Not grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("CHON").Value Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_PHU_TUNG_LOG", grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("GROUP_ID").Value, grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("MS_LOAI_PT").Value, Me.Name, Commons.Modules.UserName, 3)
        '        Commons.Modules.ObjGroups.DeleteNHOM_LOAI_PHU_TUNG(grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("GROUP_ID").Value, grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("MS_LOAI_PT").Value)
        '    ElseIf IsDBNull(grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("GROUP_ID").Value) And grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("CHON").Value Then
        '        Commons.Modules.ObjGroups.AddNHOM_LOAI_PHU_TUNG(txtGroupID.Text, grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("MS_LOAI_PT").Value)
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_LOAI_PHU_TUNG_LOG", txtGroupID.Text, grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("MS_LOAI_PT").Value, Me.Name, Commons.Modules.UserName, 1)
        '    End If
        'Next
        blnThem = -1
        VisibleButton42(True)
        BindData42()
    End Sub

    Private Sub BtnChonAll42_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrennoiSuDungVatTu.Rows.Count - 1
        '    grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("CHON").Value = True
        'Next
    End Sub

    Private Sub BtnKhongChonAll42_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdQuyenTrennoiSuDungVatTu.Rows.Count - 1
        '    grdQuyenTrennoiSuDungVatTu.Rows(i).Cells("CHON").Value = False
        'Next
    End Sub
    Private Sub BtnKhong42_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        blnThem = -1
        VisibleButton42(True)
        BindData42()
    End Sub
    Private Sub grdQuyenTrenLoaiCongViec_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs)
        intRow41 = e.RowIndex
    End Sub

    Private Sub grdQuyenTrenLoaiCongViec_RowHeaderMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs)
        intRow41 = e.RowIndex
    End Sub

    Private Sub grdQuyenTrennoiSuDungVatTu_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs)
        intRow42 = e.RowIndex
    End Sub

    Private Sub grdQuyenTrennoiSuDungVatTu_RowHeaderMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs)
        intRow42 = e.RowIndex
    End Sub
#End Region
#Region "warehouse"

    Sub VisibleButton61(ByVal chon As Boolean)
        'BtnThem61.Visible = chon
        'BtnXoa61.Visible = chon
        'BtnGhi61.Visible = Not chon
        'BtnKhong61.Visible = Not chon
        'BtnChonAll61.Visible = Not chon
        'BtnKhongChonAll61.Visible = Not chon
        'grdDanhsachkho.ReadOnly = chon
        BtnThoat.Enabled = chon
    End Sub
    Sub CreatechkGiatri61()
        Dim chkGiatri As New DataGridViewCheckBoxColumn()
        chkGiatri.Name = "CHON"
        'grdDanhsachkho.Columns.Insert(2, chkGiatri)
    End Sub
    Sub HienThi61()
        'For j As Integer = 0 To grdDanhsachkho.Rows.Count - 1
        '    If Not IsDBNull(grdDanhsachkho.Rows(j).Cells("GROUP_ID").Value) Then
        '        grdDanhsachkho.Rows(j).Cells("CHON").Value = True
        '    End If
        'Next
    End Sub
    Sub BindData61()
        If blnThem = -1 Then

            'Try
            '    grdDanhsachkho.DataSource = New Commons.OGroups().GetNHOM_KHO(txtGroupID.Text)
            '    grdDanhsachkho.Columns("TEN_KHO").Width = 613
            '    grdDanhsachkho.Columns("CHON").Visible = False
            'Catch ex As Exception
            'End Try
        Else
            'Try
            '    grdDanhsachkho.DataSource = New Commons.OGroups().GetLOAI_IC_KHO_QUYEN(txtGroupID.Text)
            '    grdDanhsachkho.Columns("GROUP_ID").Visible = False


            '    grdDanhsachkho.Columns("CHON").Visible = True
            'Catch ex As Exception
            'End Try
            If Not bCo61 Then
                CreatechkGiatri61()
                bCo61 = True
            End If
            'grdDanhsachkho.Columns("TEN_KHO").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
            'grdDanhsachkho.Columns("CHON").Width = 82
            HienThi61()
        End If

        'If grdDanhsachkho.Rows.Count > 0 Then
        '    BtnXoa61.Enabled = True
        'Else
        '    BtnXoa61.Enabled = False
        'End If
        'Try
        '    grdDanhsachkho.Columns("MS_KHO").Visible = False
        '    Me.grdDanhsachkho.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        '    Me.grdDanhsachkho.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        'Catch ex As Exception
        'End Try
        RefeshLanguage61()
    End Sub
    Sub RefeshLanguage61()
        'Try
        '    Me.grdDanhsachkho.Columns("TEN_KHO").HeaderText = GetNN(dtNNgu, "TEN_KHO")

        '    Me.grdDanhsachkho.Columns("CHON").HeaderText = GetNN(dtNNgu, "CHON")
        'Catch ex As Exception

        'End Try

    End Sub
#End Region
#Region "event warehouse"

    Private Sub BtnThem61_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 And txtGroupID.Text <> "" Then
            blnThem = 5
            VisibleButton61(False)
            BindData61()
        End If
    End Sub

    Private Sub BtnXoa61_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'If grdDanhsachkho.Rows.Count > 0 Then
        '    Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa61"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
        '    If Traloi = vbYes Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_KHO_LOG", txtGroupID.Text, grdDanhsachkho.Rows(intRow61).Cells("MS_KHO").Value, Me.Name, Commons.Modules.UserName, 3)
        '        Commons.Modules.ObjGroups.DeleteNHOM_KHO(txtGroupID.Text, grdDanhsachkho.Rows(intRow61).Cells("MS_KHO").Value)
        '        BindData61()
        '    End If
        'End If
    End Sub

    Private Sub BtnGhi61_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdDanhsachkho.Rows.Count - 1

        '    If Not IsDBNull(grdDanhsachkho.Rows(i).Cells("GROUP_ID").Value) And Not grdDanhsachkho.Rows(i).Cells("CHON").Value Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_KHO_LOG", txtGroupID.Text, grdDanhsachkho.Rows(i).Cells("MS_KHO").Value, Me.Name, Commons.Modules.UserName, 3)
        '        Commons.Modules.ObjGroups.DeleteNHOM_KHO(grdDanhsachkho.Rows(i).Cells("GROUP_ID").Value, grdDanhsachkho.Rows(i).Cells("MS_KHO").Value)
        '    ElseIf IsDBNull(grdDanhsachkho.Rows(i).Cells("GROUP_ID").Value) And grdDanhsachkho.Rows(i).Cells("CHON").Value Then
        '        Commons.Modules.ObjGroups.AddNHOM_KHO(txtGroupID.Text, grdDanhsachkho.Rows(i).Cells("MS_KHO").Value)
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_KHO_LOG", txtGroupID.Text, grdDanhsachkho.Rows(i).Cells("MS_KHO").Value, Me.Name, Commons.Modules.UserName, 1)
        '    End If
        'Next
        blnThem = -1
        VisibleButton61(True)
        BindData61()
    End Sub
    Private Sub BtnKhongChonAll61_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdDanhsachkho.Rows.Count - 1
        '    grdDanhsachkho.Rows(i).Cells("CHON").Value = False
        'Next
    End Sub

    Private Sub BtnChonAll61_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdDanhsachkho.Rows.Count - 1
        '    grdDanhsachkho.Rows(i).Cells("CHON").Value = True
        'Next
    End Sub
    Private Sub BtnKhong61_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        blnThem = -1
        VisibleButton61(True)
        BindData61()
    End Sub

    Private Sub grdDanhsachkho_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs)
        intRow61 = e.RowIndex
    End Sub

    Private Sub grdDanhsachkho_RowHeaderMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs)
        intRow61 = e.RowIndex
    End Sub
#End Region
#Region "menu"

    Sub VisibleButton11(ByVal chon As Boolean)
        BtnThem11.Visible = chon
        BtnXoa11.Visible = chon
        BtnGhi11.Visible = Not chon
        btnCopyMenu.Visible = chon
        BtnKhong11.Visible = Not chon
        BtnChonAll.Visible = Not chon
        BtnKhongChonAll.Visible = Not chon
        grdQuyentrenmenu.ReadOnly = chon
        BtnThoat.Enabled = chon
    End Sub
    Sub CreatechkGiatri11()
        Dim chkGiatri As New DataGridViewCheckBoxColumn()
        chkGiatri.Name = "CHON"
        grdQuyentrenmenu.Columns.Insert(3, chkGiatri)
    End Sub
    Sub HienThi11()
        For j As Integer = 0 To grdQuyentrenmenu.Rows.Count - 1
            If Not IsDBNull(grdQuyentrenmenu.Rows(j).Cells("GROUP_ID").Value) Then
                grdQuyentrenmenu.Rows(j).Cells("CHON").Value = True
            End If
        Next
    End Sub
    Sub GiaiMaTable(ByVal sBTamLic As String, ByVal BTam As String, ByVal sCot As String)
        Dim dtTmpLic As New DataTable
        Dim sTypeLic As String


        sTypeLic = Commons.clsXuLy.MaHoaDL(CType(SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, CommandType.Text, _
                    "SELECT ISNULL(TYPE_LIC,0) FROM NHOM WHERE GROUP_ID = " & txtGroupID.Text), Integer).ToString())


        dtTmpLic = New DataTable
        dtTmpLic.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, _
                    "SELECT * FROM " + BTam + " WHERE TYPE_LIC = N'" + sTypeLic + "' "))

        For Each row As DataRow In dtTmpLic.Rows
            row("TYPE_LIC") = Commons.clsXuLy.GiaiMaDL(row("TYPE_LIC").ToString())
            row(sCot) = Commons.clsXuLy.GiaiMaDL(row(sCot).ToString())
        Next

        Commons.Modules.ObjSystems.XoaTable(sBTamLic)
        Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, sBTamLic, dtTmpLic, "")

    End Sub

    Sub BindData11()
        Dim dtTmp As New DataTable
        Dim sSql As String
        Dim sBT, sBTamLic As String
        sBT = "LIC_MENU_TMP" + Commons.Modules.UserName
        sBTamLic = "LIC_DATA" + Commons.Modules.UserName

        GiaiMaTable(sBTamLic, "LIC_MENU", "MENU_ID")

        Commons.Modules.ObjSystems.XoaTable(sBT)
        If blnThem = -1 Then
            Try
                'TYPE_LIC,MENU_ID
                dtTmp = New Commons.OGroups().GetNHOM_MENU(txtGroupID.Text, Commons.Modules.TypeLanguage)
                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, sBT, dtTmp, "")

                sSql = "SELECT A.MENU_ID, B.MENU_NAME  FROM " + sBTamLic + " A INNER JOIN " + sBT + " B ON A.MENU_ID = B.MENU_ID   WHERE LEFT(LTRIM(MENU_NAME),1)='1' AND A.MENU_ID NOT IN ('mnuThongTinChung','mnuImport','mnuExportExcel','mnuSettingup','mnuFormsetting','mnuReportmailsetting')  ORDER BY MENU_NAME"
                dtTmp = New DataTable
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql))

                'grdQuyentrenmenu.DataSource = New Commons.OGroups().GetNHOM_MENU(txtGroupID.Text, Commons.Modules.TypeLanguage)

                grdQuyentrenmenu.DataSource = dtTmp
                grdQuyentrenmenu.Columns("MENU_NAME").Width = 500 ' 271
                grdQuyentrenmenu.Columns("CHON").Visible = False

            Catch ex As Exception
            End Try

        Else
            Try
                dtTmp = New Commons.OGroups().GetMENU_QUYEN(txtGroupID.Text, Commons.Modules.TypeLanguage)
                Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, sBT, dtTmp, "")

                sSql = "SELECT A.MENU_ID, B.MENU_NAME,GROUP_ID  FROM " + sBTamLic + " A INNER JOIN " + sBT + " B ON A.MENU_ID = B.MENU_ID  WHERE LEFT(LTRIM(MENU_NAME),1)='1' AND A.MENU_ID NOT IN ('mnuThongTinChung','mnuImport','mnuExportExcel','mnuSettingup')   ORDER BY MENU_NAME"
                dtTmp = New DataTable
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql))
                grdQuyentrenmenu.DataSource = dtTmp
                'grdQuyentrenmenu.DataSource = New Commons.OGroups().GetMENU_QUYEN(txtGroupID.Text, Commons.Modules.TypeLanguage)
                grdQuyentrenmenu.Columns("GROUP_ID").Visible = False


                grdQuyentrenmenu.Columns("CHON").Visible = True
            Catch ex As Exception
            End Try
            If Not bCo11 Then
                CreatechkGiatri11()
                bCo11 = True
            End If
            HienThi11()
            Try
                grdQuyentrenmenu.Columns("MENU_NAME").Width = 500 '200
                grdQuyentrenmenu.Columns("CHON").Width = 70 '71
                grdQuyentrenmenu.Columns("CHON").DisplayIndex = 3
            Catch ex As Exception

            End Try
        End If

        If grdQuyentrenmenu.Rows.Count > 0 Then
            BtnXoa11.Enabled = True
        Else
            BtnXoa11.Enabled = False
        End If
        Try
            Me.grdQuyentrenmenu.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
            Me.grdQuyentrenmenu.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
            grdQuyentrenmenu.Columns("MENU_ID").Visible = False

        Catch ex As Exception
        End Try
        RefeshLanguage11()
        Commons.Modules.ObjSystems.XoaTable(sBT)
        Commons.Modules.ObjSystems.XoaTable(sBTamLic)
    End Sub
#End Region
#Region "event menu"
    Private Sub BtnThem11_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnThem11.Click
        If blnThem = -1 And txtGroupID.Text <> "" Then
            blnThem = 1
            VisibleButton11(False)
            Me.grdQuyentrenmenu.Columns("MENU_NAME").SortMode = DataGridViewColumnSortMode.NotSortable
            BindData11()
        End If
    End Sub
    Private Sub BtnXoa11_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnXoa11.Click
        If grdQuyentrenmenu.Rows.Count > 0 Then
            Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa11"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
            If Traloi = vbYes Then

                SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, "UPDATE_NHOM_MENU_LOG", txtGroupID.Text, grdQuyentrenmenu.Rows(intRow11).Cells("MENU_ID").Value, Me.Name, Commons.Modules.UserName, 3)
                Commons.Modules.ObjGroups.DeleteNHOM_MENU(txtGroupID.Text, grdQuyentrenmenu.Rows(intRow11).Cells("MENU_ID").Value)
                BindData11()
            End If
        End If
    End Sub

    Private Sub BtnGhi11_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnGhi11.Click
        For i As Integer = 0 To grdQuyentrenmenu.Rows.Count - 1

            'SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, "UPDATE MENU SET FORM_NAME='" & grdQuyentrenmenu.Rows(i).Cells("FORM_NAME").Value & "' WHERE MENU_ID='" & grdQuyentrenmenu.Rows(i).Cells("MENU_ID").Value & "'")
            If Not IsDBNull(grdQuyentrenmenu.Rows(i).Cells("GROUP_ID").Value) And Not grdQuyentrenmenu.Rows(i).Cells("CHON").Value Then
                SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, "UPDATE_NHOM_MENU_LOG", grdQuyentrenmenu.Rows(i).Cells("GROUP_ID").Value, grdQuyentrenmenu.Rows(i).Cells("MENU_ID").Value, Me.Name, Commons.Modules.UserName, 3)
                Commons.Modules.ObjGroups.DeleteNHOM_MENU(grdQuyentrenmenu.Rows(i).Cells("GROUP_ID").Value, grdQuyentrenmenu.Rows(i).Cells("MENU_ID").Value)
            ElseIf IsDBNull(grdQuyentrenmenu.Rows(i).Cells("GROUP_ID").Value) And grdQuyentrenmenu.Rows(i).Cells("CHON").Value Then
                Commons.Modules.ObjGroups.AddNHOM_MENU(txtGroupID.Text, grdQuyentrenmenu.Rows(i).Cells("MENU_ID").Value)
                SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString, "UPDATE_NHOM_MENU_LOG", txtGroupID.Text, grdQuyentrenmenu.Rows(i).Cells("MENU_ID").Value, Me.Name, Commons.Modules.UserName, 1)
            End If
        Next
        blnThem = -1
        VisibleButton11(True)
        BindData11()
        Me.grdQuyentrenmenu.Columns("MENU_NAME").SortMode = DataGridViewColumnSortMode.Automatic
    End Sub
    Private Sub BtnChonAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnChonAll.Click
        For i As Integer = 0 To grdQuyentrenmenu.Rows.Count - 1
            grdQuyentrenmenu.Rows(i).Cells("CHON").Value = True
        Next
    End Sub

    Private Sub BtnKhongChonAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnKhongChonAll.Click
        For i As Integer = 0 To grdQuyentrenmenu.Rows.Count - 1
            grdQuyentrenmenu.Rows(i).Cells("CHON").Value = False
        Next
    End Sub
    Private Sub BtnKhong11_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnKhong11.Click
        blnThem = -1
        VisibleButton11(True)
        BindData11()
        Me.grdQuyentrenmenu.Columns("MENU_NAME").SortMode = DataGridViewColumnSortMode.Automatic
    End Sub

    Private Sub grdQuyentrenmenu_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdQuyentrenmenu.RowEnter
        intRow11 = e.RowIndex
    End Sub

    Private Sub grdQuyentrenmenu_RowHeaderMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs) Handles grdQuyentrenmenu.RowHeaderMouseClick
        intRow11 = e.RowIndex
    End Sub
#End Region
#Region "users"
    Sub EnableControl(ByVal chon As Boolean)
        txtTenUser.Enabled = chon
        chkActive.Enabled = chon
        txtFullName.Enabled = chon
        txtDescription5.Enabled = chon
        txtMail.Enabled = chon
        cmbDepartment.Enabled = chon
        cmbCNhan.Enabled = chon
        txtPassword.Enabled = chon
        txtComfirmPassword.Enabled = chon
    End Sub
    Sub VisibleButton51(ByVal chon As Boolean)
        BtnThem51.Visible = chon
        BtnXoa51.Visible = chon
        BtnGhi51.Visible = Not chon
        BtnKhong51.Visible = Not chon
        btnCopyChucNangUser.Visible = chon
        grdDanhsachusers.ReadOnly = True
        grdDanhsachusers.Enabled = chon
        BtnSua51.Visible = chon
        BtnThem52.Enabled = chon
        BtnXoa52.Enabled = chon
        BtnThoat.Enabled = chon

    End Sub
    Sub VisibleButton52(ByVal chon As Boolean)
        BtnThem52.Visible = chon
        BtnXoa52.Visible = chon
        BtnGhi52.Visible = Not chon
        BtnKhong52.Visible = Not chon
        BtnChonAll51.Visible = Not chon
        BtnKhongChonAll51.Visible = Not chon
        grdDanhsachQuyenxetduyet.ReadOnly = chon
        grdDanhsachusers.Enabled = chon
        BtnThoat.Enabled = chon
    End Sub
    Sub ShowData()
        txtTenUser.Text = grdDanhsachusers.Rows(intRow51).Cells("USERNAME").Value
        Try
            chkActive.Checked = grdDanhsachusers.Rows(intRow51).Cells("ACTIVE").Value
        Catch ex As Exception

        End Try

        txtFullName.Text = grdDanhsachusers.Rows(intRow51).Cells("FULL_NAME").Value
        txtDescription5.Text = grdDanhsachusers.Rows(intRow51).Cells("DESCRIPTION").Value.ToString()
        txtMail.Text = grdDanhsachusers.Rows(intRow51).Cells("USER_MAIL").Value.ToString()
        If grdDanhsachusers.Rows(intRow51).Cells("MS_TO").Value.ToString() = "" Then
            cmbDepartment.SelectedIndex = -1
        Else
            cmbDepartment.SelectedValue = grdDanhsachusers.Rows(intRow51).Cells("MS_TO").Value.ToString()
        End If
        If grdDanhsachusers.Rows(intRow51).Cells("MS_CONG_NHAN").Value.ToString() = "" Then
            cmbCNhan.SelectedIndex = -1
        Else
            cmbCNhan.SelectedValue = grdDanhsachusers.Rows(intRow51).Cells("MS_CONG_NHAN").Value.ToString()
        End If

        txtPassword.Text = Commons.clsXuLy.GiaiMaDL(grdDanhsachusers.Rows(intRow51).Cells("PASS").Value)
        txtComfirmPassword.Text = Commons.clsXuLy.GiaiMaDL(grdDanhsachusers.Rows(intRow51).Cells("PASS").Value)
    End Sub
    Sub Refresh5()
        txtTenUser.Text = ""
        chkActive.Checked = True
        txtFullName.Text = ""
        txtDescription5.Text = ""
        txtMail.Text = ""
        cmbDepartment.SelectedIndex = -1
        cmbCNhan.SelectedIndex = -1
        txtPassword.Text = ""
        txtComfirmPassword.Text = ""
    End Sub
    Sub LoadcmbDepartment()
        cmbDepartment.Display = "TEN_TO"
        cmbDepartment.Value = "MS_TO"
        cmbDepartment.StoreName = "GetTO_PHONG_BAN_QUYEN"
        cmbDepartment.ClassName = "frmDanhmucto"
        cmbDepartment.BindDataSource()
    End Sub
    Sub LoadcmbNV()
        cmbCNhan.Display = "HO_TEN_CONG_NHAN"
        cmbCNhan.Value = "MS_CONG_NHAN"
        cmbCNhan.StoreName = "GetCONG_NHANs1"
        cmbCNhan.BindDataSource()
    End Sub

    Sub BindData51(Optional ByVal sUser As String = "-1")
        Dim index As Integer
        Try
            Dim dtTable As New DataTable
            dtTable = New Commons.OGroups().GetUSERofGROUPs(txtGroupID.Text)
            dtTable.PrimaryKey = New DataColumn() {dtTable.Columns("USERNAME")}
            index = dtTable.Rows.IndexOf(dtTable.Rows.Find(sUser))
            grdDanhsachusers.DataSource = dtTable
            grdDanhsachusers.Columns("GROUP_ID").Visible = False
            grdDanhsachusers.Columns("PASS").Visible = False
            grdDanhsachusers.Columns("DESCRIPTION").Visible = False
            grdDanhsachusers.Columns("MS_TO").Visible = False
            grdDanhsachusers.Columns("MS_CONG_NHAN").Visible = False
            Try
                grdDanhsachusers.Columns("ACTIVE").Visible = False
            Catch ex As Exception

            End Try



            Me.grdDanhsachusers.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
            Me.grdDanhsachusers.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        Catch ex As Exception
        End Try
        RefeshLanguage51()
        If sUser <> "-1" Then
            Try
                grdDanhsachusers.CurrentCell = grdDanhsachusers.Rows(index).Cells("USERNAME")
            Catch ex As Exception
            End Try
        End If
        If grdDanhsachusers.Rows.Count = 0 Then
            Refresh5()
            BindData52()
        End If

        If Me.grdDanhsachusers.Rows.Count > 0 Then
            BtnXoa51.Enabled = True
            BtnThem52.Enabled = True
        Else
            BtnXoa51.Enabled = False
            BtnThem52.Enabled = False
        End If

    End Sub
    Function isValidated()

        If Not txtTenUser.IsValidated Then
            txtTenUser.Focus()
            Return False
        End If
        If Not txtFullName.IsValidated Then
            txtFullName.Focus()
            Return False
        End If
        If Not txtPassword.IsValidated Then
            txtPassword.Focus()
            Return False
        End If
        If Not txtComfirmPassword.IsValidated Then
            txtComfirmPassword.Focus()
            Return False
        End If
        Return True
    End Function
    Sub CreatechkGiatri52()
        Dim chkGiatri As New DataGridViewCheckBoxColumn()
        chkGiatri.Name = "CHON"
        grdDanhsachQuyenxetduyet.Columns.Insert(2, chkGiatri)
    End Sub
    Sub HienThi52()
        For j As Integer = 0 To grdDanhsachQuyenxetduyet.Rows.Count - 1
            If Not IsDBNull(grdDanhsachQuyenxetduyet.Rows(j).Cells("USERNAME").Value) Then
                grdDanhsachQuyenxetduyet.Rows(j).Cells("CHON").Value = True
            End If
        Next
    End Sub
    Sub BindData52()
        grdDanhsachQuyenxetduyet.DataSource = New Commons.OGroups().GetUSER_CHUC_NANG(txtTenUser.Text)
        If txtTenUser.Text <> "" Then
            If blnThem = -1 Then
                Try
                    grdDanhsachQuyenxetduyet.Columns("CHON").Visible = False
                Catch ex As Exception
                End Try
            ElseIf blnThem <> -1 And Not BtnThem52.Visible Then
                grdDanhsachQuyenxetduyet.DataSource = New Commons.OGroups().GetCHUC_NANG_QUYEN(txtTenUser.Text)
                grdDanhsachQuyenxetduyet.Columns("USERNAME").Visible = False
                If Not bCo52 Then
                    CreatechkGiatri52()
                    bCo52 = True
                End If
                Try
                    grdDanhsachQuyenxetduyet.Columns("CHON").Visible = True
                    Me.grdDanhsachQuyenxetduyet.Columns("CHON").Width = 60
                Catch ex As Exception
                End Try
                If Not Isnull Then
                    HienThi52()
                End If
            End If
            grdDanhsachQuyenxetduyet.Columns("STT").Visible = False

            Try
                Me.grdDanhsachQuyenxetduyet.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
                Me.grdDanhsachQuyenxetduyet.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
            Catch ex As Exception
            End Try
            RefeshLanguage52()
        End If
        If grdDanhsachQuyenxetduyet.Rows.Count > 0 Then
            BtnXoa52.Enabled = True
        Else
            BtnXoa52.Enabled = False
        End If
        If Commons.Modules.PermisString.Equals("Read only") Then
            EnableControlAll(False)
        Else
            EnableControlAll(True)
        End If
    End Sub
#End Region
#Region "event users"
    Private Sub grdDanhsachusers_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdDanhsachusers.RowEnter
        intRow51 = e.RowIndex
        ShowData()
        BindData52()
    End Sub

    Private Sub grdDanhsachusers_RowHeaderMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs) Handles grdDanhsachusers.RowHeaderMouseClick
        intRow51 = e.RowIndex
        ShowData()
        BindData52()
    End Sub

    Private Sub BtnThem51_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnThem51.Click
        If blnThem = -1 And txtGroupID.Text <> "" Then
            strUserName = ""
            VisibleButton51(False)
            EnableControl(True)
            Refresh5()
            blnThem = 6
            txtTenUser.Focus()
            BindData52()
        End If
    End Sub

    Private Sub BtnXoa51_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnXoa51.Click
        If blnThem = -1 Then

            If Commons.Modules.ObjGroups.CheckUSER_CHUCNANG(grdDanhsachusers.Rows(intRow51).Cells("USERNAME").Value) Then
                MsgBox(GetNN(dtNNgu, "MsgKiemtra1"), MsgBoxStyle.Exclamation)
                Exit Sub
            Else
                Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa51"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
                If Traloi = vbYes Then
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_USERS_LOG", txtTenUser.Text, Me.Name, Commons.Modules.UserName, 3)
                    Commons.Modules.ObjGroups.DeleteUSER_NHOM(txtGroupID.Text, txtTenUser.Text)
                    BindData51()
                    BindData1(txtGroupID.Text)
                End If
            End If
        End If
    End Sub

    Private Sub BtnGhi51_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnGhi51.Click
        If isValidated() Then
            Dim objUSERInfo As New Commons.IUsers()
            If AddUser() Then

                objUSERInfo.UserName = txtTenUser.Text
                objUSERInfo.FullName = txtFullName.Text
                objUSERInfo.GroupID = txtGroupID.Text
                objUSERInfo.Description = txtDescription5.Text
                objUSERInfo.UserMail = txtMail.Text
                'objUSERInfo.PASS = molEncrypt.EncryptData(txtPassword.Text.Trim)
                objUSERInfo.Password = Commons.clsXuLy.MaHoaDL(txtPassword.Text.Trim)
                If cmbDepartment.SelectedValue = -1 Then
                    objUSERInfo.MsTo = Nothing
                Else
                    objUSERInfo.MsTo = cmbDepartment.SelectedValue
                End If

                If bSua Then
                    bSua = False
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_USERS_LOG", strUserName, Me.Name, Commons.Modules.UserName, 2)
                    Commons.Modules.ObjGroups.UpdateUSER(strUserName, objUSERInfo)
                Else
                    Commons.Modules.ObjGroups.AddUSER(objUSERInfo)
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_USERS_LOG", objUSERInfo.UserName, Me.Name, Commons.Modules.UserName, 1)
                End If
            Else
                Exit Sub
            End If

            Dim sSql As String

            Try
                If cmbCNhan.Text <> "" Then
                    sSql = " UPDATE USERS SET MS_CONG_NHAN = N'" & cmbCNhan.SelectedValue & "' WHERE USERNAME = N'" & txtTenUser.Text & "' "
                Else
                    sSql = " UPDATE USERS SET MS_CONG_NHAN = NULL WHERE USERNAME = N'" & txtTenUser.Text & "' "
                End If
                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, sSql)

            Catch ex As Exception

            End Try
            Try
                If chkActive.Checked = True Then
                    sSql = " UPDATE USERS SET ACTIVE = 1 WHERE USERNAME = N'" & txtTenUser.Text & "' "
                Else
                    sSql = " UPDATE USERS SET ACTIVE = 0 WHERE USERNAME = N'" & txtTenUser.Text & "' "
                End If
                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, sSql)
            Catch ex As Exception

            End Try
            sSql = txtTenUser.Text
            Refresh5()
            BindData51(sSql)
            VisibleButton51(True)
            EnableControl(False)
            blnThem = -1

        End If
    End Sub
    Function AddUser() As Boolean

        If txtPassword.Text.Trim <> txtComfirmPassword.Text.Trim Then
            MsgBox(GetNN(dtNNgu, "MsgKhongTrung"), MsgBoxStyle.Exclamation)
            txtComfirmPassword.Focus()
            txtComfirmPassword.SelectAll()
            Return False
        End If
        If strUserName <> txtTenUser.Text.Trim Then
            If Not Commons.Modules.ObjGroups.CheckExistUserName(txtTenUser.Text.Trim) Then
                MsgBox(GetNN(dtNNgu, "MsgTrung"), MsgBoxStyle.Exclamation)
                txtTenUser.Focus()
                txtTenUser.SelectAll()
                Return False
            End If
        End If

        If txtMail.Text <> "" Then
            If Commons.Modules.ObjSystems.MCheckEmail(txtMail.Text) = False Then
                MsgBox(GetNN(dtNNgu, "MsgKhongPhaiMail"), MsgBoxStyle.Exclamation)
                txtMail.Focus()
                txtMail.SelectAll()
                Return False
            End If
        End If


        Return True
    End Function

    Private Sub BtnSua51_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnSua51.Click
        If blnThem = -1 And txtGroupID.Text <> "" Then
            strUserName = txtTenUser.Text
            VisibleButton51(False)
            EnableControl(True)
            If CheckUserExist(txtTenUser.Text.Trim) = False Or Commons.Modules.ObjGroups.CheckUSER_CHUCNANG(grdDanhsachusers.Rows(intRow51).Cells("USERNAME").Value) Then
                txtTenUser.Enabled = False
                txtFullName.Enabled = False

            End If
            blnThem = 6
            bSua = True
            If txtTenUser.Text.ToUpper = "ADMINISTRATOR" Then
                chkActive.Checked = True
                chkActive.Enabled = False
            End If
            txtTenUser.Focus()
        End If
    End Sub

    Private Sub BtnThem52_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnThem52.Click
        If blnThem = -1 Then
            VisibleButton52(False)
            blnThem = 6
            If Me.grdDanhsachQuyenxetduyet.Rows.Count > 0 Then
                Isnull = False
            Else
                Isnull = True
            End If
            BindData52()
        End If
    End Sub
    Private Sub BtnXoa52_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnXoa52.Click
        If blnThem = -1 Then
            If grdDanhsachQuyenxetduyet.Rows.Count > 0 Then
                Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa52"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
                If Traloi = vbYes Then
                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_USER_CHUC_NANG_LOG", txtTenUser.Text, grdDanhsachQuyenxetduyet.Rows(intRow52).Cells("STT").Value, Me.Name, Commons.Modules.UserName, 3)
                    Commons.Modules.ObjGroups.DeleteUSER_CHUC_NANG(txtTenUser.Text, grdDanhsachQuyenxetduyet.Rows(intRow52).Cells("STT").Value)
                    BindData52()
                End If
            End If
        End If
    End Sub

    Private Sub BtnGhi52_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnGhi52.Click
        For i As Integer = 0 To grdDanhsachQuyenxetduyet.Rows.Count - 1

            If Not IsDBNull(grdDanhsachQuyenxetduyet.Rows(i).Cells("USERNAME").Value) And Not grdDanhsachQuyenxetduyet.Rows(i).Cells("CHON").Value Then
                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_USER_CHUC_NANG_LOG", txtTenUser.Text, grdDanhsachQuyenxetduyet.Rows(i).Cells("STT").Value, Me.Name, Commons.Modules.UserName, 3)
                Commons.Modules.ObjGroups.DeleteUSER_CHUC_NANG(txtTenUser.Text, grdDanhsachQuyenxetduyet.Rows(i).Cells("STT").Value)
            ElseIf IsDBNull(grdDanhsachQuyenxetduyet.Rows(i).Cells("USERNAME").Value) And grdDanhsachQuyenxetduyet.Rows(i).Cells("CHON").Value Then

                Commons.Modules.ObjGroups.AddUSER_CHUC_NANG(txtTenUser.Text, grdDanhsachQuyenxetduyet.Rows(i).Cells("STT").Value)
                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_USER_CHUC_NANG_LOG", txtTenUser.Text, grdDanhsachQuyenxetduyet.Rows(i).Cells("STT").Value, Me.Name, Commons.Modules.UserName, 1)
            End If
        Next
        blnThem = -1
        VisibleButton52(True)
        BindData52()

        Commons.Modules.sTenNhanVienMD = ""
        Commons.Modules.sMaNhanVienMD = ""
        Dim dtTmp = New DataTable
        Try
            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, _
                " SELECT     ISNULL(A.MS_CONG_NHAN, N'') AS MS_CONG_NHAN, ISNULL(B.HO, N'') + ' ' + ISNULL(B.TEN, N'')  AS TEN_CONG_NHAN " & _
                " FROM dbo.USERS A INNER JOIN CONG_NHAN B ON A.MS_CONG_NHAN = B.MS_CONG_NHAN " & _
                " WHERE A.USERNAME = '" + Commons.Modules.UserName + "'"))
        Catch ex As Exception
        End Try
        Try
            Commons.Modules.sTenNhanVienMD = dtTmp.Rows(0)("TEN_CONG_NHAN")
            Commons.Modules.sMaNhanVienMD = dtTmp.Rows(0)("MS_CONG_NHAN")
        Catch ex As Exception
        End Try

    End Sub

    Private Sub BtnKhong52_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnKhong52.Click
        blnThem = -1
        VisibleButton52(True)
        BindData52()
    End Sub

    Private Sub BtnKhong51_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnKhong51.Click
        blnThem = -1
        VisibleButton51(True)
        EnableControl(False)
        Try
            BindData51(grdDanhsachusers.CurrentRow.Cells("USERNAME").Value.ToString)
        Catch ex As Exception
            BindData51()
        End Try


    End Sub
#End Region
#Region "Reports"
    Sub Bind_cboLoaibaocao()
        'If Commons.Modules.TypeLanguage = 0 Then
        '    cboLoaibaocao.Items.Clear()
        '    cboLoaibaocao.Items.Add("<Tất cả>")
        '    cboLoaibaocao.Items.Add("Thông tin thiết bị")
        '    cboLoaibaocao.Items.Add("Sử dụng")
        '    cboLoaibaocao.Items.Add("Bảo trì")
        '    cboLoaibaocao.Items.Add("Kho")
        '    cboLoaibaocao.SelectedIndex = 0
        'Else
        '    cboLoaibaocao.Items.Clear()
        '    cboLoaibaocao.Items.Add(" < ALL > ")
        '    cboLoaibaocao.Items.Add("Thông tin thiết bị")
        '    cboLoaibaocao.Items.Add("Sử dụng")
        '    cboLoaibaocao.Items.Add("Bảo trì")
        '    cboLoaibaocao.Items.Add("Kho")
        '    cboLoaibaocao.SelectedIndex = 0
        'End If
    End Sub

    Sub Bind_Report()
        Try
            'Dim dtTmp As New DataTable
            'Dim sSql As String
            'Dim sBT, sBTamLic As String
            'sBT = "REPORT_DATA" + Commons.Modules.UserName
            'sBTamLic = "LIC_DATA_REPORT" + Commons.Modules.UserName
            'GiaiMaTable(sBTamLic, "LIC_REPORT", "REPORT_NAME")
            'Commons.Modules.ObjSystems.XoaTable(sBT)

            'dtTmp = Commons.Modules.ObjGroups.Get_Danhsachbaocao(Commons.Modules.UserName, txtGroupID.Text, _
            '        cboLoaibaocao.SelectedIndex, Commons.Modules.TypeLanguage)

            'Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, sBT, dtTmp, "")

            'sSql = "SELECT A.REPORT_NAME, B.TEN_REPORT , QUYEN FROM (SELECT DISTINCT TYPE_LIC, REPORT_NAME FROM " + sBTamLic + " )  A INNER JOIN " + sBT + " B ON A.REPORT_NAME = B.REPORT_NAME ORDER BY TEN_REPORT"
            'dtTmp = New DataTable
            'dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql))
            'Me.grdListofReport.DataSource = dtTmp
            ''Me.grdListofReport.DataSource = Commons.Modules.ObjGroups.Get_Danhsachbaocao(Commons.Modules.UserName, txtGroupID.Text, cboLoaibaocao.SelectedIndex, Commons.Modules.TypeLanguage)
            'format_grdListofReport()
        Catch ex As Exception

        End Try
    End Sub

    Sub format_grdListofReport()
        'With Me.grdListofReport
        '    Try
        '        .Columns("REPORT_NAME").Visible = False
        '        .Columns("QUYEN").Width = 100
        '        .Columns("QUYEN").DefaultCellStyle.Alignment = DataGridViewContentAlignment.MiddleLeft
        '        .ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        '        .DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        '    Catch ex As Exception
        '    End Try
        'End With
        'refreshLangugue_of_grdReport()
    End Sub

    Sub refreshLangugue_of_grdReport()
        'Try
        '    Me.grdListofReport.Columns("TEN_REPORT").HeaderText = GetNN(dtNNgu, "TEN_REPORT")
        '    Me.grdListofReport.Columns("QUYEN").HeaderText = GetNN(dtNNgu, "QUYEN")
        'Catch ex As Exception

        'End Try

    End Sub

    Sub show_permission(ByVal rowindex As Integer)
        'If IsDBNull(Me.grdListofReport.Rows(rowindex).Cells("QUYEN").Value) Then
        '    rad_Access.Checked = False
        '    rad_noAccess.Checked = False
        'Else
        '    If Me.grdListofReport.Rows(rowindex).Cells("QUYEN").Value.ToString = "Access" Then
        '        rad_Access.Checked = True
        '    Else
        '        rad_noAccess.Checked = True
        '    End If
        'End If
    End Sub

    Private Sub cboLoaibaocao_SelectedIndexChanged(ByVal sender As Object, ByVal e As System.EventArgs)
        Bind_Report()
    End Sub

    Private Sub grdListofReport_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs)
        show_permission(e.RowIndex)
    End Sub

    Private Sub grdListofReport_RowHeaderMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs)
        show_permission(e.RowIndex)
    End Sub

    Private Sub btnGhi8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Try

            Dim report_name As String = ""
            'If chkAccess.Checked Or chkDenyAll.Checked Then
            '    If chkAccess.Checked Then
            '        For i = 0 To grdListofReport.Rows.Count - 1
            '            report_name = Me.grdListofReport.Rows(i).Cells("REPORT_NAME").Value.ToString
            '            If IsDBNull(Me.grdListofReport.Rows(i).Cells("QUYEN").Value) Then

            '                Commons.Modules.ObjGroups.Add_NHOM_REPORT(report_name, txtGroupID.Text, "Access")
            '                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_REPORT_LOG", txtGroupID.Text, report_name, Me.Name, Commons.Modules.UserName, 1)
            '            Else
            '                If Me.grdListofReport.Rows(i).Cells("QUYEN").Value.ToString <> "Access" Then
            '                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_REPORT_LOG", txtGroupID.Text, report_name, Me.Name, Commons.Modules.UserName, 2)
            '                    Commons.Modules.ObjGroups.Update_NHOM_REPORT(report_name, txtGroupID.Text, "Access")
            '                End If
            '            End If
            '        Next
            '    ElseIf chkDenyAll.Checked Then
            '        For i = 0 To grdListofReport.Rows.Count - 1
            '            report_name = Me.grdListofReport.Rows(i).Cells("REPORT_NAME").Value.ToString
            '            If IsDBNull(Me.grdListofReport.Rows(i).Cells("QUYEN").Value) Then

            '                Commons.Modules.ObjGroups.Add_NHOM_REPORT(report_name, txtGroupID.Text, "No access")
            '                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_REPORT_LOG", txtGroupID.Text, report_name, Me.Name, Commons.Modules.UserName, 1)
            '            Else
            '                If Me.grdListofReport.Rows(i).Cells("QUYEN").Value.ToString <> "No access" Then
            '                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_REPORT_LOG", txtGroupID.Text, report_name, Me.Name, Commons.Modules.UserName, 2)
            '                    Commons.Modules.ObjGroups.Update_NHOM_REPORT(report_name, txtGroupID.Text, "No access")
            '                End If
            '            End If
            '        Next
            '    End If
            'Else
            '    If Not rad_Access.Checked And Not rad_noAccess.Checked Then
            '        Exit Sub
            '    Else
            '        report_name = Me.grdListofReport.CurrentRow.Cells("REPORT_NAME").Value.ToString
            '        If rad_Access.Checked Then
            '            If IsDBNull(Me.grdListofReport.CurrentRow.Cells("QUYEN").Value) Then
            '                Commons.Modules.ObjGroups.Add_NHOM_REPORT(report_name, txtGroupID.Text, "Access")
            '                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_REPORT_LOG", txtGroupID.Text, report_name, Me.Name, Commons.Modules.UserName, 1)
            '            Else
            '                If Me.grdListofReport.CurrentRow.Cells("QUYEN").Value.ToString = "Access" Then
            '                    Exit Sub
            '                Else
            '                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_REPORT_LOG", txtGroupID.Text, report_name, Me.Name, Commons.Modules.UserName, 2)
            '                    Commons.Modules.ObjGroups.Update_NHOM_REPORT(report_name, txtGroupID.Text, "Access")
            '                End If
            '            End If
            '        Else
            '            If IsDBNull(Me.grdListofReport.CurrentRow.Cells("QUYEN").Value) Then

            '                Commons.Modules.ObjGroups.Add_NHOM_REPORT(report_name, txtGroupID.Text, "No access")
            '                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_REPORT_LOG", txtGroupID.Text, report_name, Me.Name, Commons.Modules.UserName, 1)
            '            Else
            '                If Me.grdListofReport.CurrentRow.Cells("QUYEN").Value.ToString = "No access" Then
            '                    Exit Sub
            '                Else
            '                    SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_REPORT_LOG", txtGroupID.Text, report_name, Me.Name, Commons.Modules.UserName, 2)
            '                    Commons.Modules.ObjGroups.Update_NHOM_REPORT(report_name, txtGroupID.Text, "No access")
            '                End If
            '            End If
            '        End If
            '    End If
            'End If
            'chkAccess.Checked = False
            'chkDenyAll.Checked = False
            'Bind_Report()
            'For i = 0 To Me.grdListofReport.Rows.Count - 1
            '    If Me.grdListofReport.Rows(i).Cells("REPORT_NAME").Value.ToString = report_name Then
            '        Me.grdListofReport.Rows(i).Cells("TEN_REPORT").Selected = True
            '    End If
            'Next
        Catch ex As Exception

        End Try
        Bind_Report()
    End Sub
    Private Sub chkAccess_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'If chkAccess.Checked Then
        '    rad_Access.Checked = False
        '    rad_noAccess.Checked = False
        '    chkDenyAll.Checked = False
        'End If
    End Sub
#End Region

    Private Sub BtnThoat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnThoat.Click
        Me.Close()
    End Sub
    Function CatKhoangTrang(ByVal str As String) As String
        Return str.Replace(" ", "")
    End Function

    Function CheckUserExist(ByVal USERNAME As String) As String
        Try
            Dim dt As New DataTable
            dt.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "CheckUSERNAMEExist", USERNAME))
            If dt.Rows.Count > 0 Then
                If Integer.Parse(dt.Rows(0)(0).ToString()) > 0 Then
                    Return False
                End If
            End If
            Return True
        Catch ex As Exception
            Return True
        End Try

    End Function

    Private Sub txtTenUser_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles txtTenUser.Validating
        txtTenUser.Text = Me.CatKhoangTrang(txtTenUser.Text)
    End Sub

    Private Sub cmbDepartment_Validating(ByVal sender As Object, ByVal e As System.ComponentModel.CancelEventArgs) Handles cmbDepartment.Validating, cmbCNhan.Validating
        If cmbDepartment.SelectedValue Is Nothing Then
            cmbDepartment.Text = ""
        End If
    End Sub

    Private Sub grdQuyentrenmenu_UserDeletingRow(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewRowCancelEventArgs) Handles grdQuyentrenmenu.UserDeletingRow
        e.Cancel = True
    End Sub

    Private Sub grdQuyenTrenDayTruyen_RowEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs)
        intRow33 = e.RowIndex
        intRow31 = -1
    End Sub

    Private Sub grdQuyenTrenDayTruyen_RowHeaderMouseClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs)
        intRow33 = e.RowIndex
        intRow31 = -1
    End Sub
    Private Sub Btn4TroVe_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'BtnChonAll31.Visible = True
        'BtnKhongChon31.Visible = False
        'BtnGhi31.Visible = True
        'BtnKhong31.Visible = True

        'Btn1ChonDD.Visible = False
        'Btn3KhongChonDD.Visible = False
        'Btn1ChonDC.Visible = False
        'Btn2KhongChonDC.Visible = False
        'Btn4TroVe.Visible = False

    End Sub

    Private Sub Btn2KhongChonDC_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        'Try
        '    For i As Integer = 0 To grdQuyenTrenDayTruyen.Rows.Count - 1
        '        grdQuyenTrenDayTruyen.Rows(i).Cells("CHON1").Value = False
        '    Next
        'Catch ex As Exception

        'End Try

    End Sub

    Private Sub Btn1ChonDC_Click(ByVal sender As Object, ByVal e As System.EventArgs)

        'Try
        '    For i As Integer = 0 To grdQuyenTrenDayTruyen.Rows.Count - 1
        '        grdQuyenTrenDayTruyen.Rows(i).Cells("CHON1").Value = True
        '    Next
        'Catch ex As Exception

        'End Try

    End Sub

    Private Sub Btn1ChonDD_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Try
        '    For i As Integer = 0 To grdQuyenTrenKhuVuc.Rows.Count - 1
        '        grdQuyenTrenKhuVuc.Rows(i).Cells("CHON").Value = True
        '    Next
        'Catch ex As Exception

        'End Try
    End Sub

    Private Sub Btn3KhongChonDD_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'Try
        '    For i As Integer = 0 To grdQuyenTrenKhuVuc.Rows.Count - 1
        '        grdQuyenTrenKhuVuc.Rows(i).Cells("CHON").Value = False
        '    Next
        'Catch ex As Exception

        'End Try
    End Sub

    Private Sub grdListOfGroup_CellClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdListOfGroup.CellClick
        BindDataLast()
    End Sub

    Private Sub BtnChonAll51_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnChonAll51.Click
        For i As Integer = 0 To grdDanhsachQuyenxetduyet.Rows.Count - 1
            grdDanhsachQuyenxetduyet.Rows(i).Cells("CHON").Value = True
        Next
    End Sub

    Private Sub BtnKhongChonAll51_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BtnKhongChonAll51.Click
        For i As Integer = 0 To grdDanhsachQuyenxetduyet.Rows.Count - 1
            grdDanhsachQuyenxetduyet.Rows(i).Cells("CHON").Value = False
        Next
    End Sub

    Private Sub cmbDepartment_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbDepartment.SelectedIndexChanged
    End Sub

    Private Sub chkAll_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkAll.CheckedChanged
        If chkAll.Checked Then
            chkNoControl.Checked = False
            chkFullReadonly.Checked = False
        End If
    End Sub

    Private Sub chkNoControl_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkNoControl.CheckedChanged
        If chkNoControl.Checked Then
            chkAll.Checked = False
            chkFullReadonly.Checked = False
        End If
    End Sub

    Private Sub chkFullReadonly_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkFullReadonly.CheckedChanged
        If chkFullReadonly.Checked Then
            chkNoControl.Checked = False
            chkAll.Checked = False
        End If
    End Sub

    Private Sub chkDenyAll_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'If chkDenyAll.Checked Then
        '    rad_Access.Checked = False
        '    rad_noAccess.Checked = False
        '    chkAccess.Checked = False
        'End If
    End Sub
#Region "Nhom To Phong Ban"
    Sub VisibleButton62(ByVal chon As Boolean)
        Try

            'BtnThem62.Visible = chon
            'BtnXoa62.Visible = chon
            'BtnGhi62.Visible = Not chon
            'BtnKhong62.Visible = Not chon
            'BtnChonAll62.Visible = Not chon
            'BtnKhongChonAll62.Visible = Not chon
            'grdDanhsachNhomPB.ReadOnly = chon
            BtnThoat.Enabled = chon
        Catch ex As Exception

        End Try

    End Sub

    Sub CreatechkGiatri62()
        Try

            Dim chkGiatri As New DataGridViewCheckBoxColumn()
            chkGiatri.Name = "CHON"
            'grdDanhsachNhomPB.Columns.Insert(3, chkGiatri)
        Catch ex As Exception

        End Try

    End Sub

    Sub HienThi62()
        'For j As Integer = 0 To grdDanhsachNhomPB.Rows.Count - 1
        '    If Not IsDBNull(grdDanhsachNhomPB.Rows(j).Cells("GROUP_ID").Value) Then
        '        grdDanhsachNhomPB.Rows(j).Cells("CHON").Value = True
        '    End If
        'Next
    End Sub

    Sub BindData62()
        If blnThem = -1 Then

            Try
                Dim dtTmp As New DataTable
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetNHOM_TO_PHONG_BAN", txtGroupID.Text))

                'grdDanhsachNhomPB.DataSource = dtTmp

                'grdDanhsachNhomPB.Columns("TEN_DON_VI").AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
                'grdDanhsachNhomPB.Columns("TEN_TO").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
                'grdDanhsachNhomPB.Columns("CHON").Visible = False
            Catch ex As Exception
            End Try
        Else
            Try
                Dim dtTmp As New DataTable
                dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetNHOM_TO_PHONG_BAN_QUYEN", txtGroupID.Text))
                'grdDanhsachNhomPB.DataSource = dtTmp
                'grdDanhsachNhomPB.Columns("GROUP_ID").Visible = False
                'grdDanhsachNhomPB.Columns("CHON").Visible = True
            Catch ex As Exception
            End Try
            If Not bCo62 Then
                CreatechkGiatri62()
                bCo62 = True
            End If
            'grdDanhsachNhomPB.Columns("TEN_DON_VI").AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
            'grdDanhsachNhomPB.Columns("TEN_TO").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
            'grdDanhsachNhomPB.Columns("CHON").Width = 82
            HienThi62()
        End If

        'If grdDanhsachNhomPB.Rows.Count > 0 Then
        '    BtnXoa62.Enabled = True
        'Else
        '    BtnXoa62.Enabled = False
        'End If
        'Try
        '    grdDanhsachNhomPB.Columns("MS_TO").Visible = False
        '    Me.grdDanhsachNhomPB.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
        '    Me.grdDanhsachNhomPB.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
        'Catch ex As Exception
        'End Try
        RefeshLanguage62()
    End Sub

    Sub RefeshLanguage62()
        'Try
        '    Me.grdDanhsachNhomPB.Columns("TEN_DON_VI").HeaderText = GetNN(dtNNgu, "TEN_DON_VI")
        '    Me.grdDanhsachNhomPB.Columns("TEN_TO").HeaderText = GetNN(dtNNgu, "TEN_TO")
        '    Me.grdDanhsachNhomPB.Columns("CHON").HeaderText = GetNN(dtNNgu, "CHON")
        'Catch ex As Exception

        'End Try

    End Sub


    Private Sub BtnThem62_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        If blnThem = -1 And txtGroupID.Text <> "" Then
            blnThem = 5
            VisibleButton62(False)
            BindData62()
        End If
    End Sub

    Private Sub BtnXoa62_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        'If grdDanhsachNhomPB.Rows.Count > 0 Then
        '    Dim Traloi As String = MsgBox(GetNN(dtNNgu, "MsgXoa62"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
        '    If Traloi = vbYes Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_TO_PHONG_BAN_LOG", txtGroupID.Text, grdDanhsachNhomPB.Rows(intRow62).Cells("MS_TO").Value, Me.Name, Commons.Modules.UserName, 3)
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "DeleteNHOM_TO_PHONG_BAN", txtGroupID.Text, grdDanhsachNhomPB.Rows(intRow62).Cells("MS_TO").Value)
        '        BindData62()
        '    End If
        'End If
    End Sub

    Private Sub BtnGhi62_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        Try

            'For i As Integer = 0 To grdDanhsachNhomPB.Rows.Count - 1
            '    If Not IsDBNull(grdDanhsachNhomPB.Rows(i).Cells("GROUP_ID").Value) And Not grdDanhsachNhomPB.Rows(i).Cells("CHON").Value Then
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_TO_PHONG_BAN_LOG", txtGroupID.Text, grdDanhsachNhomPB.Rows(i).Cells("MS_TO").Value, Me.Name, Commons.Modules.UserName, 3)
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "DeleteNHOM_TO_PHONG_BAN", txtGroupID.Text, grdDanhsachNhomPB.Rows(i).Cells("MS_TO").Value)
            '    ElseIf IsDBNull(grdDanhsachNhomPB.Rows(i).Cells("GROUP_ID").Value) And grdDanhsachNhomPB.Rows(i).Cells("CHON").Value Then
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "AddNHOM_TO_PHONG_BAN", txtGroupID.Text, grdDanhsachNhomPB.Rows(i).Cells("MS_TO").Value)
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_TO_PHONG_BAN_LOG", txtGroupID.Text, grdDanhsachNhomPB.Rows(i).Cells("MS_TO").Value, Me.Name, Commons.Modules.UserName, 1)
            '    End If
            'Next
            blnThem = -1
            VisibleButton62(True)
            BindData62()
        Catch ex As Exception

        End Try

    End Sub
    Private Sub BtnKhongChonAll62_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdDanhsachNhomPB.Rows.Count - 1
        '    grdDanhsachNhomPB.Rows(i).Cells("CHON").Value = False
        'Next
    End Sub

    Private Sub BtnChonAll62_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdDanhsachNhomPB.Rows.Count - 1
        '    grdDanhsachNhomPB.Rows(i).Cells("CHON").Value = True
        'Next
    End Sub
    Private Sub BtnKhong62_Click(ByVal sender As Object, ByVal e As System.EventArgs)
        blnThem = -1
        VisibleButton62(True)
        BindData62()
    End Sub

    Private Sub grdDanhsachNhomPB_RowEnter(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs)
        intRow62 = e.RowIndex
    End Sub

    Private Sub grdDanhsachNhomPB_RowHeaderMouseClick(ByVal sender As Object, ByVal e As System.Windows.Forms.DataGridViewCellMouseEventArgs)
        intRow62 = e.RowIndex
    End Sub


#End Region
#Region "Copy Phan quyen + chuc nang user"
    '//iLoai = 1 Copy Phan Quyen Menu [NHOM_MENU]
    Private Sub btnCopyMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCopyMenu.Click
        CopyPhanQuyen(1, txtGroupID.Text)
        BindData11()
    End Sub
    '//iLoai = 2 Copy Phan Quyen Nhom form [NHOM_FORM]
    Private Sub btnCopyForm_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCopyForm.Click
        CopyPhanQuyen(2, txtGroupID.Text)
        BindData2()

    End Sub

    '//iLoai = 4 Copy Phan Quyen Nhom he thong [NHOM_HE_THONG]
    Private Sub btnCopyNhomHT_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(4, txtGroupID.Text)
        BindData33()

    End Sub

    '//iLoai = 3 Copy Phan Quyen Nhom nha xuong [NHOM_NHA_XUONG]
    Private Sub btnCopyNhomNX_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(3, txtGroupID.Text)
        BindData31()

    End Sub

    '//iLoai = 5 Copy Phan Quyen Nhom loai may [NHOM_LOAI_MAY]
    Private Sub btnCopyNhomLMay_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(5, txtGroupID.Text)
        BindData32()

    End Sub

    '//iLoai = 6 Copy Phan Quyen Nhom loai cong viec [NHOM_LOAI_CONG_VIEC]
    Private Sub btnCopyNhomLoaiCV_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(6, txtGroupID.Text)
        BindData41()

    End Sub

    '//iLoai = 7 Copy Phan Quyen Nhom loai phu tung [NHOM_LOAI_PHU_TUNG]
    Private Sub btnCopyNhomLoaiPT_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(7, txtGroupID.Text)
        BindData42()

    End Sub

    '//iLoai = 10 Copy chuc nang cua user
    Private Sub btnCopyChucNangUser_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCopyChucNangUser.Click
        If grdDanhsachusers.Rows.Count = 0 Or txtTenUser.Text.Trim = "" Then
            MessageBox.Show(GetNN(dtNNgu, "msgKhongCoUserCopy"))
            Exit Sub
        End If
        CopyPhanQuyen(10, txtTenUser.Text)
        BindData51()

    End Sub

    '//iLoai = 8 Copy Phan Quyen Nhom kho [NHOM_KHO]
    Private Sub btnCopyNhomKho_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(8, txtGroupID.Text)
        BindData61()

    End Sub

    '//iLoai = 9 Copy Phan Quyen Nhom to phong ban [NHOM_TO_PHONG_BAN]
    Private Sub btnCopyNhomToPhongBan_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(9, txtGroupID.Text)
        BindData62()

    End Sub

    '//iLoai = 11 Copy Phan Quyen Nhom report [NHOM_TO_PHONG_BAN]
    Private Sub btnCopyNhomReport_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(11, txtGroupID.Text)
        Bind_Report()

    End Sub
    '////iLoai = 12 Chuyen nhom cua user
    Private Sub btnChuyenNhom_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChuyenNhom.Click
        If grdListOfGroup.Rows.Count < 2 Or txtTenUser.Text.Trim = "" Then
            MessageBox.Show(GetNN(dtNNgu, "msgKhongCoNhomDeChuyen"))
            Exit Sub
        End If
        CopyPhanQuyen(12, txtTenUser.Text)
        BindData51()
    End Sub

    Private Sub CopyPhanQuyen(ByVal iLoai As Integer, ByVal sDataGoc As String)
        'Dim frm = New ReportMain.frmCopyPhanQuyen
        'frm.iLoai = iLoai
        'frm.sDataGoc = sDataGoc
        'frm.ShowDialog()
        'LoadListUser()
    End Sub
#End Region

#Region "LoadUserDangNhap"
    Private Sub LoadUserDN()
        Dim sSql As String
        Dim dtTmp As New DataTable
        sSql = "SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY A.TIME_LOGIN DESC ,A.USER_LOGIN) AS [STT],  A.USER_LOGIN, B.USERNAME, B.FULL_NAME, B.MS_CONG_NHAN, " & _
                    " dbo.CONG_NHAN.HO + ' ' + dbo.CONG_NHAN.TEN AS HO_TEN, A.TIME_LOGIN " & _
                    " FROM         dbo.LOGIN AS A INNER JOIN " & _
                    " dbo.USERS AS B ON A.USER_LOGIN = B.USERNAME LEFT OUTER JOIN " & _
                    " dbo.CONG_NHAN ON B.MS_CONG_NHAN = dbo.CONG_NHAN.MS_CONG_NHAN " & _
                    " ORDER BY A.TIME_LOGIN DESC ,A.USER_LOGIN"
        dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql))

        grdUser.DataSource = dtTmp
        grdUser.ReadOnly = True
    End Sub

#End Region

#Region "LoadListUser"

    Private Sub LoadListUser()
        Dim sSql As String
        Dim dtTmp As New DataTable

        sSql = " SELECT A.USERNAME, A.FULL_NAME, B.GROUP_NAME, B.DESCRIPTION , A.GROUP_ID, A.GROUP_ID,HO + ' ' + TEN AS HO_TEN " & _
                " FROM dbo.USERS AS A INNER JOIN dbo.NHOM AS B ON A.GROUP_ID = B.GROUP_ID  " & _
                " LEFT JOIN CONG_NHAN C ON A.MS_CONG_NHAN = C.MS_CONG_NHAN " & _
                " ORDER BY B.GROUP_NAME, A.USERNAME "
        dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sSql))
        grdListUser.DataSource = dtTmp
        grdListUser.Columns("GROUP_ID").Visible = False

    End Sub

    Private Sub grdListUser_RowEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewCellEventArgs) Handles grdListUser.RowEnter

    End Sub


#End Region

#Region "Bo Phan Chiu Phi"
    Sub BindDataBPCP()
        Try

            Dim dtTmp As New DataTable
            If blnThem = -1 Then
                Try
                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetNHOM_BO_PHAN_CHIU_PHI", txtGroupID.Text))
                    'grdDanhsachBPCP.DataSource = dtTmp
                    'grdDanhsachBPCP.Columns("CHON").Visible = False
                Catch ex As Exception
                End Try
            Else
                Try
                    dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "GetNHOM_BO_PHAN_CHIU_PHI_QUYEN", txtGroupID.Text))
                    'grdDanhsachBPCP.DataSource = dtTmp
                    'grdDanhsachBPCP.Columns("GROUP_ID").Visible = False
                    'grdDanhsachBPCP.Columns("CHON").Visible = True
                    'grdDanhsachBPCP.Columns("CHON").Width = 82
                Catch ex As Exception
                End Try
                If Not bBPCP Then
                    bBPCP = True
                    Try
                        Dim chkGiatri As New DataGridViewCheckBoxColumn()
                        chkGiatri.Name = "CHON"
                        'grdDanhsachBPCP.Columns.Insert(3, chkGiatri)
                    Catch ex As Exception

                    End Try
                End If
                HienThiBPCP()
            End If

            'grdDanhsachBPCP.Columns("MS_BP_CHIU_PHI").AutoSizeMode = DataGridViewAutoSizeColumnMode.AllCells
            'grdDanhsachBPCP.Columns("TEN_BP_CHIU_PHI").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill
            'grdDanhsachBPCP.Columns("TEN_DON_VI").AutoSizeMode = DataGridViewAutoSizeColumnMode.Fill

            'If grdDanhsachBPCP.Rows.Count > 0 Then
            '    btnXoaBPCP.Enabled = True
            'Else
            '    btnXoaBPCP.Enabled = False
            'End If

            'Try
            '    Me.grdDanhsachBPCP.ColumnHeadersDefaultCellStyle = Commons.Modules.DataGridViewCellStyle1
            '    Me.grdDanhsachBPCP.DefaultCellStyle = Commons.Modules.DataGridViewCellStyle2
            'Catch ex As Exception
            'End Try
            RefeshLanguageBPCP()
        Catch ex As Exception

        End Try

    End Sub

    Sub HienThiBPCP()
        'For j As Integer = 0 To grdDanhsachBPCP.Rows.Count - 1
        '    If Not IsDBNull(grdDanhsachBPCP.Rows(j).Cells("GROUP_ID").Value) Then
        '        grdDanhsachBPCP.Rows(j).Cells("CHON").Value = True
        '    End If
        'Next
    End Sub

    Sub VisibleButtonBPCP(ByVal chon As Boolean)
        Try
            'btnThemBPCP.Visible = chon
            'btnXoaBPCP.Visible = chon
            'btnGhiBPCP.Visible = Not chon
            'btnKhongBPCP.Visible = Not chon
            'btnChonAllBPCP.Visible = Not chon
            'btnKhongAllBPCP.Visible = Not chon
            'grdDanhsachBPCP.ReadOnly = chon
            BtnThoat.Enabled = chon
        Catch ex As Exception

        End Try

    End Sub

    Sub RefeshLanguageBPCP()
        'Try
        '    Me.grdDanhsachBPCP.Columns("MS_BP_CHIU_PHI").HeaderText = GetNN(dtNNgu, "MS_BP_CHIU_PHI")
        '    Me.grdDanhsachBPCP.Columns("TEN_BP_CHIU_PHI").HeaderText = GetNN(dtNNgu, "TEN_BP_CHIU_PHI")
        '    Me.grdDanhsachBPCP.Columns("TEN_DON_VI").HeaderText = GetNN(dtNNgu, "TEN_DON_VI")
        '    Me.grdDanhsachBPCP.Columns("CHON").HeaderText = GetNN(dtNNgu, "CHON")
        'Catch ex As Exception

        'End Try

    End Sub

    Private Sub btnThemBPCP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If blnThem = -1 And txtGroupID.Text <> "" Then
            blnThem = 9
            VisibleButtonBPCP(False)
            BindDataBPCP()
        End If
    End Sub

    Private Sub btnGhiBPCP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Try
            'For i As Integer = 0 To grdDanhsachBPCP.Rows.Count - 1
            '    If Not IsDBNull(grdDanhsachBPCP.Rows(i).Cells("GROUP_ID").Value) And Not grdDanhsachBPCP.Rows(i).Cells("CHON").Value Then
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_BO_PHAN_CHIU_PHI_LOG", txtGroupID.Text, grdDanhsachBPCP.Rows(i).Cells("MS_BP_CHIU_PHI").Value, Me.Name, Commons.Modules.UserName, 3)
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "DeleteNHOM_BO_PHAN_CHIU_PHI", txtGroupID.Text, grdDanhsachBPCP.Rows(i).Cells("MS_BP_CHIU_PHI").Value)
            '    ElseIf IsDBNull(grdDanhsachBPCP.Rows(i).Cells("GROUP_ID").Value) And grdDanhsachBPCP.Rows(i).Cells("CHON").Value Then
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "AddNHOM_BO_PHAN_CHIU_PHI", txtGroupID.Text, grdDanhsachBPCP.Rows(i).Cells("MS_BP_CHIU_PHI").Value)
            '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_BO_PHAN_CHIU_PHI_LOG", txtGroupID.Text, grdDanhsachBPCP.Rows(i).Cells("MS_BP_CHIU_PHI").Value, Me.Name, Commons.Modules.UserName, 1)
            '    End If
            'Next
            blnThem = -1
            VisibleButtonBPCP(True)
            BindDataBPCP()
        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnKhongBPCP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        blnThem = -1
        VisibleButtonBPCP(True)
        BindDataBPCP()
    End Sub

    Private Sub btnChonAllBPCP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdDanhsachBPCP.Rows.Count - 1
        '    grdDanhsachBPCP.Rows(i).Cells("CHON").Value = True
        'Next
    End Sub

    Private Sub btnKhongAllBPCP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'For i As Integer = 0 To grdDanhsachBPCP.Rows.Count - 1
        '    grdDanhsachBPCP.Rows(i).Cells("CHON").Value = False
        'Next
    End Sub

    Private Sub btnXoaBPCP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        'If grdDanhsachBPCP.Rows.Count <= 0 Then Exit Sub
        'Try

        '    Dim Traloi As String = MsgBox(GetNN(dtNNgu, "msgXoaBPChiuPhi"), MsgBoxStyle.YesNo + MsgBoxStyle.Information, Me.Text)
        '    If Traloi = vbYes Then
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "UPDATE_NHOM_BO_PHAN_CHIU_PHI_LOG", txtGroupID.Text, grdDanhsachBPCP.Rows(grdDanhsachBPCP.CurrentRow.Index).Cells("MS_BP_CHIU_PHI").Value, Me.Name, Commons.Modules.UserName, 3)
        '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "DeleteNHOM_BO_PHAN_CHIU_PHI", txtGroupID.Text, grdDanhsachBPCP.Rows(grdDanhsachBPCP.CurrentRow.Index).Cells("MS_BP_CHIU_PHI").Value)
        '        BindDataBPCP()
        '    End If
        'Catch ex As Exception

        'End Try


    End Sub
    '////iLoai = 13 Copy nhom bo phan chiu phi
    Private Sub btnCopyBPCP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyPhanQuyen(13, txtGroupID.Text)
        BindDataBPCP()
    End Sub


#End Region

    Private Sub btnCopy2_Deselected(ByVal sender As System.Object, ByVal e As System.Windows.Forms.TabControlEventArgs) Handles btnCopy2.Deselected
        'Dim messageBoxVB As New System.Text.StringBuilder()
        'messageBoxVB.AppendFormat("{0} = {1}", "TabPage", e.TabPage)
        'messageBoxVB.AppendLine()
        'messageBoxVB.AppendFormat("{0} = {1}", "TabPageIndex", e.TabPageIndex)
        'messageBoxVB.AppendLine()
        'messageBoxVB.AppendFormat("{0} = {1}", "Action", e.Action)
        'messageBoxVB.AppendLine()
        'MessageBox.Show(messageBoxVB.ToString(), "Selecting Event")


        If e.TabPageIndex = 8 Then
            Try

                If grdListUser.Rows.Count <= 0 Then Exit Sub
                If grdListOfGroup.Rows(grdListOfGroup.CurrentRow.Index).Cells("GROUP_ID").Value = grdListUser.Rows(grdListUser.CurrentRow.Index).Cells("GROUP_ID").Value Then Exit Sub

                Me.Cursor = Cursors.WaitCursor

                For i As Integer = 0 To grdListOfGroup.Rows.Count - 1
                    If grdListOfGroup.Rows(i).Cells("GROUP_ID").Value = grdListUser.Rows(grdListUser.CurrentRow.Index).Cells("GROUP_ID").Value Then

                        grdListOfGroup.Rows(i).Cells("GROUP_NAME").Selected = True
                        BindDataLast()

                        Exit For
                    End If
                Next
            Catch ex As Exception

            End Try
            Me.Cursor = Cursors.Default
        End If
    End Sub

    Private Sub grdUser_UserDeletingRow(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewRowCancelEventArgs) Handles grdUser.UserDeletingRow
        e.Cancel = True
        If grdUser.Rows(grdUser.CurrentRow.Index).Cells("USERNAME").Value.ToString.ToUpper() = Commons.Modules.UserName.ToUpper Then Exit Sub
        If Commons.Modules.ObjSystems.MGetQuyenChucNang(Commons.Modules.UserName, 60) = False Then Exit Sub


        Try
            If (MessageBox.Show(GetNN(dtNNgu, "msgBanCoChacXoaUserNay"), "", MessageBoxButtons.YesNo)) = Windows.Forms.DialogResult.No Then Exit Sub
            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, "SP_DELETE_LOGIN", grdUser.Rows(grdUser.CurrentRow.Index).Cells("USERNAME").Value)
        Catch ex As Exception

        End Try
        LoadUserDN()

    End Sub

    Private Sub grdUser_UserDeletedRow(ByVal sender As System.Object, ByVal e As System.Windows.Forms.DataGridViewRowEventArgs) Handles grdUser.UserDeletedRow
    End Sub
End Class