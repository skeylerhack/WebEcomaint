<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmLogin
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
        Me.labUserName = New System.Windows.Forms.Label()
        Me.labPassword = New System.Windows.Forms.Label()
        Me.btnCancel = New System.Windows.Forms.Button()
        Me.btnLogin = New System.Windows.Forms.Button()
        Me.errProvider = New System.Windows.Forms.ErrorProvider()
        Me.labDbName = New System.Windows.Forms.Label()
        Me.chkRememberUser = New System.Windows.Forms.CheckBox()
        Me.tlMain = New System.Windows.Forms.TableLayoutPanel()
        Me.txtPassword = New Commons.utcTextBox()
        Me.txtUserName = New Commons.utcTextBox()
        Me.cboDatabase = New Commons.UtcComboBox()
        Me.chkRememberpass = New System.Windows.Forms.CheckBox()
        Me.LabelControl1 = New DevExpress.XtraEditors.LabelControl()
        CType(Me.errProvider, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.tlMain.SuspendLayout()
        Me.SuspendLayout()
        '
        'labUserName
        '
        Me.labUserName.Dock = System.Windows.Forms.DockStyle.Fill
        Me.labUserName.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.labUserName.ForeColor = System.Drawing.Color.Black
        Me.labUserName.Location = New System.Drawing.Point(3, 33)
        Me.labUserName.Name = "labUserName"
        Me.labUserName.Size = New System.Drawing.Size(89, 33)
        Me.labUserName.TabIndex = 6
        Me.labUserName.Text = "User name"
        Me.labUserName.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'labPassword
        '
        Me.labPassword.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.labPassword.ForeColor = System.Drawing.Color.Black
        Me.labPassword.Location = New System.Drawing.Point(3, 66)
        Me.labPassword.Name = "labPassword"
        Me.labPassword.Size = New System.Drawing.Size(89, 30)
        Me.labPassword.TabIndex = 8
        Me.labPassword.Text = "Password"
        Me.labPassword.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'btnCancel
        '
        Me.btnCancel.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnCancel.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.btnCancel.Location = New System.Drawing.Point(245, 136)
        Me.btnCancel.Name = "btnCancel"
        Me.btnCancel.Size = New System.Drawing.Size(79, 26)
        Me.btnCancel.TabIndex = 11
        Me.btnCancel.Text = "&Cancel"
        Me.btnCancel.UseVisualStyleBackColor = True
        '
        'btnLogin
        '
        Me.btnLogin.Anchor = CType((System.Windows.Forms.AnchorStyles.Top Or System.Windows.Forms.AnchorStyles.Right), System.Windows.Forms.AnchorStyles)
        Me.btnLogin.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnLogin.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.btnLogin.Location = New System.Drawing.Point(160, 136)
        Me.btnLogin.Name = "btnLogin"
        Me.btnLogin.Size = New System.Drawing.Size(79, 26)
        Me.btnLogin.TabIndex = 10
        Me.btnLogin.Text = "&Login"
        Me.btnLogin.UseVisualStyleBackColor = True
        '
        'errProvider
        '
        Me.errProvider.ContainerControl = Me
        '
        'labDbName
        '
        Me.labDbName.Dock = System.Windows.Forms.DockStyle.Fill
        Me.labDbName.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.labDbName.Location = New System.Drawing.Point(3, 0)
        Me.labDbName.Name = "labDbName"
        Me.labDbName.Size = New System.Drawing.Size(89, 33)
        Me.labDbName.TabIndex = 12
        Me.labDbName.Text = "Database "
        Me.labDbName.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        '
        'chkRememberUser
        '
        Me.chkRememberUser.Dock = System.Windows.Forms.DockStyle.Fill
        Me.chkRememberUser.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkRememberUser.Location = New System.Drawing.Point(98, 99)
        Me.chkRememberUser.Name = "chkRememberUser"
        Me.chkRememberUser.Size = New System.Drawing.Size(141, 31)
        Me.chkRememberUser.TabIndex = 14
        Me.chkRememberUser.Text = "Remember user"
        Me.chkRememberUser.UseVisualStyleBackColor = True
        '
        'tlMain
        '
        Me.tlMain.BackColor = System.Drawing.Color.Transparent
        Me.tlMain.ColumnCount = 3
        Me.tlMain.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 95.0!))
        Me.tlMain.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 45.45454!))
        Me.tlMain.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 54.54546!))
        Me.tlMain.Controls.Add(Me.btnLogin, 1, 4)
        Me.tlMain.Controls.Add(Me.labUserName, 0, 1)
        Me.tlMain.Controls.Add(Me.labPassword, 0, 2)
        Me.tlMain.Controls.Add(Me.btnCancel, 2, 4)
        Me.tlMain.Controls.Add(Me.txtPassword, 1, 2)
        Me.tlMain.Controls.Add(Me.txtUserName, 1, 1)
        Me.tlMain.Controls.Add(Me.labDbName, 0, 0)
        Me.tlMain.Controls.Add(Me.cboDatabase, 1, 0)
        Me.tlMain.Controls.Add(Me.chkRememberUser, 1, 3)
        Me.tlMain.Controls.Add(Me.chkRememberpass, 2, 3)
        Me.tlMain.Location = New System.Drawing.Point(130, 126)
        Me.tlMain.Name = "tlMain"
        Me.tlMain.RowCount = 5
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25.0!))
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 24.8!))
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 22.55639!))
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 27.81955!))
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30.0!))
        Me.tlMain.Size = New System.Drawing.Size(420, 165)
        Me.tlMain.TabIndex = 15
        '
        'txtPassword
        '
        Me.txtPassword.BackColor = System.Drawing.Color.White
        Me.tlMain.SetColumnSpan(Me.txtPassword, 2)
        Me.txtPassword.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtPassword.ErrorProviderControl = Me.errProvider
        Me.txtPassword.FieldName = ""
        Me.txtPassword.IsNull = False
        Me.txtPassword.Location = New System.Drawing.Point(98, 69)
        Me.txtPassword.Margin = New System.Windows.Forms.Padding(3, 3, 15, 3)
        Me.txtPassword.MaxLength = 0
        Me.txtPassword.Name = "txtPassword"
        Me.txtPassword.PasswordChar = Global.Microsoft.VisualBasic.ChrW(9679)
        Me.txtPassword.Size = New System.Drawing.Size(307, 21)
        Me.txtPassword.TabIndex = 9
        Me.txtPassword.TextTypeMode = Commons.TypeMode.None
        '
        'txtUserName
        '
        Me.txtUserName.BackColor = System.Drawing.Color.White
        Me.tlMain.SetColumnSpan(Me.txtUserName, 2)
        Me.txtUserName.Dock = System.Windows.Forms.DockStyle.Fill
        Me.txtUserName.ErrorProviderControl = Me.errProvider
        Me.txtUserName.FieldName = ""
        Me.txtUserName.IsNull = False
        Me.txtUserName.Location = New System.Drawing.Point(98, 36)
        Me.txtUserName.Margin = New System.Windows.Forms.Padding(3, 3, 15, 3)
        Me.txtUserName.MaxLength = 0
        Me.txtUserName.Name = "txtUserName"
        Me.txtUserName.Size = New System.Drawing.Size(307, 21)
        Me.txtUserName.TabIndex = 7
        Me.txtUserName.TextTypeMode = Commons.TypeMode.None
        '
        'cboDatabase
        '
        Me.cboDatabase.AssemblyName = ""
        Me.cboDatabase.AutoCompleteMode = System.Windows.Forms.AutoCompleteMode.SuggestAppend
        Me.cboDatabase.AutoCompleteSource = System.Windows.Forms.AutoCompleteSource.ListItems
        Me.cboDatabase.BackColor = System.Drawing.SystemColors.Window
        Me.cboDatabase.ClassName = ""
        Me.tlMain.SetColumnSpan(Me.cboDatabase, 2)
        Me.cboDatabase.Display = ""
        Me.cboDatabase.Dock = System.Windows.Forms.DockStyle.Fill
        Me.cboDatabase.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList
        Me.cboDatabase.ErrorProviderControl = Me.errProvider
        Me.cboDatabase.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboDatabase.ForeColor = System.Drawing.Color.Navy
        Me.cboDatabase.FormattingEnabled = True
        Me.cboDatabase.IsAll = False
        Me.cboDatabase.isInputNull = False
        Me.cboDatabase.IsNew = False
        Me.cboDatabase.IsNull = True
        Me.cboDatabase.ItemAll = " < ALL > "
        Me.cboDatabase.ItemNew = "...New"
        Me.cboDatabase.Location = New System.Drawing.Point(98, 3)
        Me.cboDatabase.Margin = New System.Windows.Forms.Padding(3, 3, 15, 3)
        Me.cboDatabase.MethodName = ""
        Me.cboDatabase.Name = "cboDatabase"
        Me.cboDatabase.Param = ""
        Me.cboDatabase.Param2 = ""
        Me.cboDatabase.Size = New System.Drawing.Size(307, 23)
        Me.cboDatabase.StoreName = ""
        Me.cboDatabase.TabIndex = 13
        Me.cboDatabase.Table = Nothing
        Me.cboDatabase.TextReadonly = False
        Me.cboDatabase.Value = ""
        '
        'chkRememberpass
        '
        Me.chkRememberpass.Dock = System.Windows.Forms.DockStyle.Fill
        Me.chkRememberpass.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkRememberpass.Location = New System.Drawing.Point(245, 99)
        Me.chkRememberpass.Name = "chkRememberpass"
        Me.chkRememberpass.Size = New System.Drawing.Size(172, 31)
        Me.chkRememberpass.TabIndex = 15
        Me.chkRememberpass.Text = "Remember password"
        Me.chkRememberpass.UseVisualStyleBackColor = True
        '
        'LabelControl1
        '
        Me.LabelControl1.AutoSizeMode = DevExpress.XtraEditors.LabelAutoSizeMode.None
        Me.LabelControl1.Location = New System.Drawing.Point(89, 296)
        Me.LabelControl1.Name = "LabelControl1"
        Me.LabelControl1.Size = New System.Drawing.Size(22, 21)
        Me.LabelControl1.TabIndex = 16
        '
        'frmLogin
        '
        Me.Appearance.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Appearance.Options.UseFont = True
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 15.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.AutoSize = True
        Me.BackgroundImageLayoutStore = System.Windows.Forms.ImageLayout.Stretch
        Me.BackgroundImageStore = Global.My.Resources.Resources.login
        Me.ClientSize = New System.Drawing.Size(584, 371)
        Me.ControlBox = False
        Me.Controls.Add(Me.LabelControl1)
        Me.Controls.Add(Me.tlMain)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow
        Me.LookAndFeel.SkinName = "Blue"
        Me.LookAndFeel.UseDefaultLookAndFeel = False
        Me.MaximizeBox = False
        Me.MaximumSize = New System.Drawing.Size(600, 410)
        Me.MinimizeBox = False
        Me.MinimumSize = New System.Drawing.Size(600, 405)
        Me.Name = "frmLogin"
        Me.ShowIcon = False
        Me.ShowInTaskbar = False
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Login "
        CType(Me.errProvider, System.ComponentModel.ISupportInitialize).EndInit()
        Me.tlMain.ResumeLayout(False)
        Me.tlMain.PerformLayout()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents txtUserName As Commons.utcTextBox
    Friend WithEvents labUserName As System.Windows.Forms.Label
    Friend WithEvents txtPassword As Commons.utcTextBox
    Friend WithEvents labPassword As System.Windows.Forms.Label
    Friend WithEvents btnCancel As System.Windows.Forms.Button
    Friend WithEvents btnLogin As System.Windows.Forms.Button
    Friend WithEvents errProvider As System.Windows.Forms.ErrorProvider
    Friend WithEvents labDbName As System.Windows.Forms.Label
    Friend WithEvents cboDatabase As Commons.UtcComboBox
    Friend WithEvents chkRememberUser As System.Windows.Forms.CheckBox
    Friend WithEvents tlMain As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents chkRememberpass As System.Windows.Forms.CheckBox
    Friend WithEvents LabelControl1 As DevExpress.XtraEditors.LabelControl
End Class
