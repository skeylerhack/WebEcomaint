<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()>
Partial Class FrmXNGuiMail
    Inherits DevExpress.XtraEditors.XtraForm

    'Form overrides dispose to clean up the component list.
    <System.Diagnostics.DebuggerNonUserCode()>
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
    <System.Diagnostics.DebuggerStepThrough()>
    Private Sub InitializeComponent()
        Me.btnThucHien = New DevExpress.XtraEditors.SimpleButton()
        Me.label3 = New System.Windows.Forms.Label()
        Me.label4 = New System.Windows.Forms.Label()
        Me.ProgressBarControl1 = New DevExpress.XtraEditors.ProgressBarControl()
        Me.btnCancel = New DevExpress.XtraEditors.SimpleButton()
        Me.CheckedComboBoxEdit1 = New DevExpress.XtraEditors.CheckedComboBoxEdit()
        Me.txtEmailCC = New System.Windows.Forms.TextBox()
        Me.txtEmailTo = New System.Windows.Forms.TextBox()
        Me.txtLydo = New System.Windows.Forms.TextBox()
        Me.lbLydo = New System.Windows.Forms.Label()
        Me.btnTKNG = New DevExpress.XtraEditors.SimpleButton()
        Me.txtLstmailHSE = New System.Windows.Forms.TextBox()
        CType(Me.ProgressBarControl1.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.CheckedComboBoxEdit1.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'btnThucHien
        '
        Me.btnThucHien.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnThucHien.Appearance.Options.UseFont = True
        Me.btnThucHien.Location = New System.Drawing.Point(75, 244)
        Me.btnThucHien.Name = "btnThucHien"
        Me.btnThucHien.Size = New System.Drawing.Size(254, 27)
        Me.btnThucHien.TabIndex = 29
        Me.btnThucHien.Text = "Thực hiện gửi mail"
        '
        'label3
        '
        Me.label3.AutoSize = True
        Me.label3.Location = New System.Drawing.Point(11, 72)
        Me.label3.Name = "label3"
        Me.label3.Size = New System.Drawing.Size(50, 13)
        Me.label3.TabIndex = 28
        Me.label3.Text = "Gửi thêm"
        '
        'label4
        '
        Me.label4.AutoSize = True
        Me.label4.Location = New System.Drawing.Point(11, 18)
        Me.label4.Name = "label4"
        Me.label4.Size = New System.Drawing.Size(38, 13)
        Me.label4.TabIndex = 27
        Me.label4.Text = "Gửi tới"
        '
        'ProgressBarControl1
        '
        Me.ProgressBarControl1.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.ProgressBarControl1.EditValue = "0"
        Me.ProgressBarControl1.Location = New System.Drawing.Point(0, 285)
        Me.ProgressBarControl1.Name = "ProgressBarControl1"
        Me.ProgressBarControl1.Properties.ShowTitle = True
        Me.ProgressBarControl1.Size = New System.Drawing.Size(602, 22)
        Me.ProgressBarControl1.TabIndex = 32
        '
        'btnCancel
        '
        Me.btnCancel.Appearance.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.btnCancel.Appearance.Options.UseFont = True
        Me.btnCancel.Location = New System.Drawing.Point(335, 244)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(254, 27)
        Me.btnCancel.TabIndex = 33
        Me.btnCancel.Text = "Không cần gửi mail"
        '
        'CheckedComboBoxEdit1
        '
        Me.CheckedComboBoxEdit1.EditValue = ""
        Me.CheckedComboBoxEdit1.Location = New System.Drawing.Point(75, 69)
        Me.CheckedComboBoxEdit1.Name = "CheckedComboBoxEdit1"
        Me.CheckedComboBoxEdit1.Properties.Buttons.AddRange(New DevExpress.XtraEditors.Controls.EditorButton() {New DevExpress.XtraEditors.Controls.EditorButton(DevExpress.XtraEditors.Controls.ButtonPredefines.Combo)})
        Me.CheckedComboBoxEdit1.Size = New System.Drawing.Size(481, 20)
        Me.CheckedComboBoxEdit1.TabIndex = 35
        '
        'txtEmailCC
        '
        Me.txtEmailCC.BackColor = System.Drawing.SystemColors.Window
        Me.txtEmailCC.Location = New System.Drawing.Point(75, 90)
        Me.txtEmailCC.Multiline = True
        Me.txtEmailCC.Name = "txtEmailCC"
        Me.txtEmailCC.Size = New System.Drawing.Size(514, 80)
        Me.txtEmailCC.TabIndex = 36
        '
        'txtEmailTo
        '
        Me.txtEmailTo.BackColor = System.Drawing.SystemColors.Window
        Me.txtEmailTo.Location = New System.Drawing.Point(75, 15)
        Me.txtEmailTo.Multiline = True
        Me.txtEmailTo.Name = "txtEmailTo"
        Me.txtEmailTo.ReadOnly = True
        Me.txtEmailTo.Size = New System.Drawing.Size(514, 47)
        Me.txtEmailTo.TabIndex = 37
        '
        'txtLydo
        '
        Me.txtLydo.BackColor = System.Drawing.SystemColors.Window
        Me.txtLydo.Location = New System.Drawing.Point(75, 178)
        Me.txtLydo.Multiline = True
        Me.txtLydo.Name = "txtLydo"
        Me.txtLydo.Size = New System.Drawing.Size(514, 50)
        Me.txtLydo.TabIndex = 38
        Me.txtLydo.Visible = False
        '
        'lbLydo
        '
        Me.lbLydo.AutoSize = True
        Me.lbLydo.Location = New System.Drawing.Point(11, 181)
        Me.lbLydo.Name = "lbLydo"
        Me.lbLydo.Size = New System.Drawing.Size(54, 13)
        Me.lbLydo.TabIndex = 39
        Me.lbLydo.Text = "Lý do xóa"
        Me.lbLydo.Visible = False
        '
        'btnTKNG
        '
        Me.btnTKNG.Location = New System.Drawing.Point(558, 69)
        Me.btnTKNG.Name = "btnTKNG"
        Me.btnTKNG.Size = New System.Drawing.Size(31, 20)
        Me.btnTKNG.TabIndex = 100
        Me.btnTKNG.Text = "+"
        '
        'txtLstmailHSE
        '
        Me.txtLstmailHSE.BackColor = System.Drawing.Color.White
        Me.txtLstmailHSE.Font = New System.Drawing.Font("Tahoma", 8.25!)
        Me.txtLstmailHSE.Location = New System.Drawing.Point(75, 90)
        Me.txtLstmailHSE.Multiline = True
        Me.txtLstmailHSE.Name = "txtLstmailHSE"
        Me.txtLstmailHSE.ReadOnly = True
        Me.txtLstmailHSE.Size = New System.Drawing.Size(514, 35)
        Me.txtLstmailHSE.TabIndex = 101
        Me.txtLstmailHSE.Text = "vinh.tran@bariaserece.com; safetysup@bariaserece.com; dat.le@bariaserece.com"
        Me.txtLstmailHSE.Visible = False
        '
        'FrmXNGuiMail
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(602, 307)
        Me.ControlBox = False
        Me.Controls.Add(Me.btnTKNG)
        Me.Controls.Add(Me.lbLydo)
        Me.Controls.Add(Me.txtLydo)
        Me.Controls.Add(Me.txtEmailTo)
        Me.Controls.Add(Me.txtEmailCC)
        Me.Controls.Add(Me.CheckedComboBoxEdit1)
        Me.Controls.Add(Me.btnCancel)
        Me.Controls.Add(Me.ProgressBarControl1)
        Me.Controls.Add(Me.btnThucHien)
        Me.Controls.Add(Me.label3)
        Me.Controls.Add(Me.label4)
        Me.Controls.Add(Me.txtLstmailHSE)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.LookAndFeel.SkinName = "Blue"
        Me.LookAndFeel.UseDefaultLookAndFeel = False
        Me.Name = "FrmXNGuiMail"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Xác nhận gửi mail"
        CType(Me.ProgressBarControl1.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.CheckedComboBoxEdit1.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Friend WithEvents btnThucHien As DevExpress.XtraEditors.SimpleButton
    Private WithEvents label3 As System.Windows.Forms.Label
    Private WithEvents label4 As System.Windows.Forms.Label
    Friend WithEvents ProgressBarControl1 As DevExpress.XtraEditors.ProgressBarControl
    Friend WithEvents btnCancel As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents CheckedComboBoxEdit1 As DevExpress.XtraEditors.CheckedComboBoxEdit
    Friend WithEvents txtEmailCC As System.Windows.Forms.TextBox
    Friend WithEvents txtEmailTo As System.Windows.Forms.TextBox
    Friend WithEvents txtLydo As System.Windows.Forms.TextBox
    Private WithEvents lbLydo As System.Windows.Forms.Label
    Friend WithEvents btnTKNG As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents txtLstmailHSE As System.Windows.Forms.TextBox
End Class
