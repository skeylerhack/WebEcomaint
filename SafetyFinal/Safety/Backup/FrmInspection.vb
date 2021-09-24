Imports DevExpress.XtraGrid.Views.Grid
Imports DevExpress.XtraEditors.Repository
Imports System.Data.SqlClient
Imports DevExpress.Utils
Imports DevExpress.XtraEditors
Imports DevExpress.XtraGrid.Views.Grid.ViewInfo
Imports DevExpress.XtraEditors.Controls

Public Class FrmInspection
    Dim tt As String = ""
    Dim tb As DataTable
    Private ckExist As Boolean = False
    Private _tbPersonInCharge As New DataTable()
    Public Sub New()
        InitializeComponent()
        'Dim img As Image = System.Drawing.Image.FromFile(Application.StartupPath + "/Images/1.png")
        'GridControl1.DataSource = CreateTable(3, img)
        'GridView1.Columns("IMG").ColumnEdit = New RepositoryItemPictureEdit()
    End Sub
    Private Sub XtraForm1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        LoadListLocation()
        LoadStatus()
        LoadListInCharge()
        GetListData()
        RepositoryItemPictureEdit1.ShowMenu = False
        RepositoryItemPictureEdit2.ShowMenu = False
        GridView1.RowHeight = 60
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        GridView1.Columns("InCharge1").Caption = " "
        tt = ""
    End Sub


    Private Sub GridView1_CellValueChanged(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs) Handles GridView1.CellValueChanged
        If GridView1.FocusedColumn.FieldName = "PathPicBeforeDefault" Then
            If Not GridView1.GetFocusedRowCellValue("PathPicBeforeDefault") Is Nothing Then
                DungChung.CopyFile(GridView1.GetFocusedRowCellValue("PathPicBeforeDefault"), DungChung.FolderShare)
            End If
        End If
        If GridView1.FocusedColumn.FieldName = "PathPicAfterDefault" Then
            If Not GridView1.GetFocusedRowCellValue("PathPicAfterDefault") Is Nothing Then
                DungChung.CopyFile(GridView1.GetFocusedRowCellValue("PathPicAfterDefault"), DungChung.FolderShare)
            End If
        End If
    End Sub

    Private Sub SimpleButton5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        CopyFileToFolderShare()
    End Sub
    Private Function CreateTable() As DataTable
        Dim tbl As New DataTable()
        tbl.Columns.Add("Value", GetType(Integer))
        tbl.Columns.Add("Description", GetType(String))
        tbl.Columns.Add("Image", GetType(Image))
        tbl.Rows.Add(New Object() {1, [String].Format("Description{0}", 1), System.Drawing.Image.FromFile(Application.StartupPath + "/Images/2.png")})
        Return tbl
    End Function

    Private Sub GetListData()
        Try
            tb = New DataTable
            GridView1.RowHeight = 60
            Dim tbl As New DataTable()
            tbl = GetListInspection().Copy
            tb = tbl.Clone
            tbl.Columns.Add("PicBeforeDefault_IMG", GetType(Image))
            tbl.Columns.Add("PicAfterDefault_IMG", GetType(Image))
            GridControl1.DataSource = tbl
            Try
                If Not System.IO.Directory.Exists(DungChung.FolderShare) Then
                    Exit Sub
                End If
                For i As Integer = 0 To GridView1.RowCount - 1

                    If Not IsDBNull(GridView1.GetRowCellValue(i, "PathPicBeforeDefault")) And Not GridView1.GetRowCellValue(i, "PathPicBeforeDefault") Is Nothing Then
                        If System.IO.File.Exists(GridView1.GetRowCellValue(i, "PathPicBeforeDefault") + "/" + GridView1.GetRowCellValue(i, "NamePicBeforeDefault")) Then

                            Dim img As Image = System.Drawing.Image.FromFile(GridView1.GetRowCellValue(i, "PathPicBeforeDefault") + "/" + GridView1.GetRowCellValue(i, "NamePicBeforeDefault"))
                            If img.Height > 60 Then
                                Dim tyle As Double = img.Width / 60
                                img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                            End If
                            GridView1.SetRowCellValue(i, "PicBeforeDefault_IMG", img)

                        End If

                    End If
                    If Not IsDBNull(GridView1.GetRowCellValue(i, "PathPicAfterDefault")) And Not GridView1.GetRowCellValue(i, "PathPicAfterDefault") Is Nothing Then
                        If System.IO.File.Exists(GridView1.GetRowCellValue(i, "PathPicAfterDefault") + "/" + GridView1.GetRowCellValue(i, "NamePicAfterDefault")) Then
                            Dim img As Image = System.Drawing.Image.FromFile(GridView1.GetRowCellValue(i, "PathPicAfterDefault") + "/" + GridView1.GetRowCellValue(i, "NamePicAfterDefault"))
                            If img.Height > 60 Then
                                Dim tyle As Double = img.Width / 60
                                img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                            End If
                            GridView1.SetRowCellValue(i, "PicAfterDefault_IMG", img)
                        End If
                    End If

                Next
            Catch ex As Exception

            End Try
            GridControl1.DataSource = tbl
            GridView1.OptionsSelection.MultiSelect = True
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            AllowEdit(False)
            For i As Integer = 0 To GridView1.Columns.Count - 1

                If i <> 3 And i <> 4 And i <> GridView1.Columns.Count - 1 Then
                    GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
                Else
                    GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub



    Private Sub RepositoryItemPictureEdit1_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If GridView1.FocusedRowHandle >= 0 Then
            Dim op As New OpenFileDialog
            'op.InitialDirectory = DungChung.FolderShare
            op.Filter = "All|*.*|jpg|*.jpg|png|*.png"
            If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                'While System.IO.Path.GetDirectoryName(op.FileName) <> DungChung.FolderShare

                '    MessageBox.Show("Please select image which is in the default folder", "Wrong folder", MessageBoxButtons.OK, MessageBoxIcon.Information)
                '    op.ShowDialog()
                'End While

                Dim img As Image = System.Drawing.Image.FromFile(op.FileName)
                If img.Height > 60 Then
                    Dim tyle As Double = img.Width / 60
                    img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                End If


                Try
                    If IsDBNull(GridView1.GetFocusedRowCellValue("NamePicBeforeDefault")) Then
                        GridView1.SetFocusedRowCellValue("PicBeforeDefault", -1)
                    Else
                        If System.IO.Path.GetFileName(op.FileName) <> GridView1.GetFocusedRowCellValue("NamePicAfterDefault") Then
                            GridView1.SetFocusedRowCellValue("PicBeforeDefault", -1)
                        End If
                    End If
                    GridView1.SetFocusedValue(img)
                    GridView1.SetFocusedRowCellValue("PathPicBeforeDefault", System.IO.Path.GetDirectoryName(op.FileName))
                    GridView1.SetFocusedRowCellValue("NamePicBeforeDefault", System.IO.Path.GetFileName(op.FileName))

                Catch ex As Exception

                End Try

            End If
        Else

            Dim op As New OpenFileDialog
            'op.InitialDirectory = DungChung.FolderShare
            op.Filter = "All|*.*|jpg|*.jpg|png|*.png"
            If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                'While System.IO.Path.GetDirectoryName(op.FileName) <> DungChung.FolderShare

                '    MessageBox.Show("Please select image which is in the default folder", "Wrong folder", MessageBoxButtons.OK, MessageBoxIcon.Information)
                '    op.ShowDialog()
                'End While
                Dim img As Image = System.Drawing.Image.FromFile(op.FileName)
                If img.Height > 60 Then
                    Dim tyle As Double = img.Width / 60
                    img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                End If
                GridView1.SetFocusedValue(img)

                If GridView1.FocusedValue Is Nothing Then
                    GridView1.AddNewRow()
                    Dim img1 As Image = System.Drawing.Image.FromFile(op.FileName).GetThumbnailImage(30, GridView1.RowHeight, Nothing, New IntPtr())
                    If img1.Height > 60 Then
                        Dim tyle As Double = img1.Width / 60
                        img1 = img1.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                    End If
                    GridView1.SetFocusedValue(img1)
                End If
                Try
                    If IsDBNull(GridView1.GetFocusedRowCellValue("NamePicBeforeDefault")) Then
                        GridView1.SetFocusedRowCellValue("PicBeforeDefault", -1)
                    Else
                        If System.IO.Path.GetFileName(op.FileName) <> GridView1.GetFocusedRowCellValue("NamePicAfterDefault") Then
                            GridView1.SetFocusedRowCellValue("PicBeforeDefault", -1)
                        End If
                    End If
                    GridView1.SetFocusedRowCellValue("PathPicBeforeDefault", System.IO.Path.GetDirectoryName(op.FileName))
                    GridView1.SetFocusedRowCellValue("NamePicBeforeDefault", System.IO.Path.GetFileName(op.FileName))

                Catch ex As Exception

                End Try

            End If
        End If
    End Sub

    Private Sub RepositoryItemPictureEdit2_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If GridView1.FocusedRowHandle >= 0 Then
            Dim op As New OpenFileDialog
            'op.InitialDirectory = DungChung.FolderShare
            op.Filter = "All|*.*|jpg|*.jpg|png|*.png"
            If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                'While System.IO.Path.GetDirectoryName(op.FileName) <> DungChung.FolderShare

                '    MessageBox.Show("Please select image which is in the default folder", "Wrong folder", MessageBoxButtons.OK, MessageBoxIcon.Information)
                '    op.ShowDialog()
                'End While
                Dim img As Image = System.Drawing.Image.FromFile(op.FileName)
                If img.Height > 60 Then
                    Dim tyle As Double = img.Width / 60
                    img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                End If
                Try
                    If IsDBNull(GridView1.GetFocusedRowCellValue("NamePicAfterDefault")) Then
                        GridView1.SetFocusedRowCellValue("PicAfterDefault", -1)
                    Else
                        If System.IO.Path.GetFileName(op.FileName) <> GridView1.GetFocusedRowCellValue("NamePicAfterDefault") Then
                            GridView1.SetFocusedRowCellValue("PicAfterDefault", -1)
                        End If
                    End If

                    GridView1.SetFocusedValue(img)
                    GridView1.SetFocusedRowCellValue("PathPicAfterDefault", System.IO.Path.GetDirectoryName(op.FileName))
                    GridView1.SetFocusedRowCellValue("NamePicAfterDefault", System.IO.Path.GetFileName(op.FileName))
                    GridView1.SetFocusedRowCellValue("ReportDate", Now.Date)

                Catch ex As Exception

                End Try

            End If
        Else

            Dim op As New OpenFileDialog
            'op.InitialDirectory = DungChung.FolderShare
            op.Filter = "All|*.*|jpg|*.jpg|png|*.png"

            If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                'While System.IO.Path.GetDirectoryName(op.FileName) <> DungChung.FolderShare

                '    MessageBox.Show("Please select image which is in the default folder", "Wrong folder", MessageBoxButtons.OK, MessageBoxIcon.Information)
                '    op.ShowDialog()

                'End While
                Dim img As Image = System.Drawing.Image.FromFile(op.FileName)
                If img.Height > 60 Then
                    Dim tyle As Double = img.Width / 60
                    img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                End If
                GridView1.SetFocusedValue(img)
                If GridView1.FocusedValue Is Nothing Then
                    GridView1.AddNewRow()
                    Dim img1 As Image = System.Drawing.Image.FromFile(op.FileName)
                    If img1.Height > 60 Then
                        Dim tyle As Double = img1.Width / 60
                        img1 = img1.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                    End If
                    GridView1.SetFocusedValue(img1)
                End If
                Try
                    If IsDBNull(GridView1.GetFocusedRowCellValue("NamePicAfterDefault")) Then
                        GridView1.SetFocusedRowCellValue("PicAfterDefault", -1)
                    Else
                        If System.IO.Path.GetFileName(op.FileName) <> GridView1.GetFocusedRowCellValue("NamePicAfterDefault") Then
                            GridView1.SetFocusedRowCellValue("PicAfterDefault", -1)
                        End If
                    End If
                    GridView1.SetFocusedRowCellValue("PathPicAfterDefault", System.IO.Path.GetDirectoryName(op.FileName))
                    GridView1.SetFocusedRowCellValue("NamePicAfterDefault", System.IO.Path.GetFileName(op.FileName))
                    GridView1.SetFocusedRowCellValue("ReportDate", Now.Date)

                Catch ex As Exception

                End Try
            End If

        End If
    End Sub
    Private Function CopyFileToFolderShare()
        Try
            Dim flag As Boolean = False
            For i As Integer = 0 To GridView1.RowCount - 1
                If Not IsDBNull(GridView1.GetRowCellValue(i, "PathPicBeforeDefault")) And Not GridView1.GetRowCellValue(i, "PathPicBeforeDefault") Is Nothing Then
                    If Not DungChung.CopyFile(GridView1.GetRowCellValue(i, "PathPicBeforeDefault") + "/" + GridView1.GetRowCellValue(i, "NamePicBeforeDefault"), DungChung.FolderShare) Then
                        'MessageBox.Show(Me, "Copy image to folder share failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                        flag = False
                    Else
                        flag = True
                    End If
                End If
                If Not IsDBNull(GridView1.GetRowCellValue(i, "PathPicAfterDefault")) And Not GridView1.GetRowCellValue(i, "PathPicAfterDefault") Is Nothing Then
                    If Not DungChung.CopyFile(GridView1.GetRowCellValue(i, "PathPicAfterDefault") + "/" + GridView1.GetRowCellValue(i, "NamePicAfterDefault"), DungChung.FolderShare) Then
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
#Region "Add/Edit"
    Private Sub AllowEdit(ByVal TT As Boolean)
        For i As Integer = 0 To GridView1.Columns.Count - 1
            GridView1.Columns(i).OptionsColumn.AllowEdit = TT
        Next
        GridView1.Columns("PicBeforeDefault_IMG").OptionsColumn.AllowEdit = True
        GridView1.Columns("PicAfterDefault_IMG").OptionsColumn.AllowEdit = True
    End Sub
