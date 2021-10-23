Imports System.IO
Imports System.Net.Sockets
Imports System.Text
Imports System.Net
Imports System.Threading
Imports Microsoft.Win32
Imports DevExpress.LookAndFeel
Imports DevExpress.UserSkins
Imports DevExpress.Skins
Imports SafetyPlanModule

Module CMMS_Main


    <STAThread()>
    Public Sub Main()

        Application.EnableVisualStyles()
        Application.SetCompatibleTextRenderingDefault(False)

        BonusSkins.Register()
        SkinManager.EnableFormSkins()
        UserLookAndFeel.Default.SetSkinStyle("Blue")

        Dim myHost As String = System.Net.Dns.GetHostName
        Try


            If File.Exists(Application.StartupPath + "\VSConfig.ini") Then
                Dim sFileInclude = System.IO.File.OpenText(Application.StartupPath + "\VSConfig.ini")
                Try
                    Dim sRowStream As String = sFileInclude.ReadToEnd()
                    sRowStream = Commons.clsXuLy.GiaiMaDL(sRowStream)
                    Dim sArr() As String = Split(sRowStream, "!")
                    Commons.IConnections.Server = sArr(0)
                    Commons.IConnections.Database = sArr(1)
                    Commons.IConnections.Username = sArr(2)
                    Commons.IConnections.Password = sArr(3)
                    'Commons.IConnections.Server = "."
                    'Commons.IConnections.Database = "CMMS_BARIA"
                    'Commons.IConnections.Username = "sa"
                    'Commons.IConnections.Password = "123"

                    Try

                        Dim regKey As RegistryKey
                        Try
                            regKey = Registry.CurrentUser.OpenSubKey("Software", True)
                            regKey.CreateSubKey("VS_SAFETY")
                            regKey.Close()
                        Catch ex As Exception

                        End Try




                        Dim ver As Integer
                        regKey = Registry.CurrentUser.OpenSubKey("Software\VS_SAFETY", True)
                        regKey.SetValue("VS_SAFETY", "SAFETY")
                        ver = regKey.GetValue("TypeLanguage", 0)
                        If ver = 0 Then
                            regKey.SetValue("TypeLanguage", Commons.Modules.TypeLanguage)
                            Commons.Modules.TypeLanguage = Convert.ToInt32(sArr(4))
                        Else
                            Commons.Modules.TypeLanguage = ver
                        End If
                        regKey.Close()
                    Catch ex As Exception
                        Commons.Modules.TypeLanguage = Convert.ToInt32(sArr(4))
                    End Try




                    Commons.Modules._LicensePro = sArr(5)
                    Commons.Modules._LicenseProduction = sArr(8)
                    Commons.Modules._LicenseWarehouse = sArr(9)
                Catch Excep As Exception
                    sFileInclude.Dispose()
                    MsgBox(Excep.Message, MsgBoxStyle.OkOnly, "Config Messenger")
                    frmDoiServer.ShowDialog()
                    End
                    Return
                End Try
            Else
                End
                Return
            End If



            Dim MyThread As System.Threading.Thread
            MyThread = New System.Threading.Thread(AddressOf LaunchForm)
            MyThread.SetApartmentState(Threading.ApartmentState.STA)










            MyThread.Start()
        Catch ex As Exception
            MessageBox.Show("Sub main" + vbCrLf + ex.Message)
        End Try
    End Sub

    Public Sub CapNhapPM()

        MessageBox.Show("Bạn đang dùng phiên bản cũ, phần mềm sẽ tự động cập nhật.", "", MessageBoxButtons.OK)

        Dim vRegInfo As RegistryKey = Registry.CurrentUser.CreateSubKey("SOFTWARE\ECOMAINT\ECOMAINTKEY")
        Try
            If (CType(vRegInfo.GetValue("CNBB"), String).ToUpper.Equals("true".ToUpper)) Then
                CapNhapBB()
                vRegInfo.SetValue("CNBB", "False")
            End If
        Catch
            CapNhapBB()
            vRegInfo.SetValue("CNBB", "False")
        End Try


        Dim startInfo As New System.Diagnostics.ProcessStartInfo
        startInfo.UseShellExecute = True
        startInfo.WorkingDirectory = Environment.CurrentDirectory
        Dim sFileCN As String
        Dim sFileGF As String

        sFileCN = Application.StartupPath.ToString() + "CMMS Client.exe"
        sFileGF = Application.StartupPath.ToString() + "CMMS Client GF.exe"

        If File.Exists(sFileCN) Then
            startInfo.FileName = sFileCN
        Else
            startInfo.FileName = sFileGF
        End If

        'If File.Exists(Application.StartupPath.ToString() + "\CMMS Client.exe") Then
        '    startInfo.FileName = Application.StartupPath.ToString() + "\CMMS Client.exe"
        'Else
        '    startInfo.FileName = Application.StartupPath.ToString() + "\CMMS Client GF.exe"
        '    sFileCN = "CMMS Client GF.exe"
        'End If

        startInfo.Verb = "runas"
        Try
            System.Diagnostics.Process.Start(startInfo)
        Catch ex As Exception
            System.Diagnostics.Process.Start(sFileGF)
        End Try
        End
    End Sub

    Public Sub LaunchForm()
        Try
            Application.EnableVisualStyles()
            Application.SetCompatibleTextRenderingDefault(False)
            Application.Run(frmMain)
            'Dim frm As New FrmLeadershipDetails()
            'Application.Run(frm)
        Catch ex As Exception
            MessageBox.Show("main" & ex.Message)
        End Try
    End Sub

    Public Function KiemUpDate() As Boolean
        'Dim sInfoClient, sInfoServer As Double
        'Dim sIP As String
        'sIP = ""
        'Try
        '    sIP = LayDuLieu("Server.txt", "Server")
        '    sInfoClient = Convert.ToDouble(LayDuLieu("Version.txt", "Version"))
        '    Dim objClient As CMMSClientLib.CMMSClientDll
        '    objClient = New CMMSClientLib.CMMSClientDll("", "", "")
        '    objClient.iPServer = sIP
        '    Dim sInfo As String
        '    sInfo = objClient.ReceiveInfo(sIP)
        '    sInfoServer = Convert.ToDouble(sInfo)
        '    If sInfoServer > sInfoClient Then
        '        KiemUpDate = True
        '    Else
        '        KiemUpDate = False
        '    End If
        'Catch ex As Exception
        '    KiemUpDate = False
        '    MsgBox("Vui lòng kiểm tra lại Service update." + vbCrLf + ex.Message.ToString())
        'End Try

    End Function

    Public Sub CapNhapBB()
        Dim sr As New StreamReader(Application.StartupPath.ToString() + System.IO.Path.DirectorySeparatorChar & "Server.txt")
        Try
            Dim sIP As [String]
            sIP = sr.ReadLine()
            Dim outPath As String = Application.StartupPath.ToString() + "\" '.Replace("\\", "/") + "/"
            ReceiveFilesFromServer("CMMS Client.exe", sIP, outPath)
            ReceiveFilesFromServer("CMMS Client.exe", sIP, outPath)

            ReceiveFilesFromServer("CMMSClientLib.dll", sIP, outPath)
            ReceiveFilesFromServer("CMMSClientLib.dll", sIP, outPath)

            Try
                ReceiveFilesFromServer("CMMS Client GF.exe", sIP, outPath)
                ReceiveFilesFromServer("CMMS Client GF.exe", sIP, outPath)

                ReceiveFilesFromServer("CMMSClientGFLib.dll", sIP, outPath)
                ReceiveFilesFromServer("CMMSClientGFLib.dll", sIP, outPath)
            Catch ex As Exception

            End Try
        Catch
        End Try
        sr.Close()


        Try
            Dim startInfo As New System.Diagnostics.ProcessStartInfo
            startInfo.UseShellExecute = True
            startInfo.WorkingDirectory = Environment.CurrentDirectory

            If File.Exists("CMMS Client.exe") Then
                startInfo.FileName = Application.StartupPath.ToString() + "\CMMS Client.exe"
            Else
                startInfo.FileName = Application.StartupPath.ToString() + "\CMMS Client GF.exe"
            End If

            startInfo.Verb = "runas"
            Try
                System.Diagnostics.Process.Start(startInfo)
            Catch ex As Exception
                System.Diagnostics.Process.Start(Application.StartupPath.ToString() + "\CMMS Client GF.exe")
            End Try

            End
        Catch ex As Exception

        End Try
    End Sub

    Public Function KiemHDDSerial(ByVal HDDSerial As String) As Boolean
        Try
            Dim sIP As String
            sIP = LayDuLieu("SeHDD.txt", "Server")

            Dim objClient As CMMSClientLib.CMMSClientDll
            objClient = New CMMSClientLib.CMMSClientDll("", "", "")
            objClient.iPServer = sIP
            Dim sInfo As String
            sInfo = objClient.ReceiveHDDSerial(sIP)

            If HDDSerial.ToUpper.ToString().Trim() = sInfo.ToUpper.ToString().Trim() Then
                KiemHDDSerial = True
            Else
                KiemHDDSerial = False
            End If

        Catch ex As Exception
            KiemHDDSerial = False
            MsgBox("Vui lòng kiểm tra lại HDD Service update." + vbCrLf + ex.Message.ToString())
        End Try

    End Function

    Public Function LayDuLieu(ByVal TenFile As String, ByVal Chuoi As String) As String
        Dim sW As StreamWriter
        Dim sr As StreamReader
        Dim sText As String
        sText = ""
        Try
            sText = Application.StartupPath.ToString() + "\" + TenFile
            sr = New StreamReader(sText)
            sText = ""
            sText = sr.ReadLine
            Try
                If sText = Nothing Then
                    sText = ""
                End If

            Catch ex As Exception
                sText = ""
            End Try
            sr.Close()

            If String.IsNullOrEmpty(sText.ToString().Trim()) Then
                sText = InputBox("Please input " & Chuoi & ".")
                sW = New StreamWriter(Application.StartupPath.ToString() + "\" + TenFile)
                'writer.WriteLine(text);
                sW.WriteLine(sText)
                sW.Close()
                sr = New StreamReader(Application.StartupPath.ToString() + "\" + TenFile)
                sText = sr.ReadLine
                sr.Close()
            End If
        Catch ex As Exception
        End Try
        Return sText
    End Function

    Public progress As Integer = 0, portSend As Integer, portReceive As Integer

    Public Sub ReceiveFilesFromServer(ByVal onlyFileNameObj As Object, ByVal iPServer As String, ByVal outPath As String)
        Try
            ReadAndWriteFolder(onlyFileNameObj.ToString(), outPath)
            Dim server As Socket = Nothing
            Dim ipEnd As New IPEndPoint(IPAddress.Parse(iPServer), 9051)
            server = New Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.IP)
            server.Connect(ipEnd)

            Dim onlyFileName As String = onlyFileNameObj.ToString()
            onlyFileName = onlyFileName.Replace("#", "")
            onlyFileName = onlyFileName.Replace("...", "")

            'Send file can nhan cho Server.
            Dim clientInfoData As Byte() = New Byte(255) {}
            clientInfoData = Encoding.ASCII.GetBytes(onlyFileName)
            server.Send(clientInfoData)
            'Nhan file tu Server.
            Dim receiveData As Byte() = New Byte(255) {}
            Dim recvLen As Integer = server.Receive(receiveData)
            Dim BuffLen As Integer = Integer.Parse(Encoding.ASCII.GetString(receiveData, 0, recvLen))
            Dim data As Byte() = New Byte(BuffLen - 1) {}
            'DATA FORMAT: [FILE SIZE LEN INFO[0-3]][FILE NAME LEN INFO[4-7]][FILE NAME DATA][FILE CONTENT]
            'int len = server.Receive(data, server.Available, SocketFlags.None);

            Receive(server, data, 0, data.Length, 10000)
            Dim len As Integer = data.Length

            Dim fileNameLen_h As Integer = BitConverter.ToInt32(data, 0)
            Dim fileName_h As String = Encoding.ASCII.GetString(data, 4, fileNameLen_h)
            Try
                If File.Exists(outPath & onlyFileName) Then
                    File.Delete(outPath & onlyFileName)
                End If
            Catch
            End Try

            Try
                Dim bWrite As New BinaryWriter(File.Open(outPath & onlyFileName, FileMode.Append))
                bWrite.Write(data, 4 + fileNameLen_h, len - 4 - fileNameLen_h)
                bWrite.Flush()
                bWrite.Close()
            Catch
                Try
                    Dim bWrite As New BinaryWriter(File.Open(outPath & onlyFileName, FileMode.CreateNew))
                    bWrite.Write(data, 4 + fileNameLen_h, len - 4 - fileNameLen_h)
                    bWrite.Flush()
                    bWrite.Close()
                Catch
                End Try
            End Try


            Try
                Dim sStmp As String = ReceiveFileInfo(onlyFileName, iPServer)
                Dim chuoi_tach As String() = sStmp.Split(New [Char]() {"|"c})

                File.SetCreationTime(outPath + onlyFileName, Convert.ToDateTime(chuoi_tach(0).ToString()))
                File.SetLastWriteTime(outPath + onlyFileName, Convert.ToDateTime(chuoi_tach(1).ToString()))
                File.SetLastAccessTime(outPath + onlyFileName, Convert.ToDateTime(chuoi_tach(2).ToString()))
            Catch
            End Try

            server.Shutdown(SocketShutdown.Both)
            server.Close()
        Catch
        End Try
    End Sub

    Public Sub ReadAndWriteFolder(ByVal _fileName As String, ByVal outPath As String)
        Try
            _fileName = _fileName.Replace("#", "")
            _fileName = _fileName.Replace("...", "")
            Dim _tmpPath As String = ""
            Dim _tmpFileName As String = _fileName
            While _tmpFileName.IndexOf("\") <> -1
                _tmpPath += _tmpFileName.Substring(0, _tmpFileName.IndexOf("\")) + "/"
                _tmpFileName = _tmpFileName.Substring(_tmpFileName.IndexOf("\") + 1)
            End While
            _tmpPath = _tmpPath.Trim().Substring(0, _tmpPath.Length - 1)
            If Not Directory.Exists(outPath & _tmpPath) Then
                Directory.CreateDirectory(outPath & _tmpPath)
            End If
        Catch
        End Try
    End Sub


    Public Sub Receive(ByVal socket As Socket, ByVal buffer As Byte(), ByVal offset As Integer, ByVal size As Integer, ByVal timeout As Integer)
        Dim startTickCount As Integer = Environment.TickCount
        Dim received As Integer = 0
        ' how many bytes is already received
        Do
            If Environment.TickCount > startTickCount + timeout Then
                Throw New Exception("Timeout.")
            End If
            Try
                received += socket.Receive(buffer, offset + received, size - received, SocketFlags.None)
            Catch ex As SocketException
                If ex.SocketErrorCode = SocketError.WouldBlock OrElse ex.SocketErrorCode = SocketError.IOPending OrElse ex.SocketErrorCode = SocketError.NoBufferSpaceAvailable Then
                    ' socket buffer is probably empty, wait and try again
                    Thread.Sleep(30)
                Else
                    Throw ex
                    ' any serious error occurr
                End If
            End Try
        Loop While received < size
    End Sub


    Public Function ReceiveFileInfo(ByVal fileName As String, ByVal iPServer As String) As String
        Try
            Dim server As Socket = Nothing
            Dim ipEnd As New IPEndPoint(IPAddress.Parse(iPServer), 9051)
            Dim ipEnad As New IPEndPoint(IPAddress.Parse(iPServer), 9051)

            server = New Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.IP)
            server.Connect(ipEnd)

            Dim clientInfoData As Byte() = New Byte(255) {}
            clientInfoData = Encoding.ASCII.GetBytes(Convert.ToString("FI") & fileName)
            server.Send(clientInfoData)



            Dim receiveData As Byte() = New Byte(99999) {}
            Dim recvLen As Integer = server.Receive(receiveData)

            Dim s As String = Encoding.ASCII.GetString(receiveData).Substring(0, recvLen)

            server.Shutdown(SocketShutdown.Both)
            server.Close()
            Return s
        Catch
            Return ""
        End Try
    End Function
End Module