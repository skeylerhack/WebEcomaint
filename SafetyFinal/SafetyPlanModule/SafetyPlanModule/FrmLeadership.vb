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
Imports Microsoft.ApplicationBlocks.Data
Imports DevExpress.XtraEditors.Repository

Public Class FrmLeadership
    Private iID As Integer = -1
    Private _action As String = ""
    Private dtNNgu As DataTable
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal DocNum As String)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
    End Sub
    Private Sub FrmLeadership_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        GetData()
        EnableButton(False)
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        LoadNN()
    End Sub
#Region "Get data"
    Private Sub GetData()
        Dim dt As New DataTable()
        Dim sqlcom As New SqlCommand()
        Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
        If con.State = ConnectionState.Closed Then
            con.Open()
        End If
        sqlcom.Connection = con
        sqlcom.Parameters.AddWithValue("ACTION", "GET_DATA")
        sqlcom.CommandType = CommandType.StoredProcedure
        sqlcom.CommandText = "VS_LEADERSHIP"
        Dim da As New SqlDataAdapter(sqlcom)
        Dim ds As New DataSet()
        da.Fill(ds)
        dt = ds.Tables(0).Copy()
        If GridControl1.DataSource Is Nothing Then
            GridControl1.DataSource = dt
            GridView1.PopulateColumns()
            GridView1.OptionsSelection.MultiSelect = False
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            GridView1.Columns("ID").Visible = False

            For i As Integer = 0 To GridView1.Columns.Count - 1
                GridView1.Columns(i).OptionsColumn.AllowEdit = False
            Next

            GridView1.RowHeight = 20
            GridView1.OptionsView.ColumnAutoWidth = True
            GridView1.Columns("Active").Width = 50
            GridView1.Columns("Active").OptionsColumn.FixedWidth = True

            Dim memo As New RepositoryItemMemoEdit()
            GridView1.Columns("Content").ColumnEdit = memo
        Else
            GridControl1.DataSource = dt
        End If


        'GridView1.Columns(1).Width = 182
    End Sub

    Private Sub GridView1_FocusedRowChanged(sender As Object, e As FocusedRowChangedEventArgs) Handles GridView1.FocusedRowChanged

        Try
            'Nếu trong tình trạng sửa, khi dòng được chọn thay đổi thì cập nhập nội dung được sửa cho dòng cũ
            If iID <> Nothing AndAlso _action = "UPDATE" Then
                Dim i As Integer
                Dim dt As New DataTable()
                dt = TryCast(GridControl1.DataSource, DataTable)

                For i = 0 To dt.Rows.Count - 1 Step 1
                    If dt.Rows(i)("ID") = iID Then
                        dt.Rows(i)("Content") = txtContent.Text
                        dt.AcceptChanges()
                    End If
                Next
            End If

            'Add nội dung dòng mới cho txtContent
            iID = GridView1.GetRowCellValue(e.FocusedRowHandle, GridView1.Columns("ID"))
            txtContent.Text = GridView1.GetRowCellValue(e.FocusedRowHandle, GridView1.Columns("Content"))
        Catch ex As Exception
            XtraMessageBox.Show(ex.Message)
        End Try

    End Sub

    Private Sub btnAdd_Edit_Click(sender As Object, e As EventArgs) Handles btnAdd_Edit.Click
        EnableButton(True)
        _action = "ADD"
        iID = -1
        txtContent.Text = ""
        txtContent.Select()
    End Sub

    Private Sub EnableButton(ByVal tt As Boolean)
        btnSave.Visible = tt
        btnCancel.Visible = tt
        btnAdd_Edit.Visible = Not tt
        btnEdit.Visible = Not tt
        btnDelete.Visible = Not tt
        btnExit.Visible = Not tt
        txtContent.ReadOnly = Not tt
        GridView1.OptionsSelection.UseIndicatorForSelection = False

        'Khi Edit mở ra
        GridView1.Columns("Active").OptionsColumn.AllowEdit = tt
    End Sub

    Private Sub btnEdit_Click(sender As Object, e As EventArgs) Handles btnEdit.Click
        EnableButton(True)
        _action = "UPDATE"
        iID = GridView1.GetRowCellValue(GridView1.FocusedRowHandle, GridView1.Columns("ID"))
        txtContent.Select()
        txtContent.Text = GridView1.GetRowCellValue(GridView1.FocusedRowHandle, GridView1.Columns("Content"))
    End Sub


    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        If iID < 1 Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmLeadership", "CHUACHONLEADERSHIP", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmLeadership", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If

        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmLeadership", "BANCOCHACXOA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmLeadership", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OKCancel, MessageBoxIcon.Warning) = DialogResult.Cancel Then Return

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
                sqlcom.Parameters.AddWithValue("ID", iID)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_LEADERSHIP"
                sqlcom.ExecuteNonQuery()

                transaction.Commit()

                EnableButton(False)

                GetData()

                _action = ""

            Catch ex As Exception
                XtraMessageBox.Show(ex.Message)
                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
            Finally
                con.Close()
            End Try
        End Using

    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        If _action = "ADD" Then
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
                    sqlcom.Parameters.AddWithValue("ACTION", _action)
                    sqlcom.Parameters.AddWithValue("ID", iID)
                    sqlcom.Parameters.AddWithValue("Content", txtContent.Text)
                    sqlcom.Parameters.AddWithValue("USER_NAME", Commons.Modules.UserName)

                    sqlcom.CommandType = CommandType.StoredProcedure
                    sqlcom.CommandText = "VS_LEADERSHIP"
                    sqlcom.ExecuteNonQuery()

                    transaction.Commit()

                    EnableButton(False)

                    GetData()
                Catch ex As Exception
                    XtraMessageBox.Show(ex.Message)
                    If transaction IsNot Nothing Then
                        transaction.Rollback()
                    End If
                Finally
                    con.Close()
                End Try
            End Using
        End If

        If _action = "UPDATE" Then

            'Cập nhập cho dòng hiện tại trước khi lưu
            If iID <> Nothing AndAlso _action = "UPDATE" Then
                Dim i As Integer
                Dim dt As New DataTable()
                dt = TryCast(GridControl1.DataSource, DataTable)

                For i = 0 To dt.Rows.Count - 1 Step 1
                    If dt.Rows(i)("ID") = iID Then
                        dt.Rows(i)("Content") = txtContent.Text
                        dt.AcceptChanges()
                    End If
                Next
            End If

            Dim transaction As SqlTransaction = Nothing
            Using con As New SqlConnection(Commons.IConnections.ConnectionString())
                Dim sqlcom As SqlCommand = con.CreateCommand()
                Try
                    If con.State = ConnectionState.Closed Then
                        con.Open()
                    End If


                    Dim sBT As String = "sBT_LeaderShip" + Commons.Modules.UserName
                    Dim dt As New DataTable()
                    dt = TryCast(GridControl1.DataSource, DataTable)
                    Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, sBT, dt, "")

                    transaction = con.BeginTransaction("Transaction")
                    sqlcom.Connection = con
                    sqlcom.Transaction = transaction
                    sqlcom.Parameters.AddWithValue("ACTION", _action)
                    sqlcom.Parameters.AddWithValue("@sBT", sBT)
                    sqlcom.Parameters.AddWithValue("USER_NAME", Commons.Modules.UserName)

                    sqlcom.CommandType = CommandType.StoredProcedure
                    sqlcom.CommandText = "VS_LEADERSHIP"
                    sqlcom.ExecuteNonQuery()

                    transaction.Commit()

                    EnableButton(False)

                    GetData()
                Catch ex As Exception
                    XtraMessageBox.Show(ex.Message)
                    If transaction IsNot Nothing Then
                        transaction.Rollback()
                    End If
                Finally
                    con.Close()
                End Try
            End Using
        End If
    End Sub

    Private Sub btnCancel_Click(sender As Object, e As EventArgs) Handles btnCancel.Click
        GetData()
        EnableButton(False)
    End Sub

    Private Sub btnExit_Click(sender As Object, e As EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    'NGON NGU
    Private Sub LoadNN()
        LoadDataNN()
        Me.Text = GetNN(dtNNgu, Me.Name)
        GridView1.Columns("Content").Caption = GetNN(dtNNgu, "Content")
        lblContent.Text = GetNN(dtNNgu, lblContent.Name)
        btnAdd_Edit.Text = GetNN(dtNNgu, btnAdd_Edit.Name)
        btnEdit.Text = GetNN(dtNNgu, btnEdit.Name)
        btnCancel.Text = GetNN(dtNNgu, btnCancel.Name)
        btnDelete.Text = GetNN(dtNNgu, btnDelete.Name)
        btnExit.Text = GetNN(dtNNgu, btnExit.Name)
        btnSave.Text = GetNN(dtNNgu, btnSave.Name)
    End Sub

    Private Sub LoadDataNN()
        dtNNgu = New DataTable
        dtNNgu.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT KEYWORD , CASE " & Commons.Modules.TypeLanguage &
                " WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END AS NN , CONVERT(INT," & Commons.Modules.TypeLanguage.ToString & ") AS NNGU " &
                " FROM LANGUAGES WHERE FORM = N'" & Me.Name & "' "))

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
            SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, (" INSERT INTO [LANGUAGES]([MS_MODULE],[FORM],[KEYWORD],[VIETNAM],[ENGLISH],[CHINESE]," &
                    " [FORM_HAY_REPORT],[VIETNAM_OR],[ENGLISH_OR],[CHINESE_OR]) " &
                    " VALUES(N'" + Commons.Modules.ModuleName + "',N'" + Me.Name + "',N'" + sKeyWord + "',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@'," &
                    " 0,N'@" + sKeyWord + "@',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@')"))
            sNN = "@" + sKeyWord + "@"
        End If

        Return sNN

    End Function
#End Region
End Class