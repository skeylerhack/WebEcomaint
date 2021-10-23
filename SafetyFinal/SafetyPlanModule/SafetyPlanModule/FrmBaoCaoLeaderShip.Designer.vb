<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmBaoCaoLeaderShip
    Inherits DevExpress.XtraEditors.XtraForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        Try
            If disposing AndAlso components IsNot Nothing Then
                components.Dispose()
            End If
        Finally
            MyBase.Dispose(disposing)
        End Try
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.TableLayoutPanel1 = New System.Windows.Forms.TableLayoutPanel()
        Me.Panel1 = New System.Windows.Forms.Panel()
        Me.btnThoat = New DevExpress.XtraEditors.SimpleButton()
        Me.rdoBaoCao = New DevExpress.XtraEditors.RadioGroup()
        Me.lblTuNgay = New System.Windows.Forms.Label()
        Me.lblDenNgay = New System.Windows.Forms.Label()
        Me.lblNguoiBC = New System.Windows.Forms.Label()
        Me.datTuNgay = New DevExpress.XtraEditors.DateEdit()
        Me.datDenNgay = New DevExpress.XtraEditors.DateEdit()
        Me.lokNguoiBC = New DevExpress.XtraEditors.LookUpEdit()
        Me.lokLoaiBC = New DevExpress.XtraEditors.LookUpEdit()
        Me.lblLoaiBC = New System.Windows.Forms.Label()
        Me.btnThucHien = New DevExpress.XtraEditors.SimpleButton()
        Me.GridControl1 = New DevExpress.XtraGrid.GridControl()
        Me.GridView1 = New DevExpress.XtraGrid.Views.Grid.GridView()
        Me.TableLayoutPanel1.SuspendLayout()
        Me.Panel1.SuspendLayout()
        CType(Me.rdoBaoCao.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.datTuNgay.Properties.VistaTimeProperties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.datTuNgay.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.datDenNgay.Properties.VistaTimeProperties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.datDenNgay.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.lokNguoiBC.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.lokLoaiBC.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GridControl1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GridView1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'TableLayoutPanel1
        '
        Me.TableLayoutPanel1.ColumnCount = 2
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 120.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.Controls.Add(Me.Panel1, 0, 7)
        Me.TableLayoutPanel1.Controls.Add(Me.rdoBaoCao, 0, 1)
        Me.TableLayoutPanel1.Controls.Add(Me.lblTuNgay, 0, 2)
        Me.TableLayoutPanel1.Controls.Add(Me.lblDenNgay, 0, 3)
        Me.TableLayoutPanel1.Controls.Add(Me.lblNguoiBC, 0, 5)
        Me.TableLayoutPanel1.Controls.Add(Me.datTuNgay, 1, 2)
        Me.TableLayoutPanel1.Controls.Add(Me.datDenNgay, 1, 3)
        Me.TableLayoutPanel1.Controls.Add(Me.lokNguoiBC, 1, 5)
        Me.TableLayoutPanel1.Controls.Add(Me.lokLoaiBC, 1, 4)
        Me.TableLayoutPanel1.Controls.Add(Me.lblLoaiBC, 0, 4)
        Me.TableLayoutPanel1.Controls.Add(Me.GridControl1, 1, 0)
        Me.TableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel1.Location = New System.Drawing.Point(0, 0)
        Me.TableLayoutPanel1.Name = "TableLayoutPanel1"
        Me.TableLayoutPanel1.RowCount = 8
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 8.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 29.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 26.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30.0!))
        Me.TableLayoutPanel1.Size = New System.Drawing.Size(401, 169)
        Me.TableLayoutPanel1.TabIndex = 0
        '
        'Panel1
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.Panel1, 2)
        Me.Panel1.Controls.Add(Me.btnThucHien)
        Me.Panel1.Controls.Add(Me.btnThoat)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.Panel1.Location = New System.Drawing.Point(3, 142)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(395, 24)
        Me.Panel1.TabIndex = 0
        '
        'btnThoat
        '
        Me.btnThoat.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnThoat.Appearance.Options.UseFont = True
        Me.btnThoat.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnThoat.Location = New System.Drawing.Point(309, 0)
        Me.btnThoat.Name = "btnThoat"
        Me.btnThoat.Size = New System.Drawing.Size(86, 24)
        Me.btnThoat.TabIndex = 5
        Me.btnThoat.Text = "btnThoat"
        '
        'rdoBaoCao
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.rdoBaoCao, 2)
        Me.rdoBaoCao.Dock = System.Windows.Forms.DockStyle.Fill
        Me.rdoBaoCao.Location = New System.Drawing.Point(3, 11)
        Me.rdoBaoCao.Name = "rdoBaoCao"
        Me.rdoBaoCao.Properties.Items.AddRange(New DevExpress.XtraEditors.Controls.RadioGroupItem() {New DevExpress.XtraEditors.Controls.RadioGroupItem("rdoTongQut", "Báo cáo tổng quát"), New DevExpress.XtraEditors.Controls.RadioGroupItem("rdoChiTiet", "Báo cáo chi tiết")})
        Me.rdoBaoCao.Size = New System.Drawing.Size(395, 23)
        Me.rdoBaoCao.TabIndex = 1
        '
        'lblTuNgay
        '
        Me.lblTuNgay.AutoSize = True
        Me.lblTuNgay.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lblTuNgay.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.lblTuNgay.Location = New System.Drawing.Point(3, 37)
        Me.lblTuNgay.Name = "lblTuNgay"
        Me.lblTuNgay.Size = New System.Drawing.Size(114, 26)
        Me.lblTuNgay.TabIndex = 45
        Me.lblTuNgay.Text = "lblTuNgay"
        Me.lblTuNgay.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblDenNgay
        '
        Me.lblDenNgay.AutoSize = True
        Me.lblDenNgay.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.lblDenNgay.Location = New System.Drawing.Point(3, 63)
        Me.lblDenNgay.Name = "lblDenNgay"
        Me.lblDenNgay.Size = New System.Drawing.Size(61, 13)
        Me.lblDenNgay.TabIndex = 45
        Me.lblDenNgay.Text = "lblDenNgay"
        Me.lblDenNgay.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'lblNguoiBC
        '
        Me.lblNguoiBC.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lblNguoiBC.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.lblNguoiBC.Location = New System.Drawing.Point(3, 115)
        Me.lblNguoiBC.Name = "lblNguoiBC"
        Me.lblNguoiBC.Size = New System.Drawing.Size(114, 26)
        Me.lblNguoiBC.TabIndex = 45
        Me.lblNguoiBC.Text = "lblNguoiBC"
        Me.lblNguoiBC.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'datTuNgay
        '
        Me.datTuNgay.EditValue = Nothing
        Me.datTuNgay.Location = New System.Drawing.Point(123, 40)
        Me.datTuNgay.Name = "datTuNgay"
        Me.datTuNgay.Properties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.datTuNgay.Properties.VistaTimeProperties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton()})
        Me.datTuNgay.Size = New System.Drawing.Size(157, 20)
        Me.datTuNgay.TabIndex = 46
        '
        'datDenNgay
        '
        Me.datDenNgay.EditValue = Nothing
        Me.datDenNgay.Location = New System.Drawing.Point(123, 66)
        Me.datDenNgay.Name = "datDenNgay"
        Me.datDenNgay.Properties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.datDenNgay.Properties.VistaTimeProperties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton()})
        Me.datDenNgay.Size = New System.Drawing.Size(157, 20)
        Me.datDenNgay.TabIndex = 46
        '
        'lokNguoiBC
        '
        Me.lokNguoiBC.Location = New System.Drawing.Point(123, 118)
        Me.lokNguoiBC.Name = "lokNguoiBC"
        Me.lokNguoiBC.Properties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.lokNguoiBC.Properties.NullText = ""
        Me.lokNguoiBC.Size = New System.Drawing.Size(157, 20)
        Me.lokNguoiBC.TabIndex = 47
        '
        'lokLoaiBC
        '
        Me.lokLoaiBC.Location = New System.Drawing.Point(123, 92)
        Me.lokLoaiBC.Name = "lokLoaiBC"
        Me.lokLoaiBC.Properties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.lokLoaiBC.Properties.NullText = ""
        Me.lokLoaiBC.Size = New System.Drawing.Size(157, 20)
        Me.lokLoaiBC.TabIndex = 47
        '
        'lblLoaiBC
        '
        Me.lblLoaiBC.AutoSize = True
        Me.lblLoaiBC.ImageAlign = System.Drawing.ContentAlignment.MiddleLeft
        Me.lblLoaiBC.Location = New System.Drawing.Point(3, 89)
        Me.lblLoaiBC.Name = "lblLoaiBC"
        Me.lblLoaiBC.Size = New System.Drawing.Size(49, 13)
        Me.lblLoaiBC.TabIndex = 45
        Me.lblLoaiBC.Text = "lblLoaiBC"
        Me.lblLoaiBC.TextAlign = System.Drawing.ContentAlignment.MiddleLeft
        '
        'btnThucHien
        '
        Me.btnThucHien.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnThucHien.Appearance.Options.UseFont = True
        Me.btnThucHien.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnThucHien.Location = New System.Drawing.Point(223, 0)
        Me.btnThucHien.Name = "btnThucHien"
        Me.btnThucHien.Size = New System.Drawing.Size(86, 24)
        Me.btnThucHien.TabIndex = 6
        Me.btnThucHien.Text = "Thực hiện"
        '
        'GridControl1
        '
        Me.GridControl1.Location = New System.Drawing.Point(123, 3)
        Me.GridControl1.MainView = Me.GridView1
        Me.GridControl1.Name = "GridControl1"
        Me.GridControl1.Size = New System.Drawing.Size(275, 2)
        Me.GridControl1.TabIndex = 48
        Me.GridControl1.ViewCollection.AddRange(New DevExpress.XtraGrid.Views.Base.BaseView() {Me.GridView1})
        Me.GridControl1.Visible = False
        '
        'GridView1
        '
        Me.GridView1.GridControl = Me.GridControl1
        Me.GridView1.Name = "GridView1"
        '
        'FrmBaoCaoLeaderShip
        '
        Me.Appearance.BackColor = System.Drawing.Color.FromArgb(CType(CType(227, Byte), Integer), CType(CType(239, Byte), Integer), CType(CType(255, Byte), Integer))
        Me.Appearance.Options.UseBackColor = True
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(401, 169)
        Me.Controls.Add(Me.TableLayoutPanel1)
        Me.Name = "FrmBaoCaoLeaderShip"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "FrmBaoCaoLeaderShip"
        Me.TableLayoutPanel1.ResumeLayout(False)
        Me.TableLayoutPanel1.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        CType(Me.rdoBaoCao.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.datTuNgay.Properties.VistaTimeProperties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.datTuNgay.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.datDenNgay.Properties.VistaTimeProperties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.datDenNgay.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.lokNguoiBC.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.lokLoaiBC.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GridControl1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GridView1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub

    Friend WithEvents TableLayoutPanel1 As TableLayoutPanel
    Friend WithEvents Panel1 As Panel
    Friend WithEvents rdoBaoCao As DevExpress.XtraEditors.RadioGroup
    Friend WithEvents lblTuNgay As Label
    Friend WithEvents lblDenNgay As Label
    Friend WithEvents lblNguoiBC As Label
    Friend WithEvents btnThoat As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents datTuNgay As DevExpress.XtraEditors.DateEdit
    Friend WithEvents datDenNgay As DevExpress.XtraEditors.DateEdit
    Friend WithEvents lokNguoiBC As DevExpress.XtraEditors.LookUpEdit
    Friend WithEvents lokLoaiBC As DevExpress.XtraEditors.LookUpEdit
    Friend WithEvents lblLoaiBC As Label
    Friend WithEvents btnThucHien As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents GridControl1 As DevExpress.XtraGrid.GridControl
    Friend WithEvents GridView1 As DevExpress.XtraGrid.Views.Grid.GridView
End Class
