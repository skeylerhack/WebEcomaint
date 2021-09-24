Imports System.IO

Module mdStartup
    Public SQLConnectionString As String = "Ͳ̴̨͖̤̤̜͊ͪ͠͞͞΂Ͱ͚̜ͤ͆͊͞ΪΆ̨̜̦̪̜̤̜̬"
    Public Sub Main()
        Application.Run(New frmMain())
    End Sub

    Public Function AppConnect(Optional ByVal bChangeInfomation As Boolean = False) As String
        Dim sDefaultConnectString As String = "Server=HAITU;OLE DB Services=-2;Database=CMMS_VICT;uid=garment;pwd=haugiang2749;"
        Dim sStringConnect As String = String.Empty

        If bChangeInfomation = True Then
            Dim sFileConfig As String
            sFileConfig = Directory.GetCurrentDirectory() + "\VSConfig.ini"
            If File.Exists(sFileConfig) Then
                Dim sFileInclude = System.IO.File.OpenText(sFileConfig)
                Try
                    Dim sRowStream As String = sFileInclude.ReadToEnd()
                    If sRowStream <> Nothing Then SQLConnectionString = sRowStream
                Catch
                Finally
                    sFileInclude.Dispose()
                End Try
            End If
        End If
        Try
            Dim sRowStream As String = ""
            sRowStream = Commons.clsXuLy.GiaiMaDL(SQLConnectionString)
            If sRowStream <> Nothing Then
                Dim sArr() As String = Split(sRowStream, ",")
                sStringConnect = "Server=" & sArr(0) & ";Database=" & sArr(1) & ";uid=" & sArr(2) & ";pwd=" & sArr(3) & ";Connect Timeout=9999999;"
            End If
        Catch
            sStringConnect = sDefaultConnectString
        Finally
        End Try
        Return sStringConnect
    End Function
End Module
