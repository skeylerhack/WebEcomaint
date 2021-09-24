Imports DevExpress.XtraGrid.Views.Grid
Imports System.Data.SqlClient
Imports DevExpress.XtraEditors
Imports DevExpress.Utils
Imports DevExpress.XtraGrid.Views.Grid.ViewInfo
Imports DevExpress.XtraGrid.Columns

Public Class FrmDanhMucQuanLyRuiRo
    Private tb As DataTable
    Private tbDT As DataTable
    Private tbTask As DataTable
    Private tbContactObject As DataTable
    Private _action As String = ""
    Private CheckedComboBoxEdit1 As New DevExpress.XtraEditors.Repository.RepositoryItemCheckedComboBoxEdit
#Region "Load form"
    Private Sub FrmListMoiNguy_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        LoadListLocation()
        LoadListHazards()
        LoadListTasks()
        LoadListContactObjects()
        LoadData()
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        GridView1.Columns("btTask").Caption = " "
        GridView1.Columns("btContactObject").Caption = " "
        btnTKNG.Text = "..."
        btnXFilter.Text = "X"
    End Sub
#End Region
#Region "MultiSelect"
    Private Function GetSelectedRows(ByVal view As GridView) As DataTable
        Dim ret As String = ""
        Try
            tb.Columns.Remove("PicPath")
        Catch ex As Exception

        End Try
        Dim r As DataRow = Nothing
        For Each i As Integer In GridView1.GetSelectedRows()
            Dim row As DataRow = GridView1.GetDataRow(i)
            If ret <> "" Then
                ret &= Constants.vbCrLf
            End If
            r = tb.NewRow
            r("ID") = row("ID")
            tb.Rows.Add(r)
        Next i
        Return tb
    End Function
#End Region
#Region "Add/Edit"
    Private Sub AllowEdit(ByVal TT As Boolean)
        For i As Integer = 0 To GridView1.Columns.Count - 1
            GridView1.Columns(i).OptionsColumn.AllowEdit = TT
        Next
        GridView1.Columns(10).OptionsColumn.AllowEdit = True
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
        _action = ""
    End Sub
    Private Sub btnAdd_Edit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd_Edit.Click
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        AllowEdit(True)
        EnableButton(True)
        btnSave.Focus()
        _action = "Edit"
        GridView1.FocusedRowHandle = DevExpress.XtraGrid.GridControl.NewItemRowHandle
        
    End Sub
    Private Function fnValid()
        Try
            For i As Integer = 0 To GridView1.RowCount - 2
                If IsDBNull(GridView1.GetRowCellValue(i, "LocationID")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "PHAICHONVITRI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Location at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "LocationID") = Nothing Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "PHAICHONVITRI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Location at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "HazardID")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "PHAICHONMOINGUY", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Hazard at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "HazardID") = Nothing Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "PHAICHONMOINGUY", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Hazard at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "TaskID")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "PHAICHONCONGVIEC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Task at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "TaskID") = Nothing Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "PHAICHONCONGVIEC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Task at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "ContackObjectID")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "PHAICHONDOITUONGLIENQUAN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Contact Object at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "ContackObjectID") = Nothing Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "PHAICHONDOITUONGLIENQUAN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Contact Object at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
            Next
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        btnDeleteFilter_Click(Nothing, Nothing)
        If GridView1.DataRowCount > 0 Then
            If Not fnValid() Then
                Exit Sub
            End If

            Dim dt As DataTable = CType(GridControl1.DataSource, DataTable)
            Dim table As DataTable = dt.Copy
            Try

                dt.Columns.Remove("IMG")
                dt.Columns.Remove("PicPath")
            Catch ex As Exception

            End Try
            If Excute("SAVE", dt) Then
                CopyFileToFolderShare(table)
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "LUUDLTC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                'MessageBox.Show(Me, "Save data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                LoadData()
                EnableButton(False)
                btnAdd_Edit.Focus()
                GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                _action = ""
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "LUUDLLOI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Save data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        End If

    End Sub
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        Dim dt As DataTable = GetSelectedRows(GridView1)
        If dt.Rows.Count > 0 Then
            If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "XACNHANXOADONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
                'If MessageBox.Show("Are you sure you want to delete the row selected?", "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
                If Excute("DELETE", dt) Then
                    'DeleteFileFromFolderShare()
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "XOATHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                    'MessageBox.Show(Me, "Delete data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                    LoadData()
                    EnableButton(False)
                    btnAdd_Edit.Focus()
                    GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                    _action = ""
                Else
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "XOAKHONGTHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Delete data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                End If
            End If
        Else
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "CHUACHONDONGCANXOA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmDanhMucQuanLyRuiRo", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Must select the row to delete!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        End If

    End Sub
    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Me.Close()
    End Sub
