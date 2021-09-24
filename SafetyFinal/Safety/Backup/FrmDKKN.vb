Public Class FrmDKKN
    Dim sql As New SQLFunction()
    Dim p As New Protect()
    Dim mk As String = "VS_CMMS_BARIA"
    Private Sub FrmDKKN_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        ReadSetting()
    End Sub
    Private Sub SaveSetting()
        Try
            Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.CreateSubKey("SOFTWARE\CMMS_BARIA")
            'storing the values  
            key.SetValue("Maychu", p.EnCrypt(txtMaychu.Text, mk))
            key.SetValue("CSDL", p.EnCrypt(txtCSDL.Text, mk))
            If rdbHethong.Checked = True Then
                key.SetValue("SQLMode", p.EnCrypt("0", mk))
            Else
                key.SetValue("SQLMode", p.EnCrypt("1", mk))
            End If
            key.SetValue("Taikhoan", p.EnCrypt(txtTaikhoan.Text, mk))
            key.SetValue("Matkhau", p.EnCrypt(txtMatkhau.Text, mk))
            key.Close()
            MessageBox.Show(Me, "Save settings successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
        Catch generatedExceptionName As Exception
            MessageBox.Show(Me, "Save settings failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.[Error])
        End Try
    End Sub
    Private Sub ReadSetting()
        Try
            Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.OpenSubKey("SOFTWARE\CMMS_BARIA")
            'if it does exist, retrieve the stored values  
            If key IsNot Nothing Then

                txtMaychu.Text = p.DeCrypt(DungChung.GetValueReg(key, "Maychu").ToString(), mk)
                txtCSDL.Text = p.DeCrypt(DungChung.GetValueReg(key, "CSDL").ToString(), mk)
                Dim mode As [String] = p.DeCrypt(DungChung.GetValueReg(key, "SQLMode").ToString(), mk)
                If mode = "0" Then
                    rdbHethong.Checked = True
                Else
                    rdbSQL.Checked = True
                End If
                txtTaikhoan.Text = p.DeCrypt(DungChung.GetValueReg(key, "Taikhoan").ToString(), mk)
                txtMatkhau.Text = p.DeCrypt(DungChung.GetValueReg(key, "Matkhau").ToString(), mk)
                key.Close()
            End If
        Catch generatedExceptionName As Exception
            Throw
        End Try
    End Sub

    Private Sub rdbHethong_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rdbHethong.CheckedChanged, rdbSQL.CheckedChanged
        If rdbHethong.Checked = True Then
            txtTaikhoan.Enabled = False
            txtMatkhau.Enabled = False
            txtTaikhoan.Text = ""
            txtMatkhau.Text = ""
        Else
            txtTaikhoan.Enabled = True
            txtMatkhau.Enabled = True
        End If
    End Sub

    Private Function CheckValid() As [Boolean]
        If txtMaychu.Text = "" Then
            MessageBox.Show(Me, "Must enter the Server/IP!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            txtMaychu.Focus()
            Return False
        End If
        If txtCSDL.Text = "" Then
            MessageBox.Show(Me, "Must enter the Database!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            txtCSDL.Focus()
            Return False
        End If
        If rdbSQL.Checked = True Then
            If txtTaikhoan.Text = "" Then
                MessageBox.Show(Me, "Must enter Username!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                txtTaikhoan.Focus()
                Return False
            End If
            If txtMatkhau.Text = "" Then
                MessageBox.Show(Me, "Must enter Password!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                txtMatkhau.Focus()
                Return False
            End If
        End If
        Return True
    End Function

    Private Sub btnThuketnoi_Click_1(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnThuketnoi.Click
        If CheckValid() Then
            TestConnect()
        End If
    End Sub
    Private Sub TestConnect()
        Dim con As New SQLConnectEntity()
        con.ServerName = txtMaychu.Text
        con.DatabaseName = txtCSDL.Text
        con.SQLMode = If(rdbHethong.Checked = True, True, False)
        con.Username = txtTaikhoan.Text
        con.Password = txtMatkhau.Text
        If sql.KetNoi(con) = True Then
            MessageBox.Show(Me, "Connect to the database server successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
        Else
            MessageBox.Show(Me, "Unable to connect to database server!", "Error", MessageBoxButtons.OK, MessageBoxIcon.[Error])
        End If

    End Sub

    Private Sub btnLuu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLuu.Click
        If CheckValid() Then
            SaveSetting()
            Me.Close()
        End If
    End Sub
    Private Function CheckReg()
        Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.OpenSubKey("SOFTWARE\CMMS_BARIA")
        If key Is Nothing Then
            Return False
        Else
            Return True
        End If
    End Function

    Private Sub FrmDKKN_FormClosed(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles MyBase.FormClosed
        If CheckReg() = False Then
            Application.OpenForms.Item(0).Close()
            Application.ExitThread()
        End If
    End Sub
End Class