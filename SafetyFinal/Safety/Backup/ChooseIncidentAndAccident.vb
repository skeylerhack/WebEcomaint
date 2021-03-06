Imports System.Data.SqlClient
Imports DevExpress.XtraGrid.Views.Grid
Imports DevExpress.Utils

Public Class ChooseIncidentAndAccident
    Private _tb As DataTable
    Private _wherecon As String = ""
    Private _wherecon2 As String = ""
    Private _TT1 As Boolean = False
    Private _TT2 As Boolean = False
    Private _TT3 As Boolean = False
    Private _TT4 As Boolean = False
    Private _TT5 As Boolean = False
    Private _TT6 As Boolean = False
    Private _TT7 As Boolean = False
    Private _TT8 As Boolean = False
    Private _TT9 As Boolean = False
    Private _External As String = "All"
    Private Sub ChooseHazardReport_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        cbTrangthai.SelectedIndex = 0
        _TT1 = True
        dtTungay.Value = Now.Date.AddMonths(-1)
        _TT2 = True
        GetListNBC()
        GetListNPT()
        FillComboBelongTo()
        LoadData()

        Commons.Modules.ObjSystems.ThayDoiNN(Me)

        btnTKNBC.Text = "..."
        btnTKNPT.Text = "..."
    End Sub
    Public Sub LoadData()
        If _TT1 = True And _TT2 = True And _TT3 = True And _TT4 = True And _TT9 = True Then


            Dim dt As New DataTable
            _tb = New DataTable
            _wherecon = ""
            _wherecon2 = ""
            GetWhereCondition(gbLoaiSuCo, _wherecon)
            GetWhereHPECondition(GroupBox1, _wherecon2)

            If _wherecon.Length > 0 And _wherecon2.Length > 0 Then
                _wherecon = "( " & _wherecon & " ) AND ( " & _wherecon2 & " )"
            End If
            If _wherecon.Length > 0 And _wherecon2.Length = 0 Then
                _wherecon = "( " & _wherecon & " )"
            End If
            If _wherecon.Length = 0 And _wherecon2.Length > 0 Then
                _wherecon = "( " & _wherecon2 & " )"
            End If
            dt = GetListHazards()
            _tb = dt.Clone
            GridControl1.DataSource = dt
            GridView1.OptionsSelection.MultiSelect = False
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            LockGrid(True)
            For i As Integer = 0 To GridView1.Columns.Count - 1

                If i <> 1 And i <> 2 Then
                    GridView1.Columns(i).BestFit()

                    GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
                Else
                    If i = 1 Then
                        GridView1.Columns(i).Width = 105
                    Else
                        If i = 2 Then
                            GridView1.Columns(i).Width = 350
                        Else
                            GridView1.Columns(i).Width = 200
                        End If

                    End If


                    GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
                End If
            Next
        End If
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
                _TT3 = True
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
                _TT4 = True
            End If
        Catch generatedExceptionName As Exception
            _TT4 = True
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
    Public Function GetListHazards() As DataTable
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST")
            sqlcom.Parameters.AddWithValue("TUNGAY", dtTungay.Value)
            sqlcom.Parameters.AddWithValue("DENNGAY", dtDenngay.Value)
            sqlcom.Parameters.AddWithValue("NGUOIBC", cbNBC.Text)
            sqlcom.Parameters.AddWithValue("NGUOITH", cbNPT.Text)
            sqlcom.Parameters.AddWithValue("TRANGTHAI", cbTrangthai.Text)
            sqlcom.Parameters.AddWithValue("LOAISC", _wherecon)
            sqlcom.Parameters.AddWithValue("DOCNUM", txtDocNum.Text)
            sqlcom.Parameters.AddWithValue("External_N", _External)
            sqlcom.Parameters.AddWithValue("IS_DELETE", cbIS_DELETE.Checked)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
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

            _tb.Rows.Add(r)
            DungChung.ChooseData = _tb.Copy
            For Each f As Form In Application.OpenForms
                If f.Name = "FrmIncidentAndAccident" Then
                    DirectCast(f, FrmIncidentAndAccident).Timer1.Start()
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
    Private Sub GetWhereCondition(ByVal container As Control, ByRef condition As String)
        Try
            For Each c As Control In container.Controls
                GetWhereCondition(c, condition)
                If TypeOf c Is CheckBox Then
                    If CType(c, CheckBox).Checked = True Then
                        If condition.Length = 0 Then
                            condition = "[" & c.Name & "] = 'True'"
                        Else
                            condition = condition & " or [" & c.Name & "] = 'True'"
                        End If
                    End If
                End If
            Next
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
    Private Sub FirstAID_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles FirstAID.CheckedChanged, NearMiss.CheckedChanged, MTC.CheckedChanged, PropertyDamage.CheckedChanged, RWC.CheckedChanged, WorkRelatedIllness.CheckedChanged, NonEmployee.CheckedChanged, LTA.CheckedChanged, Fire.CheckedChanged, Fatality.CheckedChanged, Environment.CheckedChanged

        LoadData()
        'MessageBox.Show(_wherecon, "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Information)
    End Sub

    Private Sub txtNguoiphutrach_EditValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        LoadData()
    End Sub

    Private Sub dtTungay_ValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles dtTungay.ValueChanged, dtDenngay.ValueChanged
        LoadData()
    End Sub

    Private Sub cbTrangthai_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbTrangthai.SelectedIndexChanged
        LoadData()
    End Sub

    Private Sub SimpleButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton1.Click
        Me.Close()
    End Sub

    Private Sub cbNBC_SelectedValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbNPT.SelectedValueChanged, cbNBC.SelectedValueChanged
        LoadData()
    End Sub

    Private Sub txtDocNum_TextChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtDocNum.TextChanged
        LoadData()
    End Sub

    Private Sub cbNBC_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbNBC.SelectedIndexChanged

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
            If System.IO.File.Exists(Application.StartupPath & "/ListIncidentAndAccident.xls") Then
                System.IO.File.Delete(Application.StartupPath & "/ListIncidentAndAccident.xls")
            End If
            GridView1.ExportToExcelOld(Application.StartupPath & "/ListIncidentAndAccident.xls")
            GridView1.ExportToXls(Application.StartupPath & "/ListIncidentAndAccident.xls")
            If System.IO.File.Exists(Application.StartupPath & "/ListIncidentAndAccident.xls") Then
                OpenExcel(Application.StartupPath & "/ListIncidentAndAccident.xls")
            End If
        Catch ex As Exception
            MsgBox(ex.Message, MsgBoxStyle.Exclamation)
        End Try
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
                        'Case ""
                        '    e.Appearance.BackColor = Color.LimeGreen
                End Select
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub HPES1_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs)
        LoadData()
    End Sub

    Private Sub cbBelongTo_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbBelongTo.SelectedIndexChanged
        If cbBelongTo.SelectedIndex = 0 Then
            _External = "All"
        ElseIf cbBelongTo.SelectedIndex = 1 Then
            _External = "1"
        ElseIf cbBelongTo.SelectedIndex = 2 Then
            _External = "0"
        End If
        LoadData()
    End Sub

    Private Sub ChooseIncidentAndAccident_VisibleChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.VisibleChanged
        Try
            If FrmIncidentAndAccident._deleteID <> -1 Then
                GridView1.DeleteSelectedRows()
                If GridView1.RowCount > 0 Then
                    GridView1.FocusedRowHandle = 0
                    GridView1.SelectRow(0)
                End If
                FrmIncidentAndAccident._deleteID = -1
            End If
        Catch ex As Exception

        End Try
        
    End Sub

    Private Sub btnTKNBC_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTKNBC.Click, btnTKNPT.Click
        Select Case DirectCast(sender, DevExpress.XtraEditors.SimpleButton).Name
            Case "btnTKNBC"
                Dim frm As New FrmFind(GetListInfoNBC())
                Dim p As New Point(cbNBC.Location.X - 4, cbNBC.Location.Y + 26)
                frm.Location = p
                'frm.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedSingle
                frm.ShowDialog()
                If frm._user = "" Then
                    cbNBC.SelectedIndex = 0
                Else
                    cbNBC.Text = frm._user
                End If

            Case "btnTKNPT"
                Dim frm As New FrmFind(GetListInfoNPT_BCT())
                Dim p As New Point(cbNPT.Location.X - 4, cbNPT.Location.Y + 26)
                frm.Location = p
                'frm.FormBorderStyle = Windows.Forms.FormBorderStyle.FixedSingle
                frm.ShowDialog()
                If frm._name = "" Then
                    cbNPT.SelectedIndex = 0
                Else
                    cbNPT.Text = frm._name
                End If

        End Select
    End Sub
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

    Private Sub HPES1_CheckedChanged_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles HPES6.CheckedChanged, HPES5.CheckedChanged, HPES4.CheckedChanged, HPES3.CheckedChanged, HPES2.CheckedChanged, HPES1.CheckedChanged
        LoadData()
    End Sub

    Private Sub cbIS_DELETE_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cbIS_DELETE.CheckedChanged
        LoadData()
    End Sub

    Private Sub Label4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Label4.Click

    End Sub

    Private Sub Label5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lbNguoiLQ.Click

    End Sub
End Class