#End Region
#Region "Get/Save data"
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
            r("NAME") = "Quá hạn"
            dt.Rows.Add(r)
            r = dt.NewRow
            r("ID") = 4
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
            cboStatus.PopupWidth = 30
            cboStatus.Columns("ID").Width = 5
            cboStatus.Columns("NAME").Width = 25
            GridView1.Columns("Status").ColumnEdit = cboStatus
        Catch ex As Exception

        End Try
    End Sub
    Public Sub LoadData()
        Dim dt As New DataTable
        dt = GetListInspection()
        GridControl1.DataSource = dt
        GridView1.OptionsSelection.MultiSelect = True
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        AllowEdit(False)
    End Sub
    Public Function GetListInspection() As DataTable
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
            sqlcom.CommandText = "VS_ST_INSPECTION"
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
            sqlcom.CommandText = "VS_ST_INSPECTION"
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
                sqlcom.Parameters.AddWithValue("@FolderShare", DungChung.FolderShare)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_INSPECTION"
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
        GetListData()
        EnableButton(False)
        btnAdd_Edit.Focus()
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        tt = ""
    End Sub
    Private Sub btnAdd_Edit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd_Edit.Click
        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        AllowEdit(True)
        EnableButton(True)
        btnSave.Focus()
        tt = "Edit"
    End Sub
    Private Function fnValid()
        Try
            For i As Integer = 0 To GridView1.RowCount - 2
                If IsDBNull(GridView1.GetRowCellValue(i, "DocNum")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAINHAPSOTHUTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input No. at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)

                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "DocNum") = -1 Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAINHAPSOTHUTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input No. at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "LocationID")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAICHONVITRI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Location at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "LocationID") = -1 Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAICHONVITRI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Location at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "InCharge")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAICHONNGUOITHUCHIEN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose InCharge at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "InCharge") = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAICHONNGUOITHUCHIEN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose InCharge at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "Deadline")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAINHAPHANTHUCHIEN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input DeadLine at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "Deadline") = Nothing Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAINHAPHANTHUCHIEN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must input DeadLine at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    Return False
                End If
                If IsDBNull(GridView1.GetRowCellValue(i, "Status")) Then

                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAICHONTRANGTHAI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Status at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    GridView1.ClearSelection()
                    GridView1.FocusedRowHandle = i
                    GridView1.SelectRow(i)
                    GridView1.ClearSelection()
                    Return False
                ElseIf GridView1.GetRowCellValue(i, "Status") = -1 Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "PHAICHONTRANGTHAI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Must choose Status at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
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
        If GridView1.DataRowCount > 0 Then
            If Not fnValid() Then
                Exit Sub
            End If
            Dim dt As DataTable = CType(GridControl1.DataSource, DataTable)
            Try
                dt.Columns.Remove("PicBeforeDefault_IMG")
                dt.Columns.Remove("PicAfterDefault_IMG")
                'dt.Columns.Remove("InspectionID")
            Catch ex As Exception

            End Try


            If Excute("SAVE", dt) Then
                If DungChung.ExistsFolderShare = True Then
                    CopyFileToFolderShare()
                End If
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "LUUDLTC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                'MessageBox.Show(Me, "Save data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                GetListData()
                EnableButton(False)
                btnAdd_Edit.Focus()
                GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                tt = ""
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "LUUDLLOI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                'MessageBox.Show(Me, "Save data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        End If

    End Sub
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "XACNHANXOADONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            'If MessageBox.Show("Are you sure you want to delete the row selected?", "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
            Dim dt As DataTable = GetSelectedRows(GridView1)
            If dt.Rows.Count > 0 Then
                If Excute("DELETE", dt) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "XOATHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                    'MessageBox.Show(Me, "Delete data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                    GetListData()
                    EnableButton(False)
                    btnAdd_Edit.Focus()
                    GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                Else
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "XOAKHONGTHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Delete data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                End If
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "CHUACHONDONGCANXOA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmInspection", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Must select the row to delete!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            End If
        End If

    End Sub
    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Me.Close()
    End Sub
