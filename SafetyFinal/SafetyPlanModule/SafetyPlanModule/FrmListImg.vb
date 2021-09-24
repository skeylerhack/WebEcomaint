Imports System.Data.SqlClient
Imports DevExpress.XtraGrid.Views.Grid

Public Class FrmListImg
    Private _InsID As Integer = Nothing
    Private _tb As DataTable
    Private _path As String = ""
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal InspectionID As Integer)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _InsID = InspectionID
        'If _InsID = -1 Then
        '    Call Excute("DELETE_NULL")
        'End If
        Call GetListData()
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
            sqlcom.Parameters.AddWithValue("InspectionID", _InsID)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_INSPECTION1"
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

    Private Sub GetListData()
        Try
           
            _tb = New DataTable
            GridView1.RowHeight = 80
            Dim tbl As New DataTable()
            tbl = GetListInspection().Copy
            _tb = tbl.Clone
            tbl.Columns.Add("IMG", GetType(Image))

            GridControl1.DataSource = tbl
            Try
                For i As Integer = 0 To GridView1.RowCount - 1
                    If Not IsDBNull(GridView1.GetRowCellValue(i, "PicPath")) And Not GridView1.GetRowCellValue(i, "PicPath") Is Nothing Then
                        If System.IO.File.Exists(GridView1.GetRowCellValue(i, "PicPath") + "/" + GridView1.GetRowCellValue(i, "PicName")) Then
                            Dim img As Image = System.Drawing.Image.FromFile(GridView1.GetRowCellValue(i, "PicPath") + "/" + GridView1.GetRowCellValue(i, "PicName"))
                            'If img.Height > 20 Then
                            '    Dim tyle As Double = img.Width / img.Height
                            '    img = img.GetThumbnailImage(GridView1.RowHeight * tyle, GridView1.RowHeight, Nothing, New IntPtr())
                            'End If
                            GridView1.SetRowCellValue(i, "IMG", img)
                        End If
                        
                    End If

                Next
            Catch ex As Exception

            End Try
            GridControl1.DataSource = tbl
            GridView1.OptionsSelection.MultiSelect = False

        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnNew_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        Dim dt As DataTable = GetSelectedRows(GridView1)
        If dt.Rows.Count > 0 Then
            If IsDBNull(GridView1.GetFocusedRowCellValue("ID")) Then
                GridView1.DeleteSelectedRows()
            Else
                If MessageBox.Show("Are you sure you want to delete the row selected?", "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
                    If Excute("DELETE", dt) Then
                        'MessageBox.Show(Me, "Delete data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                        GetListData()
                        GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                    Else
                        MessageBox.Show(Me, "Delete data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                    End If
                End If
            End If
        Else
            MessageBox.Show(Me, "Must select the row to delete!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        End If
    End Sub
    Public Function Excute(ByVal Action As String, Optional ByVal tb As DataTable = Nothing) As [Boolean]
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
                sqlcom.Parameters.AddWithValue("@InspectionID", _InsID)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_INSPECTION1"
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

    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If GridView1.DataRowCount > 0 Then
            Dim dt As DataTable = CType(GridControl1.DataSource, DataTable)
            Try
                dt.Columns.Remove("IMG")
            Catch ex As Exception

            End Try
            If Excute("SAVE", dt) Then
                CopyFileToFolderShare()
                'MessageBox.Show(Me, "Save data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
            Else
                MessageBox.Show(Me, "Save data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
            GetListData()
        End If
    End Sub
    Private Function CopyFileToFolderShare()
        Try
            Dim flag As Boolean = False
            For i As Integer = 0 To GridView1.RowCount - 1
                If Not IsDBNull(GridView1.GetRowCellValue(i, "PicPath")) And Not GridView1.GetRowCellValue(i, "PicPath") Is Nothing Then
                    If Not DungChung.CopyFile(GridView1.GetRowCellValue(i, "PicPath") + "/" + GridView1.GetRowCellValue(i, "PicName"), DungChung.FolderShare) Then
                        'MessageBox.Show(Me, "Copy image to folder share failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                        flag = False
                    Else
                        flag = True
                    End If
                End If
            Next
            If flag = False Then
                Return False
            Else
                Return True
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function

    Private Sub btnNew_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnNew.Click
        Try

            Dim op As New OpenFileDialog
            'op.InitialDirectory = DungChung.FolderShare
            op.Filter = "(Image Files)|*.jpg;*.png;*.bmp;*.gif;*.ico|Jpg, | *.jpg|Png, | *.png|Bmp, | *.bmp|Gif, | *.gif|Ico | *.ico"
            If _path <> "" Then
                op.InitialDirectory = _path
            End If
            If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                _path = System.IO.Path.GetDirectoryName(op.FileName)
                Dim dt As DataTable = CType(GridControl1.DataSource, DataTable)
                Dim r As DataRow = dt.NewRow
                r("InspectionID") = _InsID
                r("PicPath") = System.IO.Path.GetDirectoryName(op.FileName)
                r("PicName") = System.IO.Path.GetFileName(op.FileName)
                r("IMG") = System.Drawing.Image.FromFile(op.FileName)
                r("Before") = False
                dt.Rows.Add(r)
                GridControl1.DataSource = dt
                Try
                    For i As Integer = 0 To GridView1.RowCount - 1
                        If Not IsDBNull(GridView1.GetRowCellValue(i, "PicPath")) And Not GridView1.GetRowCellValue(i, "PicPath") Is Nothing Then
                            Dim img As Image = System.Drawing.Image.FromFile(GridView1.GetRowCellValue(i, "PicPath") + "/" + GridView1.GetRowCellValue(i, "PicName"))
                            If img.Height > 20 Then
                                Dim tyle As Double = img.Width / img.Height
                                img = img.GetThumbnailImage(GridView1.RowHeight * tyle, GridView1.RowHeight, Nothing, New IntPtr())
                            End If
                            GridView1.SetRowCellValue(i, "IMG", img)
                        End If

                    Next
                Catch ex As Exception

                End Try
                GridView1.OptionsSelection.MultiSelect = False
            End If

            Try
                If GridView1.DataRowCount > 0 Then
                    Dim dt As DataTable = CType(GridControl1.DataSource, DataTable)
                    Try
                        dt.Columns.Remove("IMG")
                    Catch ex As Exception

                    End Try
                    If Excute("SAVE", dt) Then
                        CopyFileToFolderShare()
                        'MessageBox.Show(Me, "Save data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                    Else
                        MessageBox.Show(Me, "Save data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
                    End If
                    GetListData()
                End If
            Catch ex As Exception

            End Try
        Catch ex As Exception

        End Try
       
    End Sub
    Private Function GetSelectedRows(ByVal view As GridView) As DataTable
        Dim ret As String = ""
        Dim rowIndex As Integer = -1
        Dim r As DataRow = Nothing
        For Each i As Integer In GridView1.GetSelectedRows()
            Dim row As DataRow = GridView1.GetDataRow(i)
            If ret <> "" Then
                ret &= Constants.vbCrLf
            End If
            r = _tb.NewRow
            r("ID") = row("ID")
            _tb.Rows.Add(r)
        Next i
        Return _tb
    End Function

    Private Sub btnChoose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChoose.Click
        Try
            If IsDBNull(GridView1.GetFocusedDataRow("ID")) = True Then
                MessageBox.Show(Me, "Must save data before choose data!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Else
                fnGetChooseRow()
                Me.Close()
            End If
        Catch ex As Exception

        End Try
    End Sub
    Private Sub fnGetChooseRow()
        Dim r As DataRow = _tb.NewRow
        r("ID") = GridView1.GetFocusedDataRow("ID")
        r("InspectionID") = GridView1.GetFocusedDataRow("InspectionID")
        r("PicName") = GridView1.GetFocusedDataRow("PicName")
        r("PicPath") = GridView1.GetFocusedDataRow("PicPath")
        r("Before") = GridView1.GetFocusedDataRow("Before")
        _tb.Rows.Add(r)
        DungChung.ChooseData = _tb.Copy
        _path = ""
    End Sub

    Private Sub GridView1_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GridView1.DoubleClick
        If IsDBNull(GridView1.GetFocusedDataRow("ID")) = True Then
            MessageBox.Show(Me, "Must save data before choose data!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        Else
            fnGetChooseRow()
            Me.Close()
        End If
    End Sub

    Private Sub FrmListImg_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
    End Sub

    Private Sub GridControl1_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GridControl1.DoubleClick
        If IsDBNull(GridView1.GetFocusedDataRow("ID")) = True Then
            MessageBox.Show(Me, "Must save data before choose data!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        Else
            fnGetChooseRow()
            Me.Close()
        End If
    End Sub
End Class