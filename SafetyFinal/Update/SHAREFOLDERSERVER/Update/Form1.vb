Imports System.IO
Imports System.Reflection
Imports System.Threading
Imports Ionic.Zip
Public Class Form1
    Private is_Extract As Boolean = False
    Dim p As New Protect
    Dim destination As String = Application.StartupPath & "/UpdateSafety"
    Private mk As String = "VS_SAFETY_2016"
    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

        If Directory.Exists(destination) Then
            Dim di As System.IO.DirectoryInfo = New DirectoryInfo(destination)
            Try
                For Each file As FileInfo In di.GetFiles()

                    file.Delete()

                Next
            Catch ex As Exception

            End Try
            Try
                For Each dir As DirectoryInfo In di.GetDirectories()
                    dir.Delete(True)
                Next
            Catch ex As Exception

            End Try

            Directory.Delete(destination)
            If File.Exists(Application.StartupPath & "/Safety.rar") Then
                File.Delete(Application.StartupPath & "/Safety.rar")
            End If
        End If

        If DownloadFileVersion() = True Then
            If CheckUpdateVersion() = True Then
                For Each P As Process In System.Diagnostics.Process.GetProcessesByName("SAFETY")
                    P.Kill()
                Next
            Else
                
                Application.ExitThread()
                Application.Exit()
            End If
        End If

        'If ExtractFile() = True Then
        '    is_Extract = True
        '    If CheckUpdateVersion() = True Then
        '        For Each P As Process In System.Diagnostics.Process.GetProcessesByName("SAFETY")
        '            P.Kill()
        '        Next
        '    Else
        '        Application.ExitThread()
        '        Application.Exit()
        '    End If
        'End If
        btnChon.Focus()
    End Sub
    Private Shared Function GetDirectorySize(ByVal parentDir As String) As String
        Dim totalFileSize As Long = 0

        Dim dirFiles As String() = Directory.GetFiles(parentDir, "*.*", System.IO.SearchOption.AllDirectories)

        For Each fileName As String In dirFiles
            ' Use FileInfo to get length of each file.
            Dim info As New FileInfo(fileName)
            totalFileSize = totalFileSize + info.Length
        Next
        Return totalFileSize.ToString()
    End Function

    Private Function CheckUpdateVersion()
        Dim client_vs As String = ""
        Dim server_vs As String = ""
        Dim flag As Boolean = False
        Dim pth As String() = destination.Split("/")
        If System.IO.File.Exists(Application.StartupPath & "/Version.txt") Then
            client_vs = IO.File.ReadAllText(Application.StartupPath & "/Version.txt")
            lbPhienbanHT.Text = client_vs
            flag = False
        Else
            lbPhienbanHT.Text = ""
            flag = True
        End If

        If System.IO.File.Exists(Application.StartupPath & "/" & pth(pth.Length - 1) & "/Version.txt") Then
            server_vs = IO.File.ReadAllText(Application.StartupPath & "/" & pth(pth.Length - 1) & "/Version.txt")
            lbPhienBanCN.Text = server_vs
            If flag = True Then
                'WriteRegistryKey("PathUpdate", Application.StartupPath & "/" & pth(pth.Length - 1))
                If ExtractFile() = True Then
                    is_Extract = True
                End If
                Return True
            End If
        Else
            lbPhienBanCN.Text = ""
            Return False
        End If

        If server_vs.Trim() <> client_vs.Trim() Then
            'WriteRegistryKey("PathUpdate", Application.StartupPath & "/" & pth(pth.Length - 1))
            If ExtractFile() = True Then
                is_Extract = True
            End If
            Return True
        Else
            Return False
        End If
    End Function

    Private Sub btnChon_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChon.Click
        UpdateFile()
        ProgressBarControl2.Text = 95
        If Directory.Exists(destination) Then
            Dim di As System.IO.DirectoryInfo = New DirectoryInfo(destination)
            Try
                For Each file As FileInfo In di.GetFiles()

                    file.Delete()

                Next
            Catch ex As Exception

            End Try
            Try
                For Each dir As DirectoryInfo In di.GetDirectories()
                    dir.Delete(True)
                Next
            Catch ex As Exception

            End Try
            Directory.Delete(destination)
            If File.Exists(Application.StartupPath & "/Safety.rar") Then
                File.Delete(Application.StartupPath & "/Safety.rar")
            End If
            If File.Exists(Application.StartupPath & "/Safety.zip") Then
                File.Delete(Application.StartupPath & "/Safety.zip")
            End If
        End If
        ProgressBarControl2.Text = 100
        For Each P As Process In System.Diagnostics.Process.GetProcessesByName("SAFETY")
            P.Kill()
        Next
        Process.Start(Application.StartupPath & "/SAFETY.exe")
        Me.Close()
    End Sub
    Public Sub XulyCopyFile(ByVal sourcepath As String, ByVal destination As String)
        Try
            Dim files() As String = IO.Directory.GetFiles(destination)
            For Each file As String In files
                If System.IO.Path.GetFileName(file) <> "Update.exe" Then
                    If System.IO.File.Exists(sourcepath & "/" & System.IO.Path.GetFileName(file)) Then

                        System.IO.File.Delete(sourcepath & "/" & System.IO.Path.GetFileName(file))
                    End If
                    If CType(ProgressBarControl2.Text, Integer) + 5 <= 65 Then
                        ProgressBarControl2.Text = CType(ProgressBarControl2.Text, Integer) + 5
                    End If
                    System.IO.File.Copy(file, sourcepath & "/" & System.IO.Path.GetFileName(file), True)
                End If
            Next
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
        
    End Sub
    'Public Sub XulyCopyUpdateExe(ByVal sourcepath As String, ByVal destination As String)

    '    Dim files() As String = IO.Directory.GetFiles(destination)
    '    For Each file As String In files
    '        If System.IO.Path.GetFileName(file) = "Update.exe" Then

    '            If System.IO.File.Exists(sourcepath & "/" & System.IO.Path.GetFileName(file)) Then
    '                System.IO.File.Delete(sourcepath & "/" & System.IO.Path.GetFileName(file))
    '            End If
    '            System.IO.File.Copy(file, sourcepath & "/" & System.IO.Path.GetFileName(file), True)
    '        End If
    '    Next
    'End Sub
    Private Function DownloadFileVersion()
        Try


            Dim source As String = "\\PMP-ECOMAIN\Data$\Data\Tailieumay\UpdateSafety\Version.txt"

            If System.IO.File.Exists(Application.StartupPath & "/UrlShare.ini") Then
                source = System.IO.File.ReadAllText(Application.StartupPath & "/UrlShare.ini").Trim() & "\UpdateSafety\Version.txt"
            End If

            ''Dim source As String = "\\PMP-ECOMAIN\Data$\Data\Tailieumay\UpdateSafety\Version.txt"
            If Not File.Exists(source) Then
                Return False
            End If
            If Not Directory.Exists(destination) Then
                Directory.CreateDirectory(destination)
            End If
            System.IO.File.Copy(source, destination & "\Version.txt", True)
            Return True
        Catch ex As Exception
            MsgBox(ex.Message)
            Return False
        End Try
    End Function
    Private Function DownloadFileUpdate()
        Try

            Dim source As String = "\\PMP-ECOMAIN\Data$\Data\Tailieumay\UpdateSafety\Safety.zip"
            'If System.IO.File.Exists(Application.StartupPath & "/UrlShare.ini") Then
            '    source = System.IO.File.ReadAllText(Application.StartupPath & "/UrlShare.ini").Trim() & "\UpdateSafety\Safety.zip"
            'End If

            ''System.IO.File.Copy(source, Application.StartupPath & "\Safety.rar", True)
            ''Dim f As New FileInfo(Application.StartupPath & "\Safety.rar")
            System.IO.File.Copy(source, Application.StartupPath & "\Safety.zip", True)
            Dim f As New FileInfo(Application.StartupPath & "\Safety.zip")
            lbDungluong.Text = Math.Round(f.Length / 1024, 0).ToString() & " KB"
            Return True
        Catch ex As Exception
            MsgBox(ex.Message)
            Return False
        End Try
    End Function
    Private Function ExtractFile()
        Try
            If DownloadFileUpdate() = True Then

                If Directory.Exists(destination) Then
                    Dim di As System.IO.DirectoryInfo = New DirectoryInfo(destination)
                    Try
                        For Each file As FileInfo In di.GetFiles()
                            file.Delete()
                        Next
                    Catch ex As Exception

                    End Try
                    Try
                        For Each dir As DirectoryInfo In di.GetDirectories()
                            dir.Delete(True)
                        Next
                    Catch ex As Exception

                    End Try

                    Directory.Delete(destination)

                End If


                'Dim source As String = Application.StartupPath & "\Safety.rar"
                Dim source As String = Application.StartupPath & "\Safety.zip"
                If File.Exists(source) Then

                    Dim zPath As String = "C:\Program Files\7-Zip\7zG.exe"
                    ' change the path and give yours 
                    Try
                        Dim zip As ZipFile = ZipFile.Read(source)
                        Using zip
                            zip.ExtractExistingFile = ExtractExistingFileAction.OverwriteSilently
                            zip.ExtractAll(destination)

                        End Using



                        'Dim pro As New ProcessStartInfo()
                        'pro.WindowStyle = ProcessWindowStyle.Hidden
                        'pro.FileName = zPath
                        'pro.Arguments = Convert.ToString((Convert.ToString("x """) & source) + """ -o") & destination
                        'Dim x As Process = Process.Start(pro)
                        'x.WaitForExit()
                        ''DO logic here 

                        If Not Directory.Exists(Application.StartupPath & "/TMP_UPDATE") Then
                            Directory.CreateDirectory(Application.StartupPath & "/TMP_UPDATE")
                        End If
                        Try
                            File.Copy(Application.StartupPath & "/UpdateSafety/Update.exe", Application.StartupPath & "/TMP_UPDATE/Update.exe", True)
                        Catch ex As Exception

                        End Try

                    Catch ex As Exception
                        MessageBox.Show(Me, "Vui lòng cài đặt phần mềm giải nén 7-Zip trước khi cập nhật", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.[Error])
                        Return False
                    End Try
                    Return True
                Else
                    Return False
                End If
            Else
                Return False
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
            Return False
        End Try
       
    End Function
    Public Sub UpdateFile()
        ' If the directory doesn't exist, create it.

        If Not Directory.Exists(destination) Then
            Directory.CreateDirectory(destination)
        End If
        Try
            ProgressBarControl2.Text = 20
            If is_Extract = False Then
                If ExtractFile() = True Then
                    Call XulyCopyFile(Application.StartupPath, destination)

                    ProgressBarControl2.Text = 70

                    Dim Dirs() As String = Directory.GetDirectories(destination)
                    For Each Dir As String In Dirs
                        Dim pth As String() = Dir.Split("\")
                        If pth.Length > 0 Then
                            Dim _path As String = Application.StartupPath & "/" & pth(pth.Length - 1)
                            If Not Directory.Exists(_path) Then
                                Directory.CreateDirectory(_path)
                            End If
                            Call XulyCopyFile(_path, Dir)
                        End If
                    Next
                End If
            Else
                ProgressBarControl2.Text = 20
                Call XulyCopyFile(Application.StartupPath, destination)
                Dim Dirs() As String = Directory.GetDirectories(destination)
                For Each Dir As String In Dirs
                    Dim pth As String() = Dir.Split("\")
                    If pth.Length > 0 Then
                        Dim _path As String = Application.StartupPath & "/" & pth(pth.Length - 1)
                        If Not Directory.Exists(_path) Then
                            Directory.CreateDirectory(_path)
                        End If
                        Call XulyCopyFile(_path, Dir)
                    End If
                Next
            End If
        Catch Ex As System.Exception
            MsgBox(Ex.Message)
        End Try
    End Sub


    Public Shared Function GetValueReg(ByVal key As Microsoft.Win32.RegistryKey, ByVal name As [String]) As [String]
        Try
            Return key.GetValue(name).ToString()
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Sub WriteRegistryKey(ByVal name As String, ByVal value As String)
        Try
            Try
                Microsoft.Win32.Registry.CurrentUser.DeleteValue(name)
            Catch ex As Exception

            End Try

            Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.CreateSubKey("SOFTWARE\SAFETY")
            key.SetValue(name, p.EnCrypt(value, mk))
        Catch generatedExceptionName As Exception
            MessageBox.Show(Me, "Write RegistryKey failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.[Error])
        End Try
    End Sub
    Private Function ReadRegistryKey(ByVal name As String)
        Dim version As String = ""
        Try
            Dim key As Microsoft.Win32.RegistryKey = Microsoft.Win32.Registry.CurrentUser.OpenSubKey("SOFTWARE\SAFETY")
            'if it does exist, retrieve the stored values  
            If key IsNot Nothing Then
                version = p.DeCrypt(GetValueReg(key, name).ToString(), mk)
                key.Close()
                Return version
            End If
            Return version
        Catch generatedExceptionName As Exception
            Return version
        End Try
    End Function
    Private Sub Form1_FormClosed(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles MyBase.FormClosed
        If Directory.Exists(destination) Then
            Dim di As System.IO.DirectoryInfo = New DirectoryInfo(destination)
            Try
                For Each file As FileInfo In di.GetFiles()

                    file.Delete()

                Next
            Catch ex As Exception

            End Try
            Try
                For Each dir As DirectoryInfo In di.GetDirectories()
                    dir.Delete(True)
                Next
            Catch ex As Exception

            End Try

            Directory.Delete(destination)
            If File.Exists(Application.StartupPath & "/Safety.zip") Then
                File.Delete(Application.StartupPath & "/Safety.zip")
            End If
        End If
    End Sub
End Class