#End Region
#Region "MultiSelect"
    Private Function GetSelectedRows(ByVal view As GridView) As DataTable
        Dim ret As String = ""
        Dim rowIndex As Integer = -1
        Dim r As DataRow = Nothing
        'Try
        '    tb.Columns.Remove("InspectionID")
        'Catch ex As Exception

        'End Try

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

    Private Sub RepositoryItemPictureEdit2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RepositoryItemPictureEdit2.DoubleClick

        Try
            If Not DungChung.ChooseData Is Nothing Then
                DungChung.ChooseData.Clear()
            End If
            Dim id As Integer = -1
            If GridView1.FocusedRowHandle >= 0 Then
                If IsDBNull(GridView1.GetFocusedRowCellValue("ID")) Then
                    If IsDBNull(GridView1.GetFocusedRowCellValue("InspectionID")) Then
                        id = (-1) * Now.Hour * Now.Minute * Now.Second * Now.Millisecond
                    Else
                        id = GridView1.GetFocusedRowCellValue("InspectionID")
                    End If
                Else
                    id = GridView1.GetFocusedRowCellValue("ID")
                End If

            Else
                If IsDBNull(GridView1.GetFocusedRowCellValue("InspectionID")) = False Then
                    id = GridView1.GetFocusedRowCellValue("InspectionID")
                    If id = 0 Then
                        Dim rd As New Random
                        id = (-1) * rd.Next(1000, 9999)
                    End If
                Else
                    Dim rd As New Random

                    id = (-1) * (Now.Hour + Now.Minute + Now.Millisecond + rd.Next(100, 999))
                End If
            End If
            Dim frm As New FrmListImg(id)
            frm.ShowDialog()
        Catch ex As Exception

        End Try

        If Not DungChung.ChooseData Is Nothing Then
            If DungChung.ChooseData.Rows.Count = 0 Then
                Exit Sub
            End If
            If GridView1.FocusedRowHandle >= 0 Then
                Dim img As Image = System.Drawing.Image.FromFile(DungChung.ChooseData.Rows(0)("PicPath") + "/" + DungChung.ChooseData.Rows(0)("PicName"))
                If img.Height > 60 Then
                    Dim tyle As Double = img.Width / img.Height
                    img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                End If
                Try
                    GridView1.SetFocusedValue(img)
                    GridView1.SetFocusedRowCellValue("PathPicAfterDefault", DungChung.ChooseData.Rows(0)("PicPath"))
                    GridView1.SetFocusedRowCellValue("NamePicAfterDefault", DungChung.ChooseData.Rows(0)("PicName"))
                    GridView1.SetFocusedRowCellValue("PicAfterDefault", DungChung.ChooseData.Rows(0)("ID"))
                    GridView1.SetFocusedRowCellValue("InspectionID", DungChung.ChooseData.Rows(0)("InspectionID"))
                    If GridView1.GetFocusedRowCellValue("ReportDate").ToString() = "" Then
                        GridView1.SetFocusedRowCellValue("ReportDate", Now.Date)
                    End If
                Catch ex As Exception

                End Try
            Else
                Dim img As Image = System.Drawing.Image.FromFile(DungChung.ChooseData.Rows(0)("PicPath") + "/" + DungChung.ChooseData.Rows(0)("PicName"))
                If img.Height > 60 Then
                    Dim tyle As Double = img.Width / 60
                    img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                End If
                GridView1.SetFocusedValue(img)
                If GridView1.FocusedValue Is Nothing Then
                    GridView1.AddNewRow()
                    Dim img1 As Image = System.Drawing.Image.FromFile(DungChung.ChooseData.Rows(0)("PicPath") + "/" + DungChung.ChooseData.Rows(0)("PicName"))
                    If img1.Height > 60 Then
                        Dim tyle As Double = img1.Width / 60
                        img1 = img1.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                    End If
                    GridView1.SetFocusedValue(img1)
                End If
                Try

                    GridView1.SetFocusedRowCellValue("PicAfterDefault", DungChung.ChooseData.Rows(0)("ID"))
                    GridView1.SetFocusedRowCellValue("PathPicAfterDefault", DungChung.ChooseData.Rows(0)("PicPath"))
                    GridView1.SetFocusedRowCellValue("NamePicAfterDefault", DungChung.ChooseData.Rows(0)("PicName"))
                    GridView1.SetFocusedRowCellValue("InspectionID", DungChung.ChooseData.Rows(0)("InspectionID"))
                    If GridView1.GetFocusedRowCellValue("ReportDate").ToString() = "" Then
                        GridView1.SetFocusedRowCellValue("ReportDate", Now.Date)
                    End If

                Catch ex As Exception

                End Try
            End If
        End If
    End Sub

    Private Sub RepositoryItemPictureEdit1_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles RepositoryItemPictureEdit1.Click
        Try
            If tt = "" Then
                Dim path As String = GridView1.GetFocusedRowCellValue("PathPicBeforeDefault") & "/" & GridView1.GetFocusedRowCellValue("NamePicBeforeDefault")
                Dim frm As New FrmShowImg(Bitmap.FromFile(path))
                frm.ShowDialog()
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub RepositoryItemPictureEdit2_Click1(ByVal sender As Object, ByVal e As System.EventArgs) Handles RepositoryItemPictureEdit2.Click
        Try
            If tt = "" Then
                Dim path As String = GridView1.GetFocusedRowCellValue("PathPicAfterDefault") & "/" & GridView1.GetFocusedRowCellValue("NamePicAfterDefault")
                Dim frm As New FrmShowImg(Bitmap.FromFile(path))
                frm.ShowDialog()
            End If
        Catch ex As Exception

        End Try
    End Sub


    Private Sub RepositoryItemPictureEdit1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles RepositoryItemPictureEdit1.DoubleClick
        Try
            If Not DungChung.ChooseData Is Nothing Then
                DungChung.ChooseData.Clear()
            End If
            Dim id As Integer = -1
            If GridView1.FocusedRowHandle >= 0 Then
                If IsDBNull(GridView1.GetFocusedRowCellValue("ID")) Then
                    If IsDBNull(GridView1.GetFocusedRowCellValue("InspectionID")) Then
                        id = (-1) * Now.Hour * Now.Minute * Now.Second * Now.Millisecond
                    Else
                        id = GridView1.GetFocusedRowCellValue("InspectionID")
                    End If
                Else
                    id = GridView1.GetFocusedRowCellValue("ID")
                End If

            Else
                If IsDBNull(GridView1.GetFocusedRowCellValue("InspectionID")) = False Then
                    id = GridView1.GetFocusedRowCellValue("InspectionID")
                    If id = 0 Then
                        Dim rd As New Random
                        id = (-1) * rd.Next(1000, 9999)
                    End If
                Else
                    Dim rd As New Random

                    id = (-1) * (Now.Hour + Now.Minute + Now.Millisecond + rd.Next(100, 999))
                End If

            End If
            Dim frm As New FrmListImg(id)
            frm.ShowDialog()
        Catch ex As Exception

        End Try

        If Not DungChung.ChooseData Is Nothing Then
            If DungChung.ChooseData.Rows.Count = 0 Then
                Exit Sub
            End If
            If GridView1.FocusedRowHandle >= 0 Then
                Dim img As Image = System.Drawing.Image.FromFile(DungChung.ChooseData.Rows(0)("PicPath") + "/" + DungChung.ChooseData.Rows(0)("PicName"))
                If img.Height > 60 Then
                    Dim tyle As Double = img.Width / 60
                    img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                End If
                Try
                    GridView1.SetFocusedValue(img)
                    GridView1.SetFocusedRowCellValue("PathPicBeforeDefault", DungChung.ChooseData.Rows(0)("PicPath"))
                    GridView1.SetFocusedRowCellValue("NamePicBeforeDefault", DungChung.ChooseData.Rows(0)("PicName"))
                    GridView1.SetFocusedRowCellValue("PicBeforeDefault", DungChung.ChooseData.Rows(0)("ID"))
                    GridView1.SetFocusedRowCellValue("InspectionID", DungChung.ChooseData.Rows(0)("InspectionID"))
                Catch ex As Exception

                End Try
            Else
                Dim img As Image = System.Drawing.Image.FromFile(DungChung.ChooseData.Rows(0)("PicPath") + "/" + DungChung.ChooseData.Rows(0)("PicName"))
                If img.Height > 60 Then
                    Dim tyle As Double = img.Width / 60
                    img = img.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                End If
                GridView1.SetFocusedValue(img)
                If GridView1.FocusedValue Is Nothing Then
                    GridView1.AddNewRow()
                    Dim img1 As Image = System.Drawing.Image.FromFile(DungChung.ChooseData.Rows(0)("PicPath") + "/" + DungChung.ChooseData.Rows(0)("PicName"))
                    If img1.Height > 60 Then
                        Dim tyle As Double = img1.Width / 60
                        img1 = img1.GetThumbnailImage(GridView1.Columns("PicBeforeDefault_IMG").Width + 64, 60, Nothing, New IntPtr())
                    End If
                    GridView1.SetFocusedValue(img1)
                End If
                Try

                    GridView1.SetFocusedRowCellValue("PicBeforeDefault", DungChung.ChooseData.Rows(0)("ID"))
                    GridView1.SetFocusedRowCellValue("PathPicBeforeDefault", DungChung.ChooseData.Rows(0)("PicPath"))
                    GridView1.SetFocusedRowCellValue("NamePicBeforeDefault", DungChung.ChooseData.Rows(0)("PicName"))
                    GridView1.SetFocusedRowCellValue("InspectionID", DungChung.ChooseData.Rows(0)("InspectionID"))
                Catch ex As Exception

                End Try
            End If
        End If
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
            sqlcom.CommandText = "VS_ST_INSPECTION"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Staff name"
            cboStatus.DataSource = ds.Tables(0)
            _tbPersonInCharge = ds.Tables(0).Copy
            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Staff name"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Description"))
            cboStatus.PopupWidth = 150
            cboStatus.Columns("ID").Width = 20
            cboStatus.Columns("Staff name").Width = 100
            cboStatus.Columns("Description").Width = 60
            cboStatus.ShowDropDown = ShowDropDown.Never
            cboStatus.Buttons(0).Visible = False
            GridView1.Columns("InCharge").ColumnEdit = cboStatus

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Private Sub ShowImageToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ShowImageToolStripMenuItem.Click
        If GridView1.FocusedColumn.AbsoluteIndex = 9 Then
            Try
                Dim img As Image = GridView1.GetFocusedRowCellValue("PicBeforeDefault_IMG")
                Dim frm As New FrmShowImg(img)
                frm.ShowDialog()
                GridControl1.ContextMenuStrip = Nothing
            Catch ex As Exception

            End Try
        ElseIf GridView1.FocusedColumn.AbsoluteIndex = 10 Then
            Try
                Dim img As Image = GridView1.GetFocusedRowCellValue("PicAfterDefault_IMG")
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
            If GridView1.FocusedColumn.AbsoluteIndex = 9 Or GridView1.FocusedColumn.AbsoluteIndex = 10 Then
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
            If GridView1.FocusedColumn.AbsoluteIndex = 9 Or GridView1.FocusedColumn.AbsoluteIndex = 10 Then
                GridControl1.ContextMenuStrip = ContextMenuStrip1
            Else
                GridControl1.ContextMenuStrip = Nothing
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
                    ElseIf GridView1.GetRowCellValue(e.RowHandle, "Status") = 3 Then
                        e.Appearance.BackColor = Color.Red
                       
                    End If

                Catch ex As Exception

                End Try
            End If
        Catch ex As Exception

        End Try

    End Sub
End Class