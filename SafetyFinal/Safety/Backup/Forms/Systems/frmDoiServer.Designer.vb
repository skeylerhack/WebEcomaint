<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmDoiServer
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
        Me.btnThoat = New DevExpress.XtraEditors.SimpleButton
        Me.lblServer = New DevExpress.XtraEditors.LabelControl
        Me.txtSerO = New DevExpress.XtraEditors.TextEdit
        Me.txtSerN = New DevExpress.XtraEditors.TextEdit
        Me.lblUser = New DevExpress.XtraEditors.LabelControl
        Me.txtUserO = New DevExpress.XtraEditors.TextEdit
        Me.txtUserN = New DevExpress.XtraEditors.TextEdit
        Me.lblPass = New DevExpress.XtraEditors.LabelControl
        Me.txtPassO = New DevExpress.XtraEditors.TextEdit
        Me.txtPassN = New DevExpress.XtraEditors.TextEdit
        Me.btnTFile = New DevExpress.XtraEditors.SimpleButton
        Me.btnCapNhap = New DevExpress.XtraEditors.SimpleButton
        Me.lblData = New DevExpress.XtraEditors.LabelControl
        Me.txtDataO = New DevExpress.XtraEditors.TextEdit
        Me.txtDataN = New DevExpress.XtraEditors.TextEdit
        Me.LabelControl1 = New DevExpress.XtraEditors.LabelControl
        Me.LabelControl2 = New DevExpress.XtraEditors.LabelControl
        CType(Me.txtSerO.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtSerN.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtUserO.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtUserN.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtPassO.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtPassN.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtDataO.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtDataN.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'btnThoat
        '
        Me.btnThoat.Location = New System.Drawing.Point(288, 117)
        Me.btnThoat.Name = "btnThoat"
        Me.btnThoat.Size = New System.Drawing.Size(114, 29)
        Me.btnThoat.TabIndex = 9
        Me.btnThoat.Text = "Thoát"
        '
        'lblServer
        '
        Me.lblServer.Location = New System.Drawing.Point(36, 24)
        Me.lblServer.Name = "lblServer"
        Me.lblServer.Size = New System.Drawing.Size(32, 13)
        Me.lblServer.TabIndex = 1
        Me.lblServer.Text = "Server"
        '
        'txtSerO
        '
        Me.txtSerO.Location = New System.Drawing.Point(127, 21)
        Me.txtSerO.Name = "txtSerO"
        Me.txtSerO.Properties.AppearanceReadOnly.BackColor = System.Drawing.SystemColors.Window
        Me.txtSerO.Properties.AppearanceReadOnly.Options.UseBackColor = True
        Me.txtSerO.Properties.ReadOnly = True
        Me.txtSerO.Size = New System.Drawing.Size(136, 20)
        Me.txtSerO.TabIndex = 1
        '
        'txtSerN
        '
        Me.txtSerN.Location = New System.Drawing.Point(281, 21)
        Me.txtSerN.Name = "txtSerN"
        Me.txtSerN.Size = New System.Drawing.Size(136, 20)
        Me.txtSerN.TabIndex = 2
        '
        'lblUser
        '
        Me.lblUser.Location = New System.Drawing.Point(36, 70)
        Me.lblUser.Name = "lblUser"
        Me.lblUser.Size = New System.Drawing.Size(44, 13)
        Me.lblUser.TabIndex = 1
        Me.lblUser.Text = "User SQL"
        '
        'txtUserO
        '
        Me.txtUserO.Location = New System.Drawing.Point(127, 67)
        Me.txtUserO.Name = "txtUserO"
        Me.txtUserO.Properties.AppearanceReadOnly.BackColor = System.Drawing.SystemColors.Window
        Me.txtUserO.Properties.AppearanceReadOnly.Options.UseBackColor = True
        Me.txtUserO.Properties.ReadOnly = True
        Me.txtUserO.Size = New System.Drawing.Size(136, 20)
        Me.txtUserO.TabIndex = 3
        '
        'txtUserN
        '
        Me.txtUserN.Location = New System.Drawing.Point(281, 67)
        Me.txtUserN.Name = "txtUserN"
        Me.txtUserN.Size = New System.Drawing.Size(136, 20)
        Me.txtUserN.TabIndex = 4
        '
        'lblPass
        '
        Me.lblPass.Location = New System.Drawing.Point(36, 93)
        Me.lblPass.Name = "lblPass"
        Me.lblPass.Size = New System.Drawing.Size(46, 13)
        Me.lblPass.TabIndex = 1
        Me.lblPass.Text = "Password"
        '
        'txtPassO
        '
        Me.txtPassO.Location = New System.Drawing.Point(127, 90)
        Me.txtPassO.Name = "txtPassO"
        Me.txtPassO.Properties.AppearanceReadOnly.BackColor = System.Drawing.SystemColors.Window
        Me.txtPassO.Properties.AppearanceReadOnly.Options.UseBackColor = True
        Me.txtPassO.Properties.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPassO.Properties.ReadOnly = True
        Me.txtPassO.Size = New System.Drawing.Size(136, 20)
        Me.txtPassO.TabIndex = 5
        '
        'txtPassN
        '
        Me.txtPassN.Location = New System.Drawing.Point(281, 90)
        Me.txtPassN.Name = "txtPassN"
        Me.txtPassN.Properties.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtPassN.Size = New System.Drawing.Size(136, 20)
        Me.txtPassN.TabIndex = 6
        '
        'btnTFile
        '
        Me.btnTFile.Location = New System.Drawing.Point(168, 117)
        Me.btnTFile.Name = "btnTFile"
        Me.btnTFile.Size = New System.Drawing.Size(114, 29)
        Me.btnTFile.TabIndex = 8
        Me.btnTFile.Text = "Tạo file mới"
        '
        'btnCapNhap
        '
        Me.btnCapNhap.Location = New System.Drawing.Point(48, 117)
        Me.btnCapNhap.Name = "btnCapNhap"
        Me.btnCapNhap.Size = New System.Drawing.Size(114, 29)
        Me.btnCapNhap.TabIndex = 7
        Me.btnCapNhap.Text = "Cập nhập"
        '
        'lblData
        '
        Me.lblData.Location = New System.Drawing.Point(36, 47)
        Me.lblData.Name = "lblData"
        Me.lblData.Size = New System.Drawing.Size(46, 13)
        Me.lblData.TabIndex = 1
        Me.lblData.Text = "Database"
        '
        'txtDataO
        '
        Me.txtDataO.Location = New System.Drawing.Point(127, 44)
        Me.txtDataO.Name = "txtDataO"
        Me.txtDataO.Properties.AppearanceReadOnly.BackColor = System.Drawing.SystemColors.Window
        Me.txtDataO.Properties.AppearanceReadOnly.Options.UseBackColor = True
        Me.txtDataO.Properties.ReadOnly = True
        Me.txtDataO.Size = New System.Drawing.Size(136, 20)
        Me.txtDataO.TabIndex = 1
        '
        'txtDataN
        '
        Me.txtDataN.Location = New System.Drawing.Point(281, 44)
        Me.txtDataN.Name = "txtDataN"
        Me.txtDataN.Size = New System.Drawing.Size(136, 20)
        Me.txtDataN.TabIndex = 2
        '
        'LabelControl1
        '
        Me.LabelControl1.Appearance.Options.UseTextOptions = True
        Me.LabelControl1.Appearance.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center
        Me.LabelControl1.AutoSizeMode = DevExpress.XtraEditors.LabelAutoSizeMode.None
        Me.LabelControl1.Location = New System.Drawing.Point(127, 2)
        Me.LabelControl1.Name = "LabelControl1"
        Me.LabelControl1.Size = New System.Drawing.Size(136, 20)
        Me.LabelControl1.TabIndex = 1
        Me.LabelControl1.Text = "Giá trị cũ"
        '
        'LabelControl2
        '
        Me.LabelControl2.Appearance.Options.UseTextOptions = True
        Me.LabelControl2.Appearance.TextOptions.HAlignment = DevExpress.Utils.HorzAlignment.Center
        Me.LabelControl2.AutoSizeMode = DevExpress.XtraEditors.LabelAutoSizeMode.None
        Me.LabelControl2.Location = New System.Drawing.Point(281, 2)
        Me.LabelControl2.Name = "LabelControl2"
        Me.LabelControl2.Size = New System.Drawing.Size(136, 20)
        Me.LabelControl2.TabIndex = 1
        Me.LabelControl2.Text = "Giá trị mới"
        '
        'frmDoiServer
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(453, 152)
        Me.Controls.Add(Me.txtPassN)
        Me.Controls.Add(Me.txtUserN)
        Me.Controls.Add(Me.txtDataN)
        Me.Controls.Add(Me.txtSerN)
        Me.Controls.Add(Me.txtPassO)
        Me.Controls.Add(Me.txtUserO)
        Me.Controls.Add(Me.txtDataO)
        Me.Controls.Add(Me.txtSerO)
        Me.Controls.Add(Me.lblPass)
        Me.Controls.Add(Me.lblUser)
        Me.Controls.Add(Me.lblData)
        Me.Controls.Add(Me.LabelControl2)
        Me.Controls.Add(Me.LabelControl1)
        Me.Controls.Add(Me.lblServer)
        Me.Controls.Add(Me.btnCapNhap)
        Me.Controls.Add(Me.btnTFile)
        Me.Controls.Add(Me.btnThoat)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.LookAndFeel.SkinName = "Blue"
        Me.LookAndFeel.UseDefaultLookAndFeel = False
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmDoiServer"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent
        Me.Text = "frmDoiServer"
        CType(Me.txtSerO.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtSerN.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtUserO.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtUserN.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtPassO.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtPassN.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtDataO.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtDataN.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnThoat As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents lblServer As DevExpress.XtraEditors.LabelControl
    Friend WithEvents txtSerO As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtSerN As DevExpress.XtraEditors.TextEdit
    Friend WithEvents lblUser As DevExpress.XtraEditors.LabelControl
    Friend WithEvents txtUserO As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtUserN As DevExpress.XtraEditors.TextEdit
    Friend WithEvents lblPass As DevExpress.XtraEditors.LabelControl
    Friend WithEvents txtPassO As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtPassN As DevExpress.XtraEditors.TextEdit
    Friend WithEvents btnTFile As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnCapNhap As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents lblData As DevExpress.XtraEditors.LabelControl
    Friend WithEvents txtDataO As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtDataN As DevExpress.XtraEditors.TextEdit
    Friend WithEvents LabelControl1 As DevExpress.XtraEditors.LabelControl
    Friend WithEvents LabelControl2 As DevExpress.XtraEditors.LabelControl
End Class
