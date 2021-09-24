Imports System.IO

Public NotInheritable Class DungChung
    Private Sub New()
    End Sub
    'Public Const ChuoiKetNoi As String = "Data Source=.;Initial Catalog=healthcare;User ID=sa;Password=123"

    Shared _ConnectString As String = ""
    Shared _FolderShare As String = ""
    Shared _Username As String = ""
    Shared _Password As String = ""
    Shared _resT As DataTable = Nothing
    Shared _UserLogin As String = ""
    Shared _ExistsFolderShare As Boolean = False
    Public Shared Property ChooseData() As DataTable
        Get
            Return _resT
        End Get
        Set(ByVal value As DataTable)
            _resT = value
        End Set
    End Property
    Public Shared Property ExistsFolderShare() As String
        Get
            Return _ExistsFolderShare
        End Get
        Set(ByVal value As String)
            _ExistsFolderShare = value
        End Set
    End Property
    Public Shared Property Login() As String
        Get
            Return _UserLogin
        End Get
        Set(ByVal value As String)
            _UserLogin = value
        End Set
    End Property
    Public Shared Property FolderShare() As String
        Get
            Return _FolderShare
        End Get
        Set(ByVal value As String)
            _FolderShare = value
        End Set
    End Property
    Public Shared Property Username() As String
        Get
            Return _Username
        End Get
        Set(ByVal value As String)
            _Username = value
        End Set
    End Property
    Public Shared Property Password() As String
        Get
            Return _Password
        End Get
        Set(ByVal value As String)
            _Password = value
        End Set
    End Property
    Public Shared Property ConnectString() As String
        Get
            Return _ConnectString
        End Get
        Set(ByVal value As String)
            _ConnectString = Value
        End Set
    End Property
    Public Shared Function GetValueReg(ByVal key As Microsoft.Win32.RegistryKey, ByVal name As [String]) As [String]
        Try
            Return key.GetValue(name).ToString()
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Public Shared Function CopyFile(ByVal sourcepath As String, ByVal DestPath As String)
        Try
            If Not File.Exists(DestPath + "/" + Path.GetFileName(sourcepath)) Then
                'Dim attributes As FileAttributes
                'attributes = File.GetAttributes(sourcepath)

                'File.SetAttributes(sourcepath, File.GetAttributes(sourcepath) Or FileAttributes.Hidden)
                Dim file1 = New FileInfo(sourcepath)
                file1.CopyTo(Path.Combine(DestPath, file1.Name), True)
                Return True
            Else
                Return True
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function DeleteFile(ByVal sourcepath As String)
        Try
            If File.Exists(sourcepath) Then
                File.Delete(sourcepath)
                Return True
            Else
                Return True
            End If
        Catch ex As Exception
            Return False
        End Try
    End Function
    
End Class