Imports DevExpress.XtraGrid.Views.Base
Imports DevExpress.XtraGrid.Views.Grid
Imports DevExpress.XtraEditors.Controls
Imports System.Data.SqlClient
Imports DevExpress.XtraEditors
Imports DevExpress.Utils
Imports DevExpress.XtraGrid.Views.Grid.ViewInfo

Public Class FrmPhanQuyenDuyet
    Private _tbPersonInCharge As New DataTable()
    Private _tt As String = ""
#Region "Load form"
    Private Sub FrmListMoiNguy_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        LoadListForm()
        LoadListUserAppr()
        LoadData()
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        GridView1.Columns("InCharge").Caption = " "
        GridView1.Columns("InCharge2").Caption = " "
    End Sub
#End Region
#Region "MultiSelect"
    Private Function GetSelectedRows(ByVal view As GridView) As DataTable
        Dim ret As String = ""
        Dim rowIndex As Integer = -1
        Dim dt As New DataTable
        dt.Columns.Add("ID")
        dt.Columns.Add("FORM_ID")
        dt.Columns.Add("APPROVAL_LEVEL1")
        dt.Columns.Add("APPROVAL_LEVEL2")
        Dim r As DataRow = Nothing
        For Each i As Integer In GridView1.GetSelectedRows()
            Dim row As DataRow = GridView1.GetDataRow(i)
            If ret <> "" Then
                ret &= Constants.vbCrLf
            End If
            r = dt.NewRow
            r("ID") = row("ID")
            r("FORM_ID") = row("FORM_ID")
            r("APPROVAL_LEVEL1") = row("APPROVAL_LEVEL1")
            r("APPROVAL_LEVEL2") = row("APPROVAL_LEVEL2")
            dt.Rows.Add(r)
        Next i
        'If view.OptionsSelection.MultiSelectMode = GridMultiSelectMode.RowSelect Then
        '    For Each i As Integer In GridView1.GetSelectedRows()
        '        Dim row As DataRow = GridView1.GetDataRow(i)
        '        If ret <> "" Then
        '            ret &= Constants.vbCrLf
        '        End If
        '        ret &= String.Format("Order: #{0} {1}", row("Description"), GridView1.GetRowCellDisplayText(i, clLocationName))
        '    Next i
        'Else
        '    For Each cell As GridCell In view.GetSelectedCells()
        '        If rowIndex <> cell.RowHandle Then
        '            If ret <> "" Then
        '                ret &= Constants.vbCrLf
        '            End If
        '            ret &= String.Format("Row: #{0}", cell.RowHandle)
        '        End If
        '        ret &= Constants.vbCrLf & "    " & view.GetRowCellDisplayText(cell.RowHandle, cell.Column)
        '        rowIndex = cell.RowHandle
        '    Next cell
        'End If
        Return dt
    End Function
#End Region
#Region "Add/Edit"
    Private Sub AllowEdit(ByVal TT As Boolean)
        For i As Integer = 0 To GridView1.Columns.Count - 1
            GridView1.Columns(i).OptionsColumn.AllowEdit = TT
        Next
    End Sub
#End Region
#Region "Control Button"
    Private Sub EnableButton(ByVal TT As Boolean)
        'btnSave.Enabled = TT
        'btnCancel.Enabled = TT
        'btnAdd_Edit.Enabled = Not TT
        btnSave.Visible = TT
        btnCancel.Visible = TT
        btnAdd_Edit.Visible = Not TT
        btnDelete.Visible = Not TT
        btnClose.Visible = Not TT
    End Sub
    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        LoadData()
        EnableButton(False)
        btnAdd_Edit.Focus()
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        _tt = ""
    End Sub
    Private Sub btnAdd_Edit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd_Edit.Click
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        AllowEdit(True)
        EnableButton(True)
        btnSave.Focus()
        _tt = "ADD"
    End Sub
    Private Function fnValid()
        Try
            For i As Integer = 0 To GridView1.RowCount - 2
                If IsDBNull(GridView1.GetRowCellValue(i, "FORM_ID")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "PHAICHONMANHINHPHANQUYEN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input FormID at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "FORM_ID") = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "PHAICHONMANHINHPHANQUYEN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input FormID at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "APPROVAL_LEVEL1")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "PHAICHONNGUOIDUYETCAP1", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input First Approval at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "APPROVAL_LEVEL1") = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "PHAICHONNGUOIDUYETCAP1", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input First Approval at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If GridView1.GetRowCellValue(i, "FORM_ID") = "FrmIncidentAndAccident" Then
                    If IsDBNull(GridView1.GetRowCellValue(i, "APPROVAL_LEVEL2")) Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "PHAICHONNGUOIDUYETCAP2", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Must input Second Approval at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        GridView1.ClearSelection()
                        GridView1.FocusedRowHandle = i
                        GridView1.SelectRow(i)
                        GridView1.ClearSelection()
                        Return False
                    ElseIf GridView1.GetRowCellValue(i, "APPROVAL_LEVEL2") = "" Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "PHAICHONNGUOIDUYETCAP2", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Must input Second Approval at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        GridView1.ClearSelection()
                        GridView1.FocusedRowHandle = i
                        GridView1.SelectRow(i)
                        Return False
                    End If
                End If
            Next
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    Private Function fnCheckDuplicate(ByVal LocationName As String)
        Try
            Dim dem As Integer = 0
            For i As Integer = 0 To GridView1.RowCount - 2
                If GridView1.GetRowCellValue(i, "LocationName") = LocationName Then
                    dem += 1
                End If
            Next
            If dem > 1 Then
                Return True
            Else
                Return False
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If GridView1.DataRowCount > 0 Then
            If Not fnValid() Then
                Exit Sub
            End If
            If Excute("SAVE", CType(GridControl1.DataSource, DataTable)) Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "LUUDLTC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                'MessageBox.Show(Me, "Save data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                LoadData()
                EnableButton(False)
                btnAdd_Edit.Focus()
                GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                _tt = ""
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "LUUDLLOI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                'MessageBox.Show(Me, "Save data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If


        End If
       
    End Sub
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        Dim dt As DataTable = GetSelectedRows(GridView1)
        If dt.Rows.Count > 0 Then
            If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "XACNHANXOADONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
                'If MessageBox.Show("Are you sure you want to delete the row selected?", "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
                If Excute("DELETE", dt) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "XOATHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                    'MessageBox.Show(Me, "Delete data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                    LoadData()
                    EnableButton(False)
                    btnAdd_Edit.Focus()
                    GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                Else
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "XOAKHONGTHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Delete data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                End If
            End If
        Else
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "CHUACHONDONGCANXOA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmPhanQuyenDuyet", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Must select the row to delete!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        End If

    End Sub
    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Me.Close()
    End Sub
    'Private Function fnGetSelectRow() As DataTable
    '    Dim dt As New DataTable
    '    dt.Columns.Add("VT")
    '    Dim r As DataRow = Nothing
    '    For Each i As Integer In GridView1.GetSelectedRows()
    '        r = dt.NewRow
    '        r("VT") = i
    '        dt.Rows.Add(r)
    '    Next i
    '    Return dt
    'End Function
    'Private Sub GridControl1_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles GridControl1.KeyDown
    '    Try
    '        If GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None Then
    '            Exit Sub
    '        End If
    '        If e.KeyCode = Keys.Delete Then
    '            Dim dt As DataTable = CType(GridControl1.DataSource, DataTable)
    '            Try
    '                Dim t As DataTable = fnGetSelectRow()
    '                For j As Integer = t.Rows.Count - 1 To 0 Step -1
    '                    dt.Rows.RemoveAt(t.Rows(j)("VT"))
    '                Next
    '                GridControl1.DataSource = dt
    '            Catch ex As Exception

    '            End Try

    '        End If
    '    Catch ex As Exception

    '    End Try
    'End Sub
