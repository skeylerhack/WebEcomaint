<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmReport
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
        Me.txtNguoiBC = New DevExpress.XtraEditors.TextEdit()
        Me.txtGhiChu = New DevExpress.XtraEditors.TextEdit()
        Me.dtNgayHT = New System.Windows.Forms.DateTimePicker()
        Me.Label1 = New System.Windows.Forms.Label()
        Me.Label2 = New System.Windows.Forms.Label()
        Me.Label3 = New System.Windows.Forms.Label()
        Me.btnBC = New DevExpress.XtraEditors.SimpleButton()
        Me.btnThoat = New DevExpress.XtraEditors.SimpleButton()
        Me.SimpleButton1 = New DevExpress.XtraEditors.SimpleButton()
        Me.btnKhongTH = New DevExpress.XtraEditors.SimpleButton()
        CType(Me.txtNguoiBC.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtGhiChu.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'txtNguoiBC
        '
        Me.txtNguoiBC.EditValue = ""
        Me.txtNguoiBC.Enabled = False
        Me.txtNguoiBC.Location = New System.Drawing.Point(109, 12)
        Me.txtNguoiBC.Name = "txtNguoiBC"
        Me.txtNguoiBC.Size = New System.Drawing.Size(126, 20)
        Me.txtNguoiBC.TabIndex = 1
        '
        'txtGhiChu
        '
        Me.txtGhiChu.EditValue = ""
        Me.txtGhiChu.Location = New System.Drawing.Point(109, 86)
        Me.txtGhiChu.Name = "txtGhiChu"
        Me.txtGhiChu.Size = New System.Drawing.Size(320, 20)
        Me.txtGhiChu.TabIndex = 3
        '
        'dtNgayHT
        '
        Me.dtNgayHT.CustomFormat = "dd/MM/yyyy"
        Me.dtNgayHT.Format = System.Windows.Forms.DateTimePickerFormat.Custom
        Me.dtNgayHT.Location = New System.Drawing.Point(109, 48)
        Me.dtNgayHT.Name = "dtNgayHT"
        Me.dtNgayHT.Size = New System.Drawing.Size(126, 21)
        Me.dtNgayHT.TabIndex = 2
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(13, 15)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(76, 13)
        Me.Label1.TabIndex = 44
        Me.Label1.Text = "Người báo cáo"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(13, 51)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(90, 13)
        Me.Label2.TabIndex = 45
        Me.Label2.Text = "Ngày hoàn thành"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(13, 89)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(42, 13)
        Me.Label3.TabIndex = 46
        Me.Label3.Text = "Ghi chú"
        '
        'btnBC
        '
        Me.btnBC.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnBC.Appearance.Options.UseFont = True
        Me.btnBC.Location = New System.Drawing.Point(16, 153)
        Me.btnBC.Name = "btnBC"
        Me.btnBC.Size = New System.Drawing.Size(86, 25)
        Me.btnBC.TabIndex = 4
        Me.btnBC.Text = "Thực hiện"
        '
        'btnThoat
        '
        Me.btnThoat.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnThoat.Appearance.Options.UseFont = True
        Me.btnThoat.Location = New System.Drawing.Point(335, 153)
        Me.btnThoat.Name = "btnThoat"
        Me.btnThoat.Size = New System.Drawing.Size(94, 25)
        Me.btnThoat.TabIndex = 6
        Me.btnThoat.Text = "Thoát"
        '
        'SimpleButton1
        '
        Me.SimpleButton1.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.SimpleButton1.Appearance.Options.UseFont = True
        Me.SimpleButton1.Location = New System.Drawing.Point(234, 153)
        Me.SimpleButton1.Name = "SimpleButton1"
        Me.SimpleButton1.Size = New System.Drawing.Size(95, 25)
        Me.SimpleButton1.TabIndex = 5
        Me.SimpleButton1.Text = "Xóa thông tin"
        '
        'btnKhongTH
        '
        Me.btnKhongTH.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnKhongTH.Appearance.Options.UseFont = True
        Me.btnKhongTH.Location = New System.Drawing.Point(109, 153)
        Me.btnKhongTH.Name = "btnKhongTH"
        Me.btnKhongTH.Size = New System.Drawing.Size(119, 25)
        Me.btnKhongTH.TabIndex = 47
        Me.btnKhongTH.Text = "Không thực hiện"
        '
        'FrmReport
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(446, 201)
        Me.Controls.Add(Me.btnKhongTH)
        Me.Controls.Add(Me.SimpleButton1)
        Me.Controls.Add(Me.btnThoat)
        Me.Controls.Add(Me.btnBC)
        Me.Controls.Add(Me.Label3)
        Me.Controls.Add(Me.Label2)
        Me.Controls.Add(Me.Label1)
        Me.Controls.Add(Me.dtNgayHT)
        Me.Controls.Add(Me.txtGhiChu)
        Me.Controls.Add(Me.txtNguoiBC)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.LookAndFeel.SkinName = "Blue"
        Me.LookAndFeel.UseDefaultLookAndFeel = False
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "FrmReport"
        Me.ShowIcon = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Report"
        CType(Me.txtNguoiBC.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtGhiChu.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents txtNguoiBC As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtGhiChu As DevExpress.XtraEditors.TextEdit
    Friend WithEvents dtNgayHT As System.Windows.Forms.DateTimePicker
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents btnBC As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnThoat As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents SimpleButton1 As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnKhongTH As DevExpress.XtraEditors.SimpleButton
End Class
