<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmDKKN
    Inherits System.Windows.Forms.Form

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
        Me.label3 = New System.Windows.Forms.Label
        Me.label4 = New System.Windows.Forms.Label
        Me.rdbSQL = New System.Windows.Forms.RadioButton
        Me.rdbHethong = New System.Windows.Forms.RadioButton
        Me.label2 = New System.Windows.Forms.Label
        Me.label1 = New System.Windows.Forms.Label
        Me.btnThuketnoi = New DevExpress.XtraEditors.SimpleButton
        Me.btnLuu = New DevExpress.XtraEditors.SimpleButton
        Me.txtMaychu = New DevExpress.XtraEditors.TextEdit
        Me.txtCSDL = New DevExpress.XtraEditors.TextEdit
        Me.txtTaikhoan = New DevExpress.XtraEditors.TextEdit
        Me.txtMatkhau = New DevExpress.XtraEditors.TextEdit
        Me.groupBox1 = New DevExpress.XtraEditors.GroupControl
        CType(Me.txtMaychu.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtCSDL.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtTaikhoan.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.txtMatkhau.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.groupBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.groupBox1.SuspendLayout()
        Me.SuspendLayout()
        '
        'label3
        '
        Me.label3.AutoSize = True
        Me.label3.Location = New System.Drawing.Point(5, 170)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(53, 13)
        Me.label3.TabIndex = 20
        Me.label3.Text = "Password"
        '
        'label4
        '
        Me.label4.AutoSize = True
        Me.label4.Location = New System.Drawing.Point(5, 143)
        Me.label4.Name = "label4"
        Me.label4.Size = New System.Drawing.Size(58, 13)
        Me.label4.TabIndex = 17
        Me.label4.Text = "User name"
        '
        'rdbSQL
        '
        Me.rdbSQL.AutoSize = True
        Me.rdbSQL.Location = New System.Drawing.Point(24, 48)
        Me.rdbSQL.Name = "rdbSQL"
        Me.rdbSQL.Size = New System.Drawing.Size(173, 17)
        Me.rdbSQL.TabIndex = 4
        Me.rdbSQL.Text = "Use SQL Server Authentication"
        Me.rdbSQL.UseVisualStyleBackColor = True
        '
        'rdbHethong
        '
        Me.rdbHethong.AutoSize = True
        Me.rdbHethong.Checked = True
        Me.rdbHethong.Location = New System.Drawing.Point(24, 25)
        Me.rdbHethong.Name = "rdbHethong"
        Me.rdbHethong.Size = New System.Drawing.Size(157, 17)
        Me.rdbHethong.TabIndex = 3
        Me.rdbHethong.TabStop = True
        Me.rdbHethong.Text = "Use Window Authentication"
        Me.rdbHethong.UseVisualStyleBackColor = True
        '
        'label2
        '
        Me.label2.AutoSize = True
        Me.label2.Location = New System.Drawing.Point(5, 41)
        Me.label2.Name = "label2"
        Me.label2.Size = New System.Drawing.Size(53, 13)
        Me.label2.TabIndex = 14
        Me.label2.Text = "Database"
        '
        'label1
        '
        Me.label1.AutoSize = True
        Me.label1.Location = New System.Drawing.Point(5, 15)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(53, 13)
        Me.label1.TabIndex = 13
        Me.label1.Text = "Server/IP"
        '
        'btnThuketnoi
        '
        Me.btnThuketnoi.Location = New System.Drawing.Point(67, 196)
        Me.btnThuketnoi.Name = "btnThuketnoi"
        Me.btnThuketnoi.Size = New System.Drawing.Size(93, 23)
        Me.btnThuketnoi.TabIndex = 7
        Me.btnThuketnoi.Text = "Connect"
        '
        'btnLuu
        '
        Me.btnLuu.Location = New System.Drawing.Point(166, 196)
        Me.btnLuu.Name = "btnLuu"
        Me.btnLuu.Size = New System.Drawing.Size(98, 23)
        Me.btnLuu.TabIndex = 8
        Me.btnLuu.Text = "Save Setting"
        '
        'txtMaychu
        '
        Me.txtMaychu.Location = New System.Drawing.Point(67, 11)
        Me.txtMaychu.Name = "txtMaychu"
        Me.txtMaychu.Size = New System.Drawing.Size(197, 20)
        Me.txtMaychu.TabIndex = 0
        '
        'txtCSDL
        '
        Me.txtCSDL.Location = New System.Drawing.Point(67, 38)
        Me.txtCSDL.Name = "txtCSDL"
        Me.txtCSDL.Size = New System.Drawing.Size(197, 20)
        Me.txtCSDL.TabIndex = 1
        '
        'txtTaikhoan
        '
        Me.txtTaikhoan.Location = New System.Drawing.Point(67, 140)
        Me.txtTaikhoan.Name = "txtTaikhoan"
        Me.txtTaikhoan.Size = New System.Drawing.Size(197, 20)
        Me.txtTaikhoan.TabIndex = 5
        '
        'txtMatkhau
        '
        Me.txtMatkhau.Location = New System.Drawing.Point(67, 167)
        Me.txtMatkhau.Name = "txtMatkhau"
        Me.txtMatkhau.Properties.PasswordChar = Global.Microsoft.VisualBasic.ChrW(42)
        Me.txtMatkhau.Size = New System.Drawing.Size(197, 20)
        Me.txtMatkhau.TabIndex = 6
        '
        'groupBox1
        '
        Me.groupBox1.Controls.Add(Me.rdbSQL)
        Me.groupBox1.Controls.Add(Me.rdbHethong)
        Me.groupBox1.Location = New System.Drawing.Point(4, 64)
        Me.groupBox1.Name = "groupBox1"
        Me.groupBox1.Size = New System.Drawing.Size(260, 70)
        Me.groupBox1.TabIndex = 2
        Me.groupBox1.Text = "Log on to server"
        '
        'FrmDKKN
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(269, 226)
        Me.Controls.Add(Me.groupBox1)
        Me.Controls.Add(Me.txtMatkhau)
        Me.Controls.Add(Me.txtTaikhoan)
        Me.Controls.Add(Me.txtCSDL)
        Me.Controls.Add(Me.txtMaychu)
        Me.Controls.Add(Me.btnLuu)
        Me.Controls.Add(Me.btnThuketnoi)
        Me.Controls.Add(Me.label3)
        Me.Controls.Add(Me.label4)
        Me.Controls.Add(Me.label2)
        Me.Controls.Add(Me.label1)
        Me.Name = "FrmDKKN"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "FrmDKKN"
        CType(Me.txtMaychu.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtCSDL.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtTaikhoan.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.txtMatkhau.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.groupBox1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.groupBox1.ResumeLayout(False)
        Me.groupBox1.PerformLayout()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Private WithEvents label3 As System.Windows.Forms.Label
    Private WithEvents label4 As System.Windows.Forms.Label
    Private WithEvents rdbSQL As System.Windows.Forms.RadioButton
    Private WithEvents rdbHethong As System.Windows.Forms.RadioButton
    Private WithEvents label2 As System.Windows.Forms.Label
    Private WithEvents label1 As System.Windows.Forms.Label
    Friend WithEvents btnThuketnoi As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents btnLuu As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents txtMaychu As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtCSDL As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtTaikhoan As DevExpress.XtraEditors.TextEdit
    Friend WithEvents txtMatkhau As DevExpress.XtraEditors.TextEdit
    Friend WithEvents groupBox1 As DevExpress.XtraEditors.GroupControl
End Class
