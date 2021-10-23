Imports System.Data.SqlClient
Imports DevExpress.XtraEditors
Imports DevExpress.XtraGrid.Views.Base
Imports Microsoft.ApplicationBlocks.Data

Public Class FrmLeadershipType
    Private iID As Int64 = -1
    Private _action As String = ""
    Private dtNNgu As DataTable
    Public Sub New()
        InitializeComponent()
    End Sub
    Private Sub FrmLeadershipType_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        GetData(-1)
        EnableButton(False)
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        Commons.Modules.ObjSystems.MLoadNNXtraGrid(grvData, Me.Name)
    End Sub
#Region "Get data"
    Private Sub GetData(ByVal iID As Int64)
        Dim dt As New DataTable()
        Dim sqlcom As New SqlCommand()
        Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
        If con.State = ConnectionState.Closed Then
            con.Open()
        End If
        sqlcom.Connection = con
        sqlcom.Parameters.AddWithValue("ACTION", "GET_DATA")
        sqlcom.CommandType = CommandType.StoredProcedure
        sqlcom.CommandText = "VS_LEADERSHIP_TYPE"
        Dim da As New SqlDataAdapter(sqlcom)
        Dim ds As New DataSet()
        da.Fill(ds)
        dt = ds.Tables(0).Copy()
        dt.PrimaryKey = New DataColumn() {dt.Columns("ID_TYPE")}
        If grdData.DataSource Is Nothing Then
            grdData.DataSource = dt
            grvData.Columns("ID_TYPE").Visible = False
        Else
            grdData.DataSource = dt
        End If
        If iID <> -1 Then
            Dim index As Integer = dt.Rows.IndexOf(dt.Rows.Find(iID))
            grvData.FocusedRowHandle = grvData.GetRowHandle(index)
        End If
    End Sub


    Private Sub btnAdd_Edit_Click(sender As Object, e As EventArgs) Handles btnAdd_Edit.Click
        EnableButton(True)
        BingdingText(True)
        _action = "ADD"
    End Sub

    Private Sub EnableButton(ByVal tt As Boolean)
        btnSave.Visible = tt
        btnCancel.Visible = tt
        btnAdd_Edit.Visible = Not tt
        btnEdit.Visible = Not tt
        btnDelete.Visible = Not tt
        btnExit.Visible = Not tt

        txtMaSo.Properties.ReadOnly = Not tt
        txtNameV.Properties.ReadOnly = Not tt
        txtNameE.Properties.ReadOnly = Not tt
        txtNote.Properties.ReadOnly = Not tt
        chkActive.Properties.ReadOnly = Not tt
        grdData.Enabled = Not tt


        'Khi Edit mở ra
    End Sub

    Private Sub btnEdit_Click(sender As Object, e As EventArgs) Handles btnEdit.Click
        EnableButton(True)
        _action = "UPDATE"
        iID = Convert.ToInt64(grvData.GetFocusedRowCellValue("ID_TYPE"))
    End Sub


    Private Sub btnDelete_Click(sender As Object, e As EventArgs) Handles btnDelete.Click
        If iID < 1 Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmLeadershipType", "CHUACHONLEADERSHIP", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmLeadershipType", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If

        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmLeadershipType", "BANCOCHACXOA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmLeadershipType", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OKCancel, MessageBoxIcon.Warning) = DialogResult.Cancel Then Return

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
                sqlcom.Parameters.AddWithValue("ID_TYPE", iID)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_LEADERSHIP_TYPE"
                sqlcom.ExecuteNonQuery()
                transaction.Commit()
                EnableButton(False)
                GetData(-1)
                _action = ""
            Catch ex As Exception
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "DuLieuDaPhatSinh", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
            Finally
                con.Close()
            End Try
        End Using

    End Sub

    Private Sub btnSave_Click(sender As Object, e As EventArgs) Handles btnSave.Click
        'kiểm tra trống
        If DxValidationProvider1.Validate() = False Then
            Exit Sub
        End If
        'kiểm tra mã số đã tồn tại
        Dim n As Integer = SqlHelper.ExecuteScalar(Commons.IConnections.ConnectionString(), CommandType.Text, "SELECT COUNT(*) FROM dbo.LeadershipType WHERE MA_SO = '" & txtMaSo.EditValue.ToString().Trim() & "'  " & IIf(iID = -1, "", " AND ID_TYPE <> " & iID.ToString() & " ") & " ")
        If n > 0 Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "TrungMa", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If _action = "ADD" Or _action = "UPDATE" Then
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
                    sqlcom.Parameters.AddWithValue("ID_TYPE", iID)
                    sqlcom.Parameters.AddWithValue("ACTION", _action)
                    sqlcom.Parameters.AddWithValue("MA_SO", txtMaSo.EditValue)
                    sqlcom.Parameters.AddWithValue("NAME_VN", txtNameV.EditValue)
                    sqlcom.Parameters.AddWithValue("NAME_EL", txtNameE.EditValue)
                    sqlcom.Parameters.AddWithValue("NOTE", txtNote.EditValue)
                    sqlcom.Parameters.AddWithValue("ACTIVE", chkActive.Checked)
                    sqlcom.CommandType = CommandType.StoredProcedure
                    sqlcom.CommandText = "VS_LEADERSHIP_TYPE"
                    iID = sqlcom.ExecuteScalar()
                    transaction.Commit()
                    EnableButton(False)
                    GetData(iID)
                Catch ex As Exception
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "DuLieuDaPhatSinh", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
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
        GetData(-1)
        EnableButton(False)
        BingdingText(False)
    End Sub

    Private Sub btnExit_Click(sender As Object, e As EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    'NGON NGU
    Private Sub LoadNN()
        LoadDataNN()
        'Me.Text = GetNN(dtNNgu, Me.Name)
        'grvData.Columns("Content").Caption = GetNN(dtNNgu, "Content")
        'lblContent.Text = GetNN(dtNNgu, lblContent.Name)
        'btnAdd_Edit.Text = GetNN(dtNNgu, btnAdd_Edit.Name)
        'btnEdit.Text = GetNN(dtNNgu, btnEdit.Name)
        'btnCancel.Text = GetNN(dtNNgu, btnCancel.Name)
        'btnDelete.Text = GetNN(dtNNgu, btnDelete.Name)
        'btnExit.Text = GetNN(dtNNgu, btnExit.Name)
        'btnSave.Text = GetNN(dtNNgu, btnSave.Name)
    End Sub

    Private Sub LoadDataNN()
        dtNNgu = New DataTable
        dtNNgu.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT KEYWORD , CASE " & Commons.Modules.TypeLanguage &
                " WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END AS NN , CONVERT(INT," & Commons.Modules.TypeLanguage.ToString & ") AS NNGU " &
                " FROM LANGUAGES WHERE FORM = N'" & Me.Name & "' "))

    End Sub

    Private Sub cboLoaiBC_ButtonClick(sender As Object, e As DevExpress.XtraEditors.Controls.ButtonPressedEventArgs)

    End Sub
    Private Sub BingdingText(ByVal flag As Boolean)
        If grvData.RowCount = 0 Then
            flag = True
        End If
        iID = IIf(flag, -1, Convert.ToInt64(grvData.GetFocusedRowCellValue("ID_TYPE")))
        txtMaSo.EditValue = IIf(flag, "", grvData.GetFocusedRowCellValue("MA_SO"))
        txtNameV.EditValue = IIf(flag, "", grvData.GetFocusedRowCellValue("NAME_VN"))
        txtNameE.EditValue = IIf(flag, "", grvData.GetFocusedRowCellValue("NAME_EL"))
        txtNote.EditValue = IIf(flag, "", grvData.GetFocusedRowCellValue("NOTE"))
        chkActive.Checked = IIf(flag, True, Convert.ToBoolean(grvData.GetFocusedRowCellValue("ACTIVE")))
    End Sub
    Private Sub grvData_FocusedRowChanged(sender As Object, e As FocusedRowChangedEventArgs) Handles grvData.FocusedRowChanged
        If grvData.FocusedRowHandle < 0 Then
            Exit Sub
        End If
        BingdingText(False)
    End Sub
#End Region
End Class