<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmLanguage
    Inherits DevExpress.XtraEditors.XtraForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Required by the Windows Form Designer
    Private components As System.ComponentModel.IContainer

    'NOTE: The following procedure is required by the Windows Form Designer
    'It can be modified using the Windows Form Designer.  
    'Do not modify it using the code editor.
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.lblTieude = New System.Windows.Forms.Label
        Me.grpDanhsachform = New System.Windows.Forms.GroupBox
        Me.grdForm = New DevExpress.XtraGrid.GridControl
        Me.grvForm = New DevExpress.XtraGrid.Views.Grid.GridView
        Me.GridView4 = New DevExpress.XtraGrid.Views.Grid.GridView
        Me.grpThongtinchitiet = New System.Windows.Forms.GroupBox
        Me.grdThongtinchitiet = New System.Windows.Forms.DataGridView
        Me.BtnSua = New System.Windows.Forms.Button
        Me.BtnThoat = New System.Windows.Forms.Button
        Me.BtnGhi = New System.Windows.Forms.Button
        Me.BtnKhongghi = New System.Windows.Forms.Button
        Me.GroupBox1 = New System.Windows.Forms.GroupBox
        Me.rdReport = New System.Windows.Forms.RadioButton
        Me.rdForm = New System.Windows.Forms.RadioButton
        Me.TableLayoutPanel1 = New System.Windows.Forms.TableLayoutPanel
        Me.Panel1 = New System.Windows.Forms.Panel
        Me.btnNNGoc = New System.Windows.Forms.Button
        Me.txtTim = New System.Windows.Forms.TextBox
        Me.txtTK = New System.Windows.Forms.TextBox
        Me.TableLayoutPanel2 = New System.Windows.Forms.TableLayoutPanel
        Me.chkAllForm = New System.Windows.Forms.CheckBox
        Me.txtChuoi = New System.Windows.Forms.TextBox
        Me.txtReplay = New System.Windows.Forms.TextBox
        Me.btnReplay = New System.Windows.Forms.Button
        Me.chkHoaThuong = New System.Windows.Forms.CheckBox
        Me.chkAnh = New System.Windows.Forms.CheckBox
        Me.chkDung = New System.Windows.Forms.CheckBox
        Me.SplitContainer1 = New System.Windows.Forms.SplitContainer
        Me.grpDanhsachform.SuspendLayout()
        CType(Me.grdForm, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.grvForm, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.GridView4, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.grpThongtinchitiet.SuspendLayout()
        CType(Me.grdThongtinchitiet, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.TableLayoutPanel1.SuspendLayout()
        Me.Panel1.SuspendLayout()
        Me.TableLayoutPanel2.SuspendLayout()
        Me.SplitContainer1.Panel1.SuspendLayout()
        Me.SplitContainer1.Panel2.SuspendLayout()
        Me.SplitContainer1.SuspendLayout()
        Me.SuspendLayout()
        '
        'lblTieude
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.lblTieude, 3)
        Me.lblTieude.Dock = System.Windows.Forms.DockStyle.Fill
        Me.lblTieude.Font = New System.Drawing.Font("Arial", 14.25!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTieude.ForeColor = System.Drawing.SystemColors.ActiveCaption
        Me.lblTieude.Location = New System.Drawing.Point(3, 0)
        Me.lblTieude.Name = "lblTieude"
        Me.lblTieude.Size = New System.Drawing.Size(906, 29)
        Me.lblTieude.TabIndex = 0
        Me.lblTieude.Text = "NGÔN NGỮ"
        Me.lblTieude.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        '
        'grpDanhsachform
        '
        Me.grpDanhsachform.Controls.Add(Me.grdForm)
        Me.grpDanhsachform.Dock = System.Windows.Forms.DockStyle.Fill
        Me.grpDanhsachform.ForeColor = System.Drawing.Color.Red
        Me.grpDanhsachform.Location = New System.Drawing.Point(0, 0)
        Me.grpDanhsachform.Name = "grpDanhsachform"
        Me.grpDanhsachform.Size = New System.Drawing.Size(306, 489)
        Me.grpDanhsachform.TabIndex = 1
        Me.grpDanhsachform.TabStop = False
        Me.grpDanhsachform.Text = "Danh sách form"
        '
        'grdForm
        '
        Me.grdForm.Dock = System.Windows.Forms.DockStyle.Fill
        Me.grdForm.Location = New System.Drawing.Point(3, 17)
        Me.grdForm.LookAndFeel.SkinName = "Blue"
        Me.grdForm.LookAndFeel.UseDefaultLookAndFeel = False
        Me.grdForm.MainView = Me.grvForm
        Me.grdForm.Name = "grdForm"
        Me.grdForm.Size = New System.Drawing.Size(300, 469)
        Me.grdForm.TabIndex = 17
        Me.grdForm.ViewCollection.AddRange(New DevExpress.XtraGrid.Views.Base.BaseView() {Me.grvForm, Me.GridView4})
        '
        'grvForm
        '
        Me.grvForm.GridControl = Me.grdForm
        Me.grvForm.Name = "grvForm"
        Me.grvForm.OptionsBehavior.AllowAddRows = DevExpress.Utils.DefaultBoolean.[False]
        Me.grvForm.OptionsBehavior.AllowDeleteRows = DevExpress.Utils.DefaultBoolean.[False]
        Me.grvForm.OptionsBehavior.Editable = False
        Me.grvForm.OptionsLayout.Columns.AddNewColumns = False
        Me.grvForm.OptionsLayout.Columns.RemoveOldColumns = False
        Me.grvForm.OptionsView.ColumnAutoWidth = False
        Me.grvForm.OptionsView.EnableAppearanceEvenRow = True
        Me.grvForm.OptionsView.EnableAppearanceOddRow = True
        Me.grvForm.OptionsView.ShowGroupPanel = False
        '
        'GridView4
        '
        Me.GridView4.GridControl = Me.grdForm
        Me.GridView4.Name = "GridView4"
        '
        'grpThongtinchitiet
        '
        Me.grpThongtinchitiet.Controls.Add(Me.grdThongtinchitiet)
        Me.grpThongtinchitiet.Dock = System.Windows.Forms.DockStyle.Fill
        Me.grpThongtinchitiet.ForeColor = System.Drawing.Color.Red
        Me.grpThongtinchitiet.Location = New System.Drawing.Point(0, 0)
        Me.grpThongtinchitiet.Name = "grpThongtinchitiet"
        Me.grpThongtinchitiet.Size = New System.Drawing.Size(596, 489)
        Me.grpThongtinchitiet.TabIndex = 2
        Me.grpThongtinchitiet.TabStop = False
        Me.grpThongtinchitiet.Text = "Thông tin chi tiết"
        '
        'grdThongtinchitiet
        '
        Me.grdThongtinchitiet.AllowUserToAddRows = False
        Me.grdThongtinchitiet.AllowUserToDeleteRows = False
        Me.grdThongtinchitiet.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill
        Me.grdThongtinchitiet.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize
        Me.grdThongtinchitiet.Dock = System.Windows.Forms.DockStyle.Fill
        Me.grdThongtinchitiet.Location = New System.Drawing.Point(3, 17)
        Me.grdThongtinchitiet.Name = "grdThongtinchitiet"
        Me.grdThongtinchitiet.RowHeadersWidth = 25
        Me.grdThongtinchitiet.Size = New System.Drawing.Size(590, 469)
        Me.grdThongtinchitiet.TabIndex = 0
        '
        'BtnSua
        '
        Me.BtnSua.Dock = System.Windows.Forms.DockStyle.Right
        Me.BtnSua.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnSua.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.BtnSua.Location = New System.Drawing.Point(276, 0)
        Me.BtnSua.Name = "BtnSua"
        Me.BtnSua.Size = New System.Drawing.Size(80, 26)
        Me.BtnSua.TabIndex = 9
        Me.BtnSua.Text = "&Sửa"
        Me.BtnSua.UseVisualStyleBackColor = True
        '
        'BtnThoat
        '
        Me.BtnThoat.Dock = System.Windows.Forms.DockStyle.Right
        Me.BtnThoat.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnThoat.ForeColor = System.Drawing.Color.Red
        Me.BtnThoat.Location = New System.Drawing.Point(516, 0)
        Me.BtnThoat.Name = "BtnThoat"
        Me.BtnThoat.Size = New System.Drawing.Size(80, 26)
        Me.BtnThoat.TabIndex = 12
        Me.BtnThoat.Text = "T&hoát"
        Me.BtnThoat.UseVisualStyleBackColor = True
        '
        'BtnGhi
        '
        Me.BtnGhi.Dock = System.Windows.Forms.DockStyle.Right
        Me.BtnGhi.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnGhi.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.BtnGhi.Location = New System.Drawing.Point(356, 0)
        Me.BtnGhi.Name = "BtnGhi"
        Me.BtnGhi.Size = New System.Drawing.Size(80, 26)
        Me.BtnGhi.TabIndex = 14
        Me.BtnGhi.Text = "&Ghi"
        Me.BtnGhi.UseVisualStyleBackColor = True
        '
        'BtnKhongghi
        '
        Me.BtnKhongghi.Dock = System.Windows.Forms.DockStyle.Right
        Me.BtnKhongghi.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnKhongghi.ForeColor = System.Drawing.Color.Red
        Me.BtnKhongghi.Location = New System.Drawing.Point(436, 0)
        Me.BtnKhongghi.Name = "BtnKhongghi"
        Me.BtnKhongghi.Size = New System.Drawing.Size(80, 26)
        Me.BtnKhongghi.TabIndex = 15
        Me.BtnKhongghi.Text = "&Không"
        Me.BtnKhongghi.UseVisualStyleBackColor = True
        '
        'GroupBox1
        '
        Me.GroupBox1.Location = New System.Drawing.Point(297, 47)
        Me.GroupBox1.Name = "GroupBox1"
        Me.GroupBox1.Size = New System.Drawing.Size(397, 47)
        Me.GroupBox1.TabIndex = 16
        Me.GroupBox1.TabStop = False
        '
        'rdReport
        '
        Me.rdReport.AutoSize = True
        Me.rdReport.Dock = System.Windows.Forms.DockStyle.Fill
        Me.rdReport.Location = New System.Drawing.Point(120, 32)
        Me.rdReport.Name = "rdReport"
        Me.rdReport.Size = New System.Drawing.Size(187, 29)
        Me.rdReport.TabIndex = 1
        Me.rdReport.Text = "Reports"
        Me.rdReport.UseVisualStyleBackColor = True
        '
        'rdForm
        '
        Me.rdForm.AutoSize = True
        Me.rdForm.Checked = True
        Me.rdForm.Dock = System.Windows.Forms.DockStyle.Fill
        Me.rdForm.Location = New System.Drawing.Point(3, 32)
        Me.rdForm.Name = "rdForm"
        Me.rdForm.Size = New System.Drawing.Size(111, 29)
        Me.rdForm.TabIndex = 0
        Me.rdForm.TabStop = True
        Me.rdForm.Text = "Forms"
        Me.rdForm.UseVisualStyleBackColor = True
        '
        'TableLayoutPanel1
        '
        Me.TableLayoutPanel1.ColumnCount = 3
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 117.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 193.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.Controls.Add(Me.rdReport, 1, 1)
        Me.TableLayoutPanel1.Controls.Add(Me.lblTieude, 0, 0)
        Me.TableLayoutPanel1.Controls.Add(Me.rdForm, 0, 1)
        Me.TableLayoutPanel1.Controls.Add(Me.Panel1, 2, 3)
        Me.TableLayoutPanel1.Controls.Add(Me.txtTK, 0, 3)
        Me.TableLayoutPanel1.Controls.Add(Me.TableLayoutPanel2, 2, 1)
        Me.TableLayoutPanel1.Controls.Add(Me.SplitContainer1, 0, 2)
        Me.TableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel1.Location = New System.Drawing.Point(0, 0)
        Me.TableLayoutPanel1.Name = "TableLayoutPanel1"
        Me.TableLayoutPanel1.RowCount = 4
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 29.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 35.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 32.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 20.0!))
        Me.TableLayoutPanel1.Size = New System.Drawing.Size(912, 591)
        Me.TableLayoutPanel1.TabIndex = 17
        '
        'Panel1
        '
        Me.Panel1.Controls.Add(Me.btnNNGoc)
        Me.Panel1.Controls.Add(Me.BtnSua)
        Me.Panel1.Controls.Add(Me.BtnGhi)
        Me.Panel1.Controls.Add(Me.BtnKhongghi)
        Me.Panel1.Controls.Add(Me.txtTim)
        Me.Panel1.Controls.Add(Me.BtnThoat)
        Me.Panel1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.Panel1.Location = New System.Drawing.Point(313, 562)
        Me.Panel1.Name = "Panel1"
        Me.Panel1.Size = New System.Drawing.Size(596, 26)
        Me.Panel1.TabIndex = 3
        '
        'btnNNGoc
        '
        Me.btnNNGoc.Dock = System.Windows.Forms.DockStyle.Right
        Me.btnNNGoc.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnNNGoc.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.btnNNGoc.Location = New System.Drawing.Point(196, 0)
        Me.btnNNGoc.Name = "btnNNGoc"
        Me.btnNNGoc.Size = New System.Drawing.Size(80, 26)
        Me.btnNNGoc.TabIndex = 16
        Me.btnNNGoc.Text = "&NNGoc"
        Me.btnNNGoc.UseVisualStyleBackColor = True
        Me.btnNNGoc.Visible = False
        '
        'txtTim
        '
        Me.txtTim.Anchor = CType((System.Windows.Forms.AnchorStyles.Bottom Or System.Windows.Forms.AnchorStyles.Left), System.Windows.Forms.AnchorStyles)
        Me.txtTim.Location = New System.Drawing.Point(0, 3)
        Me.txtTim.Name = "txtTim"
        Me.txtTim.Size = New System.Drawing.Size(160, 21)
        Me.txtTim.TabIndex = 14
        '
        'txtTK
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.txtTK, 2)
        Me.txtTK.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.txtTK.Location = New System.Drawing.Point(3, 567)
        Me.txtTK.Name = "txtTK"
        Me.txtTK.Size = New System.Drawing.Size(304, 21)
        Me.txtTK.TabIndex = 14
        '
        'TableLayoutPanel2
        '
        Me.TableLayoutPanel2.ColumnCount = 7
        Me.TableLayoutPanel2.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 70.0!))
        Me.TableLayoutPanel2.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 80.0!))
        Me.TableLayoutPanel2.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 70.0!))
        Me.TableLayoutPanel2.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 80.0!))
        Me.TableLayoutPanel2.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50.0!))
        Me.TableLayoutPanel2.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50.0!))
        Me.TableLayoutPanel2.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 70.0!))
        Me.TableLayoutPanel2.Controls.Add(Me.chkAllForm, 0, 0)
        Me.TableLayoutPanel2.Controls.Add(Me.txtChuoi, 5, 0)
        Me.TableLayoutPanel2.Controls.Add(Me.txtReplay, 4, 0)
        Me.TableLayoutPanel2.Controls.Add(Me.btnReplay, 6, 0)
        Me.TableLayoutPanel2.Controls.Add(Me.chkHoaThuong, 0, 0)
        Me.TableLayoutPanel2.Controls.Add(Me.chkAnh, 1, 0)
        Me.TableLayoutPanel2.Controls.Add(Me.chkDung, 3, 0)
        Me.TableLayoutPanel2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.TableLayoutPanel2.Location = New System.Drawing.Point(313, 32)
        Me.TableLayoutPanel2.Name = "TableLayoutPanel2"
        Me.TableLayoutPanel2.RowCount = 1
        Me.TableLayoutPanel2.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel2.Size = New System.Drawing.Size(596, 29)
        Me.TableLayoutPanel2.TabIndex = 15
        '
        'chkAllForm
        '
        Me.chkAllForm.AutoSize = True
        Me.chkAllForm.Dock = System.Windows.Forms.DockStyle.Fill
        Me.chkAllForm.Location = New System.Drawing.Point(73, 3)
        Me.chkAllForm.Name = "chkAllForm"
        Me.chkAllForm.Size = New System.Drawing.Size(74, 23)
        Me.chkAllForm.TabIndex = 20
        Me.chkAllForm.Text = "All form"
        Me.chkAllForm.UseVisualStyleBackColor = True
        '
        'txtChuoi
        '
        Me.txtChuoi.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtChuoi.Enabled = False
        Me.txtChuoi.Location = New System.Drawing.Point(416, 3)
        Me.txtChuoi.Name = "txtChuoi"
        Me.txtChuoi.Size = New System.Drawing.Size(107, 21)
        Me.txtChuoi.TabIndex = 16
        '
        'txtReplay
        '
        Me.txtReplay.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtReplay.Enabled = False
        Me.txtReplay.Location = New System.Drawing.Point(303, 3)
        Me.txtReplay.Name = "txtReplay"
        Me.txtReplay.Size = New System.Drawing.Size(107, 21)
        Me.txtReplay.TabIndex = 15
        '
        'btnReplay
        '
        Me.btnReplay.Dock = System.Windows.Forms.DockStyle.Fill
        Me.btnReplay.Enabled = False
        Me.btnReplay.Location = New System.Drawing.Point(529, 3)
        Me.btnReplay.Name = "btnReplay"
        Me.btnReplay.Size = New System.Drawing.Size(64, 23)
        Me.btnReplay.TabIndex = 17
        Me.btnReplay.Text = "Replay"
        Me.btnReplay.TextAlign = System.Drawing.ContentAlignment.TopCenter
        Me.btnReplay.UseVisualStyleBackColor = True
        '
        'chkHoaThuong
        '
        Me.chkHoaThuong.AutoSize = True
        Me.chkHoaThuong.Dock = System.Windows.Forms.DockStyle.Fill
        Me.chkHoaThuong.Location = New System.Drawing.Point(3, 3)
        Me.chkHoaThuong.Name = "chkHoaThuong"
        Me.chkHoaThuong.Size = New System.Drawing.Size(64, 23)
        Me.chkHoaThuong.TabIndex = 18
        Me.chkHoaThuong.Text = "Thuong"
        Me.chkHoaThuong.UseVisualStyleBackColor = True
        '
        'chkAnh
        '
        Me.chkAnh.AutoSize = True
        Me.chkAnh.Dock = System.Windows.Forms.DockStyle.Fill
        Me.chkAnh.Location = New System.Drawing.Point(153, 3)
        Me.chkAnh.Name = "chkAnh"
        Me.chkAnh.Size = New System.Drawing.Size(64, 23)
        Me.chkAnh.TabIndex = 19
        Me.chkAnh.Text = "Viet"
        Me.chkAnh.UseVisualStyleBackColor = True
        '
        'chkDung
        '
        Me.chkDung.AutoSize = True
        Me.chkDung.Dock = System.Windows.Forms.DockStyle.Fill
        Me.chkDung.Location = New System.Drawing.Point(223, 3)
        Me.chkDung.Name = "chkDung"
        Me.chkDung.Size = New System.Drawing.Size(74, 23)
        Me.chkDung.TabIndex = 21
        Me.chkDung.Text = "Dung"
        Me.chkDung.UseVisualStyleBackColor = True
        '
        'SplitContainer1
        '
        Me.TableLayoutPanel1.SetColumnSpan(Me.SplitContainer1, 3)
        Me.SplitContainer1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer1.Location = New System.Drawing.Point(3, 67)
        Me.SplitContainer1.Name = "SplitContainer1"
        '
        'SplitContainer1.Panel1
        '
        Me.SplitContainer1.Panel1.Controls.Add(Me.grpDanhsachform)
        '
        'SplitContainer1.Panel2
        '
        Me.SplitContainer1.Panel2.Controls.Add(Me.grpThongtinchitiet)
        Me.SplitContainer1.Size = New System.Drawing.Size(906, 489)
        Me.SplitContainer1.SplitterDistance = 306
        Me.SplitContainer1.TabIndex = 16
        '
        'frmLanguage
        '
        Me.Appearance.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Appearance.Options.UseFont = True
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 15.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(912, 591)
        Me.Controls.Add(Me.TableLayoutPanel1)
        Me.Controls.Add(Me.GroupBox1)
        Me.LookAndFeel.SkinName = "Blue"
        Me.LookAndFeel.UseDefaultLookAndFeel = False
        Me.MinimumSize = New System.Drawing.Size(686, 482)
        Me.Name = "frmLanguage"
        Me.Text = "Ngôn ngữ"
        Me.grpDanhsachform.ResumeLayout(False)
        CType(Me.grdForm, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.grvForm, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.GridView4, System.ComponentModel.ISupportInitialize).EndInit()
        Me.grpThongtinchitiet.ResumeLayout(False)
        CType(Me.grdThongtinchitiet, System.ComponentModel.ISupportInitialize).EndInit()
        Me.TableLayoutPanel1.ResumeLayout(False)
        Me.TableLayoutPanel1.PerformLayout()
        Me.Panel1.ResumeLayout(False)
        Me.Panel1.PerformLayout()
        Me.TableLayoutPanel2.ResumeLayout(False)
        Me.TableLayoutPanel2.PerformLayout()
        Me.SplitContainer1.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel2.ResumeLayout(False)
        Me.SplitContainer1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents lblTieude As System.Windows.Forms.Label
    Friend WithEvents grpDanhsachform As System.Windows.Forms.GroupBox
    Friend WithEvents grpThongtinchitiet As System.Windows.Forms.GroupBox
    Friend WithEvents grdThongtinchitiet As System.Windows.Forms.DataGridView
    Friend WithEvents BtnSua As System.Windows.Forms.Button
    Friend WithEvents BtnThoat As System.Windows.Forms.Button
    Friend WithEvents BtnGhi As System.Windows.Forms.Button
    Friend WithEvents BtnKhongghi As System.Windows.Forms.Button
    Friend WithEvents GroupBox1 As System.Windows.Forms.GroupBox
    Friend WithEvents rdReport As System.Windows.Forms.RadioButton
    Friend WithEvents rdForm As System.Windows.Forms.RadioButton
    Friend WithEvents TableLayoutPanel1 As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents Panel1 As System.Windows.Forms.Panel
    Friend WithEvents txtTK As System.Windows.Forms.TextBox
    Friend WithEvents TableLayoutPanel2 As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents txtChuoi As System.Windows.Forms.TextBox
    Friend WithEvents btnReplay As System.Windows.Forms.Button
    Friend WithEvents txtReplay As System.Windows.Forms.TextBox
    Friend WithEvents chkHoaThuong As System.Windows.Forms.CheckBox
    Friend WithEvents chkAnh As System.Windows.Forms.CheckBox
    Friend WithEvents chkAllForm As System.Windows.Forms.CheckBox
    Friend WithEvents btnNNGoc As System.Windows.Forms.Button
    Friend WithEvents chkDung As System.Windows.Forms.CheckBox
    Friend WithEvents SplitContainer1 As System.Windows.Forms.SplitContainer
    Friend WithEvents grdForm As DevExpress.XtraGrid.GridControl
    Friend WithEvents grvForm As DevExpress.XtraGrid.Views.Grid.GridView
    Friend WithEvents GridView4 As DevExpress.XtraGrid.Views.Grid.GridView
    Friend WithEvents txtTim As System.Windows.Forms.TextBox
End Class
