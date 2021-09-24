Imports Microsoft.ApplicationBlocks.Data
Imports System.Data
Imports System.Windows.Forms

Public Class MLoadBaoCao
#Region "ucMailBaoTriDinhKyThangCS - BTDKTCS"
    'ByVal grd As DevExpress.XtraGrid.GridControl, ByVal grv As DevExpress.XtraGrid.Views.Grid.GridView
    Dim rcount As Integer = 3

    Public Function BTDKTCSInMailBaoTriDinhKyThangCS(ByVal dtSch As DataTable) As String
        Try
            'string sPath, SavePath;
            'sPath = Application.StartupPath + "\\" + dtSch.Rows[0]["ID_MAIL"].ToString() + "-" + dtSch.Rows[0]["ID"].ToString() + ".xls";
            'SavePath = Application.StartupPath;

            Dim sPath As String
            sPath = Application.StartupPath + "\" + dtSch.Rows(0)("ID_MAIL").ToString() + "-" + dtSch.Rows(0)("ID").ToString() + ".xls"



            Dim NNgu, iSNgay As Integer
            Dim sUserName, sDKBCao, sDKien As String
            Dim SauNgayBD As Boolean
            NNgu = Integer.Parse(dtSch.Rows(0)("NGON_NGU").ToString())
            sUserName = dtSch.Rows(0)("USERNAME").ToString()
            sDKBCao = dtSch.Rows(0)("DK_BAOCAO").ToString()
            'string[] chuoi_tach = sStmp.Split(new Char[] { ',' });

            Dim chuoi_tach As String() = sDKBCao.Split(New [Char]() {","c})
            Dim iTTrang As Integer
            Dim sDDiem, BTam As String
            Dim TNgay, DNgay As Date
            Dim dtTmp As New DataTable
            BTam = "AAA_BTDKCS_TMP" + sUserName

            If chuoi_tach.GetValue(0).ToString().Trim() = 0 Then SauNgayBD = False Else SauNgayBD = True
            iSNgay = Integer.Parse(chuoi_tach.GetValue(1).ToString().Trim())
            iTTrang = Integer.Parse(chuoi_tach.GetValue(2).ToString().Trim())
            If iTTrang = -1 Then iTTrang = 2
            sDDiem = chuoi_tach.GetValue(3).ToString().Trim()
            sDKien = chuoi_tach.GetValue(4).ToString().Trim()

            TNgay = Convert.ToDateTime("01/" + Now.Date.Month.ToString() + "/" + Now.Date.Year.ToString())

            If SauNgayBD = False Then
                iSNgay = -iSNgay
            End If
            TNgay = TNgay.AddMonths(Convert.ToDouble(iSNgay))
            DNgay = TNgay.AddMonths(Convert.ToDouble(1))

            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "SP_Y_GET_HE_THONG", _
                            sUserName, NNgu))

            Commons.Modules.ObjSystems.MCreateTableToDatatable(Commons.IConnections.ConnectionString, BTam, dtTmp, "")

            BTam = "AAA_BTDKCS" + sUserName
            Commons.Modules.ObjSystems.XoaTable(BTam)

            If sDKien <> "ALL" Then
                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, _
                                "SELECT * INTO " + BTam + " FROM AAA_BTDKCS_TMP" + sUserName + _
                                " WHERE MS_HE_THONG IN (" + sDKien.Replace("@", ",").Substring(0, sDKien.Length - 1) + ") ")
            Else
                SqlHelper.ExecuteNonQuery(Commons.IConnections.ConnectionString, CommandType.Text, _
                                "SELECT * INTO " + BTam + " FROM AAA_BTDKCS_TMP" + sUserName + " ")

            End If

            dtTmp = New DataTable
            dtTmp.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, "SELECT MS_HE_THONG ,TEN_HE_THONG  FROM " + BTam + " ORDER BY MS_HE_THONG"))


            Dim vTbData As System.Data.DataTable = New System.Data.DataTable()

            Dim cnn As SqlClient.SqlConnection = New SqlClient.SqlConnection(Commons.IConnections.ConnectionString)
            If (cnn.State = ConnectionState.Closed) Then
                cnn.Open()
            End If
            Try

                vTbData = BTDKTCSGet_DataTable_ALL(sDDiem, DNgay, "-1", "-1", "-1", sUserName)
                If (vTbData.Rows.Count > 0) Then
                    For Each row As DataRow In vTbData.Rows
                        Dim ngaychuky As DateTime
                        Dim ngaycuoi As DateTime
                        ngaychuky = row("NGAY_CUOI")
                        ngaycuoi = row("NGAY_CUOI")

                        While ngaychuky <= DNgay
                            If Not row("CHU_KY").Equals(DBNull.Value) Then
                                Select Case row("MS_DV_TG")
                                    Case 1
                                        ngaychuky = ngaychuky.AddDays(Double.Parse(row("CHU_KY").ToString))
                                    Case 2
                                        ngaychuky = ngaychuky.AddDays(Double.Parse(row("CHU_KY").ToString) * 7)
                                    Case 3
                                        ngaychuky = ngaychuky.AddMonths(Double.Parse(row("CHU_KY").ToString))
                                    Case 4
                                        ngaychuky = ngaychuky.AddYears(Double.Parse(row("CHU_KY").ToString))
                                End Select
                                If ngaychuky >= TNgay And ngaychuky <= DNgay Then
                                    If ngaychuky.DayOfWeek = DayOfWeek.Sunday Then
                                        ngaychuky = ngaychuky.AddDays(1)
                                    End If
                                    SqlHelper.ExecuteNonQuery(cnn, "Add_BTDK_TMP", row("MS_MAY"), row("MS_LOAI_BT"), ngaycuoi, ngaychuky, row("CHU_KY"), row("MS_DV_TG"), row("MS_HE_THONG"))
                                End If
                            Else
                                Exit While
                            End If
                        End While
                    Next
                Else
                    If (cnn.State = ConnectionState.Open) Then
                        cnn.Close()
                    End If
                    Return "KhongCoDuLieuIn"
                End If

                Dim tbTx As New System.Data.DataTable
                tbTx.Load(SqlHelper.ExecuteReader(cnn, CommandType.Text, "SELECT * FROM BTDK_TMP ORDER BY MS_MAY,MS_DV_TG,MS_LOAI_BT"))
                For Each rx As DataRow In tbTx.Rows

                    Dim tbT As New System.Data.DataTable
                    tbT.Load(SqlHelper.ExecuteReader(cnn, CommandType.Text, "SELECT * FROM BTDK_TMP	WHERE MS_MAY =N'" & rx("MS_MAY").ToString & "' AND MS_LOAI_BT IN (SELECT MS_LOAI_BT_CD FROM LOAI_BAO_TRI_QH WHERE MS_LOAI_BT_CT = " & rx("MS_LOAI_BT").ToString & ")"))

                    Dim ngayke1 As DateTime
                    ngayke1 = rx("NGAYKE")

                    For Each r2 As DataRow In tbT.Rows
                        Try
                            If Not rx("MS_DV_TG").Equals(DBNull.Value) Then
                                Dim ngayke2 As DateTime
                                Dim chuky As Double
                                ngayke2 = r2("NGAYKE")
                                chuky = Double.Parse(r2("MS_DV_TG").ToString)
                                Select Case chuky
                                    Case 1
                                        If ngayke1 >= ngayke2.AddDays(-(chuky / 4)) And ngayke1 <= ngayke2.AddDays(chuky / 4) Then
                                            SqlHelper.ExecuteNonQuery(cnn, "Delete_BTDK_TMP", r2("MS_MAY"), r2("MS_LOAI_BT"), r2("NGAYKE"), r2("MS_DV_TG"))
                                        End If
                                    Case 2
                                        If ngayke1 >= ngayke2.AddDays(-(chuky * 7 / 4)) And ngayke1 <= ngayke2.AddDays(chuky * 7 / 4) Then
                                            SqlHelper.ExecuteNonQuery(cnn, "Delete_BTDK_TMP", r2("MS_MAY"), r2("MS_LOAI_BT"), r2("NGAYKE"), r2("MS_DV_TG"))
                                        End If
                                    Case 3
                                        If ngayke1 >= ngayke2.AddMonths(-(chuky / 4)) And ngayke1 <= ngayke2.AddMonths(chuky / 4) Then
                                            SqlHelper.ExecuteNonQuery(cnn, "Delete_BTDK_TMP", r2("MS_MAY"), r2("MS_LOAI_BT"), r2("NGAYKE"), r2("MS_DV_TG"))
                                        End If
                                    Case 4
                                        If ngayke1 >= ngayke2.AddYears(-(chuky / 4)) And ngayke1 <= ngayke2.AddYears(chuky / 4) Then
                                            SqlHelper.ExecuteNonQuery(cnn, "Delete_BTDK_TMP", r2("MS_MAY"), r2("MS_LOAI_BT"), r2("NGAYKE"), r2("MS_DV_TG"))
                                        End If
                                End Select
                            Else
                                'Exit For
                            End If
                        Catch ex As Exception
                        End Try

                    Next
                Next

                Dim tbT1 As New System.Data.DataTable
                tbT1.Load(SqlHelper.ExecuteReader(cnn, "GET_BTCVBP"))
                For Each r As DataRow In tbT1.Rows
                    Dim tb2 As New System.Data.DataTable
                    Dim lstPhutung As String = ""
                    tb2.Load(SqlHelper.ExecuteReader(cnn, "GET_BTCVBP_TMP", r("MS_MAY"), r("MS_LOAI_BT"), r("MS_CV"), r("MS_BO_PHAN")))
                    For Each r1 As DataRow In tb2.Rows
                        If lstPhutung = "" Then
                            lstPhutung = r1("TEN_PT") & " " & r1("SO_LUONG") & " " & r1("DVT")
                        Else
                            lstPhutung = lstPhutung & ", " & r1("TEN_PT") & " " & r1("SO_LUONG") & " " & r1("DVT")
                        End If
                    Next
                    SqlHelper.ExecuteNonQuery(cnn, "ADD_CONG_VIEC_PHU_TUNG_LIST_TMP", r("MS_MAY").ToString, r("MS_LOAI_BT").ToString, r("MS_CV").ToString, r("MS_BO_PHAN").ToString, lstPhutung)

                Next

                vTbData = New System.Data.DataTable()

                vTbData = BTDKTCSGet_DataTable(sDDiem, iTTrang, TNgay, DNgay, "-1", "-1", "-1")
                rcount = 3
                If vTbData.Rows.Count > 0 Then
                    Dim sql As String = "(0"
                    For Each row As DataRow In dtTmp.Rows
                        sql = sql & "," & row("MS_HE_THONG").ToString()
                    Next

                    sql = sql & ")"
                    Dim tbdt As New System.Data.DataTable
                    vTbData.DefaultView.RowFilter = "MS_HE_THONG IN " & sql
                    tbdt = BTDKTCSGetParentBophan(vTbData.DefaultView.ToTable())
                    If vTbData.Rows.Count > 0 Then
                        BTDKTCSExportExcel(vTbData.DefaultView.ToTable(), dtTmp, TNgay.ToString("MM/yyyy"), sDDiem, sPath, NNgu)
                    Else
                        Return "KhongCoDuLieuIn"
                    End If
                Else
                    Return "KhongCoDuLieuIn"
                End If
                If (cnn.State = ConnectionState.Open) Then
                    cnn.Close()
                End If
            Catch ex As Exception
                If (cnn.State = ConnectionState.Open) Then
                    cnn.Close()
                End If
            End Try

            Return "True"
        Catch ex As Exception
            Return "False"
        End Try

    End Function

    Private Function BTDKTCSGetParentBophan(ByVal dt As System.Data.DataTable) As System.Data.DataTable
        Try
            Dim sMamay As String
            Dim sTenbp As String
            If dt.Rows.Count > 0 Then
                Dim i As Integer
                For i = 0 To dt.Rows.Count - 1
                    Dim sMabp As String
                    sTenbp = ""
                    sMabp = dt.Rows(i)("MS_BO_PHAN").ToString()
                    sMamay = dt.Rows(i)("MS_MAY").ToString()
                    sTenbp = BTDKTCSGetParent(sMabp, sMamay, sTenbp)
                    dt.Rows(i)("TEN_BO_PHAN") = sTenbp
                Next
            End If
            Return dt
        Catch ex As Exception
            Return Nothing
        End Try
    End Function

    Private Function BTDKTCSGetParent(ByVal mabp As String, ByVal msmay As String, ByVal sTenbp As String) As String
        Dim sql, mspbcha As String
        sql = "SELECT TEN_BO_PHAN,MS_BO_PHAN_CHA FROM CAU_TRUC_THIET_BI WHERE MS_BO_PHAN =N'" + mabp + "' AND MS_MAY = N'" + msmay + "'"
        Dim dt As System.Data.DataTable = New System.Data.DataTable()
        dt.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, CommandType.Text, sql))
        If dt.Rows.Count > 0 Then
            If sTenbp = "" Then
                sTenbp = dt.Rows(0)("TEN_BO_PHAN").ToString()
            Else
                sTenbp = dt.Rows(0)("TEN_BO_PHAN").ToString() + " >> " + sTenbp
            End If


            mspbcha = dt.Rows(0)("MS_BO_PHAN_CHA").ToString()
            If mspbcha <> msmay Then
                Return BTDKTCSGetParent(mspbcha, msmay, sTenbp)
            Else
                Return sTenbp
            End If
        End If

        Return ""
    End Function

    Function BTDKTCSGet_DataTable(ByVal MS_N_Xuong As String, ByVal antoan As Integer, ByVal tungay As Date, ByVal denngay As Date, ByVal ms_tinh As String, ByVal ms_quan As String, ByVal ms_duong As String) As System.Data.DataTable
        Dim objDataTable As System.Data.DataTable = New System.Data.DataTable
        objDataTable.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "[getBaoTriDinhDinhKyThang_CS]", antoan, tungay, denngay, MS_N_Xuong, ms_tinh, ms_quan, ms_duong))
        Return objDataTable

    End Function

    Function BTDKTCSGet_DataTable_ALL(ByVal MS_N_Xuong As String, ByVal denngay As Date, ByVal city As String, ByVal district As String, _
            ByVal street As String, ByVal sUserName As String) As System.Data.DataTable
        Dim objDataTable As System.Data.DataTable = New System.Data.DataTable
        objDataTable.Load(SqlHelper.ExecuteReader(Commons.IConnections.ConnectionString, "[getBaoTriDinhDinhKyThang_All]", denngay, MS_N_Xuong, sUserName, city, district, street))
        Return objDataTable

    End Function

    Private Sub BTDKTCSExportExcel(ByVal tbData As System.Data.DataTable, ByVal dtHeThong As DataTable, ByVal sThang As String, _
                            ByVal sDDiem As String, ByVal sPath As String, ByVal NNgu As Integer)
        Try

            Dim ExcelApp As New Excel.Application
            Dim ExcelBooks As Excel.Workbook
            Dim ExcelSheets As Excel.Worksheet
            ExcelApp.Visible = False
            ExcelBooks = ExcelApp.Workbooks.Add
            ExcelSheets = CType(ExcelBooks.Worksheets(1), Excel.Worksheet)


            With ExcelSheets
                .Range("A1", "AL1").Font.Bold = True
                .Range("A1", "AL1").Merge(True)
                .Range("A1", "AL1").MergeCells = True
                .Range("A1", "AL1").HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                .Range("A1", "AL1").VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                .Range("A1", "AL1").Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "titleBaotridinhkythang", NNgu)

                .Range("A2", "B2").Font.Bold = True
                .Range("A2", "B2").Merge(True)
                .Range("A2", "B2").MergeCells = True
                .Range("A2", "B2").HorizontalAlignment = Excel.XlHAlign.xlHAlignLeft
                .Range("A2", "B2").Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "Nhaxuong", NNgu) + " " + sDDiem
            End With

            For Each row As DataRow In dtHeThong.Rows
                tbData.DefaultView.RowFilter = "MS_HE_THONG = " & row("MS_HE_THONG").ToString()
                'row("MS_HE_THONG").ToString()
                If tbData.DefaultView.ToTable().Rows.Count > 0 Then
                    With ExcelSheets
                        .Range("A" & rcount.ToString, "G" & rcount.ToString).Font.Bold = True
                        .Range("A" & rcount.ToString, "G" & rcount.ToString).Merge(True)
                        .Range("A" & rcount.ToString, "G" & rcount.ToString).MergeCells = True
                        .Range("A" & rcount.ToString, "G" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignLeft
                        .Range("A" & rcount.ToString, "G" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "Daychuyen", NNgu) + " " + row("TEN_HE_THONG").ToString()

                        .Range("H" & rcount.ToString, "AL" & rcount.ToString).Font.Bold = True
                        .Range("H" & rcount.ToString, "AL" & rcount.ToString).Merge(True)
                        .Range("H" & rcount.ToString, "AL" & rcount.ToString).MergeCells = True
                        .Range("H" & rcount.ToString, "AL" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                        .Range("H" & rcount.ToString, "AL" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "Thang", NNgu) + " " + sThang
                    End With
                    rcount = rcount + 1
                    BTDKTCSAddHeader(ExcelSheets, sThang, NNgu)
                    rcount = rcount + 1
                    BTDKTCSAddDetail(tbData.DefaultView.ToTable(), ExcelSheets, sThang)
                    'rcount = rcount + 1
                End If
            Next

            'ExcelApp.Visible = True

            'ExcelBooks.SaveAs(sPath)
            ExcelApp.DisplayAlerts = False
            ExcelBooks.Save()
            ExcelBooks.SaveAs(sPath, Excel.XlFileFormat.xlWorkbookNormal, _
            Type.Missing, Type.Missing, Type.Missing, Type.Missing, _
            Excel.XlSaveAsAccessMode.xlExclusive, _
            Type.Missing, Type.Missing, Type.Missing, Type.Missing)

            ExcelBooks.Close(Type.Missing, Type.Missing, Type.Missing)
            ExcelApp.DisplayAlerts = False
            ExcelApp.Quit()
        Catch ex As Exception

        End Try

    End Sub
    'sThang truyen vao voi gia tri "MM/yyyy"
    Private Sub BTDKTCSAddHeader(ByVal ExcelSheets As Excel.Worksheet, ByVal sThang As String, ByVal NNgu As Integer)
        With ExcelSheets
            .Range("A" & rcount.ToString, "A" & rcount.ToString).Font.Bold = True
            .Range("A" & rcount.ToString, "A" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
            .Range("A" & rcount.ToString, "A" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
            .Range("A" & rcount.ToString, "A" & rcount.ToString).ColumnWidth = 5
            .Range("A" & rcount.ToString, "A" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "STT", NNgu)

            .Range("B" & rcount.ToString, "B" & rcount.ToString).Font.Bold = True
            .Range("B" & rcount.ToString, "B" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
            .Range("B" & rcount.ToString, "B" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
            .Range("B" & rcount.ToString, "B" & rcount.ToString).ColumnWidth = 25
            .Range("B" & rcount.ToString, "B" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "MACHINENAME", NNgu)

            .Range("C" & rcount.ToString, "C" & rcount.ToString).Font.Bold = True
            .Range("C" & rcount.ToString, "C" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
            .Range("C" & rcount.ToString, "C" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
            .Range("C" & rcount.ToString, "C" & rcount.ToString).ColumnWidth = 15
            .Range("C" & rcount.ToString, "C" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "ID", NNgu)

            .Range("D" & rcount.ToString, "D" & rcount.ToString).Font.Bold = True
            .Range("D" & rcount.ToString, "D" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignLeft
            .Range("D" & rcount.ToString, "D" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
            .Range("D" & rcount.ToString, "D" & rcount.ToString).ColumnWidth = 15
            .Range("D" & rcount.ToString, "D" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "MODEL", NNgu)

            .Range("E" & rcount.ToString, "E" & rcount.ToString).Font.Bold = True
            .Range("E" & rcount.ToString, "E" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
            .Range("E" & rcount.ToString, "E" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
            .Range("E" & rcount.ToString, "E" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "LOAIBT", NNgu)

            .Range("F" & rcount.ToString, "F" & rcount.ToString).Font.Bold = True
            .Range("F" & rcount.ToString, "F" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
            .Range("F" & rcount.ToString, "F" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
            .Range("F" & rcount.ToString, "F" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "CHUKY", NNgu)

            .Range("G" & rcount.ToString, "G" & rcount.ToString).Font.Bold = True
            .Range("G" & rcount.ToString, "G" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
            .Range("G" & rcount.ToString, "G" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
            .Range("G" & rcount.ToString, "G" & rcount.ToString).ColumnWidth = 15
            .Range("G" & rcount.ToString, "G" & rcount.ToString).Value = Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "rptBaoTriDinhKyThangCS", "NGAYCUOI", NNgu)

            For i As Integer = 1 To 19
                .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).Font.Bold = True
                .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).ColumnWidth = 2
                .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).Value = i.ToString
                If DateTime.Parse(i.ToString & "/" & sThang).DayOfWeek = DayOfWeek.Sunday Then
                    .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).Interior.Color = RGB(255, 0, 0)
                End If
            Next
            For i As Integer = 0 To 11
                .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).Font.Bold = True
                .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).ColumnWidth = 2
                .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).Value = (20 + i).ToString
                Try
                    If DateTime.Parse((20 + i).ToString & "/" & sThang).DayOfWeek = DayOfWeek.Sunday Then
                        .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).Interior.Color = RGB(255, 0, 0)
                    End If
                Catch ex As Exception

                End Try

            Next
        End With
    End Sub
    'sThang truyen vao voi gia tri "MM/yyyy"
    Private Sub BTDKTCSAddDetail(ByVal dtData As System.Data.DataTable, ByVal ExcelSheets As Excel.Worksheet, ByVal sThang As String)
        Try
            Dim inx As Integer = 0
            For Each row As DataRow In dtData.Rows
                inx += 1
                With ExcelSheets
                    .Range("A" & rcount.ToString, "A" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                    .Range("A" & rcount.ToString, "A" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                    .Range("A" & rcount.ToString, "A" & rcount.ToString).Value = inx

                    .Range("B" & rcount.ToString, "B" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignLeft
                    .Range("B" & rcount.ToString, "B" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                    .Range("B" & rcount.ToString, "B" & rcount.ToString).Value = row("TEN_MAY").ToString()

                    .Range("C" & rcount.ToString, "C" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                    .Range("C" & rcount.ToString, "C" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                    .Range("C" & rcount.ToString, "C" & rcount.ToString).Value = row("MS_MAY").ToString()

                    .Range("D" & rcount.ToString, "D" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                    .Range("D" & rcount.ToString, "D" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                    .Range("D" & rcount.ToString, "D" & rcount.ToString).Value = row("MODEL").ToString()

                    .Range("E" & rcount.ToString, "E" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                    .Range("E" & rcount.ToString, "E" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                    .Range("E" & rcount.ToString, "E" & rcount.ToString).Value = row("TEN_LOAI_BT").ToString()

                    .Range("F" & rcount.ToString, "F" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                    .Range("F" & rcount.ToString, "F" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                    .Range("F" & rcount.ToString, "F" & rcount.ToString).Value = row("CHU_KY").ToString() & " " & row("TEN_DV_TG").ToString()

                    Dim nc As DateTime = DateTime.Parse(row("NGAY_CUOI").ToString)
                    .Range("G" & rcount.ToString, "G" & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                    .Range("G" & rcount.ToString, "G" & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                    .Range("G" & rcount.ToString, "G" & rcount.ToString).Value = String.Format("{0:dd/MM/yyyy}", nc)


                    For i As Integer = 1 To 19
                        .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                        .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                        .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).Value = "" 'IIf(row("T" & i).ToString <> "0", row("T" & i).ToString, "")
                        If Int32.Parse(row("T" & i).ToString) > 0 Then
                            .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).Interior.Color = RGB(200, 160, 35)
                        End If
                        If DateTime.Parse(i.ToString & "/" & sThang).DayOfWeek = DayOfWeek.Sunday Then
                            .Range(Convert.ToChar(71 + i).ToString & rcount.ToString, Convert.ToChar(71 + i).ToString & rcount.ToString).Interior.Color = RGB(255, 0, 0)
                        End If
                    Next
                    For i As Integer = 0 To 11
                        .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).HorizontalAlignment = Excel.XlHAlign.xlHAlignCenter
                        .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).VerticalAlignment = Excel.XlVAlign.xlVAlignCenter
                        .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).Value = "" 'IIf(row("T" & (i + 20).ToString).ToString <> "0", row("T" & (i + 20).ToString).ToString, "")
                        If Int32.Parse(row("T" & (i + 20).ToString).ToString()) > 0 Then
                            .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).Interior.Color = RGB(200, 160, 35)
                        End If
                        Try
                            If DateTime.Parse((20 + i).ToString & "/" & sThang).DayOfWeek = DayOfWeek.Sunday Then
                                .Range("A" & Convert.ToChar(65 + i).ToString & rcount.ToString, "A" & Convert.ToChar(65 + i).ToString & rcount.ToString).Interior.Color = RGB(255, 0, 0)
                            End If
                        Catch ex As Exception

                        End Try
                    Next
                End With
                rcount += 1
            Next

        Catch ex As Exception

        End Try
    End Sub

#End Region

End Class
