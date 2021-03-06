Imports Commons.VS.Security

Imports VS.Object
Imports Commons.VS.Classes.Admin
Imports System.Data.SqlClient
Imports Microsoft.ApplicationBlocks.Data
Imports Commons.VS.Object

Public Class frmPassword
    Private Sub frmPassword_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        txtUsername.Text = Commons.Modules.UserName
    End Sub
    Private Sub btnChange_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles BtnChange.Click
        Dim vUserInfo As Commons.IUsers = New UserCtrl().GetUser(txtUsername.Text.Trim())
        If (Not vUserInfo.Password.Equals(Commons.clsXuLy.MaHoaDL(txtPassOld.Text))) Then
            MsgBox(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "MsgKhongTrungPass", Commons.Modules.TypeLanguage), MsgBoxStyle.Exclamation, Me.Text)
            txtPassOld.Focus()
            Return
        End If
        If (Not txtPassNew.Text.Trim.Equals(txtComfirmPass.Text)) Then
            MsgBox(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "MsgKhongTrungPassCom", Commons.Modules.TypeLanguage), MsgBoxStyle.Exclamation, Me.Text)
            txtComfirmPass.Focus()
            Return
        End If
        vUserInfo.Password = Commons.clsXuLy.MaHoaDL(txtPassNew.Text)
        Dim vUserCtrl As UserCtrl = New UserCtrl()
        vUserCtrl.UpdateUser(vUserInfo)
        MsgBox(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, Me.Name, "MsgDoiMKThanhCong", Commons.Modules.TypeLanguage), MsgBoxStyle.Information, Me.Text)
        Me.Close()
    End Sub
    Private Sub btnExit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub

    Private Sub frmPassword_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If e.KeyCode = Keys.Enter Then
            btnChange_Click(sender, e)
        End If
    End Sub
End Class