#End Region
#Region "Get/Save data"
    Public Sub LoadData()
        Dim dt As New DataTable
        dt = GetListLOCATIONS()
        GridControl1.DataSource = dt
        GridView1.OptionsSelection.MultiSelect = True
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        AllowEdit(False)
        For i As Integer = 0 To GridView1.Columns.Count - 1

            If i <> 1 Then
                GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
            Else
                GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
            End If
        Next
    End Sub
    Public Function GetListLOCATIONS() As DataTable
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
            sqlcom.CommandText = "VS_ST_APPROVAL_USER"
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
    Public Function Excute(ByVal Action As String, ByVal tb As DataTable) As [Boolean]
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
                If (tb IsNot Nothing) Then
                    sqlcom.Parameters.AddWithValue("@TB", tb)
                End If
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_APPROVAL_USER"
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
    Public Sub LoadListForm()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_FORM")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_APPROVAL_USER"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "FORM NAME"
            cboStatus.DataSource = ds.Tables(0)

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("FORM NAME"))

            cboStatus.PopupWidth = 350
            cboStatus.Columns("ID").Width = 150
            cboStatus.Columns("FORM NAME").Width = 200


            GridView1.Columns("FORM_ID").ColumnEdit = cboStatus

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub LoadListUserAppr()
        Try
            _tbPersonInCharge = New DataTable()
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_USER")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_APPROVAL_USER"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "Staff name"
            cboStatus.DisplayMember = "Staff name"
            cboStatus.DataSource = ds.Tables(0)
            _tbPersonInCharge = ds.Tables(0).Copy()
            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Staff name"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("DESCRIPTION"))

            cboStatus.PopupWidth = 250
            cboStatus.Columns("Staff name").Width = 100
            cboStatus.Columns("DESCRIPTION").Width = 150
            cboStatus.ShowDropDown = ShowDropDown.Never
            cboStatus.Buttons(0).Visible = False

            GridView1.Columns("APPROVAL_LEVEL1").ColumnEdit = cboStatus
            GridView1.Columns("APPROVAL_LEVEL2").ColumnEdit = cboStatus
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
#End Region
    Private Sub gridView1_CustomDrawRowIndicator(ByVal sender As Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs) Handles GridView1.CustomDrawRowIndicator
        If e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Header Then
            e.Appearance.DrawBackground(e.Cache, e.Bounds)
            e.Appearance.DrawString(e.Cache, " ", e.Bounds)

            e.Handled = True
        Else
            e.Info.DisplayText = (e.RowHandle + 1).ToString()
        End If

    End Sub

    Private Sub GridView1_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles GridView1.MouseDown
        If _tt = "" Then
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
        If hi.Column.Name = "InCharge" Then

            Dim frm As New FrmFind(_tbPersonInCharge)
            Dim p As New Point(Me.Location.X + 365, Cursor.Position.Y + 10)
            frm.Location = p
            frm.ShowDialog()
            GridView1.Focus()
            GridView1.BeginSelection()
            If frm._id <> -1 Then
                GridView1.SetFocusedRowCellValue("APPROVAL_LEVEL1", frm._name.ToString())
            End If

        End If
        If hi.Column.Name = "InCharge2" Then

            Dim frm As New FrmFind(_tbPersonInCharge)
            Dim p As New Point(Me.Location.X + 925, Cursor.Position.Y + 10)
            frm.Location = p
            frm.ShowDialog()
            GridView1.Focus()
            GridView1.BeginSelection()
            If frm._id <> -1 Then
                GridView1.SetFocusedRowCellValue("APPROVAL_LEVEL2", frm._name.ToString())
            End If

        End If
    End Sub
End Class