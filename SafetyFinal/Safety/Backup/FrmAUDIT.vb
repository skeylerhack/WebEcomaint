Imports DevExpress.XtraGrid.Views.Base
Imports DevExpress.XtraGrid.Views.Grid
Imports DevExpress.XtraEditors.Controls
Imports System.Data.SqlClient
Imports DevExpress.XtraEditors
Imports DevExpress.Utils
Imports DevExpress.XtraGrid.Views.Grid.ViewInfo

Public Class FrmAUDIT
    Private tt As String = ""
    Private _tbPersonInCharge As New DataTable()
#Region "Load form"
    Private Sub FrmListMoiNguy_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        LoadStatus()
        LoadListInCharge()
        LoadData()
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        If tt = "" Then
            GridControl1.ContextMenuStrip = Nothing
        Else
            GridControl1.ContextMenuStrip = ContextMenuStrip1
        End If
        GridView1.Columns("InCharge1").Caption = " "
    End Sub
#End Region
#Region "MultiSelect"
    Private Function GetSelectedRows(ByVal view As GridView) As DataTable
        Dim ret As String = ""
        Dim rowIndex As Integer = -1
        Dim dt As New DataTable
        dt.Columns.Add("ID")
        dt.Columns.Add("STT")
        dt.Columns.Add("AuditContent")
        dt.Columns.Add("InCharge")
        dt.Columns.Add("DeadLine")
        dt.Columns.Add("Status")
        dt.Columns.Add("Description")
        Dim r As DataRow = Nothing
        For Each i As Integer In GridView1.GetSelectedRows()
            Dim row As DataRow = GridView1.GetDataRow(i)
            If ret <> "" Then
                ret &= Constants.vbCrLf
            End If
            r = dt.NewRow
            r("ID") = row("ID")
            'r("AuditContent") = row("AuditContent")
            'r("InCharge") = row("InCharge")
            'r("DeadLine") = row("DeadLine")
            'r("Status") = row("Status")
            'r("Description") = row("Description")
            dt.Rows.Add(r)
        Next i
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
        tt = ""
        If tt = "" Then
            GridControl1.ContextMenuStrip = Nothing
        Else
            GridControl1.ContextMenuStrip = ContextMenuStrip1
        End If
    End Sub
    Private Sub btnAdd_Edit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd_Edit.Click
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        AllowEdit(True)
        EnableButton(True)
        btnSave.Focus()
        tt = "Edit"
        If tt = "" Then
            GridControl1.ContextMenuStrip = Nothing
        Else
            GridControl1.ContextMenuStrip = ContextMenuStrip1
        End If
    End Sub
    Private Function fnValid()
        Try
            For i As Integer = 0 To GridView1.RowCount - 2
                If IsDBNull(GridView1.GetRowCellValue(i, "AuditContent")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmAUDIT", "PHAINHAPNOIDUNG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmAUDIT", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input Content at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "AuditContent") = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmAUDIT", "PHAINHAPNOIDUNG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmAUDIT", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input Content at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                'If IsDBNull(GridView1.GetRowCellValue(i, "InCharge")) Then
                '    MessageBox.Show(Me, "Must input InCharge at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                '    GridView1.ClearSelection()
                '    GridView1.FocusedRowHandle = i
                '    GridView1.SelectRow(i)
                '    GridView1.ClearSelection()
                '    Return False
                'ElseIf GridView1.GetRowCellValue(i, "InCharge") = "" Then
                '    MessageBox.Show(Me, "Must input InCharge at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                '    GridView1.ClearSelection()
                '    GridView1.FocusedRowHandle = i
                '    GridView1.SelectRow(i)
                '    Return False
                'End If
                'If IsDBNull(GridView1.GetRowCellValue(i, "DeadLine")) Then
                '    MessageBox.Show(Me, "Must input DeadLine at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                '    GridView1.ClearSelection()
                '    GridView1.FocusedRowHandle = i
                '    GridView1.SelectRow(i)
                '    GridView1.ClearSelection()
                '    Return False
                'ElseIf GridView1.GetRowCellValue(i, "DeadLine") = Nothing Then
                '    MessageBox.Show(Me, "Must input DeadLine at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                '    GridView1.ClearSelection()
                '    GridView1.FocusedRowHandle = i
                '    GridView1.SelectRow(i)
                '    Return False
                'End If
                'If IsDBNull(GridView1.GetRowCellValue(i, "Status")) Then
                '    MessageBox.Show(Me, "Must choose Status at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                '    GridView1.ClearSelection()
                '    GridView1.FocusedRowHandle = i
                '    GridView1.SelectRow(i)
                '    GridView1.ClearSelection()
                '    Return False
                'ElseIf GridView1.GetRowCellValue(i, "Status") = -1 Then
                '    MessageBox.Show(Me, "Must choose Status at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                '    GridView1.ClearSelection()
                '    GridView1.FocusedRowHandle = i
                '    GridView1.SelectRow(i)
                '    Return False
                'End If
            Next
            Return True
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
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmAUDIT", "LUUDLTC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmAUDIT", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                'MessageBox.Show(Me, "Save data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmAUDIT", "LUUDLLOI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmAUDIT", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Save data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        End If
        LoadData()
        EnableButton(False)
        btnAdd_Edit.Focus()
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        tt = ""
        If tt = "" Then
            GridControl1.ContextMenuStrip = Nothing
        Else
            GridControl1.ContextMenuStrip = ContextMenuStrip1
        End If
    End Sub
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        Dim dt As DataTable = GetSelectedRows(GridView1)
        If dt.Rows.Count > 0 Then
            If MessageBox.Show("Are you sure you want to delete the row selected?", "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
                If Excute("DELETE", dt) Then
                    MessageBox.Show(Me, "Delete data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                    LoadData()
                    EnableButton(False)
                    btnAdd_Edit.Focus()
                    GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                Else
                    MessageBox.Show(Me, "Delete data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                End If
            End If
        Else
            MessageBox.Show(Me, "Must select the row to delete!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        End If

    End Sub
    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Me.Close()
    End Sub
#End Region
#Region "Get/Save data"
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
            sqlcom.CommandText = "VS_ST_BSSMSAUDIT"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Staffname"
            cboStatus.DataSource = ds.Tables(0)
            _tbPersonInCharge = ds.Tables(0).Copy
            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Staffname"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Description"))
            cboStatus.PopupWidth = 150
            cboStatus.Columns("ID").Width = 20
            cboStatus.Columns("Staffname").Width = 100
            cboStatus.Columns("Description").Width = 60
            cboStatus.ShowDropDown = ShowDropDown.Never
            cboStatus.Buttons(0).Visible = False
            GridView1.Columns("InCharge").ColumnEdit = cboStatus
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Private Sub LoadStatus()
        Dim dtTmp As New DataTable()
        Try
            Dim dt As New DataTable
            dt.Columns.Add("ID")
            dt.Columns.Add("NAME")
            Dim r As DataRow = Nothing
            r = dt.NewRow
            r("ID") = 1
            r("NAME") = "Hoàn thành"
            dt.Rows.Add(r)
            r = dt.NewRow
            r("ID") = 2
            r("NAME") = "Chưa hoàn thành"
            dt.Rows.Add(r)
            r = dt.NewRow
            r("ID") = 3
            r("NAME") = "N/A"
            dt.Rows.Add(r)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "NAME"
            cboStatus.DataSource = dt

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("NAME"))
            cboStatus.PopupWidth = 100
            cboStatus.Columns("ID").Width = 15
            cboStatus.Columns("NAME").Width = 45
            GridView1.Columns("Status").ColumnEdit = cboStatus
        Catch ex As Exception

        End Try
    End Sub
    Public Sub LoadData()
        Dim dt As New DataTable
        dt = GetListHazards()
        GridControl1.DataSource = dt
        GridView1.OptionsSelection.MultiSelect = True
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        AllowEdit(False)
        For i As Integer = 0 To GridView1.Columns.Count - 1

            If i <> 1 And i <> 2 And i <> 7 Then
                GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
            Else
                GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
            End If
        Next

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
            sqlcom.Parameters.AddWithValue("ACTION", "LIST")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_BSSMSAUDIT"
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
                sqlcom.CommandText = "VS_ST_BSSMSAUDIT"
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
    Private Sub gridView1_CustomDrawRowIndicator(ByVal sender As Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs) Handles GridView1.CustomDrawRowIndicator
        If e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Header Then
            e.Appearance.DrawBackground(e.Cache, e.Bounds)
            e.Appearance.DrawString(e.Cache, " ", e.Bounds)

            e.Handled = True
        Else
            e.Info.DisplayText = (e.RowHandle + 1).ToString()
        End If

    End Sub
    Private Sub GridControl1_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles GridControl1.KeyDown

        If e.KeyCode = Keys.V And e.Modifiers = Keys.Control Then
            Dim iData As IDataObject = Clipboard.GetDataObject()
            ' Is Data Text?
            If iData.GetDataPresent(DataFormats.UnicodeText) Then
                RichTextBox1.Text = DirectCast(iData.GetData(DataFormats.UnicodeText), [String])
                Dim dt As DataTable = DirectCast(GridControl1.DataSource, DataTable)
                Dim dr As DataRow
                For Each s In RichTextBox1.Lines
                    Try
                        dr = dt.NewRow
                        dr("STT") = s.Split(vbTab)(0)
                        dr("AuditContent") = s.Split(vbTab)(1)
                        dt.Rows.Add(dr)
                    Catch ex As Exception
                        Clipboard.Clear()
                    End Try
                Next
                GridControl1.DataSource = dt
            Else
                RichTextBox1.Text = ""
            End If
            Clipboard.Clear()
        End If


    End Sub


    Private Sub PasteToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles PasteToolStripMenuItem.Click
        Dim iData As IDataObject = Clipboard.GetDataObject()
        ' Is Data Text?
        If iData.GetDataPresent(DataFormats.UnicodeText) Then
            RichTextBox1.Text = DirectCast(iData.GetData(DataFormats.UnicodeText), [String])
            Dim dt As DataTable = DirectCast(GridControl1.DataSource, DataTable)
            Dim dr As DataRow
            For Each s In RichTextBox1.Lines
                Try
                    dr = dt.NewRow
                    dr("STT") = s.Split(vbTab)(0)
                    dr("AuditContent") = s.Split(vbTab)(1)
                    dt.Rows.Add(dr)
                Catch ex As Exception
                    Clipboard.Clear()
                End Try
            Next
            GridControl1.DataSource = dt
        Else
            RichTextBox1.Text = ""
        End If
        Clipboard.Clear()
    End Sub

    Private Sub GridView1_MouseDown(ByVal sender As Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles GridView1.MouseDown
        Try
            If tt = "" Then
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
            If hi.Column.Name = "btnInCharge" Then

                Dim frm As New FrmFind(_tbPersonInCharge)
                Dim p As New Point(Cursor.Position.X - 140, Cursor.Position.Y + 14)
                frm.Location = p
                frm.ShowDialog()
                GridView1.Focus()
                GridView1.BeginSelection()
                If frm._id <> -1 Then
                    GridView1.SetFocusedRowCellValue("InCharge", frm._id.ToString())
                End If

            End If
        Catch ex As Exception

        End Try
    End Sub
    Private Sub GridView1_RowCellStyle(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs) Handles GridView1.RowCellStyle
        Try

            Dim View As GridView = TryCast(sender, GridView)
            If e.Column.FieldName = "Status" Then
                Try
                    e.Appearance.ForeColor = Color.Black
                    If GridView1.GetRowCellValue(e.RowHandle, "Status") = 1 Then
                        e.Appearance.BackColor = Color.LimeGreen
                    ElseIf GridView1.GetRowCellValue(e.RowHandle, "Status") = 2 Then
                        e.Appearance.BackColor = Color.Yellow
                        'ElseIf GridView1.GetRowCellValue(e.RowHandle, "Status") = 3 Then
                        '    e.Appearance.BackColor = Color.Red

                    End If

                Catch ex As Exception

                End Try
            End If
            If e.Column.FieldName = "STT" Then
                Try
                    If GridView1.GetRowCellValue(e.RowHandle, "IsBold") = "True" Then
                        e.Appearance.Font = New Font(e.Appearance.Font.FontFamily, e.Appearance.Font.Size, FontStyle.Bold)
                    Else
                        e.Appearance.Font = New Font(e.Appearance.Font.FontFamily, e.Appearance.Font.Size, FontStyle.Regular)
                    End If
                    Try
                        If GridView1.GetRowCellValue(e.RowHandle, "ColorName") <> "" Then
                            e.Appearance.ForeColor = System.Drawing.ColorTranslator.FromHtml("#" & GridView1.GetRowCellValue(e.RowHandle, "ColorName").ToString()) 'Color.FromName(GridView1.GetRowCellValue(e.RowHandle, "ColorName").ToString())
                            'Else
                            '    e.Appearance.ForeColor = Color.Black
                        End If
                    Catch ex As Exception
                        e.Appearance.ForeColor = Color.FromName(GridView1.GetRowCellValue(e.RowHandle, "ColorName").ToString())
                    End Try
                    
                Catch ex As Exception

                End Try
            End If
            If e.Column.FieldName = "AuditContent" Then
                Try
                    If GridView1.GetRowCellValue(e.RowHandle, "IsBold") = "True" Then
                        e.Appearance.Font = New Font(e.Appearance.Font.FontFamily, e.Appearance.Font.Size, FontStyle.Bold)
                    Else
                        e.Appearance.Font = New Font(e.Appearance.Font.FontFamily, e.Appearance.Font.Size, FontStyle.Regular)
                    End If
                    Try
                        If GridView1.GetRowCellValue(e.RowHandle, "ColorName") <> "" Then
                            e.Appearance.ForeColor = System.Drawing.ColorTranslator.FromHtml("#" & GridView1.GetRowCellValue(e.RowHandle, "ColorName").ToString()) 'Color.FromName(GridView1.GetRowCellValue(e.RowHandle, "ColorName").ToString())
                            'Else
                            '    e.Appearance.ForeColor = Color.Black
                        End If
                    Catch ex As Exception
                        e.Appearance.ForeColor = Color.FromName(GridView1.GetRowCellValue(e.RowHandle, "ColorName").ToString())
                    End Try


                Catch ex As Exception

                End Try
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub InĐậmToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles InĐậmToolStripMenuItem.Click
        Try
            GridView1.SetFocusedRowCellValue("IsBold", True)
        Catch ex As Exception

        End Try

    End Sub

    Private Sub BìnhThườngFontToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles BìnhThườngFontToolStripMenuItem.Click
        Try
            GridView1.SetFocusedRowCellValue("IsBold", False)
        Catch ex As Exception

        End Try
    End Sub

    Private Sub ColorToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ColorToolStripMenuItem.Click
        If ColorDialog1.ShowDialog = Windows.Forms.DialogResult.OK Then
            'MsgBox(ColorDialog1.Color.Name.ToString())
            Try
                GridView1.SetFocusedRowCellValue("ColorName", ColorDialog1.Color.Name.ToString())
            Catch ex As Exception

            End Try
        End If
    End Sub
End Class