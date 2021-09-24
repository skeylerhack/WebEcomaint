Imports System.IO
Imports System.Data.SqlClient

Public Class FrmExportExcel
    Private Loai As Integer = -1
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal TT As Integer)
        ' This call is required by the Windows Form Designer.
        InitializeComponent()
        ' Add any initialization after the InitializeComponent() call.
        Loai = TT
    End Sub
    Private Sub SimpleButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton1.Click
        Select Case Loai
            Case 0 'ReportGeneral
                'Call Function Export Excel ReportGeneral
                ReportGeneral(Application.StartupPath & "\Template\2015Report.xlsx")
            Case 1 'CommitteMeeting
                'Call Function Export Excel CommitteMeeting
                CommitteMeeting(Application.StartupPath & "\Template\CommitteMeetingTemplate.xls")
            Case 2 'AnalysisTrenching
                'Call Function Export Excel AnalysisTrenching
                AnalysisTrenching(Application.StartupPath & "\Template\AnalysisTrenchingTemplate.xls")
            Case 3 'StopCard Report
                'Call Function Export Excel StopChart
                StopChart(Application.StartupPath & "\Template\StopChartTemplate.xls")
        End Select
    End Sub
    Public Function ReportInternal() As DataTable
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("External", "False")
            sqlcom.Parameters.AddWithValue("Year", dtYear.Text)

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_2015Report"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Return ds.Tables(0)
        Catch generatedExceptionName As Exception
            Return New DataTable
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Function ReportExternal() As DataTable
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("External", "True")
            sqlcom.Parameters.AddWithValue("Year", dtYear.Text)

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_2015Report"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Return ds.Tables(0)
        Catch generatedExceptionName As Exception
            Return New DataTable
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Private Function ExcelColName(ByVal columnNumber As Integer) As String
        Dim dividend As Integer = columnNumber
        Dim columnName As String = [String].Empty
        Dim modulo As Integer

        While dividend > 0
            modulo = (dividend - 1) Mod 26
            columnName = Convert.ToChar(65 + modulo).ToString() & columnName
            dividend = CInt((dividend - modulo) / 26)
        End While
        Return columnName
    End Function
    Private Function GetRawData(ByVal dr As DataRow, ByVal CotBD As Integer, ByVal CotKT As Integer)
        Dim rawData As Object(,) = New Object(1, (CotKT - CotBD)) {}
        Dim vtbd As Integer = CotBD - 1
        For col = 0 To (CotKT - CotBD)
            rawData(0, col) = dr(vtbd).ToString()
            vtbd = vtbd + 1
        Next
        Return rawData
    End Function
    Private Sub SetRangeData(ByVal xlWorkSheet As Excel.Worksheet, ByVal Dong As Integer, ByVal CotBD As Integer, ByVal CotKT As Integer, ByVal rawData As Object(,))
        Dim excelRange As String = String.Format(ExcelColName(CotBD) & Dong.ToString() + ":{0}{1}", ExcelColName(CotKT), Dong)
        xlWorkSheet.Range(excelRange, Type.Missing).Value2 = rawData
    End Sub
    Private Sub SetRangeData(ByVal xlWorkSheet As Excel.Worksheet, ByVal tbSource As DataTable, ByVal Dong As Integer)
        Dim rawData(tbSource.Rows.Count, tbSource.Columns.Count - 1) As Object
        For col = 0 To tbSource.Columns.Count - 1
            rawData(0, col) = tbSource.Columns(col).ColumnName.ToUpper
        Next
        For col = 0 To tbSource.Columns.Count - 1
            For row = 0 To tbSource.Rows.Count - 1
                rawData(row + 1, col) = tbSource.Rows(row).ItemArray(col)
            Next
        Next

        Dim finalColLetter As String = String.Empty
        finalColLetter = ExcelColName(tbSource.Columns.Count + 1)

        Dim excelRange As String = String.Format("B" & Dong.ToString() & ":{0}{1}", _
                       finalColLetter, Dong + tbSource.Rows.Count)
        xlWorkSheet.Range(excelRange, Type.Missing).Value2 = rawData
        'xlWorkSheet.Range(xlWorkSheet.Cells(11, 1), xlWorkSheet.Cells(11, 13)).Delete()
        'xlWorkSheet.Range(xlWorkSheet.Cells(11 + tbSource.Rows.Count, 1), xlWorkSheet.Cells(11 + tbSource.Rows.Count, 13)).Delete()
    End Sub
    Private Sub OpenExcel(ByVal FileName As String)
        Dim xlApp As Excel.Application = Nothing
        Dim xlWorkBooks As Excel.Workbooks = Nothing
        Dim xlWorkBook As Excel.Workbook = Nothing
        Dim xlWorkSheet As Excel.Worksheet = Nothing
        Dim xlWorkSheets As Excel.Sheets = Nothing
        Dim xlCells As Excel.Range = Nothing
        xlApp = New Excel.Application
        xlApp.DisplayAlerts = False
        xlWorkBooks = xlApp.Workbooks
        xlWorkBook = xlWorkBooks.Open(FileName)
        xlWorkSheets = xlWorkBook.Sheets
        xlApp.Visible = True
    End Sub
    Public Sub ReportGeneral(ByVal FileName As String)
        Try
            If IO.File.Exists(FileName) Then
                Dim dongcancel As String = "4,6,8,9,13,17,21,25,29,33,35,36,38,41,42,44,46,48,50,52,54,56,58,60,62,64,66,68"
                Dim dongcancel2 As String = "4,6,8,9,13,17,21,25,29,33,35,36,40,41,43"
                Dim Proceed As Boolean = False
                Dim xlApp As Excel.Application = Nothing
                Dim xlWorkBooks As Excel.Workbooks = Nothing
                Dim xlWorkBook As Excel.Workbook = Nothing
                Dim xlWorkSheet As Excel.Worksheet = Nothing
                Dim xlWorkSheets As Excel.Sheets = Nothing
                Dim xlCells As Excel.Range = Nothing
                xlApp = New Excel.Application
                xlApp.DisplayAlerts = False
                xlWorkBooks = xlApp.Workbooks
                xlWorkBook = xlWorkBooks.Open(FileName)
                xlWorkSheets = xlWorkBook.Sheets
                Me.Cursor = Cursors.WaitCursor

                For x As Integer = 1 To xlWorkSheets.Count
                    xlWorkSheet = CType(xlWorkSheets(x), Excel.Worksheet)
                    xlWorkSheet.Activate()

                    If x = 1 Then
                        xlWorkSheet.Cells(2, 2) = dtYear.Text
                        Dim tbInternal As DataTable = ReportInternal()
                        For Each dr As DataRow In tbInternal.Rows
                            If CheckExistsRow(dongcancel, dr(0).ToString()) = False Then
                                SetRangeData(xlWorkSheet, dr(0), 4, 15, GetRawData(dr, 4, 15))
                                'For j As Integer = 4 To 15
                                '    xlWorkSheet.Cells(i, j).Formula = ""
                                'Next
                            End If

                        Next

                        'For i As Integer = 3 To 73
                        '    If CheckExistsRow(dongcancel, i.ToString()) = False Then
                        '        SetRangeData(xlWorkSheet, i, 4, 15)
                        '        'For j As Integer = 4 To 15
                        '        '    xlWorkSheet.Cells(i, j).Formula = ""
                        '        'Next
                        '    End If
                        'Next
                    ElseIf x = 2 Then
                        xlWorkSheet.Cells(2, 2) = dtYear.Text
                        Dim tbExternal As DataTable = ReportExternal()
                        For Each dr As DataRow In tbExternal.Rows
                            If CheckExistsRow(dongcancel2, dr(0).ToString()) = False Then
                                SetRangeData(xlWorkSheet, dr(0), 4, 15, GetRawData(dr, 4, 15))
                                'For j As Integer = 4 To 15
                                '    xlWorkSheet.Cells(i, j).Formula = ""
                                'Next
                            End If

                        Next
                        'For i As Integer = 3 To 43
                        '    If CheckExistsRow(dongcancel2, i.ToString()) = False Then
                        '        'SetRangeData(xlWorkSheet, i, 4, 15, GetRawData(dr, 4, 15))
                        '        ''For j As Integer = 4 To 15
                        '        ''    xlWorkSheet.Cells(i, j).Formula = ""
                        '        ''Next
                        '    End If
                        'Next
                    Else
                        xlWorkSheet.Cells(2, 2) = dtYear.Text
                    End If

                    Runtime.InteropServices.Marshal.FinalReleaseComObject(xlWorkSheet)
                    xlWorkSheet = Nothing
                Next
                Me.Cursor = Cursors.Default
                'xlApp.Visible = True
                If File.Exists(Application.StartupPath & "\ExportExcel\2015_RES.xlsx") Then
                    File.Delete(Application.StartupPath & "\ExportExcel\2015_RES.xlsx")
                End If
                xlWorkBook.SaveCopyAs(Application.StartupPath & "\ExportExcel\2015_RES.xlsx")
                'SetAttribute(Application.StartupPath & "\2015_RES.xlsx")
                xlWorkBook.Close()
                xlApp.UserControl = True
                xlApp.Quit()

                ReleaseComObject(xlCells)
                ReleaseComObject(xlWorkSheets)
                ReleaseComObject(xlWorkSheet)
                ReleaseComObject(xlWorkBook)
                ReleaseComObject(xlWorkBooks)
                ReleaseComObject(xlApp)

                OpenExcel(Application.StartupPath & "\ExportExcel\2015_RES.xlsx")

                'If MessageBox.Show("Báo cáo đã được lưu tại [" & Application.StartupPath & "\ExportExcel\2015_RES.xlsx" & "].Bạn có muốn mở báo cáo đã xuất không?", "", MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
                '    OpenExcel(Application.StartupPath & "\ExportExcel\2015_RES.xlsx")
                'End If
            Else
                MessageBox.Show("Không tìm thấy Template!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub AnalysisTrenching(ByVal FileName As String)
        Try
            If IO.File.Exists(FileName) Then

                Try

                    Dim dt As New DataTable()
                    Dim TB1 As New DataTable()
                    Dim TB2 As New DataTable()
                    Dim TB3 As New DataTable()
                    Dim TB4 As New DataTable()
                    Dim TB5 As New DataTable()
                    Dim TB6 As New DataTable()
                    Dim TB7 As New DataTable()
                    Dim TB8 As New DataTable()
                    Dim TB9 As New DataTable()
                    Dim TB10 As New DataTable()
                    Dim TB11 As New DataTable()
                    Dim TB12 As New DataTable()
                    Dim TB13 As New DataTable()
                    Dim TB14 As New DataTable()
                    Dim TB15 As New DataTable()
                    Dim TB16 As New DataTable()

                    Dim sqlcom As New SqlCommand()
                    Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
                    If con.State = ConnectionState.Closed Then
                        con.Open()
                    End If
                    sqlcom.Connection = con

                    sqlcom.Parameters.AddWithValue("Year", dtYear.Text)

                    sqlcom.CommandType = CommandType.StoredProcedure
                    sqlcom.CommandText = "VS_ST_Accident_Incident_Analysis"
                    Dim da As New SqlDataAdapter(sqlcom)
                    Dim ds As New DataSet()
                    da.Fill(ds)
                    If ds.Tables.Count > 0 Then
                        TB1 = ds.Tables(0)
                        TB2 = ds.Tables(1)
                        TB3 = ds.Tables(2)
                        TB4 = ds.Tables(3)
                        TB5 = ds.Tables(4)
                        TB6 = ds.Tables(5)
                        TB7 = ds.Tables(6)
                        TB8 = ds.Tables(7)
                        TB9 = ds.Tables(8)
                        TB10 = ds.Tables(9)
                        TB11 = ds.Tables(10)
                        TB12 = ds.Tables(11)
                        TB13 = ds.Tables(12)
                        TB14 = ds.Tables(13)
                        TB15 = ds.Tables(14)
                        TB16 = ds.Tables(15)


                        Dim xlApp As Excel.Application = Nothing
                        Dim xlWorkBooks As Excel.Workbooks = Nothing
                        Dim xlWorkBook As Excel.Workbook = Nothing
                        Dim xlWorkSheet As Excel.Worksheet = Nothing
                        Dim xlWorkSheets As Excel.Sheets = Nothing
                        Dim xlCells As Excel.Range = Nothing
                        xlApp = New Excel.Application
                        xlApp.DisplayAlerts = False
                        xlWorkBooks = xlApp.Workbooks
                        xlWorkBook = xlWorkBooks.Open(FileName)
                        xlWorkSheets = xlWorkBook.Sheets
                        Me.Cursor = Cursors.WaitCursor
                        xlWorkSheet = CType(xlWorkSheets(1), Excel.Worksheet)
                        xlWorkSheet.Activate()
                        xlWorkSheet.Cells(1, 2) = "ACCIDENT/INCIDENT " & dtYear.Text & vbNewLine & "Analysis and Trenching"
                        'Xuat du lieu Type of Accident dong bat dau 3
                        SetRangeData(xlWorkSheet, TB1, 3)
                        'Xuat du lieu Incident Area dong bat dau 16
                        SetRangeData(xlWorkSheet, TB2, 16)
                        'Xuat du lieu Pontential Severity dong bat dau 26
                        SetRangeData(xlWorkSheet, TB3, 26)
                        'Xuat du lieu Basic Causes dong bat dau 32
                        SetRangeData(xlWorkSheet, TB4, 32)
                        'Xuat du lieu Day of the Week dong bat dau 43
                        SetRangeData(xlWorkSheet, TB5, 43)
                        'Xuat du lieu Working Time dong bat dau 52
                        SetRangeData(xlWorkSheet, TB6, 52)
                        'Xuat du lieu Environment dong bat dau 56
                        SetRangeData(xlWorkSheet, TB7, 56)
                        'Xuat du lieu Injury Parts of Body dong bat dau 72
                        SetRangeData(xlWorkSheet, TB8, 72)
                        'Xuat du lieu Age of people injured/ill dong bat dau 85
                        SetRangeData(xlWorkSheet, TB9, 85)
                        'Xuat du lieu Experience in Present Job/Title dong bat dau 92
                        SetRangeData(xlWorkSheet, TB10, 92)
                        'Xuat du lieu Unsafe Condition dong bat dau 104
                        SetRangeData(xlWorkSheet, TB11, 104)
                        'Xuat du lieu Unsafe Act dong bat dau 118
                        SetRangeData(xlWorkSheet, TB12, 118)
                        'Xuat du lieu Operation Status dong bat dau 135
                        SetRangeData(xlWorkSheet, TB13, 135)
                        'Xuat du lieu Incident Type dong bat dau 143
                        SetRangeData(xlWorkSheet, TB14, 143)
                        'Xuat du lieu Source of Injury (1) dong bat dau 157
                        SetRangeData(xlWorkSheet, TB15, 157)
                        'Xuat du lieu Source of Injury (2) dong bat dau 176
                        SetRangeData(xlWorkSheet, TB16, 176)


                        Me.Cursor = Cursors.Default
                        'xlApp.Visible = True
                        If File.Exists(Application.StartupPath & "\ExportExcel\AnalysisTrenching.xls") Then
                            File.Delete(Application.StartupPath & "\ExportExcel\AnalysisTrenching.xls")
                        End If
                        xlWorkBook.SaveCopyAs(Application.StartupPath & "\ExportExcel\AnalysisTrenching.xls")

                        xlWorkBook.Close()
                        xlApp.UserControl = True
                        xlApp.Quit()

                        ReleaseComObject(xlCells)
                        ReleaseComObject(xlWorkSheets)
                        ReleaseComObject(xlWorkSheet)
                        ReleaseComObject(xlWorkBook)
                        ReleaseComObject(xlWorkBooks)
                        ReleaseComObject(xlApp)
                        OpenExcel(Application.StartupPath & "\ExportExcel\AnalysisTrenching.xls")

                    End If
                Catch generatedExceptionName As Exception

                
                End Try
            Else
                MessageBox.Show("Không tìm thấy Template!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub StopChart(ByVal FileName As String)
        Try
            If IO.File.Exists(FileName) Then

                Try

                    Dim dt As New DataTable()
                    Dim TB1 As New DataTable()
                    Dim TB2 As New DataTable()
                    Dim TB3 As New DataTable()
                    Dim TB4 As New DataTable()
                    Dim TB5 As New DataTable()
                    Dim TB6 As New DataTable()
                   

                    Dim sqlcom As New SqlCommand()
                    Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
                    If con.State = ConnectionState.Closed Then
                        con.Open()
                    End If
                    sqlcom.Connection = con

                    sqlcom.Parameters.AddWithValue("Year", dtYear.Text)

                    sqlcom.CommandType = CommandType.StoredProcedure
                    sqlcom.CommandText = "VS_ST_Stop_Chart"
                    Dim da As New SqlDataAdapter(sqlcom)
                    Dim ds As New DataSet()
                    da.Fill(ds)
                    If ds.Tables.Count > 0 Then
                        TB1 = ds.Tables(0)
                        TB2 = ds.Tables(1)
                        TB3 = ds.Tables(2)
                        TB4 = ds.Tables(3)
                        TB5 = ds.Tables(4)
                        TB6 = ds.Tables(5)
                       


                        Dim xlApp As Excel.Application = Nothing
                        Dim xlWorkBooks As Excel.Workbooks = Nothing
                        Dim xlWorkBook As Excel.Workbook = Nothing
                        Dim xlWorkSheet As Excel.Worksheet = Nothing
                        Dim xlWorkSheets As Excel.Sheets = Nothing
                        Dim xlCells As Excel.Range = Nothing
                        xlApp = New Excel.Application
                        xlApp.DisplayAlerts = False
                        xlWorkBooks = xlApp.Workbooks
                        xlWorkBook = xlWorkBooks.Open(FileName)
                        xlWorkSheets = xlWorkBook.Sheets
                        Me.Cursor = Cursors.WaitCursor
                        xlWorkSheet = CType(xlWorkSheets(1), Excel.Worksheet)
                        xlWorkSheet.Activate()
                        xlWorkSheet.Cells(1, 2) = "BEHAVIOR OBSERVATION " & dtYear.Text & vbNewLine & "Analysis and Trenching"
                        'Xuat du lieu Type of Accident dong bat dau 3
                        SetRangeData(xlWorkSheet, TB1, 3)
                        'Xuat du lieu Incident Area dong bat dau 13
                        SetRangeData(xlWorkSheet, TB2, 13)
                        'Xuat du lieu Pontential Severity dong bat dau 22
                        SetRangeData(xlWorkSheet, TB3, 22)
                        'Xuat du lieu Basic Causes dong bat dau 36
                        SetRangeData(xlWorkSheet, TB4, 36)
                        'Xuat du lieu Day of the Week dong bat dau 42
                        SetRangeData(xlWorkSheet, TB5, 42)
                        'Xuat du lieu Working Time dong bat dau 50
                        SetRangeData(xlWorkSheet, TB6, 50)
                        

                        Me.Cursor = Cursors.Default
                        'xlApp.Visible = True
                        If File.Exists(Application.StartupPath & "\ExportExcel\StopChart.xls") Then
                            File.Delete(Application.StartupPath & "\ExportExcel\StopChart.xls")
                        End If
                        xlWorkBook.SaveCopyAs(Application.StartupPath & "\ExportExcel\StopChart.xls")

                        xlWorkBook.Close()
                        xlApp.UserControl = True
                        xlApp.Quit()

                        ReleaseComObject(xlCells)
                        ReleaseComObject(xlWorkSheets)
                        ReleaseComObject(xlWorkSheet)
                        ReleaseComObject(xlWorkBook)
                        ReleaseComObject(xlWorkBooks)
                        ReleaseComObject(xlApp)
                        OpenExcel(Application.StartupPath & "\ExportExcel\StopChart.xls")

                    End If
                Catch generatedExceptionName As Exception


                End Try
            Else
                MessageBox.Show("Không tìm thấy Template!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Public Sub CommitteMeeting(ByVal FileName As String)
        Try
            If IO.File.Exists(FileName) Then

                Try

                    Dim dt As New DataTable()
                    Dim TB1 As New DataTable()
                    Dim TB2 As New DataTable()
                    Dim TB3 As New DataTable()
                    Dim TB4 As New DataTable()



                    Dim sqlcom As New SqlCommand()
                    Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
                    If con.State = ConnectionState.Closed Then
                        con.Open()
                    End If
                    sqlcom.Connection = con

                    sqlcom.Parameters.AddWithValue("Year", dtYear.Text)

                    sqlcom.CommandType = CommandType.StoredProcedure
                    sqlcom.CommandText = "VS_ST_Committe_Meeting"
                    Dim da As New SqlDataAdapter(sqlcom)
                    Dim ds As New DataSet()
                    da.Fill(ds)
                    If ds.Tables.Count > 0 Then
                        TB1 = ds.Tables(0)
                        TB2 = ds.Tables(1)
                        TB3 = ds.Tables(2)
                        TB4 = ds.Tables(3)




                        Dim xlApp As Excel.Application = Nothing
                        Dim xlWorkBooks As Excel.Workbooks = Nothing
                        Dim xlWorkBook As Excel.Workbook = Nothing
                        Dim xlWorkSheet As Excel.Worksheet = Nothing
                        Dim xlWorkSheets As Excel.Sheets = Nothing
                        Dim xlCells As Excel.Range = Nothing
                        xlApp = New Excel.Application
                        xlApp.DisplayAlerts = False
                        xlWorkBooks = xlApp.Workbooks
                        xlWorkBook = xlWorkBooks.Open(FileName)
                        xlWorkSheets = xlWorkBook.Sheets
                        Me.Cursor = Cursors.WaitCursor
                        xlWorkSheet = CType(xlWorkSheets(1), Excel.Worksheet)
                        xlWorkSheet.Activate()

                        'Xuat du lieu Type of Accident dong bat dau 5
                        SetRangeData(xlWorkSheet, TB1, 5)
                        'Xuat du lieu Incident Area dong bat dau 20
                        SetRangeData(xlWorkSheet, TB2, 20)
                        'Xuat du lieu Pontential Severity dong bat dau 34
                        SetRangeData(xlWorkSheet, TB3, 34)
                        'Xuat du lieu Basic Causes dong bat dau 48
                        SetRangeData(xlWorkSheet, TB4, 48)



                        Me.Cursor = Cursors.Default
                        'xlApp.Visible = True
                        If File.Exists(Application.StartupPath & "\ExportExcel\CommitteMeeting.xls") Then
                            File.Delete(Application.StartupPath & "\ExportExcel\CommitteMeeting.xls")
                        End If
                        xlWorkBook.SaveCopyAs(Application.StartupPath & "\ExportExcel\CommitteMeeting.xls")

                        xlWorkBook.Close()
                        xlApp.UserControl = True
                        xlApp.Quit()

                        ReleaseComObject(xlCells)
                        ReleaseComObject(xlWorkSheets)
                        ReleaseComObject(xlWorkSheet)
                        ReleaseComObject(xlWorkBook)
                        ReleaseComObject(xlWorkBooks)
                        ReleaseComObject(xlApp)
                        OpenExcel(Application.StartupPath & "\ExportExcel\CommitteMeeting.xls")

                    End If
                Catch generatedExceptionName As Exception


                End Try
            Else
                MessageBox.Show("Không tìm thấy Template!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
            End If
        Catch ex As Exception
            MsgBox(ex.Message)
        End Try
    End Sub
    Private Sub SetAttribute(ByVal path As String)
        ' Create the file if it does not exist.
        If File.Exists(path) = False Then
            File.Create(path)
        End If

        Dim attributes As FileAttributes
        attributes = File.GetAttributes(path)

        If (attributes And FileAttributes.Hidden) = FileAttributes.Hidden Then
            ' Show the file.
            attributes = RemoveAttribute(attributes, FileAttributes.Hidden)
            File.SetAttributes(path, attributes)
        Else
            ' Hide the file.
            File.SetAttributes(path, File.GetAttributes(path) Or FileAttributes.Hidden)
        End If
    End Sub

    Public Shared Function RemoveAttribute(ByVal attributes As FileAttributes, ByVal attributesToRemove As FileAttributes) As FileAttributes
        Return attributes And (Not attributesToRemove)
    End Function

    Private Function CheckExistsRow(ByVal mangdong As String, ByVal row As String)
        Try
            Dim s As String() = mangdong.Split(",")
            For i As Integer = 0 To s.Length - 1
                If s(i) = row Then
                    Return True
                End If
            Next
            Return False
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Sub ReleaseComObject(ByVal obj As Object)
        Try
            System.Runtime.InteropServices.Marshal.ReleaseComObject(obj)
            obj = Nothing
        Catch ex As Exception
            obj = Nothing
        End Try
    End Sub

    Private Sub SimpleButton2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SimpleButton2.Click
        Me.Close()
    End Sub

    Private Sub FrmExportExcel_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
    End Sub
End Class