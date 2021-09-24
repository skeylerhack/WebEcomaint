Imports DevExpress.XtraEditors

Public Class FrmReport
    Dim ngaytao As Date = Nothing
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal createdate As Date)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        ngaytao = createdate
    End Sub
    Private Sub btnThoat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnThoat.Click
        Me.Close()
    End Sub

    Private Sub FrmReport_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Try

            Dim dt As New DataTable()
            If dt.Columns.Count > 0 Then
                dt.Columns.Clear()
            End If
            dt.Columns.Add("NGUOIBC")
            dt.Columns.Add("NGAYHT")
            dt.Columns.Add("GHICHU")
            dt.Columns.Add("XOA")
            DungChung.ChooseData = dt.Clone()
            txtNguoiBC.Text = DungChung.Login
            'If DungChung.ChooseData.Columns.Count > 0 Then
            '    DungChung.ChooseData.Columns.Clear()
            'End If
            'DungChung.ChooseData.Columns.Add("NGUOIBC")
            'DungChung.ChooseData.Columns.Add("NGAYHT")
            'DungChung.ChooseData.Columns.Add("GHICHU")
            'DungChung.ChooseData.Columns.Add("XOA")
            Me.AcceptButton = btnBC
            Commons.Modules.ObjSystems.ThayDoiNN(Me)
        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnBC_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnBC.Click
        Try
            Dim date1 As Date = New Date(ngaytao.Year, ngaytao.Month, ngaytao.Day, 0, 0, 0)
            If DateTime.Compare(date1, CDate(dtNgayHT.Value.ToShortDateString())) > 0 Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "NGAYHTNHOHONNGAYTAOPHIEU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show("Ngày hoàn thành phải lớn hơn ngày tạo phiếu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Exit Sub
            End If
            If DateTime.Compare(CDate(dtNgayHT.Value.ToShortDateString()), Now.Date) > 0 Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "NGAYHTLONHONNGAYHIENTAI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show("Ngày hoàn thành không được lớn hơn ngày hiện tại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Exit Sub
            End If
            Dim r As DataRow = DungChung.ChooseData.NewRow
            r("NGUOIBC") = txtNguoiBC.Text
            r("NGAYHT") = dtNgayHT.Value
            r("GHICHU") = txtGhiChu.Text
            r("XOA") = "N"
            DungChung.ChooseData.Rows.Add(r)
            Me.Close()
        Catch ex As Exception

        End Try

    End Sub

    Private Sub SimpleButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton1.Click
        Try
            Dim r As DataRow = DungChung.ChooseData.NewRow
            r("NGUOIBC") = txtNguoiBC.Text
            r("NGAYHT") = dtNgayHT.Value
            r("GHICHU") = txtGhiChu.Text
            r("XOA") = "Y"
            DungChung.ChooseData.Rows.Add(r)
            Me.Close()
        Catch ex As Exception

        End Try

    End Sub

    Private Sub btnKhongTH_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnKhongTH.Click
        Try
            Dim date1 As Date = New Date(ngaytao.Year, ngaytao.Month, ngaytao.Day, 0, 0, 0)
            If DateTime.Compare(date1, CDate(dtNgayHT.Value.ToShortDateString())) > 0 Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "NGAYHTNHOHONNGAYTAOPHIEU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show("Ngày hoàn thành phải lớn hơn ngày tạo phiếu!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Exit Sub
            End If
            If DateTime.Compare(CDate(dtNgayHT.Value.ToShortDateString()), Now.Date) > 0 Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "NGAYHTLONHONNGAYHIENTAI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show("Ngày hoàn thành không được lớn hơn ngày hiện tại!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Exit Sub
            End If
            If txtGhiChu.Text.Length = 0 Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "PHAINHAPLYDOKHONGTHUCHIEN", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show("Phải nhập lý do không thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
                Exit Sub
            End If
            Dim r As DataRow = DungChung.ChooseData.NewRow
            r("NGUOIBC") = txtNguoiBC.Text
            r("NGAYHT") = dtNgayHT.Value
            r("GHICHU") = txtGhiChu.Text
            r("XOA") = "R"
            DungChung.ChooseData.Rows.Add(r)
            Me.Close()
        Catch ex As Exception

        End Try

    End Sub
End Class