#End Region
#Region "Get/Save data"
    Public Sub LoadListLocation()
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
            sqlcom.CommandText = "VS_ST_RiskRegister"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Location Name"
            cboStatus.DataSource = ds.Tables(0)

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Location Name"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Description"))
            cboStatus.PopupWidth = 130
            cboStatus.Columns("ID").Width = 20
            cboStatus.Columns("Location Name").Width = 50
            cboStatus.Columns("Description").Width = 60

            GridView1.Columns("LocationID").ColumnEdit = cboStatus

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub LoadListHazards()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_HAZARDS")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_RiskRegister"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Hazard"
            cboStatus.DataSource = ds.Tables(0)

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Hazard"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Description"))
            cboStatus.PopupWidth = 130
            cboStatus.Columns("ID").Width = 20
            cboStatus.Columns("Hazard").Width = 50
            cboStatus.Columns("Description").Width = 60

            GridView1.Columns("HazardID").ColumnEdit = cboStatus

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub LoadListTasks()
        Try
            Dim dt As New DataTable()
            tbTask = New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_TASKS")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_RiskRegister"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Task"
            cboStatus.DataSource = ds.Tables(0)

            tbTask = ds.Tables(0)

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Task"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Description"))
            cboStatus.PopupWidth = 130
            cboStatus.Columns("ID").Width = 20
            cboStatus.Columns("Task").Width = 50
            cboStatus.Columns("Description").Width = 60
            cboStatus.Buttons(0).Visible = False
            cboStatus.ShowDropDown = DevExpress.XtraEditors.Controls.ShowDropDown.Never
            GridView1.Columns("TaskID").ColumnEdit = cboStatus

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub LoadListContactObjects()
        Try
            tbContactObject = New DataTable()
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_CONTACTOBJECTS")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_RiskRegister"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)

            CheckedComboBoxEdit1 = New DevExpress.XtraEditors.Repository.RepositoryItemCheckedComboBoxEdit
            If ds.Tables.Count > 0 Then
                tbContactObject = ds.Tables(0)
                CheckedComboBoxEdit1.Items.Clear()

                For ct As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    Dim it As New DevExpress.XtraEditors.Controls.CheckedListBoxItem
                    it.Description = ds.Tables(0).Rows(ct)(1).ToString()
                    it.Value = ds.Tables(0).Rows(ct)(0).ToString()
                    it.CheckState = CheckState.Unchecked
                    CheckedComboBoxEdit1.Items.Add(it)
                Next
                CheckedComboBoxEdit2.Properties.Items.Clear()

                For ct As Integer = 0 To ds.Tables(0).Rows.Count - 1
                    Dim it As New DevExpress.XtraEditors.Controls.CheckedListBoxItem
                    it.Description = ds.Tables(0).Rows(ct)(1).ToString()
                    it.Value = ds.Tables(0).Rows(ct)(0).ToString()
                    it.CheckState = CheckState.Unchecked
                    CheckedComboBoxEdit2.Properties.Items.Add(it)
                Next
            End If


            'cboStatus.NullText = ""
            'cboStatus.ValueMember = "ID"
            'cboStatus.DisplayMember = "ContactObject"
            'cboStatus.DataSource = ds.Tables(0)

            'cboStatus.Columns.Clear()
            'cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            'cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ContactObject"))
            'cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Description"))
            'cboStatus.PopupWidth = 130
            'cboStatus.Columns("ID").Width = 20
            'cboStatus.Columns("ContactObject").Width = 50
            'cboStatus.Columns("Description").Width = 60



            GridView1.Columns("ContackObjectID").ColumnEdit = CheckedComboBoxEdit1

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub LoadData()
        tbDT = New DataTable
        'GridView1.RowHeight = 60
        tb = New DataTable()
        tbDT = GetListRiskRegister()
        tb = tbDT.Clone()
        tbDT.Columns.Add("IMG", GetType(Image))
        GridControl1.DataSource = tbDT
        Try
            For i As Integer = 0 To GridView1.RowCount - 1
                If Not IsDBNull(GridView1.GetRowCellValue(i, "Picture")) And Not GridView1.GetRowCellValue(i, "Picture") Is Nothing Then
                    Dim img As Image = System.Drawing.Image.FromFile(GridView1.GetRowCellValue(i, "Picture"))
                    If img.Height > 60 Then
                        Dim tyle As Double = GridView1.FocusedColumn.Width / 60 ' img1.Width / img1.Height
                        img = img.GetThumbnailImage(GridView1.FocusedColumn.Width + 64, 60, Nothing, New IntPtr())
                    End If

                    GridView1.SetRowCellValue(i, "IMG", img)
                End If
            Next
        Catch ex As Exception

        End Try
        GridControl1.DataSource = tbDT
        GridView1.OptionsSelection.MultiSelect = True
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        AllowEdit(False)
        For i As Integer = 0 To GridView1.Columns.Count - 1
            'If i <> 9 Then
            '    GridView1.Columns(i).BestFit()

            'Else
            '    GridView1.Columns(i).Width = 98
            'End If
            If i <> 9 Then
                GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
            Else
                GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
            End If
        Next

    End Sub
    Public Function GetListRiskRegister() As DataTable
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
            sqlcom.CommandText = "VS_ST_RiskRegister"
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
                sqlcom.CommandText = "VS_ST_RiskRegister"
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

    Private Sub RepositoryItemPictureEdit1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RepositoryItemPictureEdit1.Click
        Try
            If _action <> "" Then
                Dim op As New OpenFileDialog
                op.Filter = "(Image Files)|*.jpg;*.png;*.bmp;*.gif;*.ico|Jpg, | *.jpg|Png, | *.png|Bmp, | *.bmp|Gif, | *.gif|Ico | *.ico"
                If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                    Dim img As Image = System.Drawing.Image.FromFile(op.FileName)
                    If img.Height > 60 Then
                        Dim tyle As Double = GridView1.FocusedColumn.Width / img.Height 'img.Width / img.Height
                        img = img.GetThumbnailImage(GridView1.FocusedColumn.Width + 64, 60, Nothing, New IntPtr())
                    End If
                    GridView1.SetFocusedValue(img)
                    If GridView1.FocusedValue Is Nothing Then
                        GridView1.AddNewRow()
                        Dim img1 As Image = System.Drawing.Image.FromFile(op.FileName)
                        If img1.Height > 60 Then
                            Dim tyle As Double = GridView1.FocusedColumn.Width / img1.Height ' img1.Width / img1.Height
                            img1 = img1.GetThumbnailImage(GridView1.FocusedColumn.Width + 64, 60, Nothing, New IntPtr())
                        End If
                        GridView1.SetFocusedValue(img1)
                    End If
                    Try
                        GridView1.SetFocusedRowCellValue("Picture", DungChung.FolderShare + "/" + System.IO.Path.GetFileName(op.FileName))
                        GridView1.SetFocusedRowCellValue("PicPath", op.FileName)

                    Catch ex As Exception

                    End Try
                End If
            End If
        Catch ex As Exception

        End Try

    End Sub
    Private Function CopyFileToFolderShare(ByVal dt As DataTable)
        Try
            Dim flag As Boolean = False

            For Each dr As DataRow In dt.Rows
                If Not IsDBNull(dr("PicPath")) And Not dr("PicPath") Is Nothing Then
                    If Not DungChung.CopyFile(dr("PicPath"), DungChung.FolderShare) Then
                        'MessageBox.Show(Me, "Copy image to folder share failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                        flag = False
                    Else
                        flag = True
                    End If
                End If
            Next
            Return flag
        Catch ex As Exception
            Return False
        End Try
    End Function

    'Private Function DeleteFileFromFolderShare()
    '    Try
    '        For i As Integer = 0 To GridView1.RowCount - 1
    '            If Not IsDBNull(GridView1.GetRowCellValue(i, "Picture")) And Not GridView1.GetRowCellValue(i, "Picture") Is Nothing Then
    '                If Not DungChung.DeleteFile(GridView1.GetRowCellValue(i, "Picture")) Then
    '                    MessageBox.Show(Me, "Delete image from folder share failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
    '                    Return False
    '                End If
    '            End If
    '        Next
    '        Return True
    '    Catch ex As Exception
    '        Return False
    '    End Try
    'End Function

    Private Sub ShowImageToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ShowImageToolStripMenuItem.Click
        If GridView1.FocusedColumn.AbsoluteIndex = 10 Then
            Try
                Dim img As Image = GridView1.GetFocusedRowCellValue("IMG")
                Dim frm As New FrmShowImg(img)
                frm.ShowDialog()
                GridControl1.ContextMenuStrip = Nothing
            Catch ex As Exception

            End Try
        End If

    End Sub
    Private Sub GridControl1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GridControl1.Click
        Try
            GridControl1.ContextMenuStrip = Nothing
            If GridView1.FocusedColumn.AbsoluteIndex = 10 Then
                GridControl1.ContextMenuStrip = ContextMenuStrip1
            Else
                GridControl1.ContextMenuStrip = Nothing
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub GridView1_GotFocus(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GridView1.GotFocus
        Try
            GridControl1.ContextMenuStrip = Nothing
            If GridView1.FocusedColumn.AbsoluteIndex = 10 Then
                GridControl1.ContextMenuStrip = ContextMenuStrip1
            Else
                GridControl1.ContextMenuStrip = Nothing
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub RepositoryItemPictureEdit1_MouseClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RepositoryItemPictureEdit1.Click
        Try
            If _action = "" Then
                Dim path As String = GridView1.GetFocusedRowCellValue("PicPath")
                Dim frm As New FrmShowImg(Bitmap.FromFile(path))
                frm.ShowDialog()
            End If
        Catch ex As Exception

        End Try

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
            
            GridView1.Columns("IMG").Visible = False
            If System.IO.File.Exists(Application.StartupPath & "/ListRRKhuVuc.xls") Then
                System.IO.File.Delete(Application.StartupPath & "/ListRRKhuVuc.xls")
            End If
            GridView1.ExportToExcelOld(Application.StartupPath & "/ListRRKhuVuc.xls")
            GridView1.ExportToXls(Application.StartupPath & "/ListRRKhuVuc.xls")
            If System.IO.File.Exists(Application.StartupPath & "/ListRRKhuVuc.xls") Then
                OpenExcel(Application.StartupPath & "/ListRRKhuVuc.xls")
            End If
        Catch ex As Exception
            MsgBox(ex.Message, MsgBoxStyle.Exclamation)
        End Try
       
        GridView1.Columns("IMG").Visible = True
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
            Dim cP As New Point(Cursor.Position.X - 30, Cursor.Position.Y)

            If hi.Column.Name = "btTask" Then

                Dim frm As New FrmQFind(tbTask)
                Dim p As New Point(Cursor.Position.X - 100, Cursor.Position.Y + 14)
                frm.Location = p
                frm.ShowDialog()
                GridView1.Focus()
                GridView1.BeginSelection()

                If frm._id <> -1 Then

                    If GridView1.FocusedRowHandle >= 0 Then
                        GridView1.SetFocusedRowCellValue("TaskID", frm._id.ToString())
                    Else
                        Dim dr As DataRow = tbDT.NewRow
                        dr("TaskID") = frm._id.ToString()

                        tbDT.Rows.Add(dr)
                        tbDT.AcceptChanges()
                        GridView1.FocusedRowHandle = GridView1.RowCount
                    End If



                End If
                System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 140, Cursor.Position.Y + 14)
                VirtualMouse.LeftClick()
            End If
            If hi.Column.Name = "btContactObject" Then

                Dim frm As New FrmQFind(tbContactObject)
                Dim p As New Point(Cursor.Position.X - 140, Cursor.Position.Y + 14)
                frm.Location = p
                frm.ShowDialog()
                GridView1.Focus()
                GridView1.BeginSelection()

                If frm._id <> -1 Then

                    If GridView1.FocusedRowHandle >= 0 Then
                        'SetCheckValue(frm._id.ToString())
                        If IsDBNull(GridView1.GetFocusedRowCellValue("ContackObjectID")) = True Then
                            GridView1.SetFocusedRowCellValue("ContackObjectID", frm._id.ToString())
                        Else
                            If fnCheckExits(frm._id.ToString()) = False Then

                                GridView1.SetFocusedRowCellValue("ContackObjectID", GridView1.GetFocusedRowCellValue("ContackObjectID") & "," & frm._id.ToString())

                            End If
                        End If


                    End If
                End If

                System.Windows.Forms.Cursor.Position = cP
                VirtualMouse.LeftClick()
                VirtualMouse.LeftClick()
                Me.SelectNextControl(Me.ActiveControl, True, True, True, True)
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Function fnCheckExits(ByVal key As String)
        If IsDBNull(GridView1.GetFocusedRowCellValue("ContackObjectID")) = False Then
            Dim s() As String = GridView1.GetFocusedRowCellValue("ContackObjectID").ToString().Split(",")
            For i As Integer = 0 To s.Length - 1
                If s(i) = key Then
                    Return True
                End If
            Next
        End If
        Return False
    End Function
    Private Sub SetFilterValue()
        Try
            Dim sl As String = ""
            Try
                For ct As Integer = 0 To CheckedComboBoxEdit2.Properties.Items.Count - 1
                    Dim it As DevExpress.XtraEditors.Controls.CheckedListBoxItem = CheckedComboBoxEdit2.Properties.Items(ct)
                    If it.CheckState = CheckState.Checked Then
                        If sl.Length = 0 Then
                            sl = "[ContackObjectID] LIKE '%" & it.Value.ToString() & "%'"
                        Else
                            sl = sl & " OR [ContackObjectID] LIKE '%" & it.Value.ToString() & "%'"
                        End If
                    End If
                Next
            Catch ex As Exception

            End Try
            'GridView1.Columns("ContackObjectID").FilterInfo = New ColumnFilterInfo("[ContackObjectID] LIKE '%1%' OR [ContackObjectID] LIKE '%2%'")
            If sl.Length = 0 Then
                sl = "[ContackObjectID] LIKE '%'"
            End If
            GridView1.Columns("ContackObjectID").FilterInfo = New ColumnFilterInfo(sl)
        Catch ex As Exception

        End Try

    End Sub

    Private Sub CheckedComboBoxEdit2_Closed(ByVal sender As System.Object, ByVal e As DevExpress.XtraEditors.Controls.ClosedEventArgs) Handles CheckedComboBoxEdit2.Closed
        SetFilterValue()
    End Sub
    Private Sub SetCheckValue(ByVal id As String)
        Try

            For ct As Integer = 0 To CheckedComboBoxEdit2.Properties.Items.Count - 1
                Dim it As DevExpress.XtraEditors.Controls.CheckedListBoxItem = CheckedComboBoxEdit2.Properties.Items(ct)
                If it.Value = id Then
                    CheckedComboBoxEdit2.Properties.Items(ct).CheckState = CheckState.Checked
                End If
            Next
            SetFilterValue()
        Catch ex As Exception

        End Try
    End Sub
    Private Sub btnTKNG_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTKNG.Click
        Dim frm As New FrmQFind(tbContactObject)
        Dim p As New Point(Cursor.Position.X - 80, Cursor.Position.Y - 220)
        frm.Location = p
        frm.ShowDialog()
        If frm._id <> -1 Then
            SetCheckValue(frm._id.ToString())
        End If

    End Sub

    Private Sub btnDeleteFilter_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnXFilter.Click
        Try
            For ct As Integer = 0 To CheckedComboBoxEdit2.Properties.Items.Count - 1
                Dim it As DevExpress.XtraEditors.Controls.CheckedListBoxItem = CheckedComboBoxEdit2.Properties.Items(ct)
                CheckedComboBoxEdit2.Properties.Items(ct).CheckState = CheckState.Unchecked
            Next
            SetFilterValue()
        Catch ex As Exception

        End Try
    End Sub
End Class