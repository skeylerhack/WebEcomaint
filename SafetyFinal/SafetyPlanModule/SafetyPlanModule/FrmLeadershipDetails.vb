Imports System.Data.SqlClient
Imports DevExpress.XtraGrid.Views.Grid
Imports DevExpress.XtraEditors
Imports DevExpress.XtraGrid.Views.Base
Imports Microsoft.ApplicationBlocks.Data
Imports DevExpress.XtraEditors.Repository

Public Class FrmLeadershipDetails
    Private _action As String = ""
    Private dtNNgu As DataTable
    Public Sub New()
        InitializeComponent()
    End Sub
    Private Sub FrmLeadership_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Commons.Modules.SQLString = "0Load"
        GetListUser()
        GetComBo()
        dtpDateCreate.Value = DateTime.Now
        If cbUser.Items.Count > 0 Then
            cbUser.SelectedValue = Commons.Modules.UserName
        End If
        Commons.Modules.SQLString = ""
        GetData()
        EnableButton(False)
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
    End Sub

    Private Sub GetComBo()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_TYPE")
            sqlcom.Parameters.AddWithValue("NNgu", Commons.Modules.TypeLanguage)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_LEADERSHIP"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Commons.Modules.ObjSystems.MLoadLookUpEditNoRemove(cboLoaiBC, ds.Tables(0), "ID_TYPE", "NAME_TYPE", "Loại BC")
            cboLoaiBC.Properties.PopulateColumns()
            cboLoaiBC.Properties.Columns("ID_TYPE").Visible = False
        Catch generatedExceptionName As Exception
        Finally
        End Try
    End Sub


