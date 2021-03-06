Imports DevExpress.Utils

Public Class FrmQFind
    Dim _tb As New DataTable
    Public _id As Integer = -1
    Public _name As String = ""
    Public _user As String = ""
    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal dt As DataTable)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        _tb = dt.Copy
        GridControl1.DataSource = _tb

        For i As Integer = 0 To GridView1.Columns.Count - 1
            GridView1.Columns(i).OptionsColumn.AllowEdit = False
            GridView1.Columns(i).AppearanceCell.Options.UseTextOptions = True
            GridView1.Columns(i).AppearanceCell.TextOptions.HAlignment = HorzAlignment.Near
        Next
        Try
            GridView1.Columns(0).Width = 50
            GridView1.Columns(1).Width = 200
            GridView1.Columns(2).Visible = False
        Catch ex As Exception

        End Try
       
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
            btnClose.Text = "Thoát"
            GridView1.Columns(0).Caption = "Mã"
            GridView1.Columns(1).Caption = "Tên"

        Else
            'btnChoose.Text = "Choose"
            btnClose.Text = "Close"
            GridView1.Columns(0).Caption = "ID"
            GridView1.Columns(1).Caption = "Name"

        End If

    End Sub
    Private Sub LocDuLieu()
        Try
            Dim tencot As String = GridView1.Columns(1).FieldName.ToString()
            _tb.DefaultView.RowFilter = tencot & " LIKE '%" & txtFind.Text.Trim & "%'"
        Catch ex As Exception
            _tb.DefaultView.RowFilter = " 1=1 "
        End Try
    End Sub

    Private Sub txtFind_EditValueChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles txtFind.EditValueChanged
        LocDuLieu()
    End Sub

    Private Sub btnChoose_Click(ByVal sender As System.Object, ByVal e As System.EventArgs)
        Dim id As String = GridView1.Columns(0).FieldName.ToString()
        Dim name As String = GridView1.Columns(1).FieldName.ToString()
        If GridView1.RowCount > 0 Then
            _id = GridView1.GetFocusedRowCellValue(id)
            _name = GridView1.GetFocusedRowCellValue(name)

        Else
            _id = -1
            _name = ""
            _user = ""
        End If
        Me.Close()
    End Sub

    Private Sub GridView1_DoubleClick(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles GridView1.DoubleClick
        Dim id As String = GridView1.Columns(0).FieldName.ToString()
        Dim name As String = GridView1.Columns(1).FieldName.ToString()
        If GridView1.RowCount > 0 Then
            _id = GridView1.GetFocusedRowCellValue(id)
            _name = GridView1.GetFocusedRowCellValue(name)

        Else
            _id = -1
            _name = ""
            _user = ""
        End If

        Me.Close()
    End Sub

    Private Sub GridView1_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles GridView1.KeyDown
        If e.KeyData = Keys.Enter Then
            Dim id As String = GridView1.Columns(0).FieldName.ToString()
            Dim name As String = GridView1.Columns(1).FieldName.ToString()
            If GridView1.RowCount > 0 Then
                _id = GridView1.GetFocusedRowCellValue(id)
                _name = GridView1.GetFocusedRowCellValue(name)

            Else
                _id = -1
                _name = ""
                _user = ""
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