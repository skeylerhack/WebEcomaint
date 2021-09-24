Imports Commons.VS.Object
Imports System.Data.SqlClient

Public Class FrmConfirm
    Private _tb As DataTable
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal userlogin As String)
        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        txtUsername.Text = userlogin
        _tb = New DataTable()
        _tb.Columns.Add("TT")
        Me.AcceptButton = btnCheck
    End Sub

    Private Sub btnThoat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnThoat.Click
        Call fnCheckUser()
        Me.Close()
    End Sub

    Private Sub btnCheck_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCheck.Click
        If fnCheckUser() = True Then
            Me.Close()
        Else
            MessageBox.Show("Thông tin đăng nhập không đúng!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        End If
    End Sub
    Private Function fnCheckUser()
        Dim vUserCtrl As UserCtrl = New UserCtrl()
        If vUserCtrl.CheckUser(txtUsername.Text, txtPWD.Text) Then
            Dim r As DataRow = _tb.NewRow
            r("TT") = "1"
            _tb.Rows.Add(r)
            DungChung.ChooseData = _tb.Copy
            Return True
        Else
            Dim r As DataRow = _tb.NewRow
            r("TT") = "0"
            _tb.Rows.Add(r)
            DungChung.ChooseData = _tb.Copy
            Return False
        End If
    End Function

    Private Sub txtPWD_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtPWD.KeyDown
        If e.KeyData = Keys.Enter Then
            If fnCheckUser() = True Then
                Me.Close()
            Else
                MessageBox.Show("Thông tin đăng nhập không đúng!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            End If

        End If
    End Sub

    Private Sub FrmConfirm_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
    End Sub
End Class