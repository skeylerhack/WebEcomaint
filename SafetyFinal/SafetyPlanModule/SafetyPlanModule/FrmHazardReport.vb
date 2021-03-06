Imports System.Data.SqlClient
Imports DevExpress.XtraGrid.Views.Grid
Imports DevExpress.XtraGrid.Views.Grid.ViewInfo
Imports DevExpress.XtraEditors.ViewInfo
Imports DevExpress.XtraEditors.Drawing
Imports System.IO
Imports DevExpress.XtraEditors
Imports DevExpress.Utils
Imports DevExpress.XtraGrid.Columns

Imports DevExpress.XtraGrid.Views.Base

Public Class FrmHazardReport

    Private tb As DataTable
    Private _action As String = ""
    Private _isApproval As Boolean = False
    Private _userEdit As String = ""
    Private optPrint As Integer = -1
    Private sentmailType As Integer = -1
    Private reportID As String = ""
    Private _DocNum As String = ""
    Private _tbPersonInCharge As New DataTable()
    Private _tbTHIETBI As New DataTable()
    Private _tbNGUYENNHAN As New DataTable()
    Private _tbLOAIYC As New DataTable()
    Public Shared _deleteID As Integer = -1
    Private CLICK_APPROVAL As Boolean = False
    Private _ErrorMsg As String = ""
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal DocNum As String)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _DocNum = DocNum
        GetListByDocNum()
    End Sub
    Private Sub FrmHazardReport_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        GetListLocation()
        GetListLoaiMoiNguy()
        GetListDepartment()
        GetListReportParent()
        GetListPersonRef()
        LoadListInCharge()
        LoadListUuTien()
        LoadListThietBi()
        LoadListNguyenNhan()
        LoadListLoaiYC()

        Call GetListByID()
        AllowEdit(False)
        'lay du lieu tu table phan quyen duyet
        LockGrid(True)
        If (_isApproval = False) Then


        End If
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        GridView1.Columns("Incharge").Caption = " "
        btnTKBCT.Text = "..."
    End Sub
