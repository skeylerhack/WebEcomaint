Imports System.Data.SqlClient
Imports DevExpress.XtraGrid.Views.Grid
Imports System.IO
Imports DevExpress.XtraGrid.Views.Grid.ViewInfo
Imports DevExpress.XtraEditors
Imports DevExpress.Utils
Imports DevExpress.XtraGrid.Views.Base

Public Class FrmIncidentAndAccident
    Private tb As DataTable
    Private tb1 As DataTable
    Private _action As String = ""
    Private sentmailType As Integer = -1
    Private reportID As String = ""
    Private reportID2 As String = ""
    Private _userEdit As String = ""
    Private _DocNum1 As String = ""
    Private _tbPersonInCharge As New DataTable()
    Public Shared _deleteID As Integer = -1
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal DocNum1 As String)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _DocNum1 = DocNum1
        GetListByDocNum()

    End Sub

    Public Sub LoadListUuTien()
        Try

            Dim dt As New DataTable()
            dt.Columns.Add("ID")
            dt.Columns.Add("Name")
            Dim r As DataRow

            If Commons.Modules.TypeLanguage = 0 Then
                r = dt.NewRow()
                r("ID") = 1
                r("Name") = "Mức 1(1 ngày) Chắc chắn sẽ xảy ra tai nạn"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 2
                r("Name") = "Mức 2(7 ngày) Hoàn toàn có thể xảy ra tai nạn"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 3
                r("Name") = "Mức 3(14 ngày) Xem như có thể xảy ra tai nạn"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 4
                r("Name") = "Mức 4(42 ngày) Rất khó có thể xảy ra tai nạn"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 5
                r("Name") = "Mức 5(99 ngày) Được thực hiện khi có cơ hội làm được"
                dt.Rows.Add(r)
            Else
                r = dt.NewRow()
                r("ID") = 1
                r("Name") = "Level 1(1 day) Will inevitably of accident"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 2
                r("Name") = "Level 2(7 days) Entirely possible accident"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 3
                r("Name") = "Level 3(14 days) Watch as accidents can happen"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 4
                r("Name") = "Level 4(42 days) It is difficult to accident"
                dt.Rows.Add(r)
                r = dt.NewRow()
                r("ID") = 5
                r("Name") = "Level 5(99 days) Is performed when the opportunity to do"
                dt.Rows.Add(r)
            End If

            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Name"
            cboStatus.DataSource = dt


            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Name"))

            cboStatus.PopupWidth = 300
            cboStatus.Columns("ID").Width = 30
            cboStatus.Columns("Name").Width = 280
            cboStatus.DropDownRows = 5
            AdvBandedGridView1.Columns("MUCUUTIEN").ColumnEdit = cboStatus
            AdvBandedGridView2.Columns("MUCUUTIEN").ColumnEdit = cboStatus
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Private Sub XtraTabControl1_SelectedPageChanged(ByVal sender As System.Object, ByVal e As DevExpress.XtraTab.TabPageChangedEventArgs) Handles XtraTabControl1.SelectedPageChanged
        'Try
        '    If CType(e.Page, DevExpress.XtraTab.XtraTabPage).Name.ToString.Equals("XtraTabAnalysisCauses") Then
        '        Panel2.Focus()
        '    End If
        'Catch ex As Exception

        'End Try

    End Sub
    Private ControlList As New List(Of Control)()
    Private Sub GetAllControls(ByVal container As Control)
        For Each c As Control In container.Controls
            GetAllControls(c)
            If TypeOf c Is TextBox Then
                CType(c, TextBox).Text = CType(c, TextBox).Name
            End If
            If TypeOf c Is CheckBox Then
                CType(c, CheckBox).Checked = True
            End If
            If TypeOf c Is RadioButton Then
                CType(c, RadioButton).Checked = True
            End If
            If TypeOf c Is RichTextBox Then
                CType(c, RichTextBox).Text = CType(c, RichTextBox).Name
            End If
            If TypeOf c Is DateTimePicker Then
                CType(c, DateTimePicker).Value = Now
            End If
            If TypeOf c Is DevExpress.XtraEditors.TextEdit Then
                CType(c, DevExpress.XtraEditors.TextEdit).Text = CType(c, DevExpress.XtraEditors.TextEdit).Name
            End If
        Next
    End Sub
    Private Sub AllowEdit(ByVal tt As Boolean)
        Try
            Edit(TableLayoutPanel22, tt)
            Edit(TableLayoutPanel3, tt)
            Edit(TableLayoutPanel4, tt)
            Edit(TableLayoutPanel2, tt)
            Edit(TableLayoutPanel6, tt)
            Edit(TableLayoutPanel126, tt)
            Edit(TableLayoutPanel21, tt)
            InChargeOfAccident.Enabled = False
            ApprovalBy.Enabled = False
            ApprovalByHSE.Enabled = False
            ApprovalDate.Enabled = False
            ApprovalDateHSE.Enabled = False
        Catch ex As Exception

        End Try
    End Sub
    Private Sub Edit(ByVal container As Control, ByVal tt As Boolean)
        For Each c As Control In container.Controls
            Edit(c, tt)
            If TypeOf c Is TextBox Then
                CType(c, TextBox).Enabled = tt
            End If
            If TypeOf c Is CheckBox Then
                CType(c, CheckBox).Enabled = tt
            End If
            If TypeOf c Is System.Windows.Forms.ComboBox Then
                CType(c, System.Windows.Forms.ComboBox).Enabled = tt
            End If
            If TypeOf c Is RadioButton Then
                CType(c, RadioButton).Enabled = tt
            End If
            If TypeOf c Is RichTextBox Then
                CType(c, RichTextBox).Enabled = tt
            End If
            If TypeOf c Is DateTimePicker Then
                CType(c, DateTimePicker).Enabled = tt
            End If
            If TypeOf c Is DevExpress.XtraEditors.TextEdit Then
                CType(c, DevExpress.XtraEditors.TextEdit).Enabled = tt
            End If
        Next
    End Sub
    Private Sub LockGrid(ByVal TT As Boolean)
        If _action = "ADD" Then
            For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1
                If TT = False Then
                    If i <= 4 Then
                        AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
                    Else
                        AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = TT
                    End If
                Else
                    AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
                End If

            Next
            For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1
                If TT = False Then
                    If i <= 4 Then
                        AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
                    Else
                        AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = TT
                    End If
                Else
                    AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
                End If

            Next
        ElseIf _action = "UPDATE" Then
            For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1
                If TT = False Then
                    If i <= 9 Then
                        AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
                    Else
                        AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = TT
                    End If
                Else
                    AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
                End If

            Next
            For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1
                If TT = False Then
                    If i <= 9 Then
                        AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
                    Else
                        AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = TT
                    End If
                Else
                    AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
                End If

            Next
        End If

    End Sub
    Private Sub LockGridCreatedBy(ByVal TT As Boolean)
        For i As Integer = 0 To 3
            AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
        Next
        For i As Integer = 0 To 3
            AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
        Next
    End Sub
    Private Sub LockColumnGrid(ByVal TT As Boolean)
        For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1
            If i < AdvBandedGridView1.Columns.Count - 2 Then
                AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = TT
            Else
                AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
            End If
        Next
        For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1
            If i < AdvBandedGridView2.Columns.Count - 2 Then
                AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = TT
            Else
                AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
            End If
        Next
    End Sub
    Private Sub LockView(ByVal TT As Boolean)
        For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1
            AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
            
        Next
        For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1
            AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
        Next
    End Sub
    'Private Sub LockGridDept(ByVal TT As Boolean)
    '    If TT = True Then
    '        For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1
    '            AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
    '        Next
    '        For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1
    '            AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
    '        Next
    '    Else
    '        For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1
    '            If i = 2 Or i = 3 Or i = 4 Then
    '                AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
    '            Else
    '                AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = TT
    '            End If
    '        Next
    '        For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1
    '            If i = 2 Or i = 3 Or i = 4 Then
    '                AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
    '            Else
    '                AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = TT
    '            End If
    '        Next
    '    End If
    'End Sub

    Private Sub LockGridHSE(ByVal TT As Boolean)
        If TT = True Then
            For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1
                AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
            Next
            For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1
                AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
            Next
        Else
            For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1
                If i <= 9 Then
                    AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = Not TT
                Else
                    AdvBandedGridView1.Columns(i).OptionsColumn.AllowEdit = TT
                End If
            Next
            For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1
                If i <= 9 Then
                    AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = Not TT
                Else
                    AdvBandedGridView2.Columns(i).OptionsColumn.AllowEdit = TT
                End If
            Next
        End If

    End Sub
    Private Sub EnableButton(ByVal tt As Boolean)
        'btnSave.Enabled = tt
        'btnCancel.Enabled = tt
        'btnEdit.Enabled = Not tt
        'btnNew.Enabled = Not tt
        'btnDelete.Enabled = Not tt
        btnSave.Visible = tt
        btnCancel.Visible = tt
        btnAdd.Visible = Not tt
        btnEdit.Visible = Not tt
        btnLock.Visible = Not tt
        btnUnlock.Visible = Not tt
        btnDelete.Visible = Not tt
        btnPrint.Visible = Not tt
        btnExit.Visible = Not tt


        btnChoose.Visible = Not tt
        btnChon1.Visible = tt
        btnXoa1.Visible = tt
        btnChon2.Visible = tt
        btnXoa2.Visible = tt

        btnApproval1.Visible = tt
        btnApproval2.Visible = tt
    End Sub
    Private Function fnValid()
        If DocNum.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPSOCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "You must input Document Number!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            DocNum.Focus()
            Return False
        End If
        If EstimatedCCST.Text <> "" Then
            If IsNumeric(EstimatedCCST.Text) = False Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PhaiNhapKieuSoEstimated_Cost_of_the_accident", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "You must input the nummeric format for 'Estimated Cost of the accident'!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                EstimatedCCST.Focus()
                Return False
            End If
        End If
        If EstimatedCost.Text <> "" Then
            If IsNumeric(EstimatedCost.Text) = False Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PhaiNhapKieuSoEstimated_Cost", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "You must input the nummeric format for 'Estimated Cost'!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                EstimatedCost.Focus()
                Return False
            End If
        End If
        If CheckTabTypeOfAccident(TableLayoutPanel3) = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "Phaichon1giatrioTab_Type_Of_Accident", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "You must select least one at Tab Type Of Accident!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Return False
        End If
        If IncidentDescription.TextLength = 0 Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PhainhapIncident_Description", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "You must input Incident Description!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Return False
        End If
        'If IsNumeric(EstimatedCost1.Text) = False Then
        '    MessageBox.Show(Me, "Must input EstimatedCost1 Numeric!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        '    EstimatedCost1.Focus()
        '    Return False
        'End If
        'If IsNumeric(EstimatedCost2.Text) = False Then
        '    MessageBox.Show(Me, "Must input EstimatedCost2 Numeric!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        '    EstimatedCost2.Focus()
        '    Return False
        'End If
        If fnCheckCreateAndApproval() = True Then
            If AdvBandedGridView1.DataRowCount = 0 And AdvBandedGridView2.DataRowCount = 0 Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PhainhapchitietImmediate_Actions_or_Permanent_Actions", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "You must input Immediate Actions or Permanent Actions!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return False
            End If
        End If
        If fnCheckAdminUser() = True Or fnCheckApprovalUser() = True Or fnCheckApprovalHSE() = True Then
            If ApprovalBy.Text = "" Then
                If IncidentReportingPerson.Text.ToUpper <> DungChung.Login.ToUpper Then
                    If AdvBandedGridView1.DataRowCount = 0 And AdvBandedGridView2.DataRowCount = 0 Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PhainhapchitietImmediate_Actions_or_Permanent_Actions", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "You must input Immediate Actions or Permanent Actions!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        Return False
                    End If
                End If
            Else
                If AdvBandedGridView1.DataRowCount = 0 And AdvBandedGridView2.DataRowCount = 0 Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PhainhapchitietImmediate_Actions_or_Permanent_Actions", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "You must input Immediate Actions or Permanent Actions!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Return False
                End If
            End If
        End If

        For i As Integer = 0 To AdvBandedGridView1.RowCount - 2
            If IsDBNull(AdvBandedGridView1.GetRowCellValue(i, "Actions")) Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPreventiveAction", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "You must input Actions at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView1.ClearSelection()
                AdvBandedGridView1.FocusedRowHandle = i
                AdvBandedGridView1.SelectRow(i)
                AdvBandedGridView1.ClearSelection()
                Return False
            ElseIf AdvBandedGridView1.GetRowCellValue(i, "Actions") = "" Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPreventiveAction", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "You must input Actions at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView1.ClearSelection()
                AdvBandedGridView1.FocusedRowHandle = i
                AdvBandedGridView1.SelectRow(i)
                Return False
            End If
            If IsDBNull(AdvBandedGridView1.GetRowCellValue(i, "Date")) Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPDeadline", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Must input Date at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView1.ClearSelection()
                AdvBandedGridView1.FocusedRowHandle = i
                AdvBandedGridView1.SelectRow(i)
                AdvBandedGridView1.ClearSelection()
                Return False
            ElseIf AdvBandedGridView1.GetRowCellValue(i, "Date") = Nothing Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPDeadline", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Must input Date at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView1.ClearSelection()
                AdvBandedGridView1.FocusedRowHandle = i
                AdvBandedGridView1.SelectRow(i)
                Return False
            End If
            Dim date1 As Date = New Date(DocDate.Value.Year, DocDate.Value.Month, DocDate.Value.Day, 0, 0, 0)
            If DateTime.Compare(date1, AdvBandedGridView1.GetRowCellValue(i, "Date")) > 0 Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "DeadlineNHOHONNGAYTAO", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Date at row " & (i + 1).ToString() + " is invalid!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return False
            End If
            If IsDBNull(AdvBandedGridView1.GetRowCellValue(i, "Incharge")) Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView1.ClearSelection()
                AdvBandedGridView1.FocusedRowHandle = i
                AdvBandedGridView1.SelectRow(i)
                AdvBandedGridView1.ClearSelection()
                Return False
            ElseIf AdvBandedGridView1.GetRowCellValue(i, "Incharge") = "" Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView1.ClearSelection()
                AdvBandedGridView1.FocusedRowHandle = i
                AdvBandedGridView1.SelectRow(i)
                Return False
            End If
            If _action = "UPDATE" Then




                If fnCheckAdminUser() = True Or fnCheckApprovalHSE() = True Or fnCheckApproval() = True Then
                    If IsDBNull(AdvBandedGridView1.GetRowCellValue(i, "FollowUpDate")) Then
                        'MessageBox.Show(Me, "Must input Date at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPFollowUpDate", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        AdvBandedGridView1.ClearSelection()
                        AdvBandedGridView1.FocusedRowHandle = i
                        AdvBandedGridView1.SelectRow(i)
                        AdvBandedGridView1.ClearSelection()
                        Return False
                    ElseIf AdvBandedGridView1.GetRowCellValue(i, "FollowUpDate") = Nothing Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPFollowUpDate", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Must input Date at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        AdvBandedGridView1.ClearSelection()
                        AdvBandedGridView1.FocusedRowHandle = i
                        AdvBandedGridView1.SelectRow(i)
                        Return False
                    End If
                    If IsDBNull(AdvBandedGridView1.GetRowCellValue(i, "FollowUpInCharge")) Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPFollowUpIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        AdvBandedGridView1.ClearSelection()
                        AdvBandedGridView1.FocusedRowHandle = i
                        AdvBandedGridView1.SelectRow(i)
                        AdvBandedGridView1.ClearSelection()
                        Return False
                    ElseIf AdvBandedGridView1.GetRowCellValue(i, "FollowUpInCharge") = "" Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPFollowUpIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        AdvBandedGridView1.ClearSelection()
                        AdvBandedGridView1.FocusedRowHandle = i
                        AdvBandedGridView1.SelectRow(i)
                        Return False
                    End If
                End If

            End If

        Next

        For i As Integer = 0 To AdvBandedGridView2.RowCount - 2
            If IsDBNull(AdvBandedGridView2.GetRowCellValue(i, "Actions")) Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPreventiveAction", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "You must input Actions at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView2.ClearSelection()
                AdvBandedGridView2.FocusedRowHandle = i
                AdvBandedGridView2.SelectRow(i)
                AdvBandedGridView2.ClearSelection()
                Return False
            ElseIf AdvBandedGridView2.GetRowCellValue(i, "Actions") = "" Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPreventiveAction", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "You must input Actions at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView2.ClearSelection()
                AdvBandedGridView2.FocusedRowHandle = i
                AdvBandedGridView2.SelectRow(i)
                Return False
            End If
            If IsDBNull(AdvBandedGridView2.GetRowCellValue(i, "Date")) Then
                'MessageBox.Show(Me, "Must input Date at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPDeadline", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView2.ClearSelection()
                AdvBandedGridView2.FocusedRowHandle = i
                AdvBandedGridView2.SelectRow(i)
                AdvBandedGridView2.ClearSelection()
                Return False
            ElseIf AdvBandedGridView2.GetRowCellValue(i, "Date") = Nothing Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPDeadline", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Must input Date at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView2.ClearSelection()
                AdvBandedGridView2.FocusedRowHandle = i
                AdvBandedGridView2.SelectRow(i)
                Return False
            End If
            Dim date1 As Date = New Date(DocDate.Value.Year, DocDate.Value.Month, DocDate.Value.Day, 0, 0, 0)
            If DateTime.Compare(date1, AdvBandedGridView2.GetRowCellValue(i, "Date")) > 0 Then
                'MessageBox.Show(Me, "Date at row " & (i + 1).ToString() + " is invalid!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "DeadlineNHOHONNGAYTAO", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return False
            End If
            If IsDBNull(AdvBandedGridView2.GetRowCellValue(i, "Incharge")) Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView2.ClearSelection()
                AdvBandedGridView2.FocusedRowHandle = i
                AdvBandedGridView2.SelectRow(i)
                AdvBandedGridView2.ClearSelection()
                Return False
            ElseIf AdvBandedGridView2.GetRowCellValue(i, "Incharge") = "" Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                AdvBandedGridView2.ClearSelection()
                AdvBandedGridView2.FocusedRowHandle = i
                AdvBandedGridView2.SelectRow(i)
                Return False
            End If
            If _action = "UPDATE" Then
                If fnCheckAdminUser() = True Or fnCheckApprovalHSE() = True Or fnCheckApproval() = True Then
                    If IsDBNull(AdvBandedGridView2.GetRowCellValue(i, "FollowUpDate")) Then
                        'MessageBox.Show(Me, "Must input Date at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPFollowUpDate", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        AdvBandedGridView2.ClearSelection()
                        AdvBandedGridView2.FocusedRowHandle = i
                        AdvBandedGridView2.SelectRow(i)
                        AdvBandedGridView2.ClearSelection()
                        Return False
                    ElseIf AdvBandedGridView2.GetRowCellValue(i, "FollowUpDate") = Nothing Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPFollowUpDate", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Must input Date at row " & (i + 1).ToString(), "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        AdvBandedGridView2.ClearSelection()
                        AdvBandedGridView2.FocusedRowHandle = i
                        AdvBandedGridView2.SelectRow(i)
                        Return False
                    End If
                    If IsDBNull(AdvBandedGridView2.GetRowCellValue(i, "FollowUpInCharge")) Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPFollowUpIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        AdvBandedGridView2.ClearSelection()
                        AdvBandedGridView2.FocusedRowHandle = i
                        AdvBandedGridView2.SelectRow(i)
                        AdvBandedGridView2.ClearSelection()
                        Return False
                    ElseIf AdvBandedGridView2.GetRowCellValue(i, "FollowUpInCharge") = "" Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPFollowUpIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (i + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        AdvBandedGridView2.ClearSelection()
                        AdvBandedGridView2.FocusedRowHandle = i
                        AdvBandedGridView2.SelectRow(i)
                        Return False
                    End If
                End If
            End If
        Next
        Return True
    End Function
    Private Sub LamMoi()
        CleanScreen(TableLayoutPanel22)
        CleanScreen(TableLayoutPanel3)
        CleanScreen(TableLayoutPanel4)
        CleanScreen(TableLayoutPanel2)
        CleanScreen(TableLayoutPanel6)
        CleanScreen(TableLayoutPanel126)
        CleanScreen(TableLayoutPanel21)
        GridControl1.DataSource = tb
        AdvBandedGridView1.OptionsSelection.MultiSelect = True
        AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        GridControl2.DataSource = tb1
        AdvBandedGridView2.OptionsSelection.MultiSelect = True
        AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        AllowEdit(True)
        LockGrid(False)
        txtID.Text = ""

    End Sub
    Private Sub CleanScreen(ByVal container As Control)
        For Each c As Control In container.Controls
            CleanScreen(c)
            If TypeOf c Is TextBox Then
                CType(c, TextBox).Text = ""
            End If
            If TypeOf c Is CheckBox Then
                CType(c, CheckBox).Checked = False
            End If
            If TypeOf c Is System.Windows.Forms.ComboBox Then
                CType(c, System.Windows.Forms.ComboBox).SelectedIndex = -1
            End If
            If TypeOf c Is RadioButton Then
                CType(c, RadioButton).Checked = True
            End If
            If TypeOf c Is RichTextBox Then
                CType(c, RichTextBox).Text = ""
            End If
            If TypeOf c Is DateTimePicker Then
                CType(c, DateTimePicker).Value = Now
            End If
            If TypeOf c Is DevExpress.XtraEditors.TextEdit Then
                CType(c, DevExpress.XtraEditors.TextEdit).Text = ""
            End If
            If TypeOf c Is PictureBox Then
                If c.Name = "Pic1" Or c.Name = "Pic2" Then
                    CType(c, PictureBox).Image = Nothing
                End If

            End If
        Next
        Lock.Checked = False
    End Sub
    Private Sub SimpleButton7_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAdd.Click
        _action = "ADD"
        EnableButton(True)
        LamMoi()
        InChargeOfAccident.Text = DungChung.Login
        btnApproval1.Visible = False
        btnApproval2.Visible = False
        IncidentReportingPerson.Text = DungChung.Login
        IncidentReportingPerson.Enabled = False
        XtraTabControl1.SelectedTabPageIndex = 0
        GetDocNum()
        DocNum.Enabled = False
        'GetAllControls(TableLayoutPanel22)
        'GetAllControls(TableLayoutPanel3)
        'GetAllControls(TableLayoutPanel4)
        'GetAllControls(TableLayoutPanel2)
        'GetAllControls(TableLayoutPanel6)
        'GetAllControls(TableLayoutPanel126)
        LockGrid(False)
        AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        btnCancelApproval.Visible = False
        sentmailType = 0
        reportID = ""
        reportID2 = ""
        HPES6.Checked = True
    End Sub
    Public Function Excute(ByVal Action As String, Optional ByVal tb As DataTable = Nothing, Optional ByVal tb1 As DataTable = Nothing) As [Boolean]
        Dim dt As New DataTable()
        Dim transaction As SqlTransaction = Nothing
        Using con As New SqlConnection(Commons.IConnections.ConnectionString())
            Dim sqlcom As SqlCommand = con.CreateCommand()
            If sqlcom.Parameters.Count > 0 Then
                sqlcom.Parameters.Clear()
            End If
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                transaction = con.BeginTransaction("Transaction")
                sqlcom.Connection = con
                sqlcom.Transaction = transaction

                sqlcom.Parameters.AddWithValue("ACTION", Action)
                sqlcom.Parameters.AddWithValue("ID", txtID.Text)
                AddParameters(TableLayoutPanel22, sqlcom)
                AddParameters(TableLayoutPanel3, sqlcom)
                AddParameters(TableLayoutPanel4, sqlcom)
                AddParameters(TableLayoutPanel2, sqlcom)
                AddParameters(TableLayoutPanel6, sqlcom)
                AddParameters(TableLayoutPanel126, sqlcom)
                AddParameters(TableLayoutPanel21, sqlcom)
                For i As Integer = sqlcom.Parameters.Count - 1 To 0 Step -1
                    If sqlcom.Parameters(i).ParameterName.Contains("Parameter") Then
                        sqlcom.Parameters.RemoveAt(i)
                    End If
                Next

                If (tb IsNot Nothing) Then
                    sqlcom.Parameters.AddWithValue("@TB", tb)
                End If
                If (tb1 IsNot Nothing) Then
                    sqlcom.Parameters.AddWithValue("@TB1", tb1)
                End If
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_IncidentAndAccident"
                sqlcom.ExecuteNonQuery()
                transaction.Commit()
                Return True
            Catch ex As Exception
                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
                Return False
            Finally
                con.Close()
            End Try
        End Using
    End Function
    Public Function LockDocument() As [Boolean]
        Dim dt As New DataTable()
        Dim transaction As SqlTransaction = Nothing
        Using con As New SqlConnection(Commons.IConnections.ConnectionString())
            Dim sqlcom As SqlCommand = con.CreateCommand()
            If sqlcom.Parameters.Count > 0 Then
                sqlcom.Parameters.Clear()
            End If
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                transaction = con.BeginTransaction("Transaction")
                sqlcom.Connection = con
                sqlcom.Transaction = transaction
                sqlcom.Parameters.AddWithValue("ACTION", "Lock")
                sqlcom.Parameters.AddWithValue("ID", txtID.Text)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_IncidentAndAccident"
                sqlcom.ExecuteNonQuery()
                transaction.Commit()
                Return True
            Catch ex As Exception

                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
                Return False
            Finally
                con.Close()
            End Try
        End Using
    End Function
    Public Function UnLockDocument() As [Boolean]
        Dim dt As New DataTable()
        Dim transaction As SqlTransaction = Nothing
        Using con As New SqlConnection(Commons.IConnections.ConnectionString())
            Dim sqlcom As SqlCommand = con.CreateCommand()
            If sqlcom.Parameters.Count > 0 Then
                sqlcom.Parameters.Clear()
            End If
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                transaction = con.BeginTransaction("Transaction")
                sqlcom.Connection = con
                sqlcom.Transaction = transaction
                sqlcom.Parameters.AddWithValue("ACTION", "UnLock")
                sqlcom.Parameters.AddWithValue("ID", txtID.Text)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_IncidentAndAccident"
                sqlcom.ExecuteNonQuery()
                transaction.Commit()
                Return True
            Catch ex As Exception

                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
                Return False
            Finally
                con.Close()
            End Try
        End Using
    End Function
    Private Sub BindingData(ByVal dt As DataTable)
        BindingControls(TableLayoutPanel22, dt)
        BindingControls(TableLayoutPanel3, dt)
        BindingControls(TableLayoutPanel4, dt)
        BindingControls(TableLayoutPanel2, dt)
        BindingControls(TableLayoutPanel6, dt)
        BindingControls(TableLayoutPanel126, dt)
        BindingControls(TableLayoutPanel21, dt)
    End Sub
    Private Sub BindingControls(ByVal container As Control, ByVal dt As DataTable)
        Try
            For Each c As Control In container.Controls
                BindingControls(c, dt)
                If TypeOf c Is TextBox Then
                    CType(c, TextBox).Text = dt.Rows(0)(c.Name)
                    If c.Name = "DocNum" Then
                        CType(c, TextBox).Text = dt.Rows(0)(c.Name)
                    End If
                End If
                If TypeOf c Is CheckBox Then
                    CType(c, CheckBox).Checked = dt.Rows(0)(c.Name)
                End If
                If TypeOf c Is System.Windows.Forms.ComboBox Then
                    CType(c, System.Windows.Forms.ComboBox).Text = dt.Rows(0)(c.Name)
                End If
                If TypeOf c Is RadioButton Then
                    CType(c, RadioButton).Checked = dt.Rows(0)(c.Name)
                End If
                If TypeOf c Is RichTextBox Then
                    CType(c, RichTextBox).Text = dt.Rows(0)(c.Name)
                End If
                If TypeOf c Is DateTimePicker Then
                    CType(c, DateTimePicker).Value = dt.Rows(0)(c.Name)
                End If
                If TypeOf c Is DevExpress.XtraEditors.TextEdit Then
                    CType(c, DevExpress.XtraEditors.TextEdit).Text = dt.Rows(0)(c.Name)
                End If
                If TypeOf c Is PictureBox Then
                    Try
                        If c.Name = "Pic1" Or c.Name = "Pic2" Then
                            CType(c, PictureBox).Image = Nothing
                            Dim imageData As Byte() = DirectCast(dt.Rows(0)(c.Name), Byte())
                            If Not imageData Is Nothing Then
                                If imageData.Length <> 0 Then
                                    Dim ms As New MemoryStream(imageData)
                                    CType(c, PictureBox).Image = Image.FromStream(ms, True)
                                End If
                            Else
                                CType(c, PictureBox).Image = Nothing
                            End If
                            'Dim imageData As Byte() = DirectCast(dt.Rows(0)(c.Name), Byte())
                            'If Not imageData Is Nothing Then
                            '    Using ms As New MemoryStream(imageData, 0, imageData.Length)
                            '        ms.Write(imageData, 0, imageData.Length)
                            '        CType(c, PictureBox).Image = Image.FromStream(ms, True)
                            '    End Using
                            'Else
                            '    CType(c, PictureBox).Image = Nothing
                            'End If
                        End If

                    Catch ex As Exception
                        CType(c, PictureBox).Image = Nothing
                    End Try
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub
    Private Sub AddParameters(ByVal container As Control, ByRef sqlcom As SqlClient.SqlCommand)
        Try
            For Each c As Control In container.Controls
                AddParameters(c, sqlcom)
                If TypeOf c Is TextBox Then
                    sqlcom.Parameters.AddWithValue(c.Name, CType(c, TextBox).Text)
                End If
                If TypeOf c Is CheckBox Then
                    sqlcom.Parameters.AddWithValue(c.Name, CType(c, CheckBox).Checked)
                End If
                If TypeOf c Is System.Windows.Forms.ComboBox Then
                    sqlcom.Parameters.AddWithValue(c.Name, CType(c, System.Windows.Forms.ComboBox).Text)
                End If
                If TypeOf c Is RadioButton Then
                    sqlcom.Parameters.AddWithValue(c.Name, CType(c, RadioButton).Checked)
                End If
                If TypeOf c Is RichTextBox Then
                    sqlcom.Parameters.AddWithValue(c.Name, CType(c, RichTextBox).Text)
                End If
                If TypeOf c Is DateTimePicker Then
                    sqlcom.Parameters.AddWithValue(c.Name, CType(c, DateTimePicker).Value)
                End If
                If TypeOf c Is DevExpress.XtraEditors.TextEdit Then
                    sqlcom.Parameters.AddWithValue(c.Name, CType(c, DevExpress.XtraEditors.TextEdit).Text)
                End If
                If TypeOf c Is PictureBox Then
                    Try
                        If c.Name = "Pic1" Or c.Name = "Pic2" Then
                            Dim data As Byte() = Nothing
                            data = ImageToByte(CType(c, PictureBox).Image)
                            Dim p As New SqlParameter(c.Name, SqlDbType.Image)
                            p.Value = data
                            sqlcom.Parameters.Add(p)

                            'Dim ms As New MemoryStream()
                            'CType(c, PictureBox).Image.Save(ms, CType(c, PictureBox).Image.RawFormat)
                            'Dim data As Byte() = ms.GetBuffer()
                            'Dim p As New SqlParameter(c.Name, SqlDbType.Image)
                            'p.Value = data
                            'sqlcom.Parameters.Add(p)
                        End If

                    Catch ex As Exception

                    End Try
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub
    Private Function CheckTabTypeOfAccident(ByVal container As Control)
        Try
            For Each c As Control In container.Controls
                CheckTabTypeOfAccident(c)
                If TypeOf c Is CheckBox Then
                    If CType(c, CheckBox).Checked = True Then
                        Return True
                    End If
                End If
            Next
            Return False
        Catch ex As Exception
            Return False
        End Try
    End Function
    Public Shared Function ImageToByte(ByVal img As Image) As Byte()
        Dim converter As New ImageConverter()
        Return DirectCast(converter.ConvertTo(img, GetType(Byte())), Byte())
    End Function
    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnExit.Click
        Me.Close()
    End Sub
    Public Function SaveOtherUserEditDocument(ByVal Action As String) As [Boolean]
        Dim dt As New DataTable()
        Dim transaction As SqlTransaction = Nothing
        Using con As New SqlConnection(Commons.IConnections.ConnectionString())
            Dim sqlcom As SqlCommand = con.CreateCommand()
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                transaction = con.BeginTransaction("Transaction")
                sqlcom.Connection = con
                sqlcom.Transaction = transaction
                sqlcom.Parameters.AddWithValue("ACTION", Action)
                sqlcom.Parameters.AddWithValue("DocNum", DocNum.Text)
                sqlcom.Parameters.AddWithValue("UserEdit", DungChung.Login)
                sqlcom.Parameters.AddWithValue("Edit_Time", dtEditTime.Value)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_EDIT_DOCUMENT"
                sqlcom.ExecuteNonQuery()
                transaction.Commit()
                Return True
            Catch ex As Exception
                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
                Return False
            Finally
                con.Close()
            End Try
        End Using
    End Function
    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click
        If Not fnValid() Then
            Exit Sub
        End If
        If Excute(_action, CType(GridControl1.DataSource, DataTable), CType(GridControl2.DataSource, DataTable)) Then
            Call SaveOtherUserEditDocument("DELETE")
            Dim mailTo As String = ""
            Dim subject As String = ""
            Dim body As String = ""
            If (_action = "ADD" Or _action = "UPDATE") And sentmailType = -1 Then
                If fnCheckApprovalUser() = False Then
                    If IncidentReportingPerson.Text.ToUpper() = DungChung.Login.ToUpper Then
                        If fnCheckDocumentApprovedDept() = True Or fnCheckDocumentApprovedHSE() = True Then
                            sentmailType = -1
                        Else
                            sentmailType = 0
                        End If
                    Else
                        sentmailType = -1
                    End If
                Else
                    If fnCheckDocumentApprovedDept() = True Or fnCheckDocumentApprovedHSE() = True Then
                        sentmailType = -1
                    Else
                        sentmailType = 1
                    End If

                End If
            End If
            Select Case sentmailType
                Case 4 'Gui toi nguoi duyet HSE'
                    mailTo = fnGetListMailApproval_HSE()
                    If mailTo <> "" Then
                        mailTo = GetListMailTo(mailTo)
                    End If
                    subject = "Duyệt Báo cáo từ Ecomaint/Safety"
                    Dim dearto As String = fnGET_DEAR_APPROVAL_HSE()
                    If dearto <> "" Then
                        dearto = GetListDearTo(dearto)
                    End If
                    body = "Dear <b>" & dearto & "</b> </br>" & _
                           "+ Cần duyệt báo cáo về: <b>" & GetHVKAT() & "</b> </br>" & _
                           "+ Người báo cáo: <b>" & fnGetReporter(IncidentReportingPerson.Text) & "</b></br>" & _
                           "+ Ngày báo cáo: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b></br>" & _
                           "+ Số chứng từ: <b>" & DocNum.Text & "</b></br>" & _
                           "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để duyệt Báo cáo.</br>Thanks & Best regards.</br></br></br>"
                Case 0 'Gui toi nguoi duyet'
                    mailTo = fnGetListMailApproval()
                    If mailTo <> "" Then
                        mailTo = GetListMailTo(mailTo)
                    End If
                    subject = "Duyệt Báo cáo từ Ecomaint/Safety"
                    Dim dearto As String = fnGET_DEAR_APPROVAL()
                    If dearto <> "" Then
                        dearto = GetListDearTo(dearto)
                    End If
                    body = "Dear <b>" & dearto & "</b> </br>" & _
                           "+ Cần duyệt báo cáo về: <b>" & GetHVKAT() & "</b> </br>" & _
                           "+ Người báo cáo: <b>" & fnGetReporter(IncidentReportingPerson.Text) & "</b></br>" & _
                           "+ Ngày báo cáo: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b></br>" & _
                           "+ Số chứng từ: <b>" & DocNum.Text & "</b></br>" & _
                           "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để duyệt Báo cáo.</br>Thanks & Best regards.</br></br></br>"
                Case 1 'Gui toi nguoi thuc hien'
                    mailTo = fnGetListMailIncharge()
                    If mailTo <> "" Then
                        mailTo = GetListMailTo(mailTo)
                    End If
                    subject = "Thực hiện Hành động khắc phục, phòng ngừa từ Ecomaint/Safety"
                    Dim dearto As String = fnGET_DEAR_INCHARGE()
                    If dearto <> "" Then
                        dearto = GetListDearTo(dearto)
                    End If
                    Dim nduyet As String = fnGetReporter(ApprovalBy.Text)
                    Dim nduyet2 As String = fnGetReporter(ApprovalByHSE.Text)
                    body = "Dear <b>" & dearto & "</b> </br>" & _
                           "+ Báo cáo: <b>" & GetHVKAT() & "</b> </br>" & _
                           "+ Người báo cáo: <b>" & fnGetReporter(IncidentReportingPerson.Text) & "</b></br>" & _
                           "+ Ngày báo cáo: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b></br>" & _
                           "+ Người duyệt: <b>" & IIf(nduyet = "", ApprovalBy.Text, nduyet) & "," & IIf(nduyet2 = "", ApprovalByHSE.Text, nduyet2) & "</b></br>" & _
                           "+ Số chứng từ: <b>" & DocNum.Text & "</b></br>"
                    Dim dt As DataTable = fnGetListAction()
                    If dt.Rows.Count > 0 Then
                        body = body & "+ Hành động cần thực hiện: </br>"
                        For i As Integer = 0 To dt.Rows.Count - 1
                            body = body & "&nbsp;&nbsp;&nbsp;" & (i + 1).ToString() & ".&nbsp;&nbsp;<b>" & dt.Rows(i)(0).ToString() & "</b></br>"
                        Next
                    End If
                    body = body & "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để thực hiện các hành động khắc phục, phòng ngừa được đề xuất theo đúng thời hạn.</br>Thanks & Best regards.</br></br></br>"
                Case 2 'Gui toi nguoi tao va nguoi duyet'
                    mailTo = fnGetListMailApprovalAndCreatedBy()
                    If mailTo <> "" Then
                        mailTo = GetListMailTo(mailTo)
                    End If
                    subject = "Hoàn tất hành động khắc phục, phòng ngừa từ Ecomaint/Safety"
                    Dim dearto As String = GET_DEAR_APPROVAL_CREATE_BY()
                    If dearto <> "" Then
                        dearto = GetListDearTo(dearto)
                    End If
                    Dim nduyet As String = fnGetReporter(ApprovalBy.Text)
                    Dim nduyet2 As String = fnGetReporter(ApprovalByHSE.Text)
                    body = "Dear <b>" & dearto & "</b> </br>" & _
                           "+ Báo cáo: <b>Kết quả thực hiện hành động khắc phục, phòng ngừa từ Ecomaint/Safety</b></br>" & _
                           "+ Người báo cáo: <b>" & fnGetReporter(IncidentReportingPerson.Text) & "</b></br>" & _
                           "+ Ngày báo cáo: <b>" & Now.Date.ToString("dd/MM/yyyy") & "</b></br>" & _
                           "+ Người thực hiện: <b>" & fnGetReporter(DungChung.Login) & "</b></br>" & _
                           "+ Người duyệt: <b>" & IIf(nduyet = "", ApprovalBy.Text, nduyet) & "," & IIf(nduyet2 = "", ApprovalByHSE.Text, nduyet2) & "</b></br>" & _
                           "+ Số chứng từ: <b>" & DocNum.Text & "</b></br>"
                    Dim dt As DataTable = fnGetListActionDone()
                    If dt.Rows.Count > 0 Then

                        body = body & "+ Hành động đã hoàn tất:  </br>"
                        For i As Integer = 0 To dt.Rows.Count - 1
                            body = body & "&nbsp;&nbsp;&nbsp;<b>" & (i + 1).ToString() & ".&nbsp;&nbsp;" & dt.Rows(i)(0).ToString() & "</b></br>"
                        Next
                    End If
                    body = body & "Vui lòng đăng nhập vào Phần mềm Ecomaint/Safety để xác nhận thông tin báo cáo.</br>Thanks & Best regards.</br></br></br>"
            End Select
            'XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "LUUDLTC", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
            If sentmailType <> -1 And sentmailType <> 3 Then
                If mailTo <> "" Then
                    Dim frm As New FrmXNGuiMail(mailTo, subject, body)
                    frm.ShowDialog()
                End If
            End If


            'MessageBox.Show(Me, "Save data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
            EnableButton(False)
            Call GetListByID()
            LockGrid(True)
            AllowEdit(False)
            LockGrid(True)
            AdvBandedGridView1.OptionsSelection.MultiSelect = True
            AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            AdvBandedGridView2.OptionsSelection.MultiSelect = True
            AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            _action = ""
            btnCancelApproval.Visible = False
            sentmailType = -1
            reportID = ""
            reportID2 = ""
            _action = ""
        Else
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "LUUDLLOI", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Save data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End If
    End Sub
    Public Sub GetDocNum()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DOCNUM")

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    DocNum.Text = ds.Tables(0).Rows(0)(0).ToString()
                End If

            End If

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub GetListByID()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_BY_ID")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    BindingData(ds.Tables(0))
                Else
                    Call LamMoi()
                    Call AllowEdit(False)
                End If
                Call GetListDetail()
            End If
            EnableButton(False)


            If IS_DELETE.Checked = True Then

                btnLock.Visible = False
                btnEdit.Visible = False
                btnDelete.Visible = False
                btnPrint.Visible = False
            Else

                btnLock.Visible = True
                btnEdit.Visible = True
                btnDelete.Visible = True
                btnPrint.Visible = True

            End If

            If Lock.Checked = True Then
                btnUnlock.Visible = True
                btnLock.Visible = False
                btnEdit.Visible = False
                btnDelete.Visible = False
            Else
                btnLock.Visible = True
                btnUnlock.Visible = False
                If IS_DELETE.Checked = False Then
                    btnEdit.Visible = True
                    btnDelete.Visible = True
                Else
                    btnLock.Visible = False
                    btnEdit.Visible = False
                    btnDelete.Visible = False
                End If

            End If
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub GetListByDocNum()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_BY_DOC_NUM")
            sqlcom.Parameters.AddWithValue("DOCNUM", _DocNum1)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    txtID.Text = ds.Tables(0).Rows(0)(0).ToString()
                    GetListByID()
                End If
            End If

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub GetListDetail1()
        Try
            tb = New DataTable
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DETAIL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            tb = ds.Tables(0).Clone
            GridControl1.DataSource = ds.Tables(0)
            AdvBandedGridView1.OptionsSelection.MultiSelect = True
            AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            For i As Integer = 0 To AdvBandedGridView1.Columns.Count - 1

                If i <> 2 And i <> 10 Then
                    AdvBandedGridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    AdvBandedGridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
                Else
                    AdvBandedGridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    AdvBandedGridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
                End If
            Next

        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Public Sub GetListDetail2()
        Try

            tb1 = New DataTable
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DETAIL_1")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            tb1 = ds.Tables(0).Clone
            GridControl2.DataSource = ds.Tables(0)
            AdvBandedGridView2.OptionsSelection.MultiSelect = True
            AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            For i As Integer = 0 To AdvBandedGridView2.Columns.Count - 1

                If i <> 2 And i <> 10 Then
                    AdvBandedGridView2.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    AdvBandedGridView2.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Center
                Else
                    AdvBandedGridView2.Columns(i).AppearanceCell.Options.UseTextOptions = True
                    AdvBandedGridView2.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
                End If
            Next
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub
    Private Sub GetListDetail()
        Call GetListDetail1()
        Call GetListDetail2()
    End Sub

    Private Sub btnEdit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnEdit.Click
        'If txtID.Text = "" Then
        '    MessageBox.Show(Me, "You must select document to to edit!", "Warning", MessageBoxButtons.OK, MessageBoxIcon.Warning)
        '    Exit Sub
        'End If
        If txtID.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUACHONCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần chỉnh sửa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckOtherUserEditDocument() = True Then
            _action = ""
            LamMoi()
            EnableButton(False)
            AllowEdit(False)
            AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
            AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
            Call LockGrid(True)
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUNGTUNGUOIKHACCS", Commons.Modules.TypeLanguage) & " " & _userEdit, Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Chứng từ đang được người dùng '" & _userEdit & "' chỉnh sửa." & vbNewLine & "Vui lòng chọn chứng từ khác!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If

        _action = "UPDATE"
        EnableButton(True)

        AllowEdit(True)


        DocNum.Enabled = False
        DocDate.Enabled = False
        AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom
        AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.Bottom


        Call LockGrid(False)
        IncidentReportingPerson.Enabled = False
        DocDate.Enabled = False
        DocNum.Enabled = False
        TimeofIncident.Enabled = False
        'WorkingTime.Enabled = False

        If fnCheckAdminUser() = True Or fnCheckApprovalUser() = True Then 'Nguoi co quyen duyet
            If fnCheckAdminUser() = True Or fnCheckApproval() = True Then

                If fnCheckDocumentApprovedDept() = False Then
                    btnApproval1.Visible = True
                Else
                    btnApproval1.Visible = False
                    If fnCheckAdminUser() = True Or ApprovalBy.Text.ToUpper = DungChung.Login.ToUpper() Or ApprovalByHSE.Text.ToUpper = DungChung.Login.ToUpper() Then
                        btnCancelApproval.Visible = True
                    Else
                        btnCancelApproval.Visible = False
                    End If

                End If

                If fnCheckAdminUser() = False And fnCheckDocumentApprovedHSE() = True Then
                    btnCancelApproval.Visible = True
                    AllowEdit(False)
                    LockGrid(True)
                    AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                    AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                    btnChon1.Visible = False
                    btnChon2.Visible = False
                    btnXoa1.Visible = False
                    btnXoa2.Visible = False

                Else
                    LockGrid(False)
                End If
            Else
                btnApproval1.Visible = False
            End If
            If fnCheckAdminUser() = True Or fnCheckApprovalHSE() = True Then
                If fnCheckDocumentApprovedDept() = False Then
                    LockGridHSE(False)
                    btnApproval2.Visible = False
                Else

                    If fnCheckDocumentApprovedHSE() = True Then
                        If fnCheckAdminUser() = True Or ApprovalBy.Text.ToUpper = DungChung.Login.ToUpper() Or ApprovalByHSE.Text.ToUpper = DungChung.Login.ToUpper() Then
                            btnCancelApproval.Visible = True
                        Else
                            btnCancelApproval.Visible = False
                        End If


                        AllowEdit(False)
                        btnApproval2.Visible = False
                        LockGridHSE(True)
                        AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                        AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                        btnChon1.Visible = False
                        btnChon2.Visible = False
                        btnXoa1.Visible = False
                        btnXoa2.Visible = False
                    Else
                        'AllowEdit(False)
                        'btnChon1.Visible = False
                        'btnChon2.Visible = False
                        'btnXoa1.Visible = False
                        'btnXoa2.Visible = False
                        If ApprovalBy.Text <> "" Then
                            btnApproval2.Visible = True
                        Else
                            btnApproval2.Visible = False
                        End If

                        LockGridHSE(False)
                    End If
                End If
            Else
                btnApproval2.Visible = False
            End If
        Else 'Nguoi khong co quyen duyet
            btnApproval1.Visible = False
            btnApproval2.Visible = False
            LockGrid(True)
            If IncidentReportingPerson.Text.ToUpper = DungChung.Login.ToUpper Then 'Nguoi tao phieu
                If fnCheckDocumentApprovedDept() = True Or fnCheckDocumentApprovedHSE() = True Then
                    AllowEdit(False)
                    LockGrid(True)
                    AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                    AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                    btnChon1.Visible = False
                    btnChon2.Visible = False
                    btnXoa1.Visible = False
                    btnXoa2.Visible = False
                Else
                    LockGrid(False)
                End If
            Else

                If fnCheckAdminUser() = False And fnCheckUser() = False Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGDUOCPHEPCHINHSUA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)

                    Exit Sub
                Else
                    If fnCheckDocumentApprovedDept() = True Or fnCheckDocumentApprovedHSE() = True Then
                        AllowEdit(False)
                        LockGrid(True)
                        LockColumnGrid(False)
                        AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                        AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                        btnChon1.Visible = False
                        btnChon2.Visible = False
                        btnXoa1.Visible = False
                        btnXoa2.Visible = False
                    Else
                        If fnCheckAdminUser() = False And IncidentReportingPerson.Text.ToUpper <> DungChung.Login.ToUpper Then
                            AllowEdit(False)
                            LockGrid(True)
                            LockColumnGrid(False)
                            AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                            AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                            btnChon1.Visible = False
                            btnChon2.Visible = False
                            btnXoa1.Visible = False
                            btnXoa2.Visible = False
                        End If

                    End If

                End If
            End If
        End If

        If ApprovalBy.Text = "" Then
            btnApproval2.Visible = False
        End If
        If ApprovalBy.Text <> "" Then
            btnApproval1.Visible = False
        End If
        If ApprovalByHSE.Text <> "" Then
            btnApproval2.Visible = False
        End If
        Call SaveOtherUserEditDocument("ADD")
    End Sub

    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        Call GetListByID()
        LockGrid(True)
        AllowEdit(False)
        EnableButton(False)
        AdvBandedGridView1.OptionsSelection.MultiSelect = True
        AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        AdvBandedGridView2.OptionsSelection.MultiSelect = True
        AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
        btnCancelApproval.Visible = False
        sentmailType = -1
        reportID = ""
        reportID2 = ""
        _action = ""
        Call SaveOtherUserEditDocument("DELETE")
    End Sub
    Public Function Delete() As [Boolean]
        Dim dt As New DataTable()
        Dim transaction As SqlTransaction = Nothing
        Using con As New SqlConnection(Commons.IConnections.ConnectionString())
            Dim sqlcom As SqlCommand = con.CreateCommand()
            Try
                If con.State = ConnectionState.Closed Then
                    con.Open()
                End If
                transaction = con.BeginTransaction("Transaction")
                sqlcom.Connection = con
                sqlcom.Transaction = transaction
                sqlcom.Parameters.AddWithValue("ACTION", "DELETE")
                sqlcom.Parameters.AddWithValue("ID", txtID.Text)
                sqlcom.CommandType = CommandType.StoredProcedure
                sqlcom.CommandText = "VS_ST_IncidentAndAccident"
                sqlcom.ExecuteNonQuery()
                transaction.Commit()
                Return True
            Catch ex As Exception
                If transaction IsNot Nothing Then
                    transaction.Rollback()
                End If
                Return False
            Finally
                con.Close()
            End Try
        End Using
    End Function
    Private Function fnCheckOtherUserEditDocument()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_DOC")
            sqlcom.Parameters.AddWithValue("DocNum", DocNum.Text)
            sqlcom.Parameters.AddWithValue("UserEdit", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_EDIT_DOCUMENT"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                _userEdit = ""
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    _userEdit = ds.Tables(0).Rows(0)(0).ToString()
                    Return True
                Else
                    _userEdit = ""
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            _userEdit = ""
            Return False
        End Try
    End Function
    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click
        If txtID.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUACHONCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần xóa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If

        If fnCheckAdminUser() = False And (fnCheckDocumentApprovedDept() = True Or fnCheckDocumentApprovedHSE() = True) Then
            'MessageBox.Show(Me, "Chứng từ đã được duyệt không thể xóa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUNGTUDADUOCDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckOtherUserEditDocument() = True Then
            _action = ""
            LamMoi()
            EnableButton(False)
            AllowEdit(False)
            AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
            Call LockGrid(True)
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUNGTUNGUOIKHACCS", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Chứng từ đang được người dùng '" & _userEdit & "' chỉnh sửa." & vbNewLine & "Vui lòng chọn chứng từ khác!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And fnCheckUser() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGDUOCPHEPXOA", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn không được phép xóa chứng từ!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHANXOACHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            'If MessageBox.Show("Are you sure you want to delete data selected?", "Confirm", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
            Dim mailTo As String = ""
            Dim subject As String = "Xóa báo cáo"
            Dim body As String = ""
            mailTo = fnGetListMailCreatedBy()
            If mailTo <> "" Then
                mailTo = GetListMailTo(mailTo)
            End If
            Dim dearto As String = GET_DEAR_CREATE_BY()
            If dearto <> "" Then
                dearto = GetListDearTo(dearto)
            End If
            Dim nguoixoa As String = fnGetReporter(DungChung.Login)
            If nguoixoa = "" Then
                Try
                    nguoixoa = Microsoft.VisualBasic.Left(DungChung.Login, 1).ToUpper & DungChung.Login.Substring(1, Len(DungChung.Login) - 1)
                Catch ex As Exception
                    nguoixoa = DungChung.Login
                End Try

            End If
            body = "Dear <b>" & dearto & "</b> </br>" & _
             "<b>" & nguoixoa & "</b> đã xóa chứng từ <b>" + DocNum.Text + "</b></br>" & _
             "Lý do xóa: <b> @LYDO@ </b></br>" & _
             "Vui lòng cẩn thận trước khi tạo báo cáo tránh tình trạng báo cáo không đúng.</br>Thanks & Best regards.</br></br></br>"


            If Delete() Then
                'mailTo = "traitv@vietsoft.com.vn"
                _deleteID = txtID.Text
                If mailTo <> "" Then
                    Dim frm As New FrmXNGuiMail(mailTo, subject, body, True)
                    frm.ShowDialog()
                End If
                'XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XOATHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgInfo", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Information)
                ''MessageBox.Show(Me, "Delete data successfully!", "Information", MessageBoxButtons.OK, MessageBoxIcon.Information)
                LamMoi()
                AllowEdit(False)
                txtID.Text = ""
                Call GetListByID()
                LockGrid(True)
                AdvBandedGridView1.OptionsSelection.MultiSelect = True
                AdvBandedGridView1.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                AdvBandedGridView2.OptionsSelection.MultiSelect = True
                AdvBandedGridView2.OptionsView.NewItemRowPosition = NewItemRowPosition.None
                _action = ""
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XOAKHONGTHANHCONG", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Delete data failed!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error)
            End If
        End If
        sentmailType = -1
        reportID = ""
        reportID2 = ""
    End Sub
    Private Function fnGetListMailCreatedBy()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_CREATE_BY")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function GET_DEAR_CREATE_BY()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_CREATE_BY")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Sub FrmIncidentAndAccident_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        LoadListInCharge()
        LoadListUuTien()
        Call GetListByID()
        AllowEdit(False)
        LockGrid(True)
        XtraTabControl1.SelectedTabPageIndex = 0
        Commons.Modules.ObjSystems.ThayDoiNN(Me)
        AdvBandedGridView1.Columns("Incharge1").Caption = " "
        AdvBandedGridView1.Columns("Incharge2").Caption = " "
        AdvBandedGridView2.Columns("InCharge3").Caption = " "
        AdvBandedGridView2.Columns("InCharge4").Caption = " "

    End Sub

    Private Sub btnChoose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChoose.Click
        If Not DungChung.ChooseData Is Nothing Then
            DungChung.ChooseData.Clear()
        End If
        For Each f As Form In Application.OpenForms
            If f.Name = "ChooseIncidentAndAccident" Then
                f.Show()
                Exit Sub
            End If
        Next
        Dim frm As New ChooseIncidentAndAccident
        frm.Show()


    End Sub

    Public Sub Print()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "PRINT")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                ds.WriteXml(Application.StartupPath & "/XML/Incident.xml", XmlWriteMode.WriteSchema)
                Dim frm As New FrmPrint(ds, "Incident.rpt", 9)

                frm.ShowDialog()
            End If

        Catch ex As Exception

        End Try
    End Sub

    Private Sub btnPrint_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnPrint.Click
        If txtID.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUACHONCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần xóa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        Print()
    End Sub

    Private Function fnGetSelectRow(ByVal gridview1 As DevExpress.XtraGrid.Views.Grid.GridView) As DataTable
        Dim dt As New DataTable
        dt.Columns.Add("VT")
        Dim r As DataRow = Nothing
        For Each i As Integer In gridview1.GetSelectedRows()
            r = dt.NewRow
            r("VT") = i
            dt.Rows.Add(r)
        Next i
        Return dt
    End Function

    Private Sub GridControl1_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles GridControl1.KeyDown
        Try
            If _action = "ADD" Or _action = "UPDATE" Then
                If e.KeyCode = Keys.Delete Then
                    If fnCheckDocumentApprovedDept() = True Or fnCheckDocumentApprovedHSE() = True Then
                        Exit Sub
                    End If
                    Dim dt As DataTable = CType(GridControl1.DataSource, DataTable)
                    Try
                        Dim t As DataTable = fnGetSelectRow(AdvBandedGridView1)
                        For j As Integer = t.Rows.Count - 1 To 0 Step -1
                            dt.Rows.RemoveAt(t.Rows(j)("VT"))
                        Next
                        GridControl1.DataSource = dt
                    Catch ex As Exception

                    End Try

                End If
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub GridControl2_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles GridControl2.KeyDown
        Try
            If _action = "ADD" Or _action = "UPDATE" Then
                If e.KeyCode = Keys.Delete Then
                    If fnCheckDocumentApprovedDept() = True Or fnCheckDocumentApprovedHSE() = True Then
                        Exit Sub
                    End If
                    Dim dt As DataTable = CType(GridControl2.DataSource, DataTable)
                    Try
                        Dim t As DataTable = fnGetSelectRow(AdvBandedGridView2)
                        For j As Integer = t.Rows.Count - 1 To 0 Step -1
                            dt.Rows.RemoveAt(t.Rows(j)("VT"))
                        Next
                        GridControl2.DataSource = dt
                    Catch ex As Exception

                    End Try

                End If
            End If
        Catch ex As Exception

        End Try

    End Sub

    Private Sub Button4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChon1.Click
        Dim op As New OpenFileDialog
        'op.InitialDirectory = DungChung.FolderShare
        op.Filter = "(Image Files)|*.jpg;*.png;*.bmp;*.gif;*.ico|Jpg, | *.jpg|Png, | *.png|Bmp, | *.bmp|Gif, | *.gif|Ico | *.ico"
        If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
            Pic1.Image = System.Drawing.Bitmap.FromFile(op.FileName)
        End If
    End Sub

    Private Sub Button5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnChon2.Click
        Dim op As New OpenFileDialog
        'op.InitialDirectory = DungChung.FolderShare
        op.Filter = "(Image Files)|*.jpg;*.png;*.bmp;*.gif;*.ico|Jpg, | *.jpg|Png, | *.png|Bmp, | *.bmp|Gif, | *.gif|Ico | *.ico"
        If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
            Pic2.Image = System.Drawing.Bitmap.FromFile(op.FileName)
        End If
    End Sub

    Private Sub Button3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnXoa1.Click
        Pic1.Image = Nothing
    End Sub

    Private Sub Button6_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnXoa2.Click
        Pic2.Image = Nothing
    End Sub

    Private Sub btnApproval1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApproval1.Click
        If fnCheckAdminUser() = False And fnCheckApproval() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGCOQUYENDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show("Chứng từ đã được trưởng phòng duyệt rồi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And fnCheckDept() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGCUNGPHONGBANNENKHONGCOQUYENDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show("Chứng từ đã được trưởng phòng duyệt rồi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHANDUYETCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            'If MessageBox.Show("Bạn có chắc muốn duyệt chứng từ này không?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
            btnCancelApproval.Visible = False
            If Not DungChung.ChooseData Is Nothing Then
                DungChung.ChooseData.Clear()
            End If
            Dim frm As New FrmConfirm(DungChung.Login)
            frm.ShowDialog()
            If Not DungChung.ChooseData Is Nothing Then
                If DungChung.ChooseData.Rows.Count > 0 Then
                    If DungChung.ChooseData.Rows(0)(0) = "1" Then
                        ApprovalBy.Text = DungChung.Login
                        btnApproval1.Visible = False
                        sentmailType = 4
                    Else
                        ApprovalBy.Text = ""
                    End If
                End If
            End If
        End If
    End Sub
    Private Function fnCheckCreateAndApproval()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_CREATE_APPROVAL")
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function
    Private Function fnCheckAdminUser()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_ADMIN_USER")
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function
    Public Function fnCheckApproval()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("UserLogin", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Function fnCheckDept()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_DEPT")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Function fnCheckDeptHSE()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_DEPT_HSE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Function fnCheckDocumentApprovedDept()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_DOCUMENT_APPROVED_DEPT")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("UserLogin", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Function fnCheckUser()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_USER")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("UserLogin", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Function fnCheckApprovalUser()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_APPROVAL_USER")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("UserLogin", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Function fnCheckDocumentApprovedHSE()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_DOCUMENT_APPROVED_HSE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("UserLogin", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Public Function fnCheckApprovalHSE()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_APPROVAL_HSE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("UserLogin", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
                Return True
            Else
                Return False
            End If
        Catch generatedExceptionName As Exception
            Return False
        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Function
    Private Function fnGetListMailApproval()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetListMailApproval_HSE()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL_HSE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetListMailIncharge()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_INCHARGE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetListMailApprovalAndCreatedBy()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_MAIL_APPROVAL_CREATE_BY")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("RID1", reportID)
            sqlcom.Parameters.AddWithValue("RID2", reportID2)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function GetListMailTo(ByVal lstEmail As String)
        Dim s() As String = lstEmail.Split(";")
        Dim cl As New Collection
        Dim lst As String = ""
        For i As Integer = 0 To s.Length - 1
            If cl.Contains(s(i)) = False Then
                cl.Add(New String() {s(i).ToString()}, s(i).ToString())
            End If
        Next
        For i As Integer = 1 To cl.Count
            If lst.Length = 0 Then
                lst = cl(i)(0).ToString()
            Else
                lst = lst & ";" & cl(i)(0).ToString()
            End If
        Next
        Return lst
    End Function
    Private Function GetListDearTo(ByVal lstDear As String)
        Dim s() As String = lstDear.Split(",")
        Dim cl As New Collection
        Dim lst As String = ""
        For i As Integer = 0 To s.Length - 1
            If cl.Contains(s(i)) = False Then
                cl.Add(New String() {s(i).ToString()}, s(i).ToString())
            End If
        Next
        For i As Integer = 1 To cl.Count
            If lst.Length = 0 Then
                lst = cl(i)(0).ToString()
            Else
                lst = lst & "," & cl(i)(0).ToString()
            End If
        Next
        Return lst
    End Function
    Private Function fnGetReporter(ByVal user As String)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_REPORTER")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", user)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetUserLogin(ByVal id As Integer)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_USER_LOGIN")
            sqlcom.Parameters.AddWithValue("ID", id)

            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGET_DEAR_APPROVAL()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGET_DEAR_APPROVAL_HSE()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL_HSE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGET_DEAR_INCHARGE()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_INCHARGE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function GET_DEAR_APPROVAL_CREATE_BY()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_DEAR_APPROVAL_CREATE_BY")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return ""
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0).Rows(0)(0)
                Else
                    Return ""
                End If
            End If
        Catch generatedExceptionName As Exception
            Return ""
        End Try
    End Function
    Private Function fnGetListAction()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_ACTION")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return New DataTable
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0)
                Else
                    Return New DataTable
                End If
            End If
        Catch generatedExceptionName As Exception
            Return New DataTable
        End Try
    End Function
    Private Function fnGetListActionDone()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_LIST_ACTION_DONE")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("RID1", reportID)
            sqlcom.Parameters.AddWithValue("RID2", reportID2)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return New DataTable
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return ds.Tables(0)
                Else
                    Return New DataTable
                End If
            End If
        Catch generatedExceptionName As Exception
            Return New DataTable
        End Try
    End Function
    Private Function GetHVKAT()
        Dim hvkat As String = ""
        If FirstAID.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & FirstAID.Text
            Else
                hvkat = FirstAID.Text
            End If
        End If
        If NearMiss.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & NearMiss.Text
            Else
                hvkat = NearMiss.Text
            End If
        End If
        If MTC.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & MTC.Text
            Else
                hvkat = MTC.Text
            End If
        End If
        If PropertyDamage.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & PropertyDamage.Text
            Else
                hvkat = PropertyDamage.Text
            End If
        End If
        If RWC.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & RWC.Text
            Else
                hvkat = RWC.Text
            End If
        End If
        If LTA.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & LTA.Text
            Else
                hvkat = LTA.Text
            End If
        End If
        If Fatality.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & Fatality.Text
            Else
                hvkat = Fatality.Text
            End If
        End If
        If Environment.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & Environment.Text
            Else
                hvkat = Environment.Text
            End If
        End If

        If WorkRelatedIllness.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & WorkRelatedIllness.Text
            Else
                hvkat = WorkRelatedIllness.Text
            End If
        End If
        If Fire.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & Fire.Text
            Else
                hvkat = Fire.Text
            End If
        End If
        If NonEmployee.Checked = True Then
            If hvkat.Length > 0 Then
                hvkat = hvkat & "," & NonEmployee.Text
            Else
                hvkat = NonEmployee.Text
            End If
        End If
        Return hvkat
    End Function
    Private Sub btnApproval2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnApproval2.Click

        If fnCheckAdminUser() = False And fnCheckApprovalHSE() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGCOQUYENDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show("Chứng từ đã được trưởng phòng HSE duyệt rồi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And fnCheckDeptHSE() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGCUNGPHONGBANNENKHONGCOQUYENDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show("Chứng từ đã được trưởng phòng duyệt rồi", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHANDUYETCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            'If MessageBox.Show("Bạn có chắc muốn duyệt chứng từ này không?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
            btnCancelApproval.Visible = False
            If Not DungChung.ChooseData Is Nothing Then
                DungChung.ChooseData.Clear()
            End If
            Dim frm As New FrmConfirm(DungChung.Login)
            frm.ShowDialog()
            If Not DungChung.ChooseData Is Nothing Then
                If DungChung.ChooseData.Rows.Count > 0 Then
                    If DungChung.ChooseData.Rows(0)(0) = "1" Then
                        ApprovalByHSE.Text = DungChung.Login
                        btnApproval2.Visible = False
                        sentmailType = 1
                    Else
                        ApprovalByHSE.Text = ""
                    End If
                End If
            End If
        End If
    End Sub
    Public Sub LoadListInCharge()
        Try
            _tbPersonInCharge = New DataTable()
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "LIST_INCHARGE")
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            Dim cboStatus As New DevExpress.XtraEditors.Repository.RepositoryItemLookUpEdit()
            cboStatus.NullText = ""
            cboStatus.ValueMember = "ID"
            cboStatus.DisplayMember = "Staff name"
            cboStatus.DataSource = ds.Tables(0)
            _tbPersonInCharge = ds.Tables(0).Copy()

            cboStatus.Columns.Clear()
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("ID"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Staff name"))
            cboStatus.Columns.Add(New DevExpress.XtraEditors.Controls.LookUpColumnInfo("Description"))
            cboStatus.PopupWidth = 150
            cboStatus.Columns("ID").Width = 20
            cboStatus.Columns("Staff name").Width = 100
            cboStatus.Columns("Description").Width = 60
            cboStatus.ShowDropDown = DevExpress.XtraEditors.Controls.ShowDropDown.Never
            cboStatus.Buttons(0).Visible = False
            AdvBandedGridView1.Columns("Incharge").ColumnEdit = cboStatus
            AdvBandedGridView1.Columns("FollowUpInCharge").ColumnEdit = cboStatus
            AdvBandedGridView2.Columns("Incharge").ColumnEdit = cboStatus
            AdvBandedGridView2.Columns("FollowUpInCharge").ColumnEdit = cboStatus
        Catch generatedExceptionName As Exception

        Finally
            'GlobalVariables.SqlConnect.Close()
        End Try
    End Sub

    Private Sub btnLock_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnLock.Click
        If txtID.Text = "" Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUACHONCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần chỉnh sửa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And fnCheckApprovalUser() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGDUOCPHEPLOCKCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn không được phép xóa chứng từ!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And fnCheckDocumentApprovedDept() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "TRUONGPHONGCHUADUYETCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If fnCheckAdminUser() = False And fnCheckDocumentApprovedHSE() = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "HSECHUADUYETCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
        If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHANLOCKCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
            'If MessageBox.Show("Bạn có chắc muốn Lock chứng từ này không?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
            If Not DungChung.ChooseData Is Nothing Then
                DungChung.ChooseData.Clear()
            End If
            Dim frm As New FrmConfirm(DungChung.Login)
            frm.ShowDialog()
            If Not DungChung.ChooseData Is Nothing Then
                If DungChung.ChooseData.Rows.Count > 0 Then
                    If DungChung.ChooseData.Rows(0)(0) = "1" Then
                        If LockDocument() Then
                            EnableButton(False)
                            btnLock.Visible = False
                            btnEdit.Visible = False
                            btnDelete.Visible = False
                            Call GetListByID()
                        Else
                            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "LOILOCKCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        End If
                    End If
                End If
            End If
        End If

    End Sub

    Private Sub AdvBandedGridView1_CellValueChanged(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs) Handles AdvBandedGridView1.CellValueChanged
        Try
            If _action = "" Then
                Exit Sub
            End If
            If e.Column.Name = "MUCUUTIEN" Then
                Select Case AdvBandedGridView1.GetFocusedRowCellValue("MUCUUTIEN")
                    Case 1
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(1)
                        AdvBandedGridView1.SetRowCellValue(e.RowHandle, "Date", dt)
                    Case 2
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(7)
                        AdvBandedGridView1.SetRowCellValue(e.RowHandle, "Date", dt)
                    Case 3
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(14)
                        AdvBandedGridView1.SetRowCellValue(e.RowHandle, "Date", dt)
                    Case 4
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(42)
                        AdvBandedGridView1.SetRowCellValue(e.RowHandle, "Date", dt)
                    Case 5
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(99)
                        AdvBandedGridView1.SetRowCellValue(e.RowHandle, "Date", dt)
                End Select
            End If
            If e.Column.Name = "Date_1" Or e.Column.Name = "CompletedDate" Then
                If AdvBandedGridView1.GetRowCellValue(e.RowHandle, "CompletedDate").ToString() = "" Then
                    If DateTime.Compare(Now.Date, CDate(AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Date").ToString())) > 0 Then
                        AdvBandedGridView1.SetRowCellValue(e.RowHandle, "Status", "Overdue-Quá hạn")

                    Else
                        AdvBandedGridView1.SetRowCellValue(e.RowHandle, "Status", "Ongoing-Đang xử lý")

                    End If
                Else
                    If AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Status").ToString() = "Reject-Hủy bỏ" Then

                    Else
                        AdvBandedGridView1.SetRowCellValue(e.RowHandle, "Status", "Done-Đã hoàn thành")
                    End If
                End If
            End If
            If e.Column.Name = "Actions" Then
                Dim view As GridView = TryCast(sender, GridView)
                view.LayoutChanged()
            End If
            

        Catch ex As Exception


        End Try
    End Sub

    Private Sub AdvBandedGridView2_CellValueChanged(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Base.CellValueChangedEventArgs) Handles AdvBandedGridView2.CellValueChanged
        Try
            If _action = "" Then
                Exit Sub
            End If
            If e.Column.Name = "MUCUUTIEN1" Then
                Select Case AdvBandedGridView2.GetFocusedRowCellValue("MUCUUTIEN")
                    Case 1
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(1)
                        AdvBandedGridView2.SetRowCellValue(e.RowHandle, "Date", dt)
                    Case 2
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(7)
                        AdvBandedGridView2.SetRowCellValue(e.RowHandle, "Date", dt)
                    Case 3
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(14)
                        AdvBandedGridView2.SetRowCellValue(e.RowHandle, "Date", dt)
                    Case 4
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(42)
                        AdvBandedGridView2.SetRowCellValue(e.RowHandle, "Date", dt)
                    Case 5
                        Dim dt As New Date
                        dt = DocDate.Value.AddDays(99)
                        AdvBandedGridView2.SetRowCellValue(e.RowHandle, "Date", dt)
                End Select
            End If
            If e.Column.Name = "Date_2" Or e.Column.Name = "CompletedDate" Then
                If AdvBandedGridView2.GetRowCellValue(e.RowHandle, "CompletedDate").ToString() = "" Then
                    If DateTime.Compare(Now.Date, CDate(AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Date").ToString())) > 0 Then
                        AdvBandedGridView2.SetRowCellValue(e.RowHandle, "Status", "Overdue-Quá hạn")

                    Else
                        AdvBandedGridView2.SetRowCellValue(e.RowHandle, "Status", "Ongoing-Đang xử lý")

                    End If
                Else
                    If AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Status").ToString() = "Reject-Hủy bỏ" Then

                    Else
                        AdvBandedGridView2.SetRowCellValue(e.RowHandle, "Status", "Done-Đã hoàn thành")
                    End If
                End If
            End If
        Catch ex As Exception

        End Try
    End Sub

    Private Sub AdvBandedGridView1_RowCellStyle(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs) Handles AdvBandedGridView1.RowCellStyle
        Try

            Dim View As GridView = TryCast(sender, GridView)
            If e.Column.FieldName = "Status" Then
                Try
                    e.Appearance.ForeColor = Color.Black
                    If AdvBandedGridView1.GetRowCellValue(e.RowHandle, "CompletedDate").ToString() = "" Then
                        If DateTime.Compare(Now.Date, CDate(AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Date").ToString())) > 0 Then
                            'GridView1.SetRowCellValue(e.RowHandle, "Status", "Overdue-Quá hạn")
                            e.Appearance.BackColor = Color.Red
                        Else
                            'GridView1.SetRowCellValue(e.RowHandle, "Status", "Ongoing-Đang xử lý")
                            e.Appearance.BackColor = Color.Yellow

                        End If
                    Else
                        'GridView1.SetRowCellValue(e.RowHandle, "Status", "Done-Đã hoàn thành")
                        If AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Status").ToString() = "Reject-Hủy bỏ" Then
                            e.Appearance.BackColor = Color.Turquoise
                        Else
                            e.Appearance.BackColor = Color.LimeGreen
                        End If

                    End If

                Catch ex As Exception
                    'e.Appearance.BackColor = Color.Yellow
                End Try
            End If
            View.OptionsView.RowAutoHeight = True
            
        Catch ex As Exception

        End Try
    End Sub

    Private Sub AdvBandedGridView2_RowCellStyle(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowCellStyleEventArgs) Handles AdvBandedGridView2.RowCellStyle
        Try

            Dim View As GridView = TryCast(sender, GridView)
            If e.Column.FieldName = "Status" Then
                Try
                    e.Appearance.ForeColor = Color.Black
                    If AdvBandedGridView2.GetRowCellValue(e.RowHandle, "CompletedDate").ToString() = "" Then
                        If DateTime.Compare(Now.Date, CDate(AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Date").ToString())) > 0 Then
                            'GridView1.SetRowCellValue(e.RowHandle, "Status", "Overdue-Quá hạn")
                            e.Appearance.BackColor = Color.Red
                        Else
                            'GridView1.SetRowCellValue(e.RowHandle, "Status", "Ongoing-Đang xử lý")
                            e.Appearance.BackColor = Color.Yellow

                        End If
                    Else
                        'GridView1.SetRowCellValue(e.RowHandle, "Status", "Done-Đã hoàn thành")
                        If AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Status").ToString() = "Reject-Hủy bỏ" Then
                            e.Appearance.BackColor = Color.Turquoise
                        Else
                            e.Appearance.BackColor = Color.LimeGreen
                        End If
                    End If

                Catch ex As Exception
                    'e.Appearance.BackColor = Color.Yellow
                End Try
            End If
        Catch ex As Exception

        End Try
    End Sub

    Public Function fnCheckReport(ByVal personincharge As Integer)
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "GET_CHARGE_USER")
            sqlcom.Parameters.AddWithValue("PERSON_IN_CHARGE", personincharge)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count > 0 Then
                If ds.Tables(0).Rows.Count > 0 Then
                    If ds.Tables(0).Rows(0)(0).ToString.ToUpper() <> DungChung.Login.ToUpper() Then
                        XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "KHONGDUOCPHANCONGTH", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        'MessageBox.Show(Me, "Bạn không được báo cáo vì không được phân công thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                        Return False
                    Else
                        If fnCheckDocumentApprovedHSE() = False Then
                            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "CHUNGTUCHUADUOCDUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                            'MessageBox.Show(Me, "Bạn không được báo cáo vì chứng từ chưa được duyệt!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                            Return False
                        Else
                            Return True
                        End If
                    End If

                    Return True
                Else
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "KHONGDUOCPHANCONGTH", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn không được báo cáo vì không được phân công thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    Return False
                End If
            Else
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "KHONGDUOCPHANCONGTH", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn không được báo cáo vì không được phân công thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Return False
            End If

        Catch generatedExceptionName As Exception
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "KHONGDUOCPHANCONGTH", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmStopCard", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn không được báo cáo vì không được phân công thực hiện!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Return False
        End Try
    End Function

    Private Sub AdvBandedGridView1_MouseDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles AdvBandedGridView1.MouseDown
        Try


            If _action = "" Then
                Exit Sub
            End If
            Dim view As GridView = TryCast(sender, GridView)
            Dim hi As GridHitInfo = view.CalcHitInfo(New Point(e.X, e.Y))
            If Not hi.InRowCell Then
                Exit Sub
            End If
            Dim vi As GridViewInfo = TryCast(view.GetViewInfo(), GridViewInfo)
            Dim ri As GridDataRowInfo = TryCast(vi.RowsInfo.FindRow(hi.RowHandle), GridDataRowInfo)
            Dim ci As GridCellInfo = ri.Cells(hi.Column)
            AdvBandedGridView1.FocusedRowHandle = hi.RowHandle
            If hi.Column.Name = "btIncharge1" Then
                AdvBandedGridView1.CloseEditor()
                If fnCheckDocumentApprovedHSE() = False Then
                    Dim frm As New FrmFind(_tbPersonInCharge)
                    Dim p As New Point(Cursor.Position.X - 120, Cursor.Position.Y + 14)
                    frm.Location = p
                    frm.ShowDialog()
                    AdvBandedGridView1.Focus()
                    AdvBandedGridView1.BeginSelection()
                    If frm._id <> -1 Then
                        AdvBandedGridView1.SetFocusedRowCellValue("Incharge", frm._id.ToString())
                    End If
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 120, Cursor.Position.Y + 14)
                    VirtualMouse.LeftClick()
                End If
            End If
            If hi.Column.Name = "btIncharge2" Then
                If fnCheckDocumentApprovedHSE() = False Then
                    Dim frm As New FrmFind(_tbPersonInCharge)
                    Dim p As New Point(Cursor.Position.X - 120, Cursor.Position.Y + 14)
                    frm.Location = p
                    frm.ShowDialog()
                    AdvBandedGridView1.Focus()
                    AdvBandedGridView1.BeginSelection()
                    If frm._id <> -1 Then
                        AdvBandedGridView1.SetFocusedRowCellValue("FollowUpInCharge", frm._id.ToString())
                    End If
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 120, Cursor.Position.Y + 14)
                    VirtualMouse.LeftClick()
                End If
            End If
            If hi.Column.Name = "btnChon" Then
                If IsDBNull(AdvBandedGridView1.GetRowCellValue(hi.RowHandle, "Incharge")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng  " & (hi.RowHandle + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    AdvBandedGridView1.ClearSelection()
                    AdvBandedGridView1.FocusedRowHandle = hi.RowHandle
                    AdvBandedGridView1.SelectRow(hi.RowHandle)
                    AdvBandedGridView1.ClearSelection()
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                    VirtualMouse.LeftClick()
                    Exit Sub
                ElseIf AdvBandedGridView1.GetRowCellValue(hi.RowHandle, "Incharge") = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (hi.RowHandle + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    AdvBandedGridView1.ClearSelection()
                    AdvBandedGridView1.FocusedRowHandle = hi.RowHandle
                    AdvBandedGridView1.SelectRow(hi.RowHandle)
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                    VirtualMouse.LeftClick()
                    Exit Sub
                End If
                Dim flag1 As Integer = False
                Dim ngbc1 As String = fnGetUserLogin(AdvBandedGridView1.GetRowCellValue(hi.RowHandle, "Incharge")).ToString().ToUpper()
                If fnCheckAdminUser() = False And (IncidentReportingPerson.Text.ToUpper <> ngbc1 Or ngbc1 <> DungChung.Login.ToUpper()) Then
                    If fnCheckAdminUser() = False And fnCheckReport(AdvBandedGridView1.GetRowCellValue(hi.RowHandle, "Incharge")) = False Then
                        System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                        VirtualMouse.LeftClick()
                        Exit Sub
                    End If
                    flag1 = False
                Else
                    If fnCheckDocumentApprovedHSE() = True Then
                        flag1 = False
                    Else
                        If fnCheckAdminUser() = False Then
                            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUNGTUCHUADUOCDUYETBOIHSE", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                            flag1 = True
                            System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                            VirtualMouse.LeftClick()
                            Exit Sub
                        End If

                    End If
                End If

                If Not DungChung.ChooseData Is Nothing Then
                    DungChung.ChooseData.Clear()
                End If
                Dim frm As New FrmReport(DocDate.Value)
                frm.ShowDialog()
                If Not DungChung.ChooseData Is Nothing Then
                    If DungChung.ChooseData.Rows.Count > 0 Then
                        If DungChung.ChooseData.Rows(0)("XOA").ToString() = "N" Then
                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "PersonReport", DungChung.ChooseData.Rows(0)("NGUOIBC").ToString())
                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "CompletedDate", DungChung.ChooseData.Rows(0)("NGAYHT").ToString())

                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "Description", DungChung.ChooseData.Rows(0)("GHICHU").ToString())
                            If flag1 = True Then
                                If fnCheckDocumentApprovedDept() Then
                                    sentmailType = 4
                                Else
                                    sentmailType = 0
                                End If
                            Else
                                sentmailType = 2
                            End If
                            If reportID.Length = 0 Then
                                reportID = (hi.RowHandle + 1).ToString()
                            Else
                                reportID = reportID & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        ElseIf DungChung.ChooseData.Rows(0)("XOA").ToString() = "Y" Then
                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "PersonReport", "")
                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "CompletedDate", Nothing)
                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "Description", "")
                            If flag1 = True Then
                                If fnCheckDocumentApprovedDept() Then
                                    sentmailType = 4
                                Else
                                    sentmailType = 0
                                End If
                            Else
                                sentmailType = 2
                            End If
                            If reportID.Length = 0 Then
                                reportID = (hi.RowHandle + 1).ToString()
                            Else
                                reportID = reportID & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        ElseIf DungChung.ChooseData.Rows(0)("XOA").ToString() = "R" Then
                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "PersonReport", DungChung.ChooseData.Rows(0)("NGUOIBC").ToString())
                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "CompletedDate", DungChung.ChooseData.Rows(0)("NGAYHT").ToString())

                            AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "Description", DungChung.ChooseData.Rows(0)("GHICHU").ToString())
                            If flag1 = True Then
                                If fnCheckDocumentApprovedDept() Then
                                    sentmailType = 4
                                Else
                                    sentmailType = 0
                                End If

                            Else
                                sentmailType = 2
                            End If
                            If reportID.Length = 0 Then
                                reportID = (hi.RowHandle + 1).ToString()
                            Else
                                reportID = reportID & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        End If

                    End If

                End If
                System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 250, Cursor.Position.Y - 100)
                VirtualMouse.LeftClick()
            End If
            Try
                If AdvBandedGridView1.GetRowCellValue(hi.RowHandle, "CompletedDate").ToString() = "" Then
                    If DateTime.Compare(Now.Date, CDate(AdvBandedGridView1.GetRowCellValue(hi.RowHandle, "Date").ToString())) > 0 Then
                        AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "Status", "Overdue-Quá hạn")

                    Else
                        AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "Status", "Ongoing-Đang xử lý")

                    End If
                Else
                    If DungChung.ChooseData.Rows(0)("XOA").ToString() = "R" Then
                        AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "Status", "Reject-Hủy bỏ")
                    Else
                        AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "Status", "Done-Đã hoàn thành")
                    End If

                End If
            Catch ex As Exception
                'AdvBandedGridView1.SetRowCellValue(hi.RowHandle, "Status", "Ongoing-Đang xử lý")
            End Try
        Catch ex As Exception

        End Try
    End Sub

    Private Sub AdvBandedGridView2_MouseDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.MouseEventArgs) Handles AdvBandedGridView2.MouseDown
        Try


            If _action = "" Then
                Exit Sub
            End If
            Dim view As GridView = TryCast(sender, GridView)
            Dim hi As GridHitInfo = view.CalcHitInfo(New Point(e.X, e.Y))
            If Not hi.InRowCell Then
                Return
            End If
            Dim vi As GridViewInfo = TryCast(view.GetViewInfo(), GridViewInfo)
            Dim ri As GridDataRowInfo = TryCast(vi.RowsInfo.FindRow(hi.RowHandle), GridDataRowInfo)
            Dim ci As GridCellInfo = ri.Cells(hi.Column)
            AdvBandedGridView2.FocusedRowHandle = hi.RowHandle
            If hi.Column.Name = "btInCharge3" Then
                AdvBandedGridView2.CloseEditor()
                If fnCheckDocumentApprovedHSE() = False Then
                    Dim frm As New FrmFind(_tbPersonInCharge)
                    Dim p As New Point(Cursor.Position.X - 120, Cursor.Position.Y + 14)
                    frm.Location = p
                    frm.ShowDialog()
                    AdvBandedGridView2.Focus()
                    AdvBandedGridView2.BeginSelection()
                    If frm._id <> -1 Then
                        AdvBandedGridView2.SetFocusedRowCellValue("Incharge", frm._id.ToString())
                    End If
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 120, Cursor.Position.Y + 14)
                    VirtualMouse.LeftClick()
                End If
            End If
            If hi.Column.Name = "btInCharge4" Then
                If fnCheckDocumentApprovedHSE() = False Then
                    Dim frm As New FrmFind(_tbPersonInCharge)
                    Dim p As New Point(Cursor.Position.X - 120, Cursor.Position.Y + 14)
                    frm.Location = p
                    frm.ShowDialog()
                    AdvBandedGridView2.Focus()
                    AdvBandedGridView2.BeginSelection()
                    If frm._id <> -1 Then
                        AdvBandedGridView2.SetFocusedRowCellValue("FollowUpInCharge", frm._id.ToString())
                    End If
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 120, Cursor.Position.Y + 14)
                    VirtualMouse.LeftClick()
                End If
            End If
            If hi.Column.Name = "btnChon_2" Then
                If IsDBNull(AdvBandedGridView2.GetRowCellValue(hi.RowHandle, "Incharge")) Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng  " & (hi.RowHandle + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    AdvBandedGridView2.ClearSelection()
                    AdvBandedGridView2.FocusedRowHandle = hi.RowHandle
                    AdvBandedGridView2.SelectRow(hi.RowHandle)
                    AdvBandedGridView2.ClearSelection()
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                    VirtualMouse.LeftClick()
                    Exit Sub
                ElseIf AdvBandedGridView2.GetRowCellValue(hi.RowHandle, "Incharge") = "" Then
                    XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAINHAPPersonIncharge", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    'MessageBox.Show(Me, "Bạn phải nhập Person in charge tại dòng " & (hi.RowHandle + 1).ToString(), "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                    AdvBandedGridView2.ClearSelection()
                    AdvBandedGridView2.FocusedRowHandle = hi.RowHandle
                    AdvBandedGridView2.SelectRow(hi.RowHandle)
                    System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                    VirtualMouse.LeftClick()
                    Exit Sub
                End If
                Dim flag As Integer = False
                Dim ngbc1 As String = fnGetUserLogin(AdvBandedGridView2.GetRowCellValue(hi.RowHandle, "Incharge")).ToString().ToUpper()
                If fnCheckAdminUser() = False And (IncidentReportingPerson.Text.ToUpper <> ngbc1 Or ngbc1 <> DungChung.Login.ToUpper()) Then
                    If fnCheckAdminUser() = False And fnCheckReport(AdvBandedGridView2.GetRowCellValue(hi.RowHandle, "Incharge")) = False Then
                        System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                        VirtualMouse.LeftClick()
                        Exit Sub
                    End If
                    flag = False
                Else
                    If fnCheckDocumentApprovedHSE() = True Then
                        flag = False
                    Else
                        If fnCheckAdminUser() = False Then
                            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUNGTUCHUADUOCDUYETBOIHSE", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                            flag = True
                            System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X, Cursor.Position.Y)
                            VirtualMouse.LeftClick()
                            Exit Sub
                        End If
                    End If
                End If


                If Not DungChung.ChooseData Is Nothing Then
                    DungChung.ChooseData.Clear()
                End If
                Dim frm As New FrmReport(DocDate.Value)
                frm.ShowDialog()
                If Not DungChung.ChooseData Is Nothing Then
                    If DungChung.ChooseData.Rows.Count > 0 Then
                        If DungChung.ChooseData.Rows(0)("XOA").ToString() = "N" Then
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "PersonReport", DungChung.ChooseData.Rows(0)("NGUOIBC").ToString())
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "CompletedDate", DungChung.ChooseData.Rows(0)("NGAYHT").ToString())
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "Description", DungChung.ChooseData.Rows(0)("GHICHU").ToString())
                            If flag = True Then
                                If fnCheckDocumentApprovedHSE() = False Then
                                    sentmailType = 4
                                Else
                                    sentmailType = 0
                                End If

                            Else
                                sentmailType = 2
                            End If
                            If reportID2.Length = 0 Then
                                reportID2 = (hi.RowHandle + 1).ToString()
                            Else
                                reportID2 = reportID2 & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        ElseIf DungChung.ChooseData.Rows(0)("XOA").ToString() = "Y" Then
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "PersonReport", "")
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "CompletedDate", Nothing)
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "Description", "")
                            If flag = True Then
                                If fnCheckDocumentApprovedHSE() = False Then
                                    sentmailType = 4
                                Else
                                    sentmailType = 0
                                End If
                            Else
                                sentmailType = 2
                            End If
                            If reportID2.Length = 0 Then
                                reportID2 = (hi.RowHandle + 1).ToString()
                            Else
                                reportID2 = reportID2 & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        ElseIf DungChung.ChooseData.Rows(0)("XOA").ToString() = "R" Then
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "PersonReport", DungChung.ChooseData.Rows(0)("NGUOIBC").ToString())
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "CompletedDate", DungChung.ChooseData.Rows(0)("NGAYHT").ToString())
                            AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "Description", DungChung.ChooseData.Rows(0)("GHICHU").ToString())
                            If flag = True Then
                                If fnCheckDocumentApprovedHSE() = False Then
                                    sentmailType = 4
                                Else
                                    sentmailType = 0
                                End If
                            Else
                                sentmailType = 2
                            End If
                            If reportID2.Length = 0 Then
                                reportID2 = (hi.RowHandle + 1).ToString()
                            Else
                                reportID2 = reportID2 & "|" & (hi.RowHandle + 1).ToString()
                            End If
                        End If
                    End If

                End If

                System.Windows.Forms.Cursor.Position = New Point(Cursor.Position.X - 250, Cursor.Position.Y - 100)
                VirtualMouse.LeftClick()

            End If
            Try
                If AdvBandedGridView2.GetRowCellValue(hi.RowHandle, "CompletedDate").ToString() = "" Then
                    If DateTime.Compare(Now.Date, CDate(AdvBandedGridView2.GetRowCellValue(hi.RowHandle, "Date").ToString())) > 0 Then
                        AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "Status", "Overdue-Quá hạn")

                    Else
                        AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "Status", "Ongoing-Đang xử lý")

                    End If
                Else
                    If DungChung.ChooseData.Rows(0)("XOA").ToString() = "R" Then
                        AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "Status", "Reject-Hủy bỏ")
                    Else
                        AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "Status", "Done-Đã hoàn thành")
                    End If

                End If
            Catch ex As Exception
                'AdvBandedGridView2.SetRowCellValue(hi.RowHandle, "Status", "Ongoing-Đang xử lý")
            End Try
        Catch ex As Exception

        End Try
    End Sub

    Private Sub AdvBandedGridView1_MouseEnter(ByVal sender As Object, ByVal e As System.EventArgs) Handles AdvBandedGridView1.MouseEnter

    End Sub
    Private Function fnCheckCancelApproval()
        Try
            Dim dt As New DataTable()
            Dim sqlcom As New SqlCommand()
            Dim con As New SqlConnection(Commons.IConnections.ConnectionString())
            If con.State = ConnectionState.Closed Then
                con.Open()
            End If
            sqlcom.Connection = con
            sqlcom.Parameters.AddWithValue("ACTION", "CHECK_CANCEL_APPROVAL")
            sqlcom.Parameters.AddWithValue("ID", txtID.Text)
            sqlcom.Parameters.AddWithValue("APPROVAL_USER", DungChung.Login)
            sqlcom.CommandType = CommandType.StoredProcedure
            sqlcom.CommandText = "VS_ST_IncidentAndAccident"
            Dim da As New SqlDataAdapter(sqlcom)
            Dim ds As New DataSet()
            da.Fill(ds)
            If ds.Tables.Count = 0 Then
                Return False
            Else
                If ds.Tables(0).Rows.Count > 0 Then
                    Return True
                Else
                    Return False
                End If
            End If
        Catch generatedExceptionName As Exception
            Return False
        End Try
    End Function
    Private Sub btnCancelApproval_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancelApproval.Click
        If fnCheckAdminUser() = True Or fnCheckApprovalHSE() = True Then
            If fnCheckAdminUser() = False And fnCheckCancelApproval() = False Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGTHEHUYDUYETKHIBCHT", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show("Bạn không thể hủy duyệt chứng từ khi đã có báo cáo hoàn thành", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                LockGrid(True)
                Exit Sub
            End If
            If ApprovalByHSE.Text <> "" And (fnCheckAdminUser() = True Or ApprovalByHSE.Text.ToUpper() = DungChung.Login.ToUpper()) Then
                If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHANHUYDUYETCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
                    'If MessageBox.Show("Bạn có chắc muốn hủy duyệt chứng từ này không?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
                    btnApproval1.Visible = False
                    btnApproval2.Visible = False
                    If Not DungChung.ChooseData Is Nothing Then
                        DungChung.ChooseData.Clear()
                    End If
                    Dim frm As New FrmConfirm(DungChung.Login)
                    frm.ShowDialog()
                    If Not DungChung.ChooseData Is Nothing Then
                        If DungChung.ChooseData.Rows.Count > 0 Then
                            If DungChung.ChooseData.Rows(0)(0) = "1" Then
                                ApprovalByHSE.Text = ""

                                btnCancelApproval.Visible = False
                                sentmailType = 3

                            End If
                        End If
                    End If
                End If

                If Not DungChung.ChooseData Is Nothing Then
                    DungChung.ChooseData.Clear()
                    Exit Sub
                End If
            End If
        End If
        If ApprovalBy.Text <> "" And (fnCheckAdminUser() = True Or fnCheckApproval() = True) Then 'Truong phong'
            If fnCheckDocumentApprovedHSE() = True Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "KHONGTHEHUYDUYETKHIHSEDADUYET", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Exit Sub
            Else
                If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHANHUYDUYETCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
                    'If MessageBox.Show("Bạn có chắc muốn hủy duyệt chứng từ này không?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
                    If Not DungChung.ChooseData Is Nothing Then
                        DungChung.ChooseData.Clear()
                    End If
                    Dim frm As New FrmConfirm(DungChung.Login)
                    frm.ShowDialog()
                    If Not DungChung.ChooseData Is Nothing Then
                        If DungChung.ChooseData.Rows.Count > 0 Then
                            If DungChung.ChooseData.Rows(0)(0) = "1" Then
                                ApprovalBy.Text = ""

                                btnCancelApproval.Visible = False
                                sentmailType = 3

                            End If
                        End If
                    End If
                End If

                If Not DungChung.ChooseData Is Nothing Then
                    DungChung.ChooseData.Clear()
                End If
            End If
        End If

    End Sub

    Private Sub FrmIncidentAndAccident_FormClosed(ByVal sender As System.Object, ByVal e As System.Windows.Forms.FormClosedEventArgs) Handles MyBase.FormClosed
        Call SaveOtherUserEditDocument("DELETE")
        Try
            For Each f As Form In Application.OpenForms
                If f.Name = "ChooseIncidentAndAccident" Then
                    f.Close()
                    Exit For
                End If
            Next
        Catch ex As Exception

        End Try
    End Sub

    Private Sub gridView1_CustomDrawRowIndicator(ByVal sender As Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs) Handles AdvBandedGridView1.CustomDrawRowIndicator
        If e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Header Or e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Band Then
            e.Appearance.DrawBackground(e.Cache, e.Bounds)
            e.Appearance.DrawString(e.Cache, " ", e.Bounds)

            e.Handled = True
        Else
            e.Info.DisplayText = (e.RowHandle + 1).ToString()
        End If

    End Sub
    Private Sub gridView2_CustomDrawRowIndicator(ByVal sender As Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs) Handles AdvBandedGridView2.CustomDrawRowIndicator
        If e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Header Or e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Band Then
            e.Appearance.DrawBackground(e.Cache, e.Bounds)
            e.Appearance.DrawString(e.Cache, " ", e.Bounds)

            e.Handled = True
        Else
            e.Info.DisplayText = (e.RowHandle + 1).ToString()
        End If

    End Sub

    Private Sub btnUnlock_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUnlock.Click
        If fnCheckAdminUser() = True Or DungChung.Login.ToUpper() = ApprovalBy.Text.ToUpper() Or DungChung.Login.ToUpper() = ApprovalByHSE.Text.ToUpper() Or DungChung.Login.ToUpper() = IncidentReportingPerson.Text.ToUpper() Then
            If Lock.Checked = False Then
                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "CHUNGTUCHUALOCK", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần chỉnh sửa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
                Exit Sub
            End If

            If XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XAC_NHAN_UNLOCK_CHUNG_TU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "XACNHAN", Commons.Modules.TypeLanguage), MessageBoxButtons.YesNo, MessageBoxIcon.Question) = Windows.Forms.DialogResult.Yes Then
                'If MessageBox.Show("Bạn có chắc muốn Lock chứng từ này không?", "Xác nhận", MessageBoxButtons.YesNo, MessageBoxIcon.Question, MessageBoxDefaultButton.Button1) = Windows.Forms.DialogResult.Yes Then
                If Not DungChung.ChooseData Is Nothing Then
                    DungChung.ChooseData.Clear()
                End If
                Dim frm As New FrmConfirm(DungChung.Login)
                frm.ShowDialog()
                If Not DungChung.ChooseData Is Nothing Then
                    If DungChung.ChooseData.Rows.Count > 0 Then
                        If DungChung.ChooseData.Rows(0)(0) = "1" Then
                            If UnLockDocument() Then
                                EnableButton(False)
                                btnUnlock.Visible = False
                                Call GetListByID()
                            Else
                                XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "LOIUNLOCKCHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
                            End If
                        End If
                    End If
                End If
            End If
        Else
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "BAN_KHONG_CO_QUYEN_UNLOCK_CHUNGTU", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            'MessageBox.Show(Me, "Bạn chưa chọn chứng từ cần chỉnh sửa!", "Thông báo", MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Exit Sub
        End If
    End Sub

    Private Sub Pic1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Pic2.Click, Pic1.Click
        If Not CType(sender, PictureBox).Image Is Nothing Then
            Dim frm As New FrmShowImg(CType(sender, PictureBox).Image)
            frm.ShowDialog()
        End If
    End Sub

    Private Sub Timer1_Tick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles Timer1.Tick
        Try
            If Not DungChung.ChooseData Is Nothing Then
                If DungChung.ChooseData.Rows.Count > 0 Then
                    txtID.Text = DungChung.ChooseData.Rows(0)("ID")
                    Call GetListByID()
                    btnCancelApproval.Visible = False
                    _action = ""
                    sentmailType = -1
                    reportID = ""
                    reportID2 = ""
                    DungChung.ChooseData.Clear()
                    Timer1.Stop()
                    LockView(True)
                End If
            End If
        Catch ex As Exception

        End Try

    End Sub
    Private Function CheckHPEs()
        Dim isChon As Boolean = False
        fnCheckHPEs(GroupBox20, isChon)
        If isChon = False Then
            XtraMessageBox.Show(Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmIncidentAndAccident", "PHAI_CHON_IT_NHAT_1_NOI_DUNG_HPEs", Commons.Modules.TypeLanguage), Commons.Modules.ObjLanguages.GetLanguage(Commons.Modules.ModuleName, "FrmHazardReport", "msgWarning", Commons.Modules.TypeLanguage), MessageBoxButtons.OK, MessageBoxIcon.Warning)
            Return False
        Else
            Return True
        End If
    End Function
    Private Sub fnCheckHPEs(ByVal ctr As Control, ByRef chon As Boolean)
        For Each c As Control In ctr.Controls
            fnCheckHPEs(c, chon)
            If TypeOf (c) Is CheckBox Then
                If DirectCast(c, CheckBox).Checked = True Then
                    chon = True
                    Exit Sub
                End If
            End If
        Next
    End Sub

    Private Sub AdvBandedGridView1_CalcRowHeight(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowHeightEventArgs) Handles AdvBandedGridView1.CalcRowHeight
        Try
            Dim view As GridView = TryCast(sender, GridView)
            'If e.RowHandle >= 0 AndAlso e.RowHandle = view.FocusedRowHandle Then
            '    e.RowHeight = 100
            'End If
            Dim someValue As Object = DirectCast(sender, ColumnView).GetRowCellValue(e.RowHandle, "Actions")
            If AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Actions").ToString().Length >= 300 Then
                e.RowHeight = 100
            ElseIf AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Actions").ToString().Length >= 200 And AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Actions").ToString().Length < 300 Then
                e.RowHeight = 80
            ElseIf AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Actions").ToString().Length >= 100 And AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Actions").ToString().Length < 200 Then
                e.RowHeight = 60
            ElseIf AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Actions").ToString().Length >= 70 And AdvBandedGridView1.GetRowCellValue(e.RowHandle, "Actions").ToString().Length < 100 Then
                e.RowHeight = 40
            End If
        Catch ex As Exception

        End Try
        
        
    End Sub
    Private Sub AdvBandedGridView2_CalcRowHeight(ByVal sender As System.Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowHeightEventArgs) Handles AdvBandedGridView2.CalcRowHeight
        Try
            Dim view As GridView = TryCast(sender, GridView)
            'If e.RowHandle >= 0 AndAlso e.RowHandle = view.FocusedRowHandle Then
            '    e.RowHeight = 100
            'End If
            Dim someValue As Object = DirectCast(sender, ColumnView).GetRowCellValue(e.RowHandle, "Actions")
            If AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Actions").ToString().Length >= 300 Then
                e.RowHeight = 100
            ElseIf AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Actions").ToString().Length >= 200 And AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Actions").ToString().Length < 300 Then
                e.RowHeight = 80
            ElseIf AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Actions").ToString().Length >= 100 And AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Actions").ToString().Length < 200 Then
                e.RowHeight = 60
            ElseIf AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Actions").ToString().Length >= 70 And AdvBandedGridView2.GetRowCellValue(e.RowHandle, "Actions").ToString().Length < 100 Then
                e.RowHeight = 40
            End If
        Catch ex As Exception

        End Try


    End Sub
End Class