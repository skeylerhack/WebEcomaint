Public Class Form1
    Dim isLoad As Boolean = False
    Dim sql As New SQLFunction()
    Dim p As New Protect()
    Dim mk As [String] = "VS_CMMS_BARIA"
    Dim ckExistsFolderShare As Boolean = False
    Private Sub Button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button1.Click
        Dim frm As New FrmIncidentAndAccident
        frm.Show()
    End Sub

    Private Sub Button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button2.Click
        Dim frm As New FrmHazardReport
        frm.Show()
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button3.Click
        Dim frm As New FrmStopCard
        frm.Show()
    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button4.Click
        Dim frm As New FrmKhuVuc
        frm.Show()
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button5.Click
        Dim frm As New FrmDanhMucQuanLyRuiRo
        frm.Show()
    End Sub

    Private Sub SimpleButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton1.Click
        Dim frm As New FrmListMoiNguy
        frm.Show()
    End Sub

    Private Sub SimpleButton2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton2.Click
        Dim frm As New FrmListCongViec
        frm.Show()
    End Sub

    Private Sub SimpleButton3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton3.Click
        Dim frm As New FrmAUDIT
        frm.Show()
    End Sub

    Private Sub SimpleButton4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton4.Click
        Dim frm As New FrmListDTTiepXuc
        frm.Show()
    End Sub

    Private Sub SimpleButton5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton5.Click
        Dim frm As New FrmInspection
        frm.Show()
    End Sub

    'Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
    '    DungChung.ConnectString = "Data Source=.;Initial Catalog=CMMS_BARIA;User ID=sa;Password=123"
    'End Sub




    Private Sub CheckReg()
        Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.OpenSubKey("SOFTWARE\CMMS_BARIA")
        If key Is Nothing Then
            Dim frm As New FrmDKKN() 'Form dang ky ket noi database'
            frm.ShowDialog()
        Else
            Dim con As New SQLConnectEntity()
            con.ServerName = p.DeCrypt(DungChung.GetValueReg(key, "Maychu").ToString(), mk)
            con.DatabaseName = p.DeCrypt(DungChung.GetValueReg(key, "CSDL").ToString(), mk)
            Dim mode As [String] = p.DeCrypt(DungChung.GetValueReg(key, "SQLMode").ToString(), mk)
            con.SQLMode = If(mode = "0", True, False)
            con.Username = p.DeCrypt(DungChung.GetValueReg(key, "Taikhoan").ToString(), mk)
            con.Password = p.DeCrypt(DungChung.GetValueReg(key, "Matkhau").ToString(), mk)
            If sql.KetNoi(con) <> True Then
                Dim frm As New FrmDKKN()
                frm.ShowDialog()
            End If
        End If
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        'Commons.IConnections.Server = "LENPRO\SQL2012"
        'Commons.IConnections.Database = "CMMS_BARIA"
        'Commons.IConnections.Username = "sa"
        'Commons.IConnections.Password = "123"

        'DungChung.FolderShare = "\\lenpro\Images"
        'DungChung.Username = "huy"
        'DungChung.Password = "Aa@12345"
        'NetworkShare.OpenNetworkShare(DungChung.FolderShare, DungChung.Username, DungChung.Password)
        'DungChung.Login = "huy"
        Commons.IConnections.Server = "TraiTV"
        Commons.IConnections.Database = "CMMS_BARIA"
        Commons.IConnections.Username = "sa"
        Commons.IConnections.Password = "123"

        'DungChung.FolderShare = "\\192.168.2.30\Images"
        DungChung.FolderShare = "\\sap882pl16\PMP-ECOMAIN\Data$\Data\Tailieumay"
        DungChung.Username = "Administrator"
        DungChung.Password = "123"
        DungChung.ExistsFolderShare = NetworkShare.OpenNetworkShare(DungChung.FolderShare, DungChung.Username, DungChung.Password)
        DungChung.Login = "Administrator"
        'DungChung.Login = "Admin"
        'DungChung.Login = "tuong_dong"
        'DungChung.Login = "truong_le"
        'DungChung.Login = "019970"

    End Sub

    Private Sub Form1_Activate(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Activated
        'CheckReg()
    End Sub

    Private Sub Button6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim frm As New FrmInspection
        frm.ShowDialog()
    End Sub

    Private Sub Form1_FormClosed(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles MyBase.FormClosed
        NetworkShare.CloseNetworkShare(DungChung.FolderShare)
    End Sub

    Private Sub Button6_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim frm As New FrmListImg(26)
        frm.ShowDialog()
    End Sub

    Private Sub Button6_Click_2(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button6.Click
        Dim frm As New FrmDKKN
        frm.ShowDialog()
    End Sub

    Private Sub Button7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button7.Click
        Dim frm As New FrmListDepartment
        frm.ShowDialog()
    End Sub

    Private Sub Button8_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button8.Click
        Dim frm As New FrmListNhanVienSafety
        frm.ShowDialog()
    End Sub

    Private Sub Button9_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button9.Click
        Dim frm As New FrmExportExcel(1)
        frm.ShowDialog()
    End Sub

    Private Sub Button10_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button10.Click
        Dim frm As New FrmPhanQuyenDuyet
        frm.ShowDialog()
    End Sub

    Private Sub Button11_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Button11.Click
        Dim iData As IDataObject = Clipboard.GetDataObject()
       
        ' Is Data Text?
        If iData.GetDataPresent(DataFormats.UnicodeText) Then

            RichTextBox1.Text = DirectCast(iData.GetData(DataFormats.UnicodeText), [String])
            Dim dt As New DataTable
            dt.Columns.Add("ID")
            dt.Columns.Add("VALUE")
            Dim dr As DataRow '
            For Each s In RichTextBox1.Lines
                Try
                    dr = dt.NewRow
                    dr("ID") = s.Split(vbTab)(0)
                    dr("VALUE") = s.Split(vbTab)(1)
                    dt.Rows.Add(dr)
                Catch ex As Exception

                End Try
            Next
            MsgBox(dt.Rows.Count.ToString())
        Else
            RichTextBox1.Text = ""
        End If
    End Sub
End Class
