<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class frmPassword
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
        Me.components = New System.ComponentModel.Container
        Me.labUserName = New System.Windows.Forms.Label
        Me.labPassword = New System.Windows.Forms.Label
        Me.labNewPassword = New System.Windows.Forms.Label
        Me.labConfirmPass = New System.Windows.Forms.Label
        Me.BtnChange = New System.Windows.Forms.Button
        Me.btnExit = New System.Windows.Forms.Button
        Me.ErrorProvider1 = New System.Windows.Forms.ErrorProvider(Me.components)
        Me.tlMain = New System.Windows.Forms.TableLayoutPanel
        Me.txtUsername = New Commons.utcTextBox
        Me.txtPassOld = New Commons.utcTextBox
        Me.txtPassNew = New Commons.utcTextBox
        Me.txtComfirmPass = New Commons.utcTextBox
        Me.TableLayoutPanel1 = New System.Windows.Forms.TableLayoutPanel
        Me.labLine = New System.Windows.Forms.Label
        CType(Me.ErrorProvider1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.tlMain.SuspendLayout()
        Me.TableLayoutPanel1.SuspendLayout()
        Me.SuspendLayout()
        '
        'labUserName
        '
        Me.labUserName.Dock = System.Windows.Forms.DockStyle.Fill
        Me.labUserName.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.labUserName.Location = New System.Drawing.Point(3, 0)
        Me.labUserName.Name = "labUserName"
        Me.labUserName.Size = New System.Drawing.Size(89, 26)
        Me.labUserName.TabIndex = 1
        Me.labUserName.Text = "Username"
        Me.labUserName.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.labUserName.UseCompatibleTextRendering = True
        '
        'labPassword
        '
        Me.labPassword.Dock = System.Windows.Forms.DockStyle.Fill
        Me.labPassword.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.labPassword.Location = New System.Drawing.Point(3, 26)
        Me.labPassword.Name = "labPassword"
        Me.labPassword.Size = New System.Drawing.Size(89, 26)
        Me.labPassword.TabIndex = 2
        Me.labPassword.Text = "Old Pword"
        Me.labPassword.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.labPassword.UseCompatibleTextRendering = True
        '
        'labNewPassword
        '
        Me.labNewPassword.Dock = System.Windows.Forms.DockStyle.Fill
        Me.labNewPassword.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.labNewPassword.Location = New System.Drawing.Point(3, 52)
        Me.labNewPassword.Name = "labNewPassword"
        Me.labNewPassword.Size = New System.Drawing.Size(89, 26)
        Me.labNewPassword.TabIndex = 3
        Me.labNewPassword.Text = "New Pword"
        Me.labNewPassword.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.labNewPassword.UseCompatibleTextRendering = True
        '
        'labConfirmPass
        '
        Me.labConfirmPass.Dock = System.Windows.Forms.DockStyle.Fill
        Me.labConfirmPass.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.labConfirmPass.Location = New System.Drawing.Point(3, 78)
        Me.labConfirmPass.Name = "labConfirmPass"
        Me.labConfirmPass.Size = New System.Drawing.Size(89, 26)
        Me.labConfirmPass.TabIndex = 4
        Me.labConfirmPass.Text = "Confirm Pwd "
        Me.labConfirmPass.TextAlign = System.Drawing.ContentAlignment.MiddleRight
        Me.labConfirmPass.UseCompatibleTextRendering = True
        '
        'BtnChange
        '
        Me.BtnChange.Dock = System.Windows.Forms.DockStyle.Fill
        Me.BtnChange.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.BtnChange.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.BtnChange.Location = New System.Drawing.Point(85, 3)
        Me.BtnChange.Name = "BtnChange"
        Me.BtnChange.Size = New System.Drawing.Size(79, 24)
        Me.BtnChange.TabIndex = 9
        Me.BtnChange.Text = "&Change"
        Me.BtnChange.UseVisualStyleBackColor = True
        '
        'btnExit
        '
        Me.btnExit.Dock = System.Windows.Forms.DockStyle.Fill
        Me.btnExit.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.btnExit.ForeColor = System.Drawing.Color.FromArgb(CType(CType(64, Byte), Integer), CType(CType(0, Byte), Integer), CType(CType(0, Byte), Integer))
        Me.btnExit.Location = New System.Drawing.Point(170, 3)
        Me.btnExit.Name = "btnExit"
        Me.btnExit.Size = New System.Drawing.Size(79, 24)
        Me.btnExit.TabIndex = 10
        Me.btnExit.Text = "&Exit"
        Me.btnExit.UseVisualStyleBackColor = True
        '
        'ErrorProvider1
        '
        Me.ErrorProvider1.ContainerControl = Me
        '
        'tlMain
        '
        Me.tlMain.ColumnCount = 2
        Me.tlMain.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 95.0!))
        Me.tlMain.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.tlMain.Controls.Add(Me.labUserName, 0, 0)
        Me.tlMain.Controls.Add(Me.labPassword, 0, 1)
        Me.tlMain.Controls.Add(Me.labNewPassword, 0, 2)
        Me.tlMain.Controls.Add(Me.labConfirmPass, 0, 3)
        Me.tlMain.Controls.Add(Me.txtUsername, 1, 0)
        Me.tlMain.Controls.Add(Me.txtPassOld, 1, 1)
        Me.tlMain.Controls.Add(Me.txtPassNew, 1, 2)
        Me.tlMain.Controls.Add(Me.txtComfirmPass, 1, 3)
        Me.tlMain.Dock = System.Windows.Forms.DockStyle.Top
        Me.tlMain.Location = New System.Drawing.Point(0, 5)
        Me.tlMain.Name = "tlMain"
        Me.tlMain.RowCount = 4
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25.0!))
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25.0!))
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25.0!))
        Me.tlMain.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 25.0!))
        Me.tlMain.Size = New System.Drawing.Size(334, 104)
        Me.tlMain.TabIndex = 76
        '
        'txtUsername
        '
        Me.txtUsername.BackColor = System.Drawing.Color.White
        Me.txtUsername.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.txtUsername.ErrorProviderControl = Me.ErrorProvider1
        Me.txtUsername.FieldName = ""
        Me.txtUsername.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtUsername.IsNull = False
        Me.txtUsername.Location = New System.Drawing.Point(98, 3)
        Me.txtUsername.Margin = New System.Windows.Forms.Padding(3, 3, 15, 3)
        Me.txtUsername.Name = "txtUsername"
        Me.txtUsername.ReadOnly = True
        Me.txtUsername.Size = New System.Drawing.Size(221, 21)
        Me.txtUsername.TabIndex = 5
        Me.txtUsername.TextTypeMode = Commons.TypeMode.None
        '
        'txtPassOld
        '
        Me.txtPassOld.BackColor = System.Drawing.Color.White
        Me.txtPassOld.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.txtPassOld.ErrorProviderControl = Me.ErrorProvider1
        Me.txtPassOld.FieldName = ""
        Me.txtPassOld.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPassOld.IsNull = False
        Me.txtPassOld.Location = New System.Drawing.Point(98, 29)
        Me.txtPassOld.Margin = New System.Windows.Forms.Padding(3, 3, 15, 3)
        Me.txtPassOld.Name = "txtPassOld"
        Me.txtPassOld.PasswordChar = Global.Microsoft.VisualBasic.ChrW(9679)
        Me.txtPassOld.Size = New System.Drawing.Size(221, 21)
        Me.txtPassOld.TabIndex = 6
        Me.txtPassOld.TextTypeMode = Commons.TypeMode.None
        '
        'txtPassNew
        '
        Me.txtPassNew.BackColor = System.Drawing.Color.White
        Me.txtPassNew.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.txtPassNew.ErrorProviderControl = Me.ErrorProvider1
        Me.txtPassNew.FieldName = ""
        Me.txtPassNew.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtPassNew.IsNull = False
        Me.txtPassNew.Location = New System.Drawing.Point(98, 55)
        Me.txtPassNew.Margin = New System.Windows.Forms.Padding(3, 3, 15, 3)
        Me.txtPassNew.Name = "txtPassNew"
        Me.txtPassNew.PasswordChar = Global.Microsoft.VisualBasic.ChrW(9679)
        Me.txtPassNew.Size = New System.Drawing.Size(221, 21)
        Me.txtPassNew.TabIndex = 7
        Me.txtPassNew.TextTypeMode = Commons.TypeMode.None
        '
        'txtComfirmPass
        '
        Me.txtComfirmPass.BackColor = System.Drawing.Color.White
        Me.txtComfirmPass.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.txtComfirmPass.ErrorProviderControl = Me.ErrorProvider1
        Me.txtComfirmPass.FieldName = ""
        Me.txtComfirmPass.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtComfirmPass.IsNull = False
        Me.txtComfirmPass.Location = New System.Drawing.Point(98, 81)
        Me.txtComfirmPass.Margin = New System.Windows.Forms.Padding(3, 3, 15, 3)
        Me.txtComfirmPass.Name = "txtComfirmPass"
        Me.txtComfirmPass.PasswordChar = Global.Microsoft.VisualBasic.ChrW(9679)
        Me.txtComfirmPass.Size = New System.Drawing.Size(221, 21)
        Me.txtComfirmPass.TabIndex = 8
        Me.txtComfirmPass.TextTypeMode = Commons.TypeMode.None
        '
        'TableLayoutPanel1
        '
        Me.TableLayoutPanel1.ColumnCount = 4
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 85.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Absolute, 85.0!))
        Me.TableLayoutPanel1.ColumnStyles.Add(New System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 50.0!))
        Me.TableLayoutPanel1.Controls.Add(Me.btnExit, 2, 0)
        Me.TableLayoutPanel1.Controls.Add(Me.BtnChange, 1, 0)
        Me.TableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Bottom
        Me.TableLayoutPanel1.Location = New System.Drawing.Point(0, 121)
        Me.TableLayoutPanel1.Name = "TableLayoutPanel1"
        Me.TableLayoutPanel1.RowCount = 1
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 100.0!))
        Me.TableLayoutPanel1.RowStyles.Add(New System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Absolute, 30.0!))
        Me.TableLayoutPanel1.Size = New System.Drawing.Size(334, 30)
        Me.TableLayoutPanel1.TabIndex = 77
        '
        'labLine
        '
        Me.labLine.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.labLine.Location = New System.Drawing.Point(14, 119)
        Me.labLine.Name = "labLine"
        Me.labLine.Size = New System.Drawing.Size(314, 2)
        Me.labLine.TabIndex = 78
        '
        'frmPassword
        '
        Me.Appearance.Font = New System.Drawing.Font("Arial", 9.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.Appearance.Options.UseFont = True
        Me.AutoScaleDimensions = New System.Drawing.SizeF(7.0!, 15.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(334, 151)
        Me.ControlBox = False
        Me.Controls.Add(Me.labLine)
        Me.Controls.Add(Me.TableLayoutPanel1)
        Me.Controls.Add(Me.tlMain)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.SizableToolWindow
        Me.KeyPreview = True
        Me.LookAndFeel.SkinName = "Blue"
        Me.LookAndFeel.UseDefaultLookAndFeel = False
        Me.MaximizeBox = False
        Me.MaximumSize = New System.Drawing.Size(350, 190)
        Me.MinimizeBox = False
        Me.MinimumSize = New System.Drawing.Size(350, 185)
        Me.Name = "frmPassword"
        Me.Padding = New System.Windows.Forms.Padding(0, 5, 0, 0)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Change Password"
        CType(Me.ErrorProvider1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.tlMain.ResumeLayout(False)
        Me.tlMain.PerformLayout()
        Me.TableLayoutPanel1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents labUserName As System.Windows.Forms.Label
    Friend WithEvents labPassword As System.Windows.Forms.Label
    Friend WithEvents labNewPassword As System.Windows.Forms.Label
    Friend WithEvents labConfirmPass As System.Windows.Forms.Label
    Friend WithEvents txtUsername As Commons.utcTextBox
    Friend WithEvents txtPassOld As Commons.utcTextBox
    Friend WithEvents txtPassNew As Commons.utcTextBox
    Friend WithEvents txtComfirmPass As Commons.utcTextBox
    Friend WithEvents BtnChange As System.Windows.Forms.Button
    Friend WithEvents btnExit As System.Windows.Forms.Button
    Friend WithEvents ErrorProvider1 As System.Windows.Forms.ErrorProvider
    Friend WithEvents tlMain As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents TableLayoutPanel1 As System.Windows.Forms.TableLayoutPanel
    Friend WithEvents labLine As System.Windows.Forms.Label
End Class
