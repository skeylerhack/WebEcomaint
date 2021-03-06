Public Class frmDoiServer 

    Private Sub frmDoiServer_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        txtSerO.Text = Commons.IConnections.Server
        txtSerN.Text = Commons.IConnections.Server
        txtUserO.Text = Commons.IConnections.Username
        txtUserN.Text = Commons.IConnections.Username
        txtPassO.Text = Commons.IConnections.Password
        txtPassN.Text = Commons.IConnections.Password
        txtDataO.Text = Commons.IConnections.Database
        txtDataN.Text = Commons.IConnections.Database


    End Sub

    Private Sub btnTFile_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnTFile.Click
        Dim sPath As String

        sPath = Commons.Modules.MExcel.SaveFiles("Text file (*.txt)|*.txt")
        If sPath = "" Then Exit Sub

        Dim sChuoiCon As String
        sChuoiCon = ""
        sChuoiCon = TaoFileConnect()
        If sChuoiCon = "" Then Exit Sub
        'sPath = Commons.Modules.MExcel.SaveFiles("Text file (*.txt)|*.txt")

        CapNhapFile(sChuoiCon, Application.StartupPath + "\VSConfig.ini")

    End Sub

    Private Sub btnThoat_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnThoat.Click
        Me.Close()

    End Sub

    Private Sub btnCapNhap_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCapNhap.Click

        Dim sChuoiCon As String
        sChuoiCon = ""
        sChuoiCon = TaoFileConnect()
        If sChuoiCon = "" Then Exit Sub


        CapNhapFile(sChuoiCon, Application.StartupPath + "\VSConfig.ini")
    End Sub

    Public Function TaoFileConnect() As String
        If txtSerN.Text = "" Then
            MsgBox("Vui lòng nhập server!", MsgBoxStyle.Exclamation, Me.Text)
            Return ""
        End If

        If txtUserN.Text = "" Then
            MsgBox("Vui lòng nhập user!", MsgBoxStyle.Exclamation, Me.Text)
            Return ""
        End If

        Commons.IConnections.Server = txtSerN.Text
        Commons.IConnections.Username = txtUserN.Text
        Commons.IConnections.Password = txtPassN.Text
        Commons.IConnections.Database = txtDataN.Text

        Dim sSer As String
        Dim sUser As String
        Dim sPass As String
        Dim sData As String
        Dim sChuoiCon As String

        If IO.File.Exists(Application.StartupPath + "\VSConfig.ini") Then
            Dim sFileInclude = System.IO.File.OpenText(Application.StartupPath + "\VSConfig.ini")
            Try
                sChuoiCon = sFileInclude.ReadToEnd()
                sChuoiCon = Commons.clsXuLy.GiaiMaDL(sChuoiCon)
                Dim sArr() As String = Split(sChuoiCon, "!")
                sSer = sArr(0) + "!"
                sChuoiCon = sChuoiCon.Replace(sSer, "")

                sData = sArr(1) + "!"
                sChuoiCon = sChuoiCon.Replace(sData, "")

                sUser = sArr(2) + "!"
                sChuoiCon = sChuoiCon.Replace(sUser, "")

                sPass = sArr(3) + "!"
                sChuoiCon = sChuoiCon.Replace(sPass, "")

            Catch
                sFileInclude.Dispose()
                MsgBox("Cập nhập không thành công!", MsgBoxStyle.Critical, Me.Text)
                Return ""
            End Try
            sChuoiCon = txtSerN.Text + "!" + txtDataN.Text + "!" + txtUserN.Text + "!" + txtPassN.Text + "!" + sChuoiCon


            sFileInclude.Dispose()
            sFileInclude.Close()
            Return sChuoiCon
        Else
            MsgBox("Cập nhập không thành công!", MsgBoxStyle.Critical, Me.Text)
            Return ""
        End If

    End Function

    Public Sub CapNhapFile(ByVal sChuoiCon As String, ByVal sFile As String)
        Dim sWriter As System.IO.StreamWriter = Nothing
        Try

            sWriter = New System.IO.StreamWriter(sFile)
            sWriter.Write(Commons.clsXuLy.MaHoaDL(sChuoiCon.Trim()))
            sWriter.Flush()
            sWriter.Close()
            MsgBox("Cập nhập thành công!", MsgBoxStyle.Exclamation, Me.Text)

            txtSerO.Text = Commons.IConnections.Server
            txtSerN.Text = Commons.IConnections.Server
            txtUserO.Text = Commons.IConnections.Username
            txtUserN.Text = Commons.IConnections.Username
            txtPassO.Text = Commons.IConnections.Password
            txtPassN.Text = Commons.IConnections.Password
            txtDataO.Text = Commons.IConnections.Database
            txtDataN.Text = Commons.IConnections.Database

        Catch ex As Exception
            sWriter.Flush()
            sWriter.Close()
            MsgBox("Cập nhập không thành công!", MsgBoxStyle.Critical, Me.Text)
        End Try
    End Sub
End Class