#Region "Get data"
    Private Sub GetData()
        If Commons.Modules.SQLString = "0Load" Then
            Exit Sub
        End If
        Dim dt As New DataTable()
        Dim sqlcom As New SqlCommand()
        Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
        If con.State = ConnectionState.Closed Then
            con.Open()
        End If
        sqlcom.Connection = con
        sqlcom.Parameters.AddWithValue("ACTION", "GET_DATA")
        sqlcom.Parameters.AddWithValue("USER_NAME", cbUser.SelectedValue)
        sqlcom.Parameters.AddWithValue("DateCreate", dtpDateCreate.Value)
        sqlcom.Parameters.AddWithValue("ID_TYPE", cboLoaiBC.EditValue)
        sqlcom.CommandType = CommandType.StoredProcedure
        sqlcom.CommandText = "VS_LEADERSHIPDETAILS"
        Dim da As New SqlDataAdapter(sqlcom)
        Dim ds As New DataSet()
        da.Fill(ds)
        dt = ds.Tables(0).Copy()
        If GridControl1.DataSource Is Nothing Then
            GridControl1.DataSource = dt
            GridView1.PopulateColumns()
            GridView1.OptionsSelection.MultiSelect = False
            GridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            GridView1.Columns("IDLeadership").Visible = False
            GridView1.Columns("UserName").Visible = False

            For i As Integer = 0 To GridView1.Columns.Count - 1
                If GridView1.Columns(i).FieldName <> "Yes" And GridView1.Columns(i).FieldName <> "No" And GridView1.Columns(i).FieldName <> "NA" Then
                    GridView1.Columns(i).OptionsColumn.AllowEdit = False
                End If
            Next

            GridView1.RowHeight = 20
            GridView1.OptionsView.ColumnAutoWidth = True
            GridView1.Columns("DateCreate").Visible = False
            GridView1.Columns("STT").Width = 25
            GridView1.Columns("Yes").Width = 50
            GridView1.Columns("No").Width = 50
            GridView1.Columns("NA").Width = 50
            GridView1.Columns("STT").OptionsColumn.FixedWidth = True
            GridView1.Columns("Yes").OptionsColumn.FixedWidth = True
            GridView1.Columns("No").OptionsColumn.FixedWidth = True
            GridView1.Columns("NA").OptionsColumn.FixedWidth = True

            'Multi-line Content
            Dim memo As New RepositoryItemMemoEdit()
            GridView1.Columns("Content").ColumnEdit = memo
        Else
            GridControl1.DataSource = dt
        End If
    End Sub

    Public Sub GetListUser()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_USER")
            sqlcom.Parameters.AddWithValue("USER_NAME", Commons.Modules.UserName)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_LEADERSHIPDETAILS"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            cbUser.DataSource = ds.Tables(0)
            cbUser.ValueMember = "Userlogin"
            cbUser.DisplayMember = "Staffname"

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Private Sub EnableButton(ByVal tt As Boolean)
        btnSave.Visible = tt
        btnCancel.Visible = tt
        GridView1.OptionsBehavior.Editable = tt
        btnEdit.Visible = Not tt
        btnExit.Visible = Not tt
        cbUser.Enabled = Not tt
        cboLoaiBC.Enabled = Not tt
        dtpDateCreate.Enabled = Not tt
    End Sub

    Private Sub btnEdit_Click(sender As Object, e As EventArgs) Handles btnEdit.Click
        'kiểm tra user chọn có bằng với user name không có thì mới cho sữa còn không thì không được
        If cbUser.SelectedValue.ToString().Trim() <> Commons.Modules.UserName Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "BanKhongCoQuyen", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        EnableButton(True)
        _action = "UPDATE"
    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        If _action = "UPDATE" Then
            Dim transaction As SqlTransaction = Nothing
            Using con As New SqlConnection(Commons.IConnections.ConnectionString())
                Dim sqlcom As SqlCommand = con.CreateCommand()
                Try
                    If con.State = ConnectionState.Closed Then
                        con.Open()
                    End If
                    transaction = con.BeginTransaction("Transaction")

                    Dim sBT = "LDSDetails" + Commons.Modules.UserName
                    Dim dt As New DataTable()
                    dt = GridControl1.DataSource
                    Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString(), sBT, dt, "")
                    sqlcom.Connection = con
                    sqlcom.Transaction = transaction
                    sqlcom.Parameters.AddWithValue("ACTION", _action)
                    sqlcom.Parameters.AddWithValue("USER_NAME", Commons.Modules.UserName)
                    sqlcom.Parameters.AddWithValue("DateCreate", dtpDateCreate.Value)
                    sqlcom.Parameters.AddWithValue("ID_TYPE", cboLoaiBC.EditValue)
                    sqlcom.Parameters.AddWithValue("sBT", sBT)

                    sqlcom.CommandType = CommandType.StoredProcedure
                    sqlcom.CommandText = "VS_LEADERSHIPDETAILS"
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

    ''NGON NGU
    'Private Sub LoadNN()
    '    LoadDataNN()
    '    Me.Text = GetNN(dtNNgu, Me.Name)
    '    GridView1.Columns("Content").Caption = GetNN(dtNNgu, "STT")
    '    GridView1.Columns("Content").Caption = GetNN(dtNNgu, "Content")
    '    GridView1.Columns("Yes").Caption = GetNN(dtNNgu, "Yes")
    '    GridView1.Columns("No").Caption = GetNN(dtNNgu, "No")
    '    GridView1.Columns("NA").Caption = GetNN(dtNNgu, "NA")
    '    btnEdit.Text = GetNN(dtNNgu, btnEdit.Name)
    '    btnCancel.Text = GetNN(dtNNgu, btnCancel.Name)
    '    btnExit.Text = GetNN(dtNNgu, btnExit.Name)
    '    btnSave.Text = GetNN(dtNNgu, btnSave.Name)
    'End Sub

    'Private Sub LoadDataNN()
    '    dtNNgu = New DataTable
    '    dtNNgu.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT KEYWORD , CASE " & Commons.Modules.TypeLanguage &
    '            " WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END AS NN , CONVERT(INT," & Commons.Modules.TypeLanguage.ToString & ") AS NNGU " &
    '            " FROM LANGUAGES WHERE FORM = N'" & Me.Name & "' "))

    'End Sub

    'Private Function GetNN(ByVal dtNN As DataTable, ByVal sKeyWord As String) As String
    '    If dtNN Is Nothing Then
    '        Return ""
    '        Exit Function
    '    End If

    '    Dim sNN As String = ""
    '    Try
    '        If CInt(dtNN.Rows(0)(2).ToString) <> Commons.Modules.TypeLanguage Then LoadNN()
    '        sNN = CType(dtNN.Select("KEYWORD = '" & sKeyWord & "'"), DataRow())(0)(1).ToString()


    '    Catch ex As Exception
    '        sNN = ""
    '    End Try

    '    If sNN = "" Then
    '        SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, (" INSERT INTO [LANGUAGES]([MS_MODULE],[FORM],[KEYWORD],[VIETNAM],[ENGLISH],[CHINESE]," &
    '                " [FORM_HAY_REPORT],[VIETNAM_OR],[ENGLISH_OR],[CHINESE_OR]) " &
    '                " VALUES(N'" + Commons.Modules.ModuleName + "',N'" + Me.Name + "',N'" + sKeyWord + "',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@'," &
    '                " 0,N'@" + sKeyWord + "@',N'@" + sKeyWord + "@',N'@" + sKeyWord + "@')"))
    '        sNN = "@" + sKeyWord + "@"
    '    End If

    '    Return sNN

    'End Function

    Private Sub GridView1_CellValueChanging(sender As Object, e As CellValueChangedEventArgs) Handles GridView1.CellValueChanging
        Dim Yes As Int32 = GridView1.GetRowCellValue(e.RowHandle, GridView1.Columns("Yes"))
        Dim No As Int32 = GridView1.GetRowCellValue(e.RowHandle, GridView1.Columns("No"))
        Dim NA As Int32 = GridView1.GetRowCellValue(e.RowHandle, GridView1.Columns("NA"))

        If e.Column.FieldName = "Yes" And Yes = 0 Then
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("Yes"), 1)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("No"), 0)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("NA"), 0)
            Return
        End If

        If e.Column.FieldName = "No" And No = 0 Then
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("Yes"), 0)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("No"), 1)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("NA"), 0)
            Return
        End If

        If e.Column.FieldName = "NA"  And NA = 0 Then
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("No"), 0)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("Yes"), 0)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("NA"), 1)
            Return
        End If

        If e.Column.FieldName = "No" And Yes = 0 And No = -1 Then
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("Yes"), 0)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("NA"), 1)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("No"), 0)
            Return
        End If

        If e.Column.FieldName = "Yes" And Yes = -1 And No = 0 Then
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("Yes"), 0)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("NA"), 1)
            GridView1.SetRowCellValue(e.RowHandle, GridView1.Columns("No"), 0)
            Return
        End If
    End Sub

    Private Sub cbUser_SelectedIndexChanged(sender As Object, e As EventArgs) Handles cbUser.SelectedIndexChanged
        If Commons.Modules.SQLString = "0Load" Then
            Exit Sub
        End If
        GetData()
    End Sub

    Private Sub dtpDateCreate_ValueChanged(sender As Object, e As EventArgs) Handles dtpDateCreate.ValueChanged
        'Load data
        If Commons.Modules.SQLString = "0Load" Then
            Exit Sub
        End If
        GetData()
    End Sub

    Private Sub cboLoaiBC_EditValueChanged(sender As Object, e As EventArgs) Handles cboLoaiBC.EditValueChanged
        If Commons.Modules.SQLString = "0Load" Then
            Exit Sub
        End If
        GetData()
    End Sub

    Private Sub btnPrint_Click(sender As Object, e As EventArgs) Handles btnPrint.Click
        Dim frm As New FrmBaoCaoLeaderShip()
        frm.ShowDialog()
    End Sub
#End Region
End Class