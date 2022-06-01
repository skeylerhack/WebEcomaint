Imports System.Data.SqlClient
Imports DevExpress.XtraGrid.Views.Grid
Imports DevExpress.Utils

Public Class ChooseHazardReport
    Private _tb As DataTable
    Private _wherecon As String = ""
    Private _wherecon2 As String = ""
    Private _wherecon3 As String = ""
    Private _External As String = "All"
    Private _TT1 As Boolean = False
    Private _TT2 As Boolean = False
    Private _TT3 As Boolean = False
    Private _TT4 As Boolean = False
    Private _TT5 As Boolean = False
    Private _TT6 As Boolean = False
    Private _TT7 As Boolean = False
    Private _TT8 As Boolean = False
    Private _TT9 As Boolean = False
    Private _TT10 As Boolean = False
    Private _TT11 As Boolean = False
    Private Sub ChooseHazardReport_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        FillComboDKHVKAT()
        FillComboPBLQ()
        FillComboBelongTo()
        GetListDepartment()
        GetListNBC()
        GetListNPT()
        GetListReportParent()
        cbTrangthai.SelectedIndex = 0
        _TT7 = True
        dtTungay.Value = Now.Date.AddDays(-7)
        _TT8 = True
        cboNgungviec.SelectedIndex = 0
        _TT10 = True
        GetListNguoiLQ()
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
        Try
            Commons.Modules.ObjSystems.ThayDoiNN(Me)
        Catch ex As Exception

        End Try
        btnTKBCT.Text = "..."
        btnTKNBC.Text = "..."
        btnTKNPT.Text = "..."
    End Sub

    Private Sub FillComboBelongTo()
        cbBelongTo.DataSource = Nothing
        Dim DT As New DataTable
        DT.Columns.Add("ColumnName")
        DT.Columns.Add("Value")
        Dim dr As DataRow = Nothing
        dr = DT.NewRow
        dr("ColumnName") = "All"
        dr("Value") = "All"
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "cbBelongtoContractor"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbBelongtoContractor", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "cbBelongtoBSPort"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "cbBelongtoBSPort", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        cbBelongTo.DataSource = DT
        cbBelongTo.DisplayMember = "Value"
        cbBelongTo.ValueMember = "ColumnName"
        cbBelongTo.SelectedIndex = 0
        _TT9 = True
    End Sub

    Private Sub FillComboDKHVKAT()
        cbDKHVKAT.DataSource = Nothing
        Dim DT As New DataTable
        DT.Columns.Add("ColumnName")
        DT.Columns.Add("Value")
        Dim dr As DataRow = Nothing
        dr = DT.NewRow
        dr("ColumnName") = "All"
        dr("Value") = "All"
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "UnsafeCondition"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "cbUnsafeCondition", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "UnsafeBehevior"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "cbUnsafeBehavior", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "SatetySuggestion"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "cbSafetySuggestion", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "NearMiss"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "cbNearMiss", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "Environment"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "cbMT", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "Other"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "cbOther", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        cbDKHVKAT.DataSource = DT
        cbDKHVKAT.DisplayMember = "Value"
        cbDKHVKAT.ValueMember = "ColumnName"
        cbDKHVKAT.SelectedIndex = 0
        _TT1 = True
    End Sub

    Private Sub FillComboPBLQ()
        cbPBLQ.DataSource = Nothing
        Dim DT As New DataTable
        DT.Columns.Add("ColumnName")
        DT.Columns.Add("Value")
        Dim dr As DataRow = Nothing
        dr = DT.NewRow
        dr("ColumnName") = "All"
        dr("Value") = "All"
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "Tally"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "Tally", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "Operation"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "Operation", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "TechHSE"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "TechHSE", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "Procu"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "Procu", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "HR"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "HR", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "Acount"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "Account", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        dr = DT.NewRow
        dr("ColumnName") = "Commercial"
        dr("Value") = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "ChooseHazardReport", "Commercial", Commons.Modules.TypeLanguage)
        DT.Rows.Add(dr)
        cbPBLQ.DataSource = DT
        cbPBLQ.DisplayMember = "Value"
        cbPBLQ.ValueMember = "ColumnName"
        cbPBLQ.SelectedIndex = 0
        _TT2 = True
    End Sub
    Public Sub LoadData()
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then


            Dim dt As New DataTable
            _tb = New DataTable
            _wherecon = ""
            _wherecon2 = ""
            _wherecon3 = ""
            GetWhereCondition(cbPBLQ, _wherecon)
            GetWhereCondition(cbDKHVKAT, _wherecon2)
            GetWhereHPECondition(GroupBox1, _wherecon3)
            If _wherecon.Length > 0 And _wherecon2.Length > 0 And _wherecon3.Length > 0 Then
                _wherecon = _wherecon & " AND " & _wherecon2 & " AND (" & _wherecon3 & ")"
                _wherecon2 = ""
                _wherecon3 = ""
            End If

            If _wherecon.Length > 0 And _wherecon2.Length > 0 And _wherecon3.Length = 0 Then
                _wherecon = _wherecon & " AND " & _wherecon2
                _wherecon2 = ""
            End If

            If _wherecon.Length > 0 And _wherecon2.Length = 0 And _wherecon3.Length > 0 Then
                _wherecon = _wherecon & " AND (" & _wherecon3 & ")"
                _wherecon3 = ""
            End If

            If _wherecon.Length > 0 And _wherecon2.Length = 0 And _wherecon3.Length = 0 Then
                _wherecon = _wherecon
            End If

            If _wherecon.Length = 0 And _wherecon2.Length > 0 And _wherecon3.Length > 0 Then
                _wherecon = _wherecon2 & " AND (" & _wherecon3 & ")"
                _wherecon2 = ""
                _wherecon3 = ""
            End If

            If _wherecon.Length = 0 And _wherecon2.Length > 0 And _wherecon3.Length = 0 Then
                _wherecon = _wherecon2
                _wherecon2 = ""
            End If

            If _wherecon.Length = 0 And _wherecon2.Length = 0 And _wherecon3.Length > 0 Then
                _wherecon = "(" & _wherecon3 & ")"
                _wherecon3 = ""
            End If

            dt = GetListHazards()
            _tb = dt.Clone
            GridControl1.DataSource = dt
            GridView1.OptionsSelection.MultiSelect = False
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None

            LockGrid(True)
            'For i As Integer = 0 To GridView1.Columns.Count - 1

            '    If i <> 1 And i <> 2 Then
            '        GridView1.Columns(i).BestFit()

            '        GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
            '        GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
            '    Else
            '        If i = 1 Then
            '            GridView1.Columns(i).Width = 100
            '        Else
            '            GridView1.Columns(i).Width = 350
            '        End If

            '        GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
            '        GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
            '    End If
            'Next
            GridView1.RowHeight = 20
            'For i As Integer = 1 To GridView1.Columns.Count - 1
            '    GridView1.Columns(i).Width = GridView1.Columns(i).Width
            '    GridView1.Columns(i).MaxWidth = GridView1.Columns(i).MaxWidth
            '    GridView1.Columns(i).MinWidth = GridView1.Columns(i).MaxWidth
            'Next
            GridView1.Columns(GridView1.Columns.Count - 1).Width = 182
            GridView1.Columns(GridView1.Columns.Count - 1).MaxWidth = 182
            GridView1.Columns(GridView1.Columns.Count - 1).MinWidth = 182
        End If
    End Sub
    Private Sub GetWhereCondition(ByVal container As Control, ByRef condition As String)
        Try
            If CType(container, ComboBox).SelectedIndex = 0 Then
                condition = ""
            Else
                condition = "T1." & CType(container, ComboBox).SelectedValue & " = 'True'"
            End If

        Catch ex As Exception

        End Try
    End Sub
    Private Sub GetWhereHPECondition(ByVal container As Control, ByRef condition As String)
        Try
            For Each c As Control In container.Controls
                GetWhereHPECondition(c, condition)
                If TypeOf c Is RadioButton Then
                    If CType(c, RadioButton).Checked = True Then
                        condition = "T1." & c.Name & " = 'True'"
                        Exit Sub
                        'If condition.Length = 0 Then
                        '    condition = "T1." & c.Name & " = 'True'"
                        'Else
                        '    condition = condition & " or T1." & c.Name & " = 'True'"
                        'End If
                    End If
                End If
            Next
        Catch ex As Exception

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
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_DEPARTMENT_F")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbDepartment.DataSource = ds.Tables(0)
            cbDepartment.ValueMember = "ID"
            cbDepartment.DisplayMember = "Department"
            If cbDepartment.Items.Count > 0 Then
                cbDepartment.SelectedIndex = 0
                _TT3 = True
            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub


    Public Sub GetListNguoiLQ()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORT_PARENT3")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbNguoiLQ.DataSource = ds.Tables(0)
            cbNguoiLQ.ValueMember = "Userlogin"
            cbNguoiLQ.DisplayMember = "NPT"
            If cbNguoiLQ.Items.Count > 0 Then
                cbNguoiLQ.SelectedIndex = 0
                _TT11 = True
            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Public Sub GetListNBC()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "NBC")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_FIND"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbNBC.DataSource = ds.Tables(0)
            cbNBC.ValueMember = "MA"
            cbNBC.DisplayMember = "NBC"
            If cbNBC.Items.Count > 0 Then
                cbNBC.SelectedIndex = 0
                _TT4 = True
            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub GetListNPT()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "NPT")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_FIND"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbNPT.DataSource = ds.Tables(0)
            cbNPT.ValueMember = "MA"
            cbNPT.DisplayMember = "NPT"
            If cbNPT.Items.Count > 0 Then
                cbNPT.SelectedValue = fnGetReporter(DungChung.Login)
                _TT5 = True
            End If
        Catch generatedExceptionName As Exception
            _TT5 = True
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Private Function fnGetReporter(ByVal user As String)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_INFO_USER")
            sqlcom.Parameters.AddWithValue("USER", user)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_StopCard"
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
    Public Sub GetListReportParent()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORT_PARENT")
            sqlcom.Parameters.AddWithValue("CreatedBy", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbReportParent.DataSource = ds.Tables(0)
            cbReportParent.ValueMember = "Userlogin"
            cbReportParent.DisplayMember = "NPT"
            If cbReportParent.Items.Count > 0 Then
                cbReportParent.SelectedIndex = 0
                _TT6 = True
            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Function GetListHazards() As DataTable
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.Clear()
            sqlcom.Parameters.AddWithValue("ACTION", "LIST")
            sqlcom.Parameters.AddWithValue("TUNGAY", dtTungay.Value)
            sqlcom.Parameters.AddWithValue("DENNGAY", dtDenngay.Value)
            sqlcom.Parameters.AddWithValue("NGUOIPHUTRACH", cbNPT.Text)
            sqlcom.Parameters.AddWithValue("NGUOIBAOCAO", cbNBC.Text)
            sqlcom.Parameters.AddWithValue("PHONGBAN", cbDepartment.SelectedValue)
            sqlcom.Parameters.AddWithValue("TRANGTHAI", cbTrangthai.Text)
            sqlcom.Parameters.AddWithValue("LOAISC", _wherecon)
            sqlcom.Parameters.AddWithValue("LOAISC2", _wherecon2)
            sqlcom.Parameters.AddWithValue("REPORT_PARENT", cbReportParent.SelectedValue)
            sqlcom.Parameters.AddWithValue("DOCNUM", txtDocNum.Text)
            sqlcom.Parameters.AddWithValue("External_N", _External)
            sqlcom.Parameters.AddWithValue("IS_DELETE", cbIS_DELETE.Checked)
            sqlcom.Parameters.AddWithValue("NGUOILIENQUAN1", cbNguoiLQ.SelectedValue)
            sqlcom.Parameters.AddWithValue("NGUOILIENQUAN2", txtNguoiLQ.Text)
            sqlcom.Parameters.AddWithValue("@NNgu", Commons.Modules.TypeLanguage)
            If cboNgungviec.SelectedIndex = 0 Then
                sqlcom.Parameters.AddWithValue("STOP_WORK", "ALL")
            End If
            If cboNgungviec.SelectedIndex = 1 Then
                sqlcom.Parameters.AddWithValue("STOP_WORK", "1")

            End If
            If cboNgungviec.SelectedIndex = 2 Then
                sqlcom.Parameters.AddWithValue("STOP_WORK", "0")
            End If
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_HazardReport"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Return ds.Tables(0)
        Catch generatedExceptionName As Exception
            Return New DataTable
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Private Sub LockGrid(ByVal TT As Boolean)
        For i As Integer = 0 To GridView1.Columns.Count - 1
            GridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
        Next
    End Sub
    Private Sub fnGetChooseRow()
        Try
            _tb.Rows.Clear()
            Dim r As DataRow = _tb.NewRow
            r("ID") = GridView1.GetFocusedDataRow("ID")
            'r("DocNum") = GridView1.GetFocusedDataRow("DocNum")
            'r("DocDate") = GridView1.GetFocusedDataRow("DocDate")
            'r("DocTime") = GridView1.GetFocusedDataRow("DocTime")
            'r("CreatedBy") = GridView1.GetFocusedDataRow("CreatedBy")
            'r("Department") = GridView1.GetFocusedDataRow("Department")
            _tb.Rows.Add(r)
            DungChung.ChooseData = _tb.Copy
            For Each f As Form In Application.OpenForms
                If f.Name = "FrmHazardReport" Then
                    DirectCast(f, FrmHazardReport).Timer1.Start()
                    Exit Sub
                End If
            Next

        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnChoose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChoose.Click
        fnGetChooseRow()
        Me.Hide()
    End Sub

    Private Sub GridView1_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GridView1.DoubleClick
        fnGetChooseRow()
        Me.Hide()
    End Sub



    Private Sub dtDenngay_ValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles dtDenngay.ValueChanged, dtTungay.ValueChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub txtNguoiphutrach_EditValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub


    Private Sub cbDepartment_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbDepartment.SelectedIndexChanged, cbTrangthai.SelectedIndexChanged, cbReportParent.SelectedIndexChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub SimpleButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton1.Click
        Me.Close()
    End Sub

    Private Sub cbNBC_SelectedValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbNPT.SelectedValueChanged, cbNBC.SelectedValueChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub txtDocNum_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDocNum.TextChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub Tally_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub
    Private Sub gridView1_CustomDrawRowIndicator(ByVal sender As Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs) Handles GridView1.CustomDrawRowIndicator
        If e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Header Then
            e.Appearance.DrawBackground(e.Cache, e.Bounds)
            e.Appearance.DrawString(e.Cache, " ", e.Bounds)

            e.Handled = True
        Else
            e.Info.DisplayText = (e.RowHandle + 1).ToString()
        End If

    End Sub

    Private Sub cbNearMiss_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub
    Private Sub cbProcu_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)

    End Sub
    Private Sub OpenExcel(ByVal FileName As String)
        Dim xlApp As Excel.Application = Nothing
        Dim xlWorkBooks As Excel.Workbooks = Nothing
        Dim xlWorkBook As Excel.Workbook = Nothing
        Dim xlWorkSheet As Excel.Worksheet = Nothing
        Dim xlWorkSheets As Excel.Sheets = Nothing
        Dim xlCells As Excel.Range = Nothing
        xlApp = New Excel.Application
        xlApp.DisplayAlerts = False
        xlWorkBooks = xlApp.Workbooks
        xlWorkBook = xlWorkBooks.Open(FileName)
        xlWorkSheets = xlWorkBook.Sheets
        xlApp.Visible = True
    End Sub
    Private Sub btnExportExcel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExportExcel.Click
        Try
            GridView1.RowHeight = 20
            For i As Integer = 1 To GridView1.Columns.Count - 1
                GridView1.Columns(i).Width = GridView1.Columns(i).Width
                GridView1.Columns(i).MaxWidth = GridView1.Columns(i).MaxWidth
                GridView1.Columns(i).MinWidth = GridView1.Columns(i).MaxWidth
            Next
            GridView1.Columns(GridView1.Columns.Count - 1).Width = 120
            GridView1.Columns(GridView1.Columns.Count - 1).MaxWidth = 120
            GridView1.Columns(GridView1.Columns.Count - 1).MinWidth = 120
            If System.IO.File.Exists(Application.StartupPath & "/ListHazard.xls") Then
                System.IO.File.Delete(Application.StartupPath & "/ListHazard.xls")
            End If
            GridView1.ExportToExcelOld(Application.StartupPath & "/ListHazard.xls")
            'GridView1.ExportToXls(Application.StartupPath & "/ListHazard.xls")
            If System.IO.File.Exists(Application.StartupPath & "/ListHazard.xls") Then
                OpenExcel(Application.StartupPath & "/ListHazard.xls")
            End If
        Catch ex As Exception
            MsgBox(ex.Message, MsgBoxStyle.Exclamation)
        End Try
    End Sub



    Private Sub cbPBLQ_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbPBLQ.SelectedIndexChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub GridView1_RowCellStyle(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs) Handles GridView1.RowCellStyle

        Try
            Dim View As GridView = TryCast(sender, GridView)
            If e.Column.FieldName = "TTTH" Then
                e.Appearance.ForeColor = Color.Black
                Select Case GridView1.GetRowCellValue(e.RowHandle, "TTTH").ToString()
                    Case "Done-Đã hoàn thành"
                        e.Appearance.BackColor = Color.LimeGreen
                    Case "Ongoing-Đang xử lý"
                        e.Appearance.BackColor = Color.Yellow
                    Case "Overdue-Quá hạn"
                        e.Appearance.BackColor = Color.Red
                    Case "Reject-Hủy bỏ"
                        e.Appearance.BackColor = Color.Turquoise

                End Select
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub cbDKHVKAT_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbDKHVKAT.SelectedIndexChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub cbHPES1_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub


    Private Sub cbBelongTo_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbBelongTo.SelectedIndexChanged
        If cbBelongTo.SelectedIndex = 0 Then
            _External = "All"
        ElseIf cbBelongTo.SelectedIndex = 1 Then
            _External = "1"
        ElseIf cbBelongTo.SelectedIndex = 2 Then
            _External = "0"
        End If
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub ChooseHazardReport_VisibleChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.VisibleChanged
        If FrmHazardReport._deleteID <> -1 Then
            GridView1.DeleteSelectedRows()
            If GridView1.RowCount > 0 Then
                GridView1.FocusedRowHandle = 0
                GridView1.SelectRow(0)
            End If
            FrmHazardReport._deleteID = -1
        End If
    End Sub

    Private Sub btnTKNBC_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTKNPT.Click, btnTKNBC.Click, btnTKBCT.Click, btNguoiLQ.Click

        Select Case DirectCast(sender, DevExpress.XtraEditors.SimpleButton).Name
            Case "btnTKNBC"
                Dim frm As New FrmFind(GetListInfoNBC())
                Dim p As New Point(105, 60)
                frm.Location = p
                ''frm.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedSingle
                frm.Width = frm.Width + 10
                frm.ShowDialog()
                If frm._user = "" Then
                    cbNBC.SelectedIndex = 0
                Else
                    cbNBC.Text = frm._user
                End If

            Case "btnTKBCT"
                Dim frm As New FrmFind(GetListInfoNPT_BCT())
                Dim p As New Point(708, 60)
                frm.Location = p
                'frm.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedSingle
                frm.ShowDialog()
                If frm._name = "" Then
                    cbReportParent.SelectedIndex = 0
                Else
                    cbReportParent.Text = frm._name
                End If

            Case "btnTKNPT"
                Dim frm As New FrmFind(GetListInfoNPT_BCT())
                Dim p As New Point(105, 100)
                frm.Location = p
                frm.Width = frm.Width + 10
                'frm.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedSingle
                frm.ShowDialog()
                If frm._name = "" Then
                    cbNPT.SelectedIndex = 0
                Else
                    cbNPT.Text = frm._name
                End If
            Case "btNguoiLQ"
                Dim frm As New FrmFind(GetListInfoNPT_BCT1())
                Dim p As New Point(105, 200)
                frm.Location = p
                frm.Width = frm.Width + 10
                'frm.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedSingle
                frm.ShowDialog()
                If frm._name = "" Then
                    cbNguoiLQ.SelectedIndex = 0
                Else
                    cbNguoiLQ.Text = frm._name
                End If
        End Select
    End Sub
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
            sqlcom.Parameters.AddWithValue("CreatedBy", DungChung.Login)

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
    Public Function GetListInfoNBC()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LISTNBC")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_FIND"
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
    Public Function GetListInfoNPT_BCT()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_FIND"
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

    Private Sub cbHPES1_CheckedChanged_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles HPES6.CheckedChanged, HPES5.CheckedChanged, HPES4.CheckedChanged, HPES3.CheckedChanged, HPES2.CheckedChanged, HPES1.CheckedChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    'Private Sub HPES1_MouseClick(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles HPES6.MouseClick, HPES5.MouseClick, HPES4.MouseClick, HPES3.MouseClick, HPES2.MouseClick, HPES1.MouseClick
    '    If (DirectCast(sender, RadioButton).Checked = True) Then
    '        DirectCast(sender, RadioButton).Checked = False
    '    End If
    'End Sub

    Private Sub cbIS_DELETE_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbIS_DELETE.CheckedChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub cbNgungviec_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub cboNgungviec_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cboNgungviec.SelectedIndexChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub cbNguoiLQ_SelectedValueChanged(sender As Object, e As EventArgs) Handles cbNguoiLQ.SelectedValueChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

    Private Sub txtNguoiLQ_TextChanged(sender As Object, e As EventArgs) Handles txtNguoiLQ.TextChanged
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT5 = True And _TT6 = True And _TT7 = True And _TT8 = True And _TT9 = True And _TT10 = True And _TT11 = True Then
            LoadData()
        End If
    End Sub

End Class