#Region "Get data"


    Public Sub GetListLocation()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_LOCATION")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbLocation.DataSource = ds.Tables(0)
            cbLocation.ValueMember = "ID"
            cbLocation.DisplayMember = "NAME"
            cbLocation.SelectedIndex = -1
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Public Sub GetListLoaiMoiNguy()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_LOAIMOINGUY")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbLoaiMoiNguy.DataSource = ds.Tables(0)
            cbLoaiMoiNguy.ValueMember = "ID"
            cbLoaiMoiNguy.DisplayMember = "Hazard"
            cbLoaiMoiNguy.SelectedIndex = -1
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Public Sub GetListDepartment()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_DEPARTMENT")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbDepartment.DataSource = ds.Tables(0)
            cbDepartment.ValueMember = "ID"
            cbDepartment.DisplayMember = "Department"
            cbDepartment.SelectedIndex = -1
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub SetDepartment()
        Try
            If _action <> "" Then
                Dim dt As New DataTable()
                Dim sqlcom As New SqlCommand()
                Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                sqlcom.Connection = con
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEPT")
                sqlcom.Parameters.AddWithValue("CreatedBy", txtCreatedBy.Text)
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", IIf(cbReportParent.SelectedIndex = -1, "", cbReportParent.SelectedValue))
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_HazardReport"
                Dim da As New SqlDataAdapter(sqlcom)
                Dim ds As New DataSet()
                da.Fill(ds)
                cbDepartment.SelectedValue = ds.Tables(0).Rows(0)(0).ToString



            End If

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Function CheckSameDepartment()
        Try
            If _action <> "" Then
                Dim dt As New DataTable()
                Dim sqlcom As New SqlCommand()
                Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                sqlcom.Connection = con
                sqlcom.Parameters.AddWithValue("ACTION", "GET_DEPT")
                sqlcom.Parameters.AddWithValue("CreatedBy", txtCreatedBy.Text)
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", cbReportParent.SelectedValue)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_HazardReport"
                Dim da As New SqlDataAdapter(sqlcom)
                Dim ds As New DataSet()
                da.Fill(ds)
                If cbDepartment.SelectedValue = ds.Tables(0).Rows(0)(0).ToString() Then
                    Return True
                Else
                    Return False
                End If
            End If
            Return True
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Sub GetListReportParent()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORT_PARENT2")
            sqlcom.Parameters.AddWithValue("CreatedBy", txtCreatedBy.Text)

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbReportParent.DataSource = ds.Tables(0)
            cbReportParent.ValueMember = "Userlogin"
            cbReportParent.DisplayMember = "NPT"
            cbReportParent.SelectedIndex = -1
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub


    Public Sub GetListPersonRef()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORT_PARENT3")
            sqlcom.Parameters.AddWithValue("CreatedBy", txtCreatedBy.Text)

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbNguoiLQ.DataSource = ds.Tables(0)
            cbNguoiLQ.ValueMember = "Userlogin"
            cbNguoiLQ.DisplayMember = "NPT"
            cbNguoiLQ.SelectedIndex = -1
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Public Sub GetDocNum()
        Try
            CLICK_APPROVAL = False
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DOCNUM")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtDocNum.Text = ds.Tables(0).Rows(0)(0)
                End If
            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub GetListByDocNum()
        Try
            CLICK_APPROVAL = False
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_BY_DOC_NUM")
            sqlcom.Parameters.AddWithValue("DOCNUM", _DocNum)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtID.Text = ds.Tables(0).Rows(0)("ID")
                    dtDocDate.Value = ds.Tables(0).Rows(0)("DocDate")
                    txtDocNum.Text = ds.Tables(0).Rows(0)("DocNum")
                    dtDocTime.Value = ds.Tables(0).Rows(0)("DocTime")
                    dtCreatedTime.Value = ds.Tables(0).Rows(0)("Createdtime")
                    txtCreatedBy.Text = ds.Tables(0).Rows(0)("CreatedBy")
                    cbExternal.Checked = ds.Tables(0).Rows(0)("External")
                    cbDepartment.SelectedValue = ds.Tables(0).Rows(0)("Department")
                    cbUnsafeCondition.Checked = ds.Tables(0).Rows(0)("UnsafeCondition")
                    cbBelongtoContractor.Checked = ds.Tables(0).Rows(0)("BelongContractor")
                    cbOperation.Checked = ds.Tables(0).Rows(0)("Operation")
                    cbHR.Checked = ds.Tables(0).Rows(0)("HR")
                    cbUnsafeBehavior.Checked = ds.Tables(0).Rows(0)("UnsafeBehevior")
                    cbBelongtoBSPort.Checked = ds.Tables(0).Rows(0)("BelongToBSPort")
                    cbTechHSE.Checked = ds.Tables(0).Rows(0)("TechHSE")
                    cbAccount.Checked = ds.Tables(0).Rows(0)("Acount")
                    cbSafetySuggestion.Checked = ds.Tables(0).Rows(0)("SatetySuggestion")
                    cbTally.Checked = ds.Tables(0).Rows(0)("Tally")
                    cbProcu.Checked = ds.Tables(0).Rows(0)("Procu")
                    cbOther.Checked = ds.Tables(0).Rows(0)("Other")

                    cbNearMiss.Checked = ds.Tables(0).Rows(0)("NearMiss")
                    If ds.Tables(0).Rows(0)("Stopwork") = "True" Then
                        rdYes.Checked = True
                    Else
                        rdNo.Checked = True
                    End If
                    cbCommercial.Checked = ds.Tables(0).Rows(0)("Commercial")
                    cbHPES1.Checked = ds.Tables(0).Rows(0)("HPES1")
                    cbHPES2.Checked = ds.Tables(0).Rows(0)("HPES2")
                    cbHPES3.Checked = ds.Tables(0).Rows(0)("HPES3")
                    cbHPES4.Checked = ds.Tables(0).Rows(0)("HPES4")
                    cbHPES5.Checked = ds.Tables(0).Rows(0)("HPES5")
                    cbHPES6.Checked = ds.Tables(0).Rows(0)("HPES6")
                    cbLocation.SelectedValue = ds.Tables(0).Rows(0)("Location")
                    cbLoaiMoiNguy.SelectedValue = ds.Tables(0).Rows(0)("ID_HAZARD")
                    txtDescription.Text = ds.Tables(0).Rows(0)("Description")
                    txtApproval_User.Text = ds.Tables(0).Rows(0)("APPROVAL_USER")
                    cbApproved.Checked = ds.Tables(0).Rows(0)("IS_APPROVED")
                    cbReportParent.SelectedValue = ds.Tables(0).Rows(0)("REPORT_PARENT")

                    If cbApproved.Checked = True Then
                        btnApproval.Visible = False
                    Else
                        cbApproved.Visible = True
                    End If
                    IMG_PATCH1.Text = ds.Tables(0).Rows(0)("IMG_PATCH1")
                    IMG_PATCH2.Text = ds.Tables(0).Rows(0)("IMG_PATCH2")
                    cbTT.Checked = ds.Tables(0).Rows(0)("TT")
                    cbIS_DELETE.Checked = ds.Tables(0).Rows(0)("IS_DELETE")
                    txtComment.Text = ds.Tables(0).Rows(0)("COMMENT")
                    ptbImage_1.Image = Nothing
                    ptbImage_2.Image = Nothing
                    Try
                        Dim imageData As Byte() = DirectCast(ds.Tables(0).Rows(0)("Image_1"), Byte())
                        If Not imageData Is Nothing Then
                            If imageData.Length <> 0 Then
                                Dim ms As New MemoryStream(imageData)
                                ptbImage_1.Image = Image.FromStream(ms, True)
                            End If
                        End If
                    Catch ex As Exception
                        ptbImage_1.Image = Nothing
                    End Try

                    Try
                        Dim imageData As Byte() = DirectCast(ds.Tables(0).Rows(0)("Image_2"), Byte())
                        If Not imageData Is Nothing Then
                            If imageData.Length <> 0 Then
                                Dim ms As New MemoryStream(imageData)
                                ptbImage_2.Image = Image.FromStream(ms, True)
                            End If
                        End If
                    Catch ex As Exception
                        ptbImage_2.Image = Nothing
                    End Try

                    cbNguoiLQ.SelectedValue = ds.Tables(0).Rows(0)("NGUOILIENQUAN1")
                    txtNguoiLQ.Text = ds.Tables(0).Rows(0)("NGUOILIENQUAN2")
                    txtRandom.Text = ds.Tables(0).Rows(0)("RANDOM")
                Else
                    Call LamMoi()
                    Call AllowEdit(False)
                End If
                Call GetListDetail()
                If cbIS_DELETE.Checked = True Then
                    btnEdit.Visible = False
                    btnDelete.Visible = False

                    btnPrint.Visible = False
                Else
                    btnEdit.Visible = True
                    btnDelete.Visible = True

                    btnPrint.Visible = True
                End If
            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub GetListByID()
        Try
            CLICK_APPROVAL = False
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_BY_ID")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtID.Text = ds.Tables(0).Rows(0)("ID")
                    dtDocDate.Value = ds.Tables(0).Rows(0)("DocDate")
                    txtDocNum.Text = ds.Tables(0).Rows(0)("DocNum")
                    dtDocTime.Value = ds.Tables(0).Rows(0)("DocTime")
                    dtCreatedTime.Value = ds.Tables(0).Rows(0)("Createdtime")
                    txtCreatedBy.Text = ds.Tables(0).Rows(0)("CreatedBy")
                    cbExternal.Checked = ds.Tables(0).Rows(0)("External")
                    cbDepartment.SelectedValue = ds.Tables(0).Rows(0)("Department")
                    cbUnsafeCondition.Checked = ds.Tables(0).Rows(0)("UnsafeCondition")
                    cbBelongtoContractor.Checked = ds.Tables(0).Rows(0)("BelongContractor")
                    cbOperation.Checked = ds.Tables(0).Rows(0)("Operation")
                    cbHR.Checked = ds.Tables(0).Rows(0)("HR")
                    cbUnsafeBehavior.Checked = ds.Tables(0).Rows(0)("UnsafeBehevior")
                    cbBelongtoBSPort.Checked = ds.Tables(0).Rows(0)("BelongToBSPort")
                    cbTechHSE.Checked = ds.Tables(0).Rows(0)("TechHSE")
                    cbAccount.Checked = ds.Tables(0).Rows(0)("Acount")
                    cbSafetySuggestion.Checked = ds.Tables(0).Rows(0)("SatetySuggestion")
                    cbTally.Checked = ds.Tables(0).Rows(0)("Tally")
                    cbProcu.Checked = ds.Tables(0).Rows(0)("Procu")
                    cbOther.Checked = ds.Tables(0).Rows(0)("Other")
                    cbMT.Checked = ds.Tables(0).Rows(0)("Environment")

                    cbNearMiss.Checked = ds.Tables(0).Rows(0)("NearMiss")
                    If ds.Tables(0).Rows(0)("Stopwork") = "True" Then
                        rdYes.Checked = True
                    Else
                        rdNo.Checked = True
                    End If
                    cbCommercial.Checked = ds.Tables(0).Rows(0)("Commercial")
                    cbHPES1.Checked = ds.Tables(0).Rows(0)("HPES1")
                    cbHPES2.Checked = ds.Tables(0).Rows(0)("HPES2")
                    cbHPES3.Checked = ds.Tables(0).Rows(0)("HPES3")
                    cbHPES4.Checked = ds.Tables(0).Rows(0)("HPES4")
                    cbHPES5.Checked = ds.Tables(0).Rows(0)("HPES5")
                    cbHPES6.Checked = ds.Tables(0).Rows(0)("HPES6")
                    cbLocation.SelectedValue = ds.Tables(0).Rows(0)("Location")
                    cbLoaiMoiNguy.SelectedValue = ds.Tables(0).Rows(0)("ID_HAZARD")
                    txtDescription.Text = ds.Tables(0).Rows(0)("Description")
                    txtApproval_User.Text = ds.Tables(0).Rows(0)("APPROVAL_USER")
                    cbApproved.Checked = ds.Tables(0).Rows(0)("IS_APPROVED")
                    cbReportParent.SelectedValue = ds.Tables(0).Rows(0)("REPORT_PARENT")

                    If cbApproved.Checked = True Then
                        btnApproval.Visible = False
                    Else
                        cbApproved.Visible = True
                    End If
                    IMG_PATCH1.Text = ds.Tables(0).Rows(0)("IMG_PATCH1")
                    IMG_PATCH2.Text = ds.Tables(0).Rows(0)("IMG_PATCH2")
                    cbTT.Checked = ds.Tables(0).Rows(0)("TT")
                    cbIS_DELETE.Checked = ds.Tables(0).Rows(0)("IS_DELETE")
                    txtComment.Text = ds.Tables(0).Rows(0)("COMMENT")
                    ptbImage_1.Image = Nothing
                    ptbImage_2.Image = Nothing
                    Try
                        Dim imageData As Byte() = DirectCast(ds.Tables(0).Rows(0)("Image_1"), Byte())
                        If Not imageData Is Nothing Then
                            If imageData.Length <> 0 Then
                                Dim ms As New MemoryStream(imageData)
                                ptbImage_1.Image = Image.FromStream(ms, True)
                            End If
                        End If
                    Catch ex As Exception
                        ptbImage_1.Image = Nothing
                    End Try



                    Try
                        Dim imageData As Byte() = DirectCast(ds.Tables(0).Rows(0)("Image_2"), Byte())
                        If Not imageData Is Nothing Then
                            If imageData.Length <> 0 Then
                                Dim ms As New MemoryStream(imageData)
                                ptbImage_2.Image = Image.FromStream(ms, True)
                            End If
                        End If
                    Catch ex As Exception
                        ptbImage_2.Image = Nothing
                    End Try


                    Try
                        cbNguoiLQ.SelectedValue = ds.Tables(0).Rows(0)("NGUOILIENQUAN1")
                        txtNguoiLQ.Text = ds.Tables(0).Rows(0)("NGUOILIENQUAN2")
                        txtRandom.Text = ds.Tables(0).Rows(0)("RANDOM")
                    Catch ex As Exception

                    End Try

                Else
                    Call LamMoi()
                    Call AllowEdit(False)
                End If
                Call GetListDetail()
                If cbIS_DELETE.Checked = True Then
                    btnEdit.Visible = False
                    btnDelete.Visible = False

                    btnPrint.Visible = False
                Else
                    btnEdit.Visible = True
                    btnDelete.Visible = True

                    btnPrint.Visible = True
                End If
            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub GetListDetail()
        Try

            tb = New DataTable
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DETAIL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)

            tb = ds.Tables(0).Clone
            GridControl1.DataSource = ds.Tables(0)
            GridView1.OptionsSelection.MultiSelect = True
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None

            For i As Integer = 0 To GridView1.Columns.Count - 1

                If i <> 1 And i <> 7 Then
                    GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
                Else
                    GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
                End If
            Next
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Public Function Save(ByVal Action As String, ByVal tb As DataTable) As [Boolean]
        Dim dt As New DataTable()
        Dim transaction As SqlTransaction = Nothing
        Using con As New SqlConnection(Commons.IConnections.ConnectionString())
            Dim sqlcom As SqlCommand = con.CreateCommand()
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                transaction = con.BeginTransaction("Transaction")
                sqlcom.Connection = con
                sqlcom.Transaction = transaction
                sqlcom.Parameters.AddWithValue("ACTION", Action)
                sqlcom.Parameters.AddWithValue("ID", txtID.Text)
                sqlcom.Parameters.AddWithValue("DocNum", txtDocNum.Text)
                sqlcom.Parameters.AddWithValue("DocDate", dtDocDate.Value)
                sqlcom.Parameters.AddWithValue("DocTime", dtDocTime.Value)
                sqlcom.Parameters.AddWithValue("Createdtime", dtCreatedTime.Value)
                sqlcom.Parameters.AddWithValue("CreatedBy", txtCreatedBy.Text)
                sqlcom.Parameters.AddWithValue("Department", cbDepartment.SelectedValue)
                sqlcom.Parameters.AddWithValue("REPORT_PARENT", cbReportParent.SelectedValue)
                sqlcom.Parameters.AddWithValue("UnsafeCondition", cbUnsafeCondition.Checked)
                sqlcom.Parameters.AddWithValue("BelongContractor", cbBelongtoContractor.Checked)
                sqlcom.Parameters.AddWithValue("Operation", cbOperation.Checked)
                sqlcom.Parameters.AddWithValue("HR", cbHR.Checked)
                sqlcom.Parameters.AddWithValue("NearMiss", cbNearMiss.Checked)
                sqlcom.Parameters.AddWithValue("UnsafeBehevior", cbUnsafeBehavior.Checked)
                sqlcom.Parameters.AddWithValue("BelongToBSPort", cbBelongtoBSPort.Checked)
                sqlcom.Parameters.AddWithValue("TechHSE", cbTechHSE.Checked)
                sqlcom.Parameters.AddWithValue("Acount", cbAccount.Checked)
                sqlcom.Parameters.AddWithValue("SatetySuggestion", cbSafetySuggestion.Checked)
                sqlcom.Parameters.AddWithValue("Tally", cbTally.Checked)
                sqlcom.Parameters.AddWithValue("Procu", cbProcu.Checked)
                sqlcom.Parameters.AddWithValue("Other", cbOther.Checked)
                sqlcom.Parameters.AddWithValue("Environment", cbMT.Checked)
                sqlcom.Parameters.AddWithValue("External", cbExternal.Checked)

                If rdYes.Checked = True Then
                    sqlcom.Parameters.AddWithValue("Stopwork", True)
                Else
                    sqlcom.Parameters.AddWithValue("Stopwork", False)
                End If

                sqlcom.Parameters.AddWithValue("Commercial", cbCommercial.Checked)
                sqlcom.Parameters.AddWithValue("HPES1", cbHPES1.Checked)
                sqlcom.Parameters.AddWithValue("HPES2", cbHPES2.Checked)
                sqlcom.Parameters.AddWithValue("HPES3", cbHPES3.Checked)
                sqlcom.Parameters.AddWithValue("HPES4", cbHPES4.Checked)
                sqlcom.Parameters.AddWithValue("HPES5", cbHPES5.Checked)
                sqlcom.Parameters.AddWithValue("HPES6", cbHPES6.Checked)
                sqlcom.Parameters.AddWithValue("Location", cbLocation.SelectedValue)
                sqlcom.Parameters.AddWithValue("ID_HAZARD", cbLoaiMoiNguy.SelectedValue)
                sqlcom.Parameters.AddWithValue("Description", txtDescription.Text)
                sqlcom.Parameters.AddWithValue("IS_APPROVED", cbApproved.Checked)
                sqlcom.Parameters.AddWithValue("APPROVAL_USER", txtApproval_User.Text)
                sqlcom.Parameters.AddWithValue("IMG_PATCH1", IMG_PATCH1.Text)
                sqlcom.Parameters.AddWithValue("IMG_PATCH2", IMG_PATCH2.Text)
                sqlcom.Parameters.AddWithValue("TT", cbTT.Checked)
                sqlcom.Parameters.AddWithValue("COMMENT", txtComment.Text)
                sqlcom.Parameters.AddWithValue("NGUOILIENQUAN1", cbNguoiLQ.SelectedValue)

                Dim img = New ImageConverter()
                If ptbImage_1.Image IsNot Nothing Then
                    sqlcom.Parameters.AddWithValue("Image_1", imgToByteConverter(DirectCast(img.ConvertTo(ptbImage_1.Image, GetType(Byte())), Byte())))
                End If

                If ptbImage_2.Image IsNot Nothing Then
                    sqlcom.Parameters.AddWithValue("Image_2", imgToByteConverter(DirectCast(img.ConvertTo(ptbImage_2.Image, GetType(Byte())), Byte())))
                End If

                If txtNguoiLQ.TextLength > 0 Then
                    If Commons.Modules.TypeLanguage = 0 Then
                        txtNguoiLQ.Text = txtNguoiLQ.Text.Replace("Ví dụ: Lê Văn Hùng", "")
                    Else
                        txtNguoiLQ.Text = txtNguoiLQ.Text.Replace("Ex: Le Van Hung", "")
                    End If
                End If
                sqlcom.Parameters.AddWithValue("NGUOILIENQUAN2", txtNguoiLQ.Text)
                sqlcom.Parameters.AddWithValue("RANDOM", txtRandom.Text)
                'Try
                '    Dim data As Byte() = Nothing
                '    data = ImageToByte(PictureBox6.Image)
                '    Dim p As New SqlParameter("Picture", SqlDbType.Image)
                '    p.Value = data
                '    sqlcom.Parameters.Add(p)
                'Catch ex As Exception
                '    sqlcom.Parameters.AddWithValue("Picture", Nothing)
                'End Try

                sqlcom.Parameters.AddWithValue("@CLICK_APPROVAL", CLICK_APPROVAL)
                If (tb IsNot Nothing) Then
                    sqlcom.Parameters.AddWithValue("@TB", tb)
                End If
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_HazardReport"
                sqlcom.ExecuteNonQuery()

                transaction.Commit()
                Return True
            Catch ex As Exception
                _ErrorMsg = ex.Message.ToString()
                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
                Return False
            Finally
                con.Close()
            End Try
        End Using
    End Function

    Public Shared Function ImageToByte(ByVal img As Image) As Byte()
        Dim converter As New ImageConverter()
        Return DirectCast(converter.ConvertTo(img, GetType(Byte())), Byte())
    End Function
    Public Function Delete() As [Boolean]
        Dim dt As New DataTable()
        Dim transaction As SqlTransaction = Nothing
        Using con As New SqlConnection(Commons.IConnections.ConnectionString())
            Dim sqlcom As SqlCommand = con.CreateCommand()
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                transaction = con.BeginTransaction("Transaction")
                sqlcom.Connection = con
                sqlcom.Transaction = transaction
                sqlcom.Parameters.AddWithValue("ACTION", "DELETE")
                sqlcom.Parameters.AddWithValue("ID", txtID.Text)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_HazardReport"
                sqlcom.ExecuteNonQuery()
                transaction.Commit()
                Return True
            Catch ex As Exception
                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
                Return False
            Finally
                con.Close()
            End Try
        End Using
    End Function
#End Region
#Region "Lam moi"
    Private Sub LamMoi()
        txtRandom.Text = ""
        txtID.Text = ""
        dtDocDate.Value = Now.Date
        txtDocNum.Text = ""
        dtDocTime.Value = Now
        dtCreatedTime.Value = Now
        txtCreatedBy.Text = ""
        cbReportParent.SelectedIndex = -1
        cbDepartment.SelectedIndex = -1
        cbTT.Checked = False
        cbUnsafeCondition.Checked = True
        cbBelongtoContractor.Checked = True
        cbOperation.Checked = True
        cbHR.Checked = False
        cbNearMiss.Checked = False
        cbUnsafeBehavior.Checked = False
        cbBelongtoBSPort.Checked = False
        cbTechHSE.Checked = False
        cbAccount.Checked = False
        cbSafetySuggestion.Checked = False
        cbTally.Checked = False
        cbProcu.Checked = False
        cbOther.Checked = False
        cbMT.Checked = False
        cbExternal.Checked = False
        rdYes.Checked = False
        rdNo.Checked = True
        cbCommercial.Checked = False
        cbHPES1.Checked = False
        cbHPES2.Checked = False
        cbHPES3.Checked = False
        cbHPES4.Checked = False
        cbHPES5.Checked = False
        cbHPES6.Checked = False
        cbLocation.SelectedIndex = -1
        cbLoaiMoiNguy.SelectedIndex = -1
        txtDescription.Text = ""
        GridControl1.DataSource = tb
        ptbImage_1.Image = Nothing
        ptbImage_2.Image = Nothing
        cbApproved.Checked = False
        cbIS_DELETE.Checked = False
        txtApproval_User.Text = ""
        IMG_PATCH1.Text = ""
        IMG_PATCH2.Text = ""
        cbNguoiLQ.SelectedIndex = -1
        txtNguoiLQ.Text = ""
        txtComment.Text = ""
        GridView1.OptionsSelection.MultiSelect = True
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        Call AllowEdit(True)
        Call LockGrid(False)
        dtDocDate.Focus()

    End Sub
    Private Sub AllowEdit(ByVal tt As Boolean)
        dtDocDate.Enabled = tt
        txtDocNum.Enabled = tt
        dtDocTime.Enabled = tt
        dtCreatedTime.Enabled = False
        txtCreatedBy.Enabled = tt
        cbDepartment.Enabled = False
        cbUnsafeCondition.Enabled = tt
        cbBelongtoContractor.Enabled = tt
        cbOperation.Enabled = tt
        cbHR.Enabled = tt
        cbNearMiss.Enabled = tt
        cbUnsafeBehavior.Enabled = tt
        cbBelongtoBSPort.Enabled = tt
        cbTechHSE.Enabled = tt
        cbAccount.Enabled = tt
        cbSafetySuggestion.Enabled = tt
        cbTally.Enabled = tt
        cbProcu.Enabled = tt
        cbOther.Enabled = tt
        cbMT.Enabled = tt
        cbExternal.Enabled = tt
        rdYes.Enabled = tt
        rdNo.Enabled = tt
        cbCommercial.Enabled = tt
        cbHPES1.Enabled = tt
        cbHPES2.Enabled = tt
        cbHPES3.Enabled = tt
        cbHPES4.Enabled = tt
        cbHPES5.Enabled = tt
        cbHPES6.Enabled = tt
        cbTT.Enabled = tt
        cbLocation.Enabled = tt
        cbLoaiMoiNguy.Enabled = tt
        txtDescription.Enabled = tt
        cbReportParent.Enabled = tt
        btnTKBCT.Enabled = tt
        cbNguoiLQ.Enabled = tt
        txtNguoiLQ.Enabled = tt
        If _action = "UPDATE" Then
            If fnCheckAdminUser() = False And DungChung.Login.ToUpper() <> txtCreatedBy.Text.ToUpper() Then
                txtDescription.Enabled = False
            Else
                txtDescription.Enabled = tt
            End If
        End If
        txtComment.Enabled = tt
    End Sub
    Private Sub LockGrid(ByVal TT As Boolean)
        For i As Integer = 0 To GridView1.Columns.Count - 1
            If i <> 1 And i <> 2 And i <> 3 And i <> 4 And i <> 5 And i <> 10 And i <> 11 And i <> 12 And i <> 13 And i <> 14 And i <> 15 Then
                GridView1.Columns(i).OptionsColumn.AllowEdit = False
                GridView1.Columns(i).OptionsColumn.AllowFocus = False
            Else
                GridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
                GridView1.Columns(i).OptionsColumn.AllowFocus = Not TT
            End If
        Next
    End Sub
    Private Sub EnableButton(ByVal tt As Boolean)
        'btnSave.Enabled = tt
        'btnCancel.Enabled = tt
        'btnEdit.Enabled = Not tt
        'btnNew.Enabled = Not tt
        'btnDelete.Enabled = Not tt
        btnApproval.Visible = tt
        If fnCheckAdminUser() = False And fnCheckApprovalUser() = False Then
            btnApproval.Visible = False
            btnCancelApproval.Visible = False
        End If

        btnTKBCT.Enabled = tt
        btnSave.Visible = tt
        btnCancel.Visible = tt
        btnAdd_Edit.Visible = Not tt
        btnEdit.Visible = Not tt
        btnDelete.Visible = Not tt
        btnPrint.Visible = Not tt
        btnExit.Visible = Not tt

        btnChoose.Visible = Not tt
        btNguoiLQ.Enabled = tt
        btnXoa.Visible = tt
        btnChon.Visible = tt
        btnXoa1.Visible = tt
        btnChon1.Visible = tt

    End Sub
#End Region
    Private Sub curID_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Call GetListByID()
    End Sub

    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub
    Private Function GetHVKAT_ENG()
        Dim hvkat As String = ""
        If cbUnsafeCondition.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbUnsafeCondition", 1)
            Else
                hvkat = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbUnsafeCondition", 1)
            End If
        End If
        If cbUnsafeBehavior.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbUnsafeBehavior", 1)
            Else
                hvkat = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbUnsafeBehavior", 1)
            End If
        End If
        If cbSafetySuggestion.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbSafetySuggestion", 1)
            Else
                hvkat = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbSafetySuggestion", 1)
            End If
        End If
        If cbNearMiss.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbNearMiss", 1)
            Else
                hvkat = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbNearMiss", 1)
            End If
        End If
        If cbOther.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbOther", 1)
            Else
                hvkat = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbOther", 1)
            End If
        End If


        'If cbBelongtoContractor.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbBelongtoContractor.Text
        '    Else
        '        hvkat = cbBelongtoContractor.Text
        '    End If
        'End If
        'If cbBelongtoBSPort.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbBelongtoBSPort.Text
        '    Else
        '        hvkat = cbBelongtoBSPort.Text
        '    End If
        'End If
        'If cbTally.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbTally.Text
        '    Else
        '        hvkat = cbTally.Text
        '    End If
        'End If
        'If cbOperation.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbOperation.Text
        '    Else
        '        hvkat = cbOperation.Text
        '    End If
        'End If
        'If cbTechHSE.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbTechHSE.Text
        '    Else
        '        hvkat = cbTechHSE.Text
        '    End If
        'End If
        'If cbProcu.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbProcu.Text
        '    Else
        '        hvkat = cbProcu.Text
        '    End If
        'End If
        'If cbHR.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbHR.Text
        '    Else
        '        hvkat = cbHR.Text
        '    End If
        'End If
        'If cbAccount.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbAccount.Text
        '    Else
        '        hvkat = cbAccount.Text
        '    End If
        'End If
        'If cbCommercial.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbCommercial.Text
        '    Else
        '        hvkat = cbCommercial.Text
        '    End If
        'End If
        'If rdYes.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & Label10.Text
        '    Else
        '        hvkat = Label10.Text
        '    End If
        'End If
        Return hvkat
    End Function

    Private Function GetHVKAT()
        Dim hvkat As String = ""
        If cbUnsafeCondition.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & cbUnsafeCondition.Text
            Else
                hvkat = cbUnsafeCondition.Text
            End If
        End If
        If cbUnsafeBehavior.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & cbUnsafeBehavior.Text
            Else
                hvkat = cbUnsafeBehavior.Text
            End If
        End If
        If cbSafetySuggestion.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & cbSafetySuggestion.Text
            Else
                hvkat = cbSafetySuggestion.Text
            End If
        End If
        If cbNearMiss.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & cbNearMiss.Text
            Else
                hvkat = cbNearMiss.Text
            End If
        End If
        If cbOther.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & cbOther.Text
            Else
                hvkat = cbOther.Text
            End If
        End If


        'If cbBelongtoContractor.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbBelongtoContractor.Text
        '    Else
        '        hvkat = cbBelongtoContractor.Text
        '    End If
        'End If
        'If cbBelongtoBSPort.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbBelongtoBSPort.Text
        '    Else
        '        hvkat = cbBelongtoBSPort.Text
        '    End If
        'End If
        'If cbTally.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbTally.Text
        '    Else
        '        hvkat = cbTally.Text
        '    End If
        'End If
        'If cbOperation.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbOperation.Text
        '    Else
        '        hvkat = cbOperation.Text
        '    End If
        'End If
        'If cbTechHSE.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbTechHSE.Text
        '    Else
        '        hvkat = cbTechHSE.Text
        '    End If
        'End If
        'If cbProcu.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbProcu.Text
        '    Else
        '        hvkat = cbProcu.Text
        '    End If
        'End If
        'If cbHR.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbHR.Text
        '    Else
        '        hvkat = cbHR.Text
        '    End If
        'End If
        'If cbAccount.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbAccount.Text
        '    Else
        '        hvkat = cbAccount.Text
        '    End If
        'End If
        'If cbCommercial.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & cbCommercial.Text
        '    Else
        '        hvkat = cbCommercial.Text
        '    End If
        'End If
        'If rdYes.Checked = True Then
        '    If hvkat.Length > 0 Then
        '        hvkat = hvkat & "," & Label10.Text
        '    Else
        '        hvkat = Label10.Text
        '    End If
        'End If
        Return hvkat
    End Function

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        _ErrorMsg = ""
        If Not fnValid() Then
            Exit Sub
        End If
        Dim tenngvp As String = txtNguoiLQ.Text
        If Save(_action, CType(GridControl1.DataSource, DataTable)) Then

            Call SaveOtherUserEditDocument("DELETE")
            CLICK_APPROVAL = False
            Dim mailTo As String = ""
            Dim subject As String = ""
            Dim subjectEng As String = ""
            Dim body As String = ""
            Dim bodyEng As String = ""
            Dim ReportVN As String = ""
            Dim ReportEng As String = ""


            If _action = "ADD" Then
                txtID.Text = GET_DOC_ID().ToString()
                If fnNguoiTaoLaNguoiDuyet(txtID.Text) Then
                    sentmailType = 1
                End If
            End If

            If (_action = "ADD" Or _action = "UPDATE") And sentmailType = -1 Then
                If fnCheckApprovalUser() = False Then
                    If txtCreatedBy.Text.ToUpper() = DungChung.Login.ToUpper Then
                        If fnCheckApprovedDocument() = True Then
                            sentmailType = -1
                        Else
                            sentmailType = 0
                        End If
                    Else
                        sentmailType = -1
                    End If
                Else
                    If fnCheckApprovedDocument() = True Then
                        sentmailType = -1
                    Else
                        If txtCreatedBy.Text.ToUpper() = DungChung.Login.ToUpper Then
                            sentmailType = 0
                        Else
                            If txtApproval_User.Text <> "" Then
                                sentmailType = 1
                            Else
                                sentmailType = 0
                            End If
                        End If

                    End If
                End If
            End If

            Select Case sentmailType
                Case 0 'Gui toi nguoi duyet'
                    mailTo = fnGetListMailApproval()
                    If mailTo <> "" Then
                        mailTo = GetListMailTo(mailTo)
                    End If
                    subject = "Duyệt Báo cáo từ Ecomaint/Safety"
                    subjectEng = "Please review reports from Ecomaint/Safety"
                    Dim dearto As String = fnGET_DEAR_APPROVAL()
                    If dearto <> "" Then
                        dearto = GetListDearTo(dearto)
                    End If
                    ReportVN = GetHVKAT()
                    ReportEng = GetHVKAT_ENG()
                    body = "Dear <b>" & dearto & "</b> <br>" &
                           "+ Cần duyệt báo cáo về: <b>" & "@TVT_REPORT_VN@" & "</b> <br>" &
                           "+ Người báo cáo: <b>" & fnGetReporter(txtCreatedBy.Text) & "</b><br>" &
                           "+ Ngày báo cáo: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b><br>" &
                           "+ Số chứng từ: <b>" & txtDocNum.Text & "</b><br>" &
                           "+ Nội dung/nguyên nhân: <b>" & txtDescription.Text & "</b><br>" &
                           "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để duyệt Báo cáo.<br>Thanks & Best regards.<br><br><br>"

                    bodyEng = "Dear <b>" & dearto & "</b> <br>" &
                           "+ Need to review reports of: <b>" & "@TVT_REPORT_ENG@" & "</b> <br>" &
                           "+ Reporter: <b>" & fnGetReporter(txtCreatedBy.Text) & "</b><br>" &
                           "+ Report Date: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b><br>" &
                           "+ Doc. No.: <b>" & txtDocNum.Text & "</b><br>" &
                           "+ Description/ Cause: <b>" & txtDescription.Text & "</b><br>" &
                           "Please log in Ecomaint/Safety Software to review reports.<br>Thanks & Best regards.<br><br><br>"
                Case 1 'Gui toi nguoi thuc hien'
                    mailTo = fnGetListMailIncharge()
                    If mailTo <> "" Then
                        mailTo = GetListMailTo(mailTo)
                    End If
                    subject = "Thực hiện Hành động khắc phục, phòng ngừa từ Ecomaint/Safety"
                    subjectEng = "Please complete preventive and corrective actions from Ecomaint/ Safety"
                    Dim dearto As String = fnGET_DEAR_INCHARGE()
                    If dearto <> "" Then
                        dearto = GetListDearTo(dearto)
                    End If
                    ReportVN = GetHVKAT()
                    ReportEng = GetHVKAT_ENG()

                    Dim nduyet As String = fnGetApproval(txtApproval_User.Text)
                    body = "Dear <b>" & dearto & "</b> <br>" &
                           "+ Báo cáo: <b>" & "@TVT_REPORT_VN@" & "</b> <br>" &
                           "+ Người báo cáo: <b>" & fnGetReporter(txtCreatedBy.Text) & "</b><br>" &
                           "+ Ngày báo cáo: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b><br>" &
                           "+ Người duyệt: <b>" & IIf(nduyet = "", txtApproval_User.Text, nduyet) & "</b><br>" &
                           "+ Số chứng từ: <b>" & txtDocNum.Text & "</b><br>" &
                           "+ Nội dung/nguyên nhân: <b>" & txtDescription.Text & "</b><br>" &
                           "+ Hành động cần thực hiện: <br>"

                    bodyEng = "Dear <b>" & dearto & "</b> <br>" &
                           "+ Report: <b>" & "@TVT_REPORT_ENG@" & "</b> <br>" &
                           "+ Reporter: <b>" & fnGetReporter(txtCreatedBy.Text) & "</b><br>" &
                           "+ Report Date: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b><br>" &
                           "+ Reviewed by: <b>" & IIf(nduyet = "", txtApproval_User.Text, nduyet) & "</b><br>" &
                           "+ Doc. No.: <b>" & txtDocNum.Text & "</b><br>" &
                           "+ Description/ Cause: <b>" & txtDescription.Text & "</b><br>" &
                           "+ Required Actions: <br>"
                    Dim dt As DataTable = fnGetListAction()
                    If dt.Rows.Count > 0 Then
                        For i As Integer = 0 To dt.Rows.Count - 1
                            body = body & "&nbsp;&nbsp;&nbsp;" & (i + 1).ToString() & ".&nbsp;&nbsp;<b>" & dt.Rows(i)(0).ToString() & "</b><br>"
                            bodyEng = bodyEng & "&nbsp;&nbsp;&nbsp;" & (i + 1).ToString() & ".&nbsp;&nbsp;<b>" & dt.Rows(i)(0).ToString() & "</b><br>"
                        Next
                    End If
                    body = body & "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện các hành động khắc phục, phòng ngừa được đề xuất theo đúng thời hạn.<br>Thanks & Best regards.<br><br><br>"
                    bodyEng = bodyEng & "Please log in Ecomaint/Safety Software to complete required actions.<br>Thanks & Best regards.<br><br><br>"
                Case 2 'Gui toi nguoi tao va nguoi duyet'
                    mailTo = fnGetListMailApprovalAndCreatedBy()
                    If mailTo <> "" Then
                        mailTo = GetListMailTo(mailTo)
                    End If
                    subject = "Hoàn tất hành động khắc phục, phòng ngừa từ Ecomaint/Safety"
                    subjectEng = "Completed preventive and corrective actions from Ecomaint/Safety"
                    Dim dearto As String = GET_DEAR_APPROVAL_CREATE_BY()
                    If dearto <> "" Then
                        dearto = GetListDearTo(dearto)
                    End If
                    Dim nduyet As String = fnGetApproval(txtApproval_User.Text)
                    Dim nth As String = fnGetApproval(DungChung.Login)
                    body = "Dear <b>" & dearto & "</b> <br>" &
                           "+ Báo cáo: <b>Kết quả thực hiện hành động khắc phục, phòng ngừa từ Ecomaint/Safety</b><br>" &
                           "+ Người báo cáo: <b>" & fnGetReporter(txtCreatedBy.Text) & "</b><br>" &
                           "+ Ngày báo cáo: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b><br>" &
                           "+ Người duyệt: <b>" & IIf(nduyet = "", txtApproval_User.Text, nduyet) & "</b><br>" &
                           "+ Người thực hiện: <b>" & IIf(nth = "", DungChung.Login, nth) & "</b><br>" &
                           "+ Số chứng từ: <b>" & txtDocNum.Text & "</b><br>" &
                           "+ Nội dung/nguyên nhân: <b>" & txtDescription.Text & "</b><br>" &
                           "+ Hành động đã hoàn tất:  <br>"

                    bodyEng = "Dear <b>" & dearto & "</b> <br>" &
                           "+ Report: <b>Result of preventive and corrective actions</b><br>" &
                           "+ Reporter: <b>" & fnGetReporter(txtCreatedBy.Text) & "</b><br>" &
                           "+ Report Date: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b><br>" &
                           "+ Reviewed by: <b>" & IIf(nduyet = "", txtApproval_User.Text, nduyet) & "</b><br>" &
                           "+ Person in charge: <b>" & IIf(nth = "", DungChung.Login, nth) & "</b><br>" &
                           "+ Doc. No.: <b>" & txtDocNum.Text & "</b><br>" &
                           "+ Description/ Cause: <b>" & txtDescription.Text & "</b><br>" &
                           "+ Action done:  <br>"

                    Dim dt As DataTable = fnGetListActionDone()
                    If dt.Rows.Count > 0 Then
                        For i As Integer = 0 To dt.Rows.Count - 1
                            body = body & "&nbsp;&nbsp;&nbsp;<b>" & (i + 1).ToString() & ".&nbsp;&nbsp;" & dt.Rows(i)(0).ToString() & "</b><br>"
                            bodyEng = bodyEng & "&nbsp;&nbsp;&nbsp;<b>" & (i + 1).ToString() & ".&nbsp;&nbsp;" & dt.Rows(i)(0).ToString() & "</b><br>"
                        Next
                    End If
                    body = body & "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để xác nhận thông tin báo cáo.<br>Thanks & Best regards.<br><br><br>"
                    bodyEng = bodyEng & "Please log in Ecomaint/Safety Software to confirm information.<br>Thanks & Best regards.<br><br><br>"
            End Select
            'XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "LUUDLTC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
            If sentmailType <> -1 And sentmailType <> 3 Then
                If mailTo <> "" Then
                    Dim frm As New FrmXNGuiMail(mailTo, subject, body, subjectEng, bodyEng, ReportVN, ReportEng)
                    frm.ShowDialog()
                End If
            End If
            If tenngvp <> "" Then
                Dim slvp As Integer = fnGetSoLanViPham(tenngvp)
                If slvp > 0 Then
                    If Commons.Modules.TypeLanguage = 0 Then
                        XtraMessageBox.Show(txtNguoiLQ.Text & " đã vi phạm " & slvp.ToString() & " lần!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Else
                        XtraMessageBox.Show(txtNguoiLQ.Text & " had violated " & slvp.ToString() & IIf(slvp > 1, " times!", " time!"), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    End If
                End If
            End If


            reportID = ""
            ''MessageBox.Show(Me, "Lưu dữ liệu thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information)
            EnableButton(False)
            Call GetListByID()
            LockGrid(True)
            AllowEdit(False)
            LockGrid(True)
            GridView1.OptionsSelection.MultiSelect = True
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            _action = ""
            btnCancelApproval.Visible = False
            sentmailType = -1
        Else
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "LUUDLLOI", Commons.Modules.TypeLanguage) & vbNewLine & _ErrorMsg, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Không thể lưu dữ liệu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End If
    End Sub
    Private Function fnGetApproval(ByVal user As String)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORTER_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", user)
            sqlcom.Parameters.AddWithValue("REPORT_PARENT", cbReportParent.SelectedValue)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd_Edit.Click
        _action = "ADD"
        txtID.Text = ""
        _ErrorMsg = ""
        EnableButton(True)
        LamMoi()
        GetDocNum()
        txtCreatedBy.Text = DungChung.Login
        txtCreatedBy.Enabled = False
        txtDocNum.Enabled = False
        btnApproval.Visible = False
        sentmailType = 0
        reportID = ""
        cbHPES6.Checked = True
        If Commons.Modules.TypeLanguage = 0 Then
            txtNguoiLQ.Text = "Ví dụ: Lê Văn Hùng"
        Else
            txtNguoiLQ.Text = "Ex: Le Van Hung"
        End If
        Dim rd As New Random()
        txtRandom.Text = DungChung.Login & Now.TimeOfDay.Ticks.ToString() & rd.Next(1000, 99999).ToString()
    End Sub
    Private Sub LockColumnGrid(ByVal TT As Boolean)
        For i As Integer = 0 To GridView1.Columns.Count - 1
            If i <> 1 And i <> 2 And i <> 3 And i <> 4 And i <> 5 And i <> 10 And i <> 11 And i <> 12 And i <> 13 And i <> 14 And i <> 15 Then
                GridView1.Columns(i).OptionsColumn.AllowEdit = False
                GridView1.Columns(i).OptionsColumn.AllowFocus = False
            Else
                GridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
                GridView1.Columns(i).OptionsColumn.AllowFocus = Not TT
            End If

        Next
        If TT = True Then
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        Else
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        End If

    End Sub
    Private Sub btnEdit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        If txtID.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "CHUACHONCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần chỉnh sửa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckOtherUserEditDocument() = True Then
            _action = ""
            LamMoi()
            EnableButton(False)
            AllowEdit(False)
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            Call LockGrid(True)
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "CHUNGTUNGUOIKHACCS", Commons.Modules.TypeLanguage) & " " & _userEdit, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Chứng từ đang được người dùng '" & _userEdit & "' chỉnh sửa." & vbNewLine & "Vui lòng chọn chứng từ khác!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        btnCancelApproval.Visible = False
        If cbApproved.Checked = True Then 'Chung tu da duoc duyet
            btNguoiLQ.Enabled = False
            If fnCheckAdminUser() = False And fnCheckApprovalUser() = False Then 'User khong co quyen duyet chung tu
                If fnCheckAdminUser() = False And DungChung.Login.ToUpper() = txtCreatedBy.Text.ToUpper() And fnCheckApprovedDocument() = True And fnCheckUser() = False Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "CHUNGTUDADUOCDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Chứng từ đã được duyệt bạn không được phép chỉnh sửa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Exit Sub
                Else
                    If fnCheckUser() = False And fnCheckAdminUser() = False Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGDUOCPHEPCHINHSUA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        ' MessageBox.Show(Me, "Bạn không được phép chỉnh sửa chứng từ!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        Exit Sub
                    End If
                    _action = "UPDATE"
                    EnableButton(True)
                    'AllowEdit(True)
                    AllowEdit(False)
                    GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
                    Call LockGrid(False)
                    txtDocNum.Enabled = False
                    dtDocDate.Enabled = False
                    dtCreatedTime.Enabled = False
                    dtDocTime.Enabled = False
                    txtCreatedBy.Enabled = False
                    btnApproval.Visible = False

                    btnChon.Visible = False
                    btnXoa.Visible = False
                    btnChon1.Visible = False
                    btnXoa1.Visible = False
                    If txtApproval_User.Text.ToUpper() <> DungChung.Login.ToUpper() Then
                        LockColumnGrid(True)
                    Else
                        LockColumnGrid(False)
                    End If
                End If
            Else 'User co quyen duyet chung tu
                _action = "UPDATE"
                EnableButton(True)
                AllowEdit(True)
                GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
                Call LockGrid(False)
                txtDocNum.Enabled = False
                dtDocDate.Enabled = False
                dtCreatedTime.Enabled = False
                dtDocTime.Enabled = False
                txtCreatedBy.Enabled = False
                btnApproval.Visible = False

                If _action = "UPDATE" Then
                    If cbApproved.Checked = False Then
                        GridControl1.ContextMenuStrip = Nothing
                    Else
                        GridControl1.ContextMenuStrip = ContextMenuStrip1
                    End If
                Else
                    GridControl1.ContextMenuStrip = Nothing
                End If

                If fnCheckApprovedDocument() = True Then
                    btNguoiLQ.Enabled = False
                    LockColumnGrid(True)
                    If DungChung.Login.ToUpper() <> txtApproval_User.Text.ToUpper() Then
                        AllowEdit(False)
                        btnChon.Visible = False
                        btnXoa.Visible = False
                        btnChon1.Visible = False
                        btnXoa1.Visible = False
                        If fnCheckAdminUser() = False Then
                            btnCancelApproval.Visible = False
                        Else
                            btnCancelApproval.Visible = True
                        End If
                    Else
                        AllowEdit(False)
                        btnChon.Visible = False
                        btnXoa.Visible = False
                        btnChon1.Visible = False
                        btnXoa1.Visible = False

                        btnCancelApproval.Visible = True


                    End If
                Else
                    If fnCheckAdminUser() = False And DungChung.Login.ToUpper() = txtCreatedBy.Text.ToUpper() Then
                        LockColumnGrid(False)
                    Else
                        LockColumnGrid(True)
                    End If
                End If
            End If
        Else 'Chung tu chua duoc duyet
            If fnCheckAdminUser() = False And fnCheckApprovalUser() = False Then
                If fnCheckAdminUser() = False And fnCheckUser() = False Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGDUOCPHEPCHINHSUA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn không được phép chỉnh sửa chứng từ!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Exit Sub
                End If
            End If
            _action = "UPDATE"
            EnableButton(True)
            AllowEdit(True)
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
            Call LockGrid(False)
            txtDocNum.Enabled = False
            dtDocDate.Enabled = False
            dtCreatedTime.Enabled = False
            dtDocTime.Enabled = False
            txtCreatedBy.Enabled = False
            If fnCheckApprovedDocument() = True Then
                AllowEdit(False)
                btnChon.Visible = False
                btnXoa.Visible = False
                btnChon1.Visible = False
                btnXoa1.Visible = False
                LockColumnGrid(True)
            Else
                If fnCheckApprovalUser() = False Then
                    If DungChung.Login.ToUpper() = txtCreatedBy.Text.ToUpper() Or fnCheckAdminUser() = True Then
                        LockColumnGrid(False)
                    Else
                        AllowEdit(False)
                        btnChon.Visible = False
                        btnXoa.Visible = False
                        btnChon1.Visible = False
                        btnXoa1.Visible = False
                        LockColumnGrid(True)
                    End If
                Else
                    LockColumnGrid(False)
                End If

            End If
        End If
        Call SaveOtherUserEditDocument("ADD")
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Call SaveOtherUserEditDocument("DELETE")
        Call GetListByID()
        LockGrid(True)
        AllowEdit(False)
        EnableButton(False)
        GridView1.OptionsSelection.MultiSelect = True
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        _action = ""
        btnCancelApproval.Visible = False
        sentmailType = -1
        reportID = ""
    End Sub

    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        If txtID.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "CHUACHONCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần xóa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If

        If fnCheckAdminUser() = False And fnCheckApprovedDocument() = True Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "CHUNGTUDADUOCDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Chứng từ đã được duyệt không thể xóa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckOtherUserEditDocument() = True Then
            _action = ""
            LamMoi()
            EnableButton(False)
            AllowEdit(False)
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            Call LockGrid(True)
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "CHUNGTUNGUOIKHACCS", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Chứng từ đang được người dùng '" & _userEdit & "' chỉnh sửa." & vbNewLine & "Vui lòng chọn chứng từ khác!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And fnCheckUser() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGDUOCPHEPXOA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn không được phép xóa chứng từ!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XACNHANXOACHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            'If MessageBox.Show("Bạn có chắc muốn xóa chứng từ đang chọn?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then

            Dim mailTo As String = ""
            Dim subject As String = "Xóa báo cáo"
            Dim body As String = ""
            Dim subjectEng As String = "Delete Report"
            Dim bodyEng As String = ""
            mailTo = fnGetListMailCreatedBy()
            If mailTo <> "" Then
                mailTo = GetListMailTo(mailTo)
            End If
            Dim dearto As String = GET_DEAR_CREATE_BY()
            If dearto <> "" Then
                dearto = GetListDearTo(dearto)
            End If
            Dim nguoixoa As String = fnGetReporter(DungChung.Login)
            If nguoixoa = "" Then
                nguoixoa = DungChung.Login
            End If
            body = "Dear <b>" & dearto & "</b> <br>" &
             "<b>" & nguoixoa & "</b> đã xóa chứng từ <b>" + txtDocNum.Text + "</b><br>" &
             "Lý do xóa: <b> @LYDO@ </b><br>" &
             "Vui lòng cẩn thận trước khi tạo báo cáo tránh tình trạng báo cáo không đúng.<br>Thanks & Best regards.<br><br><br>"
            bodyEng = "Dear <b>" & dearto & "</b> <br>" &
             "<b>" & nguoixoa & "</b> removed Doc No. <b>" + txtDocNum.Text + "</b><br>" &
             "Reason for delete: <b> @LYDO@ </b><br>" &
             "Please be careful before you create the report avoids the incorrect report status.<br>Thanks & Best regards.<br><br><br>"
            If Delete() Then
                'mailTo = "traitv@vietsoft.com.vn"
                _deleteID = txtID.Text
                If mailTo <> "" Then
                    Dim frm As New FrmXNGuiMail(mailTo, subject, body, True, subjectEng, bodyEng)
                    frm.ShowDialog()
                End If
                'XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XOATHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                ''MessageBox.Show(Me, "Xóa chứng từ thành công!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information)
                LamMoi()
                AllowEdit(False)
                txtID.Text = ""
                Call GetListByID()
                LockGrid(True)
                GridView1.OptionsSelection.MultiSelect = True
                GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                _action = ""
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XOAKHONGTHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Không thể xóa chứng từ!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        End If
    End Sub
    Private Function fnGetSelectRow() As DataTable
        Dim dt As New DataTable
        dt.Columns.Add("VT")
        Dim r As DataRow = Nothing
        For Each i As Integer In GridView1.GetSelectedRows()
            r = dt.NewRow
            r("VT") = i
            dt.Rows.Add(r)
        Next i
        Return dt
    End Function

    Private Sub GridControl1_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles GridControl1.KeyDown
        Try
            If _action = "ADD" Or _action = "UPDATE" Then
                If e.KeyCode = Keys.Delete Then
                    If fnCheckApprovedDocument() = True Then
                        Exit Sub
                    End If
                    Dim dt As DataTable = CType(GridControl1.DataSource, DataTable)
                    Try
                        Dim t As DataTable = fnGetSelectRow()
                        For j As Integer = t.Rows.Count - 1 To 0 Step -1
                            dt.Rows.RemoveAt(t.Rows(j)("VT"))
                        Next
                        GridControl1.DataSource = dt
                    Catch ex As Exception

                    End Try

                End If
            End If
        Catch ex As Exception

        End Try
    End Sub
    Private Function fnValid()
        If cbHPES6.Checked Then
            If (XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAICHON5HPE", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Warning)) = DialogResult.Yes Then
                cbHPES6.Focus()
                Return False
                Exit Function
            End If
        End If

        If txtDocNum.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPSOCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn phải nhập số chứng từ!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            txtDocNum.Focus()
            Return False
        End If
        If txtCreatedBy.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPTENNGUOIBC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn phải nhập tên người báo cáo!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            txtCreatedBy.Focus()
            Return False
        End If
        If cbDepartment.SelectedIndex = -1 Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAICHONPHONGBAN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn phải chọn Department!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            cbDepartment.Focus()
            Return False
        End If
        If cbLocation.SelectedIndex = -1 Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAICHONVITRI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn phải chọn Location!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            cbLocation.Focus()
            Return False
        End If
        If txtDescription.TextLength = 0 Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAI_NHAP_MOTA_TOM_TAT", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn phải chọn Department!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            txtDescription.Focus()
            Return False
        End If
        If fnCheckApprovalUser() = True Then
            If GridView1.DataRowCount = 0 Then
                GridView1.Focus()
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPLUOIHANHDONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn phải nhập lưới Action!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return False
            End If
        End If
        If fnCheckApprovalUser() = True Or fnCheckAdminUser() = True Then
            If txtApproval_User.Text = "" Then
                If txtCreatedBy.Text.ToUpper <> DungChung.Login.ToUpper Then
                    If GridView1.DataRowCount = 0 Then
                        GridView1.Focus()
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPLUOIHANHDONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Bạn phải nhập lưới Action!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        Return False
                    End If
                End If
            Else
                If GridView1.DataRowCount = 0 Then
                    GridView1.Focus()
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPLUOIHANHDONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập lưới Action!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Return False
                End If
            End If

        End If
        For i As Integer = 0 To GridView1.RowCount - 2
            If IsDBNull(GridView1.GetRowCellValue(i, "PreventiveAction")) Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPPreventiveAction", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn phải nhập Preventive Action tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                GridView1.ClearSelection()
                GridView1.FocusedRowHandle = i
                GridView1.SelectRow(i)
                GridView1.ClearSelection()
                Return False
            ElseIf GridView1.GetRowCellValue(i, "PreventiveAction") = "" Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPPreventiveAction", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn phải nhập Preventive Action tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                GridView1.ClearSelection()
                GridView1.FocusedRowHandle = i
                GridView1.SelectRow(i)
                Return False
            End If
            If fnCheckApprovalUser() = True Or fnCheckAdminUser() = True Then
                If IsDBNull(GridView1.GetRowCellValue(i, "PersonIncharge")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "PersonIncharge") = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "Deadline")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAP_MUCUUTIEN_HOAC_DEADLINE", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Deadline tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "Deadline") = Nothing Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAP_MUCUUTIEN_HOAC_DEADLINE", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Deadline tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                Dim date1 As Date = New Date(dtDocDate.Value.Year, dtDocDate.Value.Month, dtDocDate.Value.Day, 0, 0, 0)
                If DateTime.Compare(date1, GridView1.GetRowCellValue(i, "Deadline")) > 0 Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "DeadlineNHOHONNGAYTAO", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Deadline tại dòng " & (i + 1).ToString() + " không được nhỏ hơn ngày tạo!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Return False
                End If
            End If
            If IsDBNull(GridView1.GetRowCellValue(i, "THIETBI")) = False Then
                If IsDBNull(GridView1.GetRowCellValue(i, "MUCUUTIEN")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPMUCUUTIEN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Preventive Action tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If

                If IsDBNull(GridView1.GetRowCellValue(i, "LOAIYEUCAU")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPLOAIYEUCAU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Preventive Action tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "NGUYENNHAN")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPNGUYENNHAN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Preventive Action tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
            End If
        Next
        If cbApproved.Checked = True And txtApproval_User.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "NHAPTHONGTINAPPROVAL", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Vui lòng xác nhận thông tin Approval!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Return False
        End If
        Return True
    End Function

    Private Sub btnChoose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChoose.Click
        If Not DungChung.ChooseData Is Nothing Then
            DungChung.ChooseData.Clear()
        End If
        Dim flag As Boolean = False
        For Each f As Form In Application.OpenForms
            If f.Name = "ChooseHazardReport" Then
                f.Show()
                Exit Sub
            End If
        Next

        Dim frm As New ChooseHazardReport
        frm.Show()

    End Sub

    Private Sub btnPrint_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPrint.Click

        If txtID.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "CHUACHONCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần Print", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        'If MessageBox.Show("Vui lòng chọn loại report cần in." & vbNewLine & "- Yes: In NearMiss Report" & vbNewLine & "- No: In Hazard Report", "Xác nhận?", MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
        '    optPrint = 3
        'Else
        '    optPrint = 2
        'End If
        optPrint = 3
        Print()
    End Sub
    Public Sub Print()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If

            sqlcom.Connection = con
            If optPrint = 2 Then
                sqlcom.Parameters.AddWithValue("ACTION", "PRINT")
                sqlcom.Parameters.AddWithValue("ID", txtID.Text)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_HazardReport"
                Dim da As New SqlDataAdapter(sqlcom)
                Dim ds As New DataSet()
                da.Fill(ds)
                If ds.Tables.Count > 0 Then
                    ds.WriteXml(Application.StartupPath & "/XML/Hazard.xml", XmlWriteMode.WriteSchema)
                    Dim frm As New FrmPrint(ds, "HazardVI.rpt", 2)

                    frm.ShowDialog()
                End If
            Else
                sqlcom.Parameters.AddWithValue("ACTION", "PRINT_NEW")
                sqlcom.Parameters.AddWithValue("ID", txtID.Text)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_HazardReport"
                Dim da As New SqlDataAdapter(sqlcom)
                Dim ds As New DataSet()
                da.Fill(ds)
                If ds.Tables.Count > 0 Then
                    ds.WriteXml(Application.StartupPath & "/XML/NearMiss.xml", XmlWriteMode.WriteSchema)
                    Dim frm As New FrmPrint(ds, "NearMiss.rpt", 3)

                    frm.ShowDialog()
                End If
            End If

            'sqlcom.Connection = con

        Catch ex As Exception

        End Try
    End Sub
    Public Sub LoadListInCharge()
        Try
            _tbPersonInCharge = New DataTable()
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_INCHARGE")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Staff name"
            cboStatus.DataSource = ds.Tables(0)

            _tbPersonInCharge = ds.Tables(0).Copy()

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Staff name"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Description"))
            cboStatus.PopupWidth = 150
            cboStatus.Columns("ID").Width = 20
            cboStatus.Columns("Staff name").Width = 100
            cboStatus.Columns("Description").Width = 60
            cboStatus.ShowDropDown = DevExpress.XtraEditors.Controls.ShowDropDown.Never
            cboStatus.Buttons(0).Visible = False

            GridView1.Columns("PersonIncharge").ColumnEdit = cboStatus
            GridView1.Columns("PersonIncharge").OptionsColumn.AllowEdit = False
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Public Sub LoadListThietBi()
        Try
            _tbTHIETBI = New DataTable()
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_THIET_BI")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "ID"
            cboStatus.DataSource = ds.Tables(0)

            _tbTHIETBI = ds.Tables(0).Copy()

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Staffname"))

            cboStatus.PopupWidth = 250
            cboStatus.Columns("ID").Width = 80
            cboStatus.Columns("Staffname").Width = 170

            cboStatus.ShowDropDown = DevExpress.XtraEditors.Controls.ShowDropDown.Never
            cboStatus.Buttons(0).Visible = False

            GridView1.Columns("THIETBI").ColumnEdit = cboStatus
            GridView1.Columns("THIETBI").OptionsColumn.AllowEdit = False
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub LoadListNguyenNhan()
        Try
            _tbNGUYENNHAN = New DataTable()
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_NGUYEN_NHAN")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Staffname"
            cboStatus.DataSource = ds.Tables(0)

            _tbNGUYENNHAN = ds.Tables(0).Copy()

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Staffname"))

            cboStatus.PopupWidth = 250
            cboStatus.Columns("ID").Width = 50
            cboStatus.Columns("Staffname").Width = 200

            cboStatus.ShowDropDown = DevExpress.XtraEditors.Controls.ShowDropDown.Never
            cboStatus.Buttons(0).Visible = False

            GridView1.Columns("NGUYENNHAN").ColumnEdit = cboStatus
            GridView1.Columns("NGUYENNHAN").OptionsColumn.AllowEdit = False
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub LoadListLoaiYC()
        Try
            _tbLOAIYC = New DataTable()
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_LOAI_YEU_CAU")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Staffname"
            cboStatus.DataSource = ds.Tables(0)

            _tbLOAIYC = ds.Tables(0).Copy()

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Staffname"))

            cboStatus.PopupWidth = 250
            cboStatus.Columns("ID").Width = 50
            cboStatus.Columns("Staffname").Width = 200

            cboStatus.ShowDropDown = DevExpress.XtraEditors.Controls.ShowDropDown.Never
            cboStatus.Buttons(0).Visible = False

            GridView1.Columns("LOAIYEUCAU").ColumnEdit = cboStatus
            GridView1.Columns("LOAIYEUCAU").OptionsColumn.AllowEdit = False
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Public Sub LoadListUuTien()
        Try

            Dim dt As New DataTable()
            dt.Columns.Add("ID")
            dt.Columns.Add("Name")
            Dim r As DataRow

            If Commons.Modules.TypeLanguage = 0 Then
                r = dt.NewRow()
                r("ID") = 1
                r("Name") = "Mức 1(1 ngày) Chắc chắn sẽ xảy ra tai nạn"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 2
                r("Name") = "Mức 2(7 ngày) Hoàn toàn có thể xảy ra tai nạn"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 3
                r("Name") = "Mức 3(14 ngày) Xem như có thể xảy ra tai nạn"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 4
                r("Name") = "Mức 4(42 ngày) Rất khó có thể xảy ra tai nạn"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 5
                r("Name") = "Mức 5(99 ngày) Được thực hiện khi có cơ hội làm được"
                dt.Rows.Add(r)
            Else
                r = dt.NewRow()
                r("ID") = 1
                r("Name") = "Level 1(1 day) Will inevitably of accident"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 2
                r("Name") = "Level 2(7 days) Entirely possible accident"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 3
                r("Name") = "Level 3(14 days) Watch as accidents can happen"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 4
                r("Name") = "Level 4(42 days) It is difficult to accident"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 5
                r("Name") = "Level 5(99 days) Is performed when the opportunity to do"
                dt.Rows.Add(r)
            End If

            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Name"
            cboStatus.DataSource = dt


            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Name"))

            cboStatus.PopupWidth = 300
            cboStatus.Columns("ID").Width = 30
            cboStatus.Columns("Name").Width = 280
            cboStatus.DropDownRows = 5
            GridView1.Columns("MUCUUTIEN").ColumnEdit = cboStatus

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Private Sub GridView1_ColumnPositionChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles GridView1.ColumnPositionChanged
        If _action = "" Then
            Exit Sub
        End If
        If GridView1.FocusedColumn.Name = "PersonIncharge" Then
            GridView1.EndSelection()
        End If
    End Sub


    Private Sub GridView1_MouseDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles GridView1.MouseDown
        Try
            If _action = "" Then
                Exit Sub
            End If
            Dim view As GridView = TryCast(sender, GridView)
            Dim hi As GridHitInfo = view.CalcHitInfo(New Point(e.X, e.Y))
            If Not hi.InRowCell Then
                Return
            End If
            Dim vi As GridViewInfo = TryCast(view.GetViewInfo(), GridViewInfo)
            Dim ri As GridDataRowInfo = TryCast(vi.RowsInfo.FindRow(hi.RowHandle), GridDataRowInfo)
            Dim ci As GridCellInfo = ri.Cells(hi.Column)
            GridView1.FocusedRowHandle = hi.RowHandle
            If hi.Column.Name = "Incharge" Then
                GridView1.CloseEditor()
                If fnCheckApprovedDocument() = False Then
                    Dim frm As New FrmFind(_tbPersonInCharge)
                    Dim p As New Point(Cursor.Position.X - 140, Cursor.Position.Y + 14)
                    frm.Location = p
                    frm.ShowDialog()
                    GridView1.Focus()
                    GridView1.BeginSelection()

                    If frm._id <> -1 Then
                        GridView1.SetFocusedRowCellValue("PersonIncharge", frm._id.ToString())
                    End If
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 140, Cursor.Position.Y + 14)
                    VirtualMouse.LeftClick()
                End If
            End If

            If hi.Column.Name = "btnThietbi" Then
                GridView1.CloseEditor()
                If fnCheckApprovedDocument() = False Then
                    Dim frm As New FrmFind(_tbTHIETBI, 0)
                    Dim p As New Point(Cursor.Position.X - 140, Cursor.Position.Y - 10)
                    frm.Location = p
                    frm.ShowDialog()
                    GridView1.Focus()
                    GridView1.BeginSelection()

                    If frm.id <> "-1" Then
                        GridView1.SetFocusedRowCellValue("THIETBI", frm.id.ToString())
                    End If
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 140, Cursor.Position.Y + 14)
                    VirtualMouse.LeftClick()
                End If
            End If
            If hi.Column.Name = "btnLoaiYC" Then
                GridView1.CloseEditor()
                If fnCheckApprovedDocument() = False Then
                    Dim frm As New FrmFind(_tbLOAIYC, 1)
                    Dim p As New Point(Cursor.Position.X - 240, Cursor.Position.Y - 10)
                    frm.Location = p
                    frm.ShowDialog()
                    GridView1.Focus()
                    GridView1.BeginSelection()

                    If frm.id <> "-1" Then
                        GridView1.SetFocusedRowCellValue("LOAIYEUCAU", frm.id.ToString())
                    End If
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 140, Cursor.Position.Y + 14)
                    VirtualMouse.LeftClick()
                End If
            End If
            If hi.Column.Name = "btnNGUYENNHAN" Then
                GridView1.CloseEditor()
                If fnCheckApprovedDocument() = False Then
                    Dim frm As New FrmFind(_tbNGUYENNHAN, 2)
                    Dim p As New Point(Cursor.Position.X - 280, Cursor.Position.Y - 10)
                    frm.Location = p
                    frm.ShowDialog()
                    GridView1.Focus()
                    GridView1.BeginSelection()

                    If frm.id <> "-1" Then
                        GridView1.SetFocusedRowCellValue("NGUYENNHAN", frm.id.ToString())
                    End If
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 140, Cursor.Position.Y + 14)
                    VirtualMouse.LeftClick()
                End If
            End If
            If hi.Column.Name = "Report" Then
                If IsDBNull(GridView1.GetRowCellValue(hi.RowHandle, "PersonIncharge")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng  " & (hi.RowHandle + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = hi.RowHandle
                    GridView1.SelectRow(hi.RowHandle)
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                    VirtualMouse.LeftClick()
                    Exit Sub
                ElseIf GridView1.GetRowCellValue(hi.RowHandle, "PersonIncharge") = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (hi.RowHandle + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = hi.RowHandle
                    GridView1.SelectRow(hi.RowHandle)
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                    VirtualMouse.LeftClick()
                    Exit Sub
                End If
                Dim flag As Boolean = False
                Dim ngbc As String = fnGetUserLogin(GridView1.GetRowCellValue(hi.RowHandle, "PersonIncharge")).ToString().ToUpper()
                If fnCheckAdminUser() = False And txtCreatedBy.Text.ToUpper <> ngbc Or DungChung.Login.ToUpper <> ngbc Then
                    If fnCheckAdminUser() = False Then
                        If fnCheckReport(GridView1.GetRowCellValue(hi.RowHandle, "PersonIncharge")) = False Then
                            System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                            VirtualMouse.LeftClick()
                            Exit Sub
                        End If
                    End If
                    flag = False
                Else
                    If fnCheckAdminUser() = False And fnCheckApprovedDocument() = True Then
                        flag = False
                    Else
                        flag = True
                    End If
                End If

                If Not DungChung.ChooseData Is Nothing Then
                    DungChung.ChooseData.Clear()
                End If
                Dim frm As New FrmReport(dtDocDate.Value)
                frm.ShowDialog()
                If Not DungChung.ChooseData Is Nothing Then
                    If DungChung.ChooseData.Rows.Count > 0 Then
                        If DungChung.ChooseData.Rows(0)("XOA").ToString() = "N" Then
                            GridView1.SetRowCellValue(hi.RowHandle, "PersonReport", DungChung.ChooseData.Rows(0)("NGUOIBC").ToString())
                            GridView1.SetRowCellValue(hi.RowHandle, "CompletedDate", DungChung.ChooseData.Rows(0)("NGAYHT").ToString())
                            GridView1.SetRowCellValue(hi.RowHandle, "Description", DungChung.ChooseData.Rows(0)("GHICHU").ToString())
                            If flag = True Then
                                sentmailType = 0
                            Else
                                sentmailType = 2
                            End If

                            If reportID.Length = 0 Then
                                reportID = (hi.RowHandle + 1).ToString()
                            Else
                                reportID = reportID & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        ElseIf DungChung.ChooseData.Rows(0)("XOA").ToString() = "Y" Then
                            GridView1.SetRowCellValue(hi.RowHandle, "PersonReport", "")
                            GridView1.SetRowCellValue(hi.RowHandle, "CompletedDate", Nothing)
                            GridView1.SetRowCellValue(hi.RowHandle, "Description", "")
                            If flag = True Then
                                sentmailType = 0
                            Else
                                sentmailType = 2
                            End If
                            If reportID.Length = 0 Then
                                reportID = (hi.RowHandle + 1).ToString()
                            Else
                                reportID = reportID & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        ElseIf DungChung.ChooseData.Rows(0)("XOA").ToString() = "R" Then
                            GridView1.SetRowCellValue(hi.RowHandle, "PersonReport", DungChung.ChooseData.Rows(0)("NGUOIBC").ToString())
                            GridView1.SetRowCellValue(hi.RowHandle, "CompletedDate", DungChung.ChooseData.Rows(0)("NGAYHT").ToString())
                            GridView1.SetRowCellValue(hi.RowHandle, "Description", DungChung.ChooseData.Rows(0)("GHICHU").ToString())
                            If flag = True Then
                                sentmailType = 0
                            Else
                                sentmailType = 2
                            End If
                            If reportID.Length = 0 Then
                                reportID = (hi.RowHandle + 1).ToString()
                            Else
                                reportID = reportID & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        End If

                    End If

                End If
                System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 250, Cursor.Position.Y - 100)
                VirtualMouse.LeftClick()
            End If
            Try
                If GridView1.GetRowCellValue(hi.RowHandle, "CompletedDate").ToString() = "" Then
                    If DateTime.Compare(Now.Date, CDate(GridView1.GetRowCellValue(hi.RowHandle, "Deadline").ToString())) > 0 Then
                        GridView1.SetRowCellValue(hi.RowHandle, "Status", "Overdue-Quá hạn")

                    Else
                        GridView1.SetRowCellValue(hi.RowHandle, "Status", "Ongoing-Đang xử lý")

                    End If
                Else
                    If DungChung.ChooseData.Rows(0)("XOA").ToString() = "R" Then
                        GridView1.SetRowCellValue(hi.RowHandle, "Status", "Reject-Hủy bỏ")
                    Else
                        GridView1.SetRowCellValue(hi.RowHandle, "Status", "Done-Đã hoàn thành")
                    End If

                End If
            Catch ex As Exception
                'GridView1.SetRowCellValue(hi.RowHandle, "Status", "Ongoing-Đang xử lý")
            End Try


        Catch ex As Exception

        End Try


    End Sub

    Private Sub GridView1_RowCellStyle(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs) Handles GridView1.RowCellStyle
        Try

            Dim View As GridView = TryCast(sender, GridView)
            If e.Column.FieldName = "Status" Then
                Try
                    e.Appearance.ForeColor = Color.Black
                    If GridView1.GetRowCellValue(e.RowHandle, "CompletedDate").ToString() = "" Then
                        If DateTime.Compare(Now.Date, CDate(GridView1.GetRowCellValue(e.RowHandle, "Deadline").ToString())) > 0 Then
                            'GridView1.SetRowCellValue(e.RowHandle, "Status", "Overdue-Quá hạn")
                            e.Appearance.BackColor = Color.Red
                        Else
                            'GridView1.SetRowCellValue(e.RowHandle, "Status", "Ongoing-Đang xử lý")
                            e.Appearance.BackColor = Color.Yellow

                        End If
                    Else
                        If GridView1.GetRowCellValue(e.RowHandle, "Status").ToString() = "Reject-Hủy bỏ" Then
                            e.Appearance.BackColor = Color.Turquoise
                        Else
                            e.Appearance.BackColor = Color.LimeGreen
                        End If
                    End If

                Catch ex As Exception
                    'e.Appearance.BackColor = Color.Yellow
                End Try
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub GridView1_CellValueChanged(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs) Handles GridView1.CellValueChanged
        Try
            If _action = "" Then
                Exit Sub
            End If
            If e.Column.Name = "MUCUUTIEN" Then
                GridView1.CloseEditor()
                Select Case GridView1.GetFocusedRowCellValue("MUCUUTIEN")
                    Case 1
                        Dim dt As New Date
                        dt = dtDocDate.Value.AddDays(1)
                        GridView1.SetRowCellValue(e.RowHandle, "Deadline", dt)

                    Case 2
                        Dim dt As New Date
                        dt = dtDocDate.Value.AddDays(7)
                        GridView1.SetRowCellValue(e.RowHandle, "Deadline", dt)
                    Case 3
                        Dim dt As New Date
                        dt = dtDocDate.Value.AddDays(14)
                        GridView1.SetRowCellValue(e.RowHandle, "Deadline", dt)
                    Case 4
                        Dim dt As New Date
                        dt = dtDocDate.Value.AddDays(42)
                        GridView1.SetRowCellValue(e.RowHandle, "Deadline", dt)
                    Case 5
                        Dim dt As New Date
                        dt = dtDocDate.Value.AddDays(99)
                        GridView1.SetRowCellValue(e.RowHandle, "Deadline", dt)
                End Select


            End If
            If e.Column.Name = "Deadline" Then
                GridView1.CloseEditor()
                If GridView1.GetRowCellValue(e.RowHandle, "CompletedDate").ToString() = "" Then
                    If DateTime.Compare(Now.Date, CDate(GridView1.GetRowCellValue(e.RowHandle, "Deadline").ToString())) > 0 Then
                        GridView1.SetRowCellValue(e.RowHandle, "Status", "Overdue-Quá hạn")

                    Else
                        GridView1.SetRowCellValue(e.RowHandle, "Status", "Ongoing-Đang xử lý")

                    End If
                Else
                    If GridView1.GetRowCellValue(e.RowHandle, "Status").ToString() = "Reject-Hủy bỏ" Then

                    Else
                        GridView1.SetRowCellValue(e.RowHandle, "Status", "Done-Đã hoàn thành")
                    End If
                End If
            End If


        Catch ex As Exception

        End Try
    End Sub

    Private Sub SimpleButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChon.Click
        Try
            Dim op As New OpenFileDialog
            'op.InitialDirectory = DungChung.FolderShare
            op.Filter = "(Image Files)|*.jpg;*.png;*.bmp;*.gif;*.ico|Jpg, | *.jpg|Png, | *.png|Bmp, | *.bmp|Gif, | *.gif|Ico | *.ico"
            If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                CopyFileToFolderShare(op.FileName)
                IMG_PATCH1.Text = System.IO.Path.GetFileName(op.FileName)
                ptbImage_1.Image = System.Drawing.Bitmap.FromFile(op.FileName)
            End If
        Catch ex As Exception
            XtraMessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Function imgToByteConverter(imgConvert As Byte()) As Byte()
        Dim currentByteImageArray As Byte() = imgConvert
        Dim Scale As Double = 1.0F
        Dim inputMemoryStream As New MemoryStream(imgConvert)
        Dim fullsizeImage As Image = Image.FromStream(inputMemoryStream)

        Do
            Dim fullSizeBitmap As New Bitmap(fullsizeImage, New Size((fullsizeImage.Width * Scale), (fullsizeImage.Height * Scale)))
            Dim resultStream As New MemoryStream()
            fullSizeBitmap.Save(resultStream, fullsizeImage.RawFormat)
            currentByteImageArray = resultStream.ToArray()
            resultStream.Dispose()
            resultStream.Close()
            Scale -= 0.05F
        Loop While (currentByteImageArray.Length > 60000)
        Return currentByteImageArray
    End Function

    Private Sub SimpleButton2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnXoa.Click
        ptbImage_1.Image = Nothing
        IMG_PATCH1.Text = ""
    End Sub


#Region "Approval"
    Public Function fnCheckReport(ByVal personincharge As Integer)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_CHARGE_USER")
            sqlcom.Parameters.AddWithValue("PERSON_IN_CHARGE", personincharge)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    If ds.Tables(0).Rows(0)(0).ToString.ToUpper() <> DungChung.Login.ToUpper() Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGDUOCPHANCONGTH", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Bạn không được báo cáo vì không được phân công thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        Return False
                    Else
                        If cbApproved.Checked = False Then
                            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "CHUNGTUCHUADUOCDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                            'MessageBox.Show(Me, "Bạn không được báo cáo vì chứng từ chưa được duyệt!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                            Return False
                        Else
                            Return True
                        End If
                    End If

                    Return True
                Else
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGDUOCPHANCONGTH", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn không được báo cáo vì không được phân công thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Return False
                End If
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGDUOCPHANCONGTH", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn không được báo cáo vì không được phân công thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return False
            End If

        Catch generatedExceptionName As Exception
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGDUOCPHANCONGTH", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn không được báo cáo vì không được phân công thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Return False
        End Try
    End Function
    Private Function fnCheckOtherUserEditDocument()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_DOC")
            sqlcom.Parameters.AddWithValue("DocNum", txtDocNum.Text)
            sqlcom.Parameters.AddWithValue("UserEdit", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_EDIT_DOCUMENT"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                _userEdit = ""
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    _userEdit = ds.Tables(0).Rows(0)(0).ToString()
                    Return True
                Else
                    _userEdit = ""
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            _userEdit = ""
            Return False
        End Try
    End Function
    Private Function fnCheckCancelApproval()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_CANCEL_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("APPROVAL_USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function
    Private Function fnCheckAdminUser()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_ADMIN_USER")
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function
    Private Function fnCheckCreateAndApproval()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_CREATE_APPROVAL")

            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function

    Private Function GET_DOC_ID()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DOC_ID")
            sqlcom.Parameters.AddWithValue("DocNum", txtDocNum.Text)
            sqlcom.Parameters.AddWithValue("RANDOM", txtRandom.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Return sqlcom.ExecuteScalar()
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnNguoiTaoLaNguoiDuyet(ByVal ID As String)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "IS_CREATE_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", ID)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function

    Private Function fnCheckApprovalUser()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_APPROVAL_USER")
            sqlcom.Parameters.AddWithValue("FORMID", Me.Name)
            sqlcom.Parameters.AddWithValue("APPROVAL_USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function
    Private Function fnCheckApprovedDocument()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_APPROVED")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function
    Private Function fnCheckUser()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_USER")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function
    Public Function SaveOtherUserEditDocument(ByVal Action As String) As [Boolean]
        Dim dt As New DataTable()
        Dim transaction As SqlTransaction = Nothing
        Using con As New SqlConnection(Commons.IConnections.ConnectionString())
            Dim sqlcom As SqlCommand = con.CreateCommand()
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                transaction = con.BeginTransaction("Transaction")
                sqlcom.Connection = con
                sqlcom.Transaction = transaction
                sqlcom.Parameters.AddWithValue("ACTION", Action)
                sqlcom.Parameters.AddWithValue("DocNum", txtDocNum.Text)
                sqlcom.Parameters.AddWithValue("UserEdit", DungChung.Login)
                sqlcom.Parameters.AddWithValue("Edit_Time", dtEditTime.Value)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_EDIT_DOCUMENT"
                sqlcom.ExecuteNonQuery()
                transaction.Commit()
                Return True
            Catch ex As Exception
                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
                Return False
            Finally
                con.Close()
            End Try
        End Using
    End Function
    Private Function fnGetListMailApproval()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.Parameters.AddWithValue("REPORT_PARENT", cbReportParent.SelectedValue)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function


    Private Function fnGetSoLanViPham(ByVal tenngvp As String)
        Try

            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_SO_LAN_VI_PHAM")

            sqlcom.Parameters.AddWithValue("NGUOILIENQUAN2", tenngvp)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Return sqlcom.ExecuteScalar()
        Catch generatedExceptionName As Exception
            Return 0
        End Try
    End Function



    Private Function fnGetListMailIncharge()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_INCHARGE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetListMailApprovalAndCreatedBy()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL_CREATE_BY")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetListMailCreatedBy()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_CREATE_BY")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetReporter(ByVal user As String)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORTER")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", user)
            sqlcom.Parameters.AddWithValue("REPORT_PARENT", cbReportParent.SelectedValue)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetUserLogin(ByVal id As Integer)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_USER_LOGIN")
            sqlcom.Parameters.AddWithValue("ID", id)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGET_DEAR_APPROVAL()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.Parameters.AddWithValue("REPORT_PARENT", cbReportParent.SelectedValue)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGET_DEAR_INCHARGE()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_INCHARGE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function GET_DEAR_APPROVAL_CREATE_BY()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL_CREATE_BY")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function GET_DEAR_CREATE_BY()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_CREATE_BY")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetListAction()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_ACTION")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return New DataTable
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0)
                Else
                    Return New DataTable
                End If
            End If
        Catch generatedExceptionName As Exception
            Return New DataTable
        End Try
    End Function
    Private Function fnGetListActionDone()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_ACTION_DONE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("RID", reportID)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return New DataTable
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0)
                Else
                    Return New DataTable
                End If
            End If
        Catch generatedExceptionName As Exception
            Return New DataTable
        End Try
    End Function
