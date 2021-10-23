Imports System.Data.SqlClient
Imports DevExpress.XtraEditors

Public Class FrmBaoCaoLeaderShip
    Private Sub FrmBaoCaoLeaderShip_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        GetComBoLoai()
        GetComboUser()
        datTuNgay.DateTime = DateTime.Now().AddDays(-DateTime.Now.Day + 1)
        datDenNgay.DateTime = datTuNgay.DateTime.AddMonths(1).AddDays(-1)
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
    End Sub

    Public Sub GetComboUser()
        Try
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

            Dim tab As New DataTable
            tab = ds.Tables(0)
            tab.Rows.Add("-1", "<All>")
            tab.DefaultView.Sort = "Staffname ASC"
            Commons.Modules.ObjSystems.MLoadLookUpEdit(lokNguoiBC, ds.Tables(0), "Userlogin", "Staffname", Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "Staffname", Commons.Modules.TypeLanguage))
            lokNguoiBC.EditValue = "-1"

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub


    Private Sub GetComBoLoai()
        Try
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

            Dim tab As New DataTable
            tab = ds.Tables(0)
            tab.Rows.Add(-1, "-1", "<All>")
            tab.DefaultView.Sort = "NAME_TYPE ASC"

            Commons.Modules.ObjSystems.MLoadLookUpEditNoRemove(lokLoaiBC, ds.Tables(0), "ID_TYPE", "NAME_TYPE", Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "NAME_TYPE", Commons.Modules.TypeLanguage))
            lokLoaiBC.Properties.PopulateColumns()
            lokLoaiBC.Properties.Columns("ID_TYPE").Visible = False
            lokLoaiBC.EditValue = Convert.ToInt64(-1)


        Catch generatedExceptionName As Exception
        Finally
        End Try
    End Sub

    Private Sub btnThucHien_Click(sender As Object, e As EventArgs) Handles btnThucHien.Click

        Dim sqlcom As New SqlCommand()
        Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
        If con.State = ConnectionState.Closed Then
            con.Open()
        End If
        sqlcom.Connection = con
        sqlcom.Parameters.AddWithValue("TU_NGAY", datTuNgay.DateTime)
        sqlcom.Parameters.AddWithValue("DEN_NGAY", datDenNgay.DateTime)
        sqlcom.Parameters.AddWithValue("LoaiBC", lokLoaiBC.EditValue)
        sqlcom.Parameters.AddWithValue("UserBC", lokNguoiBC.EditValue)
        sqlcom.Parameters.AddWithValue("flag", rdoBaoCao.SelectedIndex)
        sqlcom.CommandType = CommandType.StoredProcedure
        sqlcom.CommandText = "spBCLeaderShipDetails"
        Dim da As New SqlDataAdapter(sqlcom)
        Dim ds As New DataSet()
        da.Fill(ds)

        If ds.Tables(0).Rows.Count = 0 Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "KhongCoDuLieuDeIn", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If

        GridControl1.DataSource = Not Nothing
        Commons.Modules.ObjSystems.MLoadXtraGrid(GridControl1, GridView1, ds.Tables(0), False, True, True, True, IIf(rdoBaoCao.SelectedIndex = 0, False, True), Me.Name)
        GridView1.BestFitColumns()
        Dim sPath As String = ""
        sPath = Commons.Modules.MExcel.SaveFiles("Excel file (*.xlsx)|*.xlsx")
        If sPath = "" Then Return 
        GridView1.ActiveFilter.Clear()
        GridView1.ExportToXlsx(sPath)
        If System.IO.File.Exists(sPath) Then
            OpenExcel(sPath)
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

    Private Sub btnThoat_Click(sender As Object, e As EventArgs) Handles btnThoat.Click
        Me.Close()
    End Sub
End Class