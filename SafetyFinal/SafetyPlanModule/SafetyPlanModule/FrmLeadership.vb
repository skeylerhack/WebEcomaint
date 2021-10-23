Imports System.Data.SqlClient
Imports DevExpress.XtraGrid.Views.Grid
Imports DevExpress.XtraEditors
Imports DevExpress.XtraGrid.Views.Base
Imports Microsoft.ApplicationBlocks.Data
Imports DevExpress.XtraEditors.Repository

Public Class FrmLeadership
    Private iID As Integer = -1
    Private _action As String = ""
    Private dtNNgu As DataTable
    Public Sub New()
        InitializeComponent()
    End Sub
    Private Sub FrmLeadership_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Commons.Modules.SQLString = "0Load"
        GetComBo()
        GetData(-1)
        EnableButton(False)
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        Commons.Modules.SQLString = ""
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
    Private Sub GetData(ByVal id As Int32)
        If _action = "UPDATE" Then
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
        sqlcom.Parameters.AddWithValue("NNgu", Commons.Modules.TypeLanguage)
        sqlcom.Parameters.AddWithValue("ID_TYPE", cboLoaiBC.EditValue)
        sqlcom.CommandType = CommandType.StoredProcedure
        sqlcom.CommandText = "VS_LEADERSHIP"
        Dim da As New SqlDataAdapter(sqlcom)
        Dim ds As New DataSet()
        da.Fill(ds)
        dt = ds.Tables(0).Copy()
        dt.PrimaryKey = New DataColumn() {dt.Columns("ID")}
        If grdData.DataSource Is Nothing Then
            Commons.Modules.ObjSystems.MLoadXtraGrid(grdData, grvData, dt, False, False, True, True, True, Me.Name)
            grvData.Columns("ID_TYPE").Visible = False
            grvData.Columns("ID").Visible = False
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
        grdData.Enabled = Not tt

        txtContent.ReadOnly = Not tt
        chkActive.Properties.ReadOnly = Not tt


    End Sub

    Private Sub btnEdit_Click(sender As Object, e As EventArgs) Handles btnEdit.Click
        EnableButton(True)
        _action = "UPDATE"
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
                    sqlcom.Parameters.AddWithValue("ACTION", _action)
                    sqlcom.Parameters.AddWithValue("ID", iID)
                    sqlcom.Parameters.AddWithValue("Content", txtContent.Text)
                    sqlcom.Parameters.AddWithValue("USER_NAME", Commons.Modules.UserName)
                    sqlcom.Parameters.AddWithValue("ID_TYPE", cboLoaiBC.EditValue)
                    sqlcom.Parameters.AddWithValue("Active", chkActive.Checked)

                    sqlcom.CommandType = CommandType.StoredProcedure
                    sqlcom.CommandText = "VS_LEADERSHIP"
                    iID = sqlcom.ExecuteNonQuery()
                    transaction.Commit()
                    EnableButton(False)
                    _action = ""
                    GetData(iID)
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
        _action = ""
        GetData(-1)
        EnableButton(False)
        BingdingText(False)
    End Sub

    Private Sub btnExit_Click(sender As Object, e As EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    Private Sub btnTKBCT_Click(sender As Object, e As EventArgs) Handles btnTKBCT.Click
        Dim frm As New FrmLeadershipType()
        frm.ShowDialog()
        GetComBo()
    End Sub

    Private Sub grvData_FocusedRowChanged(sender As Object, e As FocusedRowChangedEventArgs) Handles grvData.FocusedRowChanged
        If grvData.FocusedRowHandle < 0 Then
            BingdingText(True)
        Else
            BingdingText(False)
        End If
    End Sub

    Private Sub BingdingText(ByVal flag As Boolean)
        If grvData.RowCount = 0 Then
            flag = True
        End If
        iID = IIf(flag, -1, Convert.ToInt64(grvData.GetFocusedRowCellValue("ID")))
        txtContent.Text = IIf(flag, "", grvData.GetFocusedRowCellValue("Content"))
        cboLoaiBC.EditValue = IIf(flag, -1, Convert.ToInt64(grvData.GetFocusedRowCellValue("ID_TYPE")))
        chkActive.Checked = IIf(flag, True, Convert.ToBoolean(grvData.GetFocusedRowCellValue("Active")))
    End Sub

    Private Sub cboLoaiBC_EditValueChanged(sender As Object, e As EventArgs) Handles cboLoaiBC.EditValueChanged
        If Commons.Modules.SQLString = "0Load" Then
            Exit Sub
        End If
        GetData(-1)
    End Sub


#End Region
End Class