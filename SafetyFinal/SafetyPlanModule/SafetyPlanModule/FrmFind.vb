Imports DevExpress.Utils

Public Class FrmFind
    Dim _tb As New DataTable
    Public _id As Integer = -1
    Public _name As String = ""
    Public _user As String = ""
    Public _type As Integer = -1
    Public id As String = "-1"
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal dt As DataTable, Optional Type As Integer = -1)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _tb = dt.Copy
        _type = Type
        GridControl1.DataSource = _tb

        For i As Integer = 0 To GridView1.Columns.Count - 1
            GridView1.Columns(i).OptionsColumn.AllowEdit = False
            GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
            GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
        Next
        If _type = -1 Then
            GridView1.Columns(0).Visible = False
        ElseIf _type = 0 Then
            GridView1.Columns(0).Visible = True
            GridView1.Columns(2).Visible = False
        ElseIf _type = 1 Then
            GridView1.Columns(0).Visible = False
            GridView1.Columns(2).Visible = False
        ElseIf _type = 2 Then
            GridView1.Columns(0).Visible = False
            GridView1.Columns(2).Visible = False
        ElseIf _type = 9999 Then
            GridView1.Columns(0).Visible = False
            GridView1.Columns(2).Visible = False
        End If

        GridView1.Columns(0).Width = 100
        GridView1.Columns(1).Width = 200
        GridView1.Columns(2).Width = 150
    End Sub
    Private Sub FrmFind_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If e.KeyData = Keys.Escape Then
            Me.Close()
        End If
    End Sub

    Private Sub btnClose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnClose.Click
        Me.Close()
    End Sub

    Private Sub FrmFind_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        If Commons.Modules.TypeLanguage = 0 Then
            'btnChoose.Text = "Chọn"

            Select Case _type
                Case -1
                    GridView1.Columns(1).Caption = "Nhân viên"
                    GridView1.Columns(2).Caption = "Tài khoản"
                Case 0 'Thiet bi'
                    GridView1.Columns(0).Caption = "Mã thiết bị"
                    GridView1.Columns(1).Caption = "Tên thiết bị"

                Case 1
                    GridView1.Columns(0).Caption = "Mã yêu cầu"
                    GridView1.Columns(1).Caption = "Tên yêu cầu"
                Case 2
                    GridView1.Columns(0).Caption = "Mã nguyên nhân"
                    GridView1.Columns(1).Caption = "Tên nguyên nhân"
                Case 9999
                    GridView1.Columns(1).Caption = "Đối tượng"
                    GridView1.Columns(2).Caption = "Tài khoản"
            End Select
            btnClose.Text = "Thoát"

        Else
            'btnChoose.Text = "Choose"
            Select Case _type
                Case -1
                    GridView1.Columns(1).Caption = "Staff name"
                    GridView1.Columns(2).Caption = "Account Login"
                Case 0
                    GridView1.Columns(0).Caption = "Equipment ID"
                    GridView1.Columns(1).Caption = "Equipment Name"
                Case 1
                    GridView1.Columns(0).Caption = "Request ID"
                    GridView1.Columns(1).Caption = "Request Name"
                Case 2
                    GridView1.Columns(0).Caption = "Reason ID"
                    GridView1.Columns(1).Caption = "Reason Name"
            End Select
            btnClose.Text = "Close"

        End If

    End Sub
    Private Sub LocDuLieu()
        If _type = -1 Then
            If Not GridView1.Columns("Staff name") Is Nothing Then
                Try
                    _tb.DefaultView.RowFilter = "    [Staff name] LIKE '%" & txtFind.Text.Trim & "%' OR [Description] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            Else
                Try
                    _tb.DefaultView.RowFilter = "    [Staffname] LIKE '%" & txtFind.Text.Trim & "%' OR [Description] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            End If
        ElseIf _type = 0 Then
            If Not GridView1.Columns("Staff name") Is Nothing Then
                Try
                    _tb.DefaultView.RowFilter = "    [ID] LIKE '%" & txtFind.Text.Trim & "%' OR [Staff name] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            Else
                Try
                    _tb.DefaultView.RowFilter = "    [ID] LIKE '%" & txtFind.Text.Trim & "%' OR [Staffname] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            End If
        ElseIf _type = 1 Then
            If Not GridView1.Columns("Staff name") Is Nothing Then
                Try
                    _tb.DefaultView.RowFilter = "    [Staff name] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            Else
                Try
                    _tb.DefaultView.RowFilter = "  [Staffname] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    'MessageBox.Show(ex.Message.ToString())
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            End If
        ElseIf _type = 2 Then
            If Not GridView1.Columns("Staff name") Is Nothing Then
                Try
                    _tb.DefaultView.RowFilter = "   [Staff name] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            Else
                Try
                    _tb.DefaultView.RowFilter = "    [Staffname] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            End If
        ElseIf _type = 9999 Then
            If Not GridView1.Columns("Staff name") Is Nothing Then
                Try
                    _tb.DefaultView.RowFilter = "   [Staff name] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            Else
                Try
                    _tb.DefaultView.RowFilter = "    [Staffname] LIKE '%" & txtFind.Text.Trim & "%'  "
                Catch ex As Exception
                    _tb.DefaultView.RowFilter = " 1=1 "
                End Try
            End If
        End If


    End Sub

    Private Sub txtFind_EditValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtFind.EditValueChanged
        LocDuLieu()
    End Sub

    Private Sub btnChoose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        If _type = -1 Then
            If GridView1.RowCount > 0 Then
                _id = GridView1.GetFocusedRowCellValue("ID")
                _name = GridView1.GetFocusedRowCellValue("Staff name")
                _user = GridView1.GetFocusedRowCellValue("Description")
            Else
                _id = -1
                _name = ""
                _user = ""
            End If
        Else
            If GridView1.RowCount > 0 Then
                id = GridView1.GetFocusedRowCellValue("ID")
                _name = GridView1.GetFocusedRowCellValue("Staff name")
                _user = GridView1.GetFocusedRowCellValue("Description")
            Else
                id = "-1"
                _name = ""
                _user = ""
            End If

        End If

        Me.Close()
    End Sub

    Private Sub GridView1_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GridView1.DoubleClick
        If _type = -1 Then
            If GridView1.RowCount > 0 Then
                _id = GridView1.GetFocusedRowCellValue("ID")
                _name = GridView1.GetFocusedRowCellValue("Staff name")
                _user = GridView1.GetFocusedRowCellValue("Description")
            Else
                _id = -1
                _name = ""
                _user = ""
            End If
        Else
            If GridView1.RowCount > 0 Then
                id = GridView1.GetFocusedRowCellValue("ID")
                _name = GridView1.GetFocusedRowCellValue("Staff name")
                _user = GridView1.GetFocusedRowCellValue("Description")
            Else
                id = "-1"
                _name = ""
                _user = ""
            End If

        End If


        Me.Close()
    End Sub

    Private Sub GridView1_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles GridView1.KeyDown
        If e.KeyData = Keys.Enter Then
            If _type = -1 Then
                If GridView1.RowCount > 0 Then
                    _id = GridView1.GetFocusedRowCellValue("ID")
                    _name = GridView1.GetFocusedRowCellValue("Staff name")
                    _user = GridView1.GetFocusedRowCellValue("Description")
                Else
                    _id = -1
                    _name = ""
                    _user = ""
                End If
            Else
                If GridView1.RowCount > 0 Then
                    id = GridView1.GetFocusedRowCellValue("ID")
                    _name = GridView1.GetFocusedRowCellValue("Staff name")
                    _user = GridView1.GetFocusedRowCellValue("Description")
                Else
                    id = "-1"
                    _name = ""
                    _user = ""
                End If

            End If

            Me.Close()
        End If
    End Sub

    Private Sub txtFind_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles txtFind.KeyDown
        If e.KeyData = Keys.Enter Or e.KeyData = Keys.Down Then
            GridView1.Focus()
        End If
    End Sub
    Private Sub gridView1_CustomDrawRowIndicator(ByVal sender As Object, ByVal e As DevExpress.XtraGrid.Views.Grid.RowIndicatorCustomDrawEventArgs) Handles GridView1.CustomDrawRowIndicator
        If e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.Header Or e.Info.Kind = DevExpress.Utils.Drawing.IndicatorKind.RowFooter Then
            e.Appearance.DrawBackground(e.Cache, e.Bounds)
            e.Appearance.DrawString(e.Cache, " ", e.Bounds)

            e.Handled = True
        Else
            e.Info.DisplayText = (e.RowHandle + 1).ToString()
        End If

    End Sub

End Class