#End Region

    Private Sub btnApproval_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApproval.Click

        If fnCheckAdminUser() = False And fnCheckApprovalUser() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGCOQUYENDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show("Bạn không có quyền duyệt chứng từ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            LockGrid(True)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And CheckSameDepartment() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGCUNGPHONGBANNENKHONGCOQUYENDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show("Bạn không có quyền duyệt chứng từ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            LockGrid(True)
            Exit Sub
        End If
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XACNHANDUYETCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            'If MessageBox.Show("Bạn có chắc muốn duyệt chứng từ này không?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
            If Not DungChung.ChooseData Is Nothing Then
                DungChung.ChooseData.Clear()
            End If
            Dim frm As New FrmConfirm(DungChung.Login)
            frm.ShowDialog()
            If Not DungChung.ChooseData Is Nothing Then
                If DungChung.ChooseData.Rows.Count > 0 Then
                    If DungChung.ChooseData.Rows(0)(0) = "1" Then
                        txtApproval_User.Text = DungChung.Login
                        cbApproved.Checked = True
                        btnApproval.Visible = False
                        If _action = "UPDATE" Then
                            sentmailType = 1
                            CLICK_APPROVAL = True
                        End If
                    Else
                        btnApproval.Visible = True
                        cbApproved.Checked = False
                        txtApproval_User.Text = ""
                    End If
                End If
            End If
        End If
        If Not DungChung.ChooseData Is Nothing Then
            DungChung.ChooseData.Clear()
        End If
    End Sub
    Private Sub FrmHazardReport_FormClosed(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles MyBase.FormClosed
        Call SaveOtherUserEditDocument("DELETE")
        For Each f As Form In Application.OpenForms
            If f.Name = "ChooseHazardReport" Then
                f.Close()
                Exit For
            End If
        Next
    End Sub

    Private Sub btnCancelApproval_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelApproval.Click
        If fnCheckAdminUser() = False And fnCheckApprovalUser() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGCOQUYENHUYDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show("Bạn không có quyền hủy duyệt chứng từ", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            LockGrid(True)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And fnCheckCancelApproval() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "KHONGTHEHUYDUYETKHIBCHT", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show("Bạn không thể hủy duyệt chứng từ khi đã có báo cáo hoàn thành", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            LockGrid(True)
            Exit Sub
        End If
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XACNHANHUYDUYETCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            'If MessageBox.Show("Bạn có chắc muốn hủy duyệt chứng từ này không?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
            If Not DungChung.ChooseData Is Nothing Then
                DungChung.ChooseData.Clear()
            End If
            Dim frm As New FrmConfirm(DungChung.Login)
            frm.ShowDialog()
            If Not DungChung.ChooseData Is Nothing Then
                If DungChung.ChooseData.Rows.Count > 0 Then
                    If DungChung.ChooseData.Rows(0)(0) = "1" Then
                        txtApproval_User.Text = ""
                        cbApproved.Checked = False
                        btnCancelApproval.Visible = False
                        sentmailType = 3
                        'Else
                        '    btnCancelApproval.Visible = True
                        '    cbApproved.Checked = True
                        '    txtApproval_User.Text = DungChung.Login
                    End If
                End If
            End If
        End If

        If Not DungChung.ChooseData Is Nothing Then
            DungChung.ChooseData.Clear()
        End If
    End Sub

    Private Sub cbApproved_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles cbApproved.Click

    End Sub
    Private Function GetListMailTo(ByVal lstEmail As String)
        Dim s() As String = lstEmail.Split(";")
        Dim cl As New Collection
        Dim lst As String = ""
        For i As Integer = 0 To s.Length - 1
            If cl.Contains(s(i)) = False Then
                cl.Add(New String() {s(i).ToString()}, s(i).ToString())
            End If
        Next
        For i As Integer = 1 To cl.Count
            If lst.Length = 0 Then
                lst = cl(i)(0).ToString()
            Else
                lst = lst & ";" & cl(i)(0).ToString()
            End If
        Next
        Return lst
    End Function
    Private Function GetListDearTo(ByVal lstDear As String)
        Dim s() As String = lstDear.Split(",")
        Dim cl As New Collection
        Dim lst As String = ""
        For i As Integer = 0 To s.Length - 1
            If cl.Contains(s(i)) = False Then
                cl.Add(New String() {s(i).ToString()}, s(i).ToString())
            End If
        Next
        For i As Integer = 1 To cl.Count
            If lst.Length = 0 Then
                lst = cl(i)(0).ToString()
            Else
                lst = lst & "," & cl(i)(0).ToString()
            End If
        Next
        Return lst
    End Function

    Private Sub btnChon1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChon1.Click
        Try
            Dim op As New OpenFileDialog
            'op.InitialDirectory = DungChung.FolderShare
            op.Filter = "(Image Files)|*.jpg;*.png;*.bmp;*.gif;*.ico|Jpg, | *.jpg|Png, | *.png|Bmp, | *.bmp|Gif, | *.gif|Ico | *.ico"
            If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                CopyFileToFolderShare(op.FileName)
                IMG_PATCH2.Text = System.IO.Path.GetFileName(op.FileName)
                ptbImage_2.Image = System.Drawing.Bitmap.FromFile(op.FileName)
            End If
        Catch ex As Exception
            XtraMessageBox.Show(ex.Message)
        End Try
    End Sub

    Private Sub btnXoa1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnXoa1.Click
        ptbImage_2.Image = Nothing
        IMG_PATCH2.Text = ""
    End Sub
    Private Function CopyFileToFolderShare(ByVal f_patch As String)
        Try
            Dim flag As Boolean = False
            If Not DungChung.CopyFile(f_patch, DungChung.FolderShare) Then
                flag = False
            Else
                flag = True
            End If
            If flag = False Then
                Return False
            Else
                Return True
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Sub cbReportParent_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbReportParent.SelectedIndexChanged
        SetDepartment()
    End Sub

    Private Sub txtCreatedBy_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtCreatedBy.TextChanged
        SetDepartment()
    End Sub

    Private Sub PictureBox6_MouseEnter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ptbImage_1.MouseClick
        If Not ptbImage_1.Image Is Nothing Then
            Dim frm As New FrmShowImg(ptbImage_1.Image, True)
            frm.Top = ptbImage_1.Top + ptbImage_1.Height + 72
            frm.Left = ptbImage_1.Left + 388
            frm.ShowDialog()
        End If

    End Sub

    Private Sub PictureBox7_MouseEnter(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ptbImage_2.MouseClick
        If Not ptbImage_2.Image Is Nothing Then
            Dim frm As New FrmShowImg(ptbImage_2.Image, True)
            frm.Top = ptbImage_2.Top + ptbImage_2.Height + 72
            frm.Left = ptbImage_2.Left + 388
            frm.ShowDialog()
        End If

    End Sub
    Private Sub gridView1_CustomDrawRowIndicator(ByVal sender As Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs) Handles GridView1.CustomDrawRowIndicator
        If e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Header Or e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.RowFooter Then
            e.Appearance.DrawBackground(e.Cache, e.Bounds)
            e.Appearance.DrawString(e.Cache, " ", e.Bounds)

            e.Handled = True
        Else
            e.Info.DisplayText = (e.RowHandle + 1).ToString()
        End If

    End Sub

    Private Sub cbBelongtoContractor_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbBelongtoContractor.CheckedChanged, cbBelongtoBSPort.CheckedChanged
        If _action <> "" Then
            Select Case CType(sender, RadioButton).Name
                Case "cbBelongtoContractor"
                    If CType(sender, RadioButton).Checked = True Then
                        cbExternal.Checked = True
                    Else
                        cbExternal.Checked = False
                    End If
                Case "cbBelongtoBSPort"
                    If CType(sender, RadioButton).Checked = True Then
                        cbExternal.Checked = False
                    Else
                        cbExternal.Checked = True
                    End If
            End Select
        End If
    End Sub



    Private Sub FrmHazardReport_Activated(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Activated
        Try
            If Not DungChung.ChooseData Is Nothing Then
                If DungChung.ChooseData.Rows.Count > 0 Then
                    txtID.Text = DungChung.ChooseData.Rows(0)("ID")
                    Call GetListByID()
                    Call LockGrid(True)
                    sentmailType = -1
                    reportID = ""
                    DungChung.ChooseData.Clear()
                End If
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        If Not DungChung.ChooseData Is Nothing Then
            If DungChung.ChooseData.Rows.Count > 0 Then
                txtID.Text = DungChung.ChooseData.Rows(0)("ID")
                Call GetListByID()
                Call LockGrid(True)
                sentmailType = -1
                reportID = ""
                DungChung.ChooseData.Clear()
                Timer1.Stop()
            End If
        End If
    End Sub


    Private Sub PictureBox6_MouseEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles ptbImage_1.MouseClick

    End Sub
    Private Sub PictureBox7_MouseEnter(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles ptbImage_2.MouseClick

    End Sub

    Private Sub btnTKBCT_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTKBCT.Click
        Dim frm As New FrmFind(GetListInfoNPT_BCT())
        Dim p As New Point(Me.Location.X + 602, Me.Location.Y + 120)
        frm.Location = p
        'frm.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedSingle
        frm.ShowDialog()
        If frm._name = "" Then
            cbReportParent.SelectedIndex = 0
        Else
            cbReportParent.Text = frm._name
        End If
    End Sub
    Public Function GetListInfoNPT_BCT()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_BCT")
            sqlcom.Parameters.AddWithValue("CreatedBy", txtCreatedBy.Text)

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Return ds.Tables(0)

        Catch generatedExceptionName As Exception
            Return New DataTable()
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function

    Public Function GetListInfoNPT_BCT1()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_BCT1")
            sqlcom.Parameters.AddWithValue("CreatedBy", txtCreatedBy.Text)

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Return ds.Tables(0)

        Catch generatedExceptionName As Exception
            Return New DataTable()
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Private Function fnCheckHPEs()
        For Each c As Control In GroupBox1.Controls
            If TypeOf (c) Is CheckBox Then
                If DirectCast(c, CheckBox).Checked = True Then
                    Return True
                End If
            End If
        Next
        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "PHAI_CHON_IT_NHAT_1_NOI_DUNG_HPEs", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
        Return False

    End Function

    Private Sub btTest_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub

    Private Sub SplitContainer4_Panel2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SplitContainer4.Panel2.Click
        'MsgBox(Cursor.Position.X.ToString() + "," + Cursor.Position.Y.ToString())
        Dim a As String = ""
        Exit Sub
    End Sub


    'Private Sub TableLayoutPanel2_Paint(ByVal sender As System.Object, ByVal e As System.Windows.Forms.PaintEventArgs) Handles TableLayoutPanel2.Paint

    'End Sub

    Private Sub btNguoiLQ_Click(sender As Object, e As EventArgs) Handles btNguoiLQ.Click
        Dim frm As New FrmFind(GetListInfoNPT_BCT1())
        Dim p As New Point(Me.Location.X + 205, Me.Location.Y + 468)
        frm.Location = p
        'frm.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedSingle
        frm.ShowDialog()
        If frm._name = "" Then
            cbNguoiLQ.SelectedIndex = 0
        Else
            cbNguoiLQ.Text = frm._name
        End If
    End Sub

    Private Sub cbApproved_CheckedChanged(sender As Object, e As EventArgs) Handles cbApproved.CheckedChanged

        If _action = "UPDATE" Then
            If cbApproved.Checked = False Then
                GridControl1.ContextMenuStrip = Nothing
            Else
                GridControl1.ContextMenuStrip = ContextMenuStrip1
            End If
        Else
            GridControl1.ContextMenuStrip = Nothing
        End If

    End Sub



    Private Sub txtNguoiLQ_MouseEnter(sender As Object, e As EventArgs) Handles txtNguoiLQ.MouseEnter
        'Dim toolTip1 As New System.Windows.Forms.ToolTip()
        'toolTip1.SetToolTip(Me.txtNguoiLQ, "Phải nhập đầy đủ họ và tên/Must input Fullname!")
    End Sub

    Private Sub txtNguoiLQ_TextChanged(sender As Object, e As EventArgs) Handles txtNguoiLQ.TextChanged
        'If txtNguoiLQ.TextLength = 0 Then
        '    If Commons.Modules.TypeLanguage = 0 Then
        '        txtNguoiLQ.Text = "Ví dụ: Lê Văn Hùng"
        '    Else
        '        txtNguoiLQ.Text = "Ex: Le Van Hung"
        '    End If
        'End If
    End Sub

    Private Sub txtNguoiLQ_MouseClick(sender As Object, e As MouseEventArgs) Handles txtNguoiLQ.MouseClick
        If txtNguoiLQ.TextLength > 0 Then
            If Commons.Modules.TypeLanguage = 0 Then
                txtNguoiLQ.Text = txtNguoiLQ.Text.Replace("Ví dụ: Lê Văn Hùng", "")
            Else
                txtNguoiLQ.Text = txtNguoiLQ.Text.Replace("Ex: Le Van Hung", "")
            End If
        End If
    End Sub

    Private Sub txtNguoiLQ_MouseLeave(sender As Object, e As EventArgs) Handles txtNguoiLQ.MouseLeave


    End Sub

End Class