<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class FrmPrint
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
        Me.CrystalReportViewer1 = New CrystalDecisions.Windows.Forms.CrystalReportViewer
        Me.SplitContainer1 = New System.Windows.Forms.SplitContainer
        Me.rdEN = New System.Windows.Forms.RadioButton
        Me.rdVI = New System.Windows.Forms.RadioButton
        Me.SplitContainer2 = New System.Windows.Forms.SplitContainer
        Me.rdSafety = New System.Windows.Forms.RadioButton
        Me.rdIncident = New System.Windows.Forms.RadioButton
        Me.SplitContainer1.Panel1.SuspendLayout()
        Me.SplitContainer1.Panel2.SuspendLayout()
        Me.SplitContainer1.SuspendLayout()
        Me.SplitContainer2.Panel1.SuspendLayout()
        Me.SplitContainer2.Panel2.SuspendLayout()
        Me.SplitContainer2.SuspendLayout()
        Me.SuspendLayout()
        '
        'CrystalReportViewer1
        '
        Me.CrystalReportViewer1.ActiveViewIndex = -1
        Me.CrystalReportViewer1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.CrystalReportViewer1.DisplayGroupTree = False
        Me.CrystalReportViewer1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.CrystalReportViewer1.Location = New System.Drawing.Point(0, 0)
        Me.CrystalReportViewer1.Name = "CrystalReportViewer1"
        Me.CrystalReportViewer1.SelectionFormula = ""
        Me.CrystalReportViewer1.Size = New System.Drawing.Size(974, 455)
        Me.CrystalReportViewer1.TabIndex = 0
        Me.CrystalReportViewer1.ViewTimeSelectionFormula = ""
        '
        'SplitContainer1
        '
        Me.SplitContainer1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer1.FixedPanel = System.Windows.Forms.FixedPanel.Panel1
        Me.SplitContainer1.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer1.Name = "SplitContainer1"
        Me.SplitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal
        '
        'SplitContainer1.Panel1
        '
        Me.SplitContainer1.Panel1.Controls.Add(Me.rdEN)
        Me.SplitContainer1.Panel1.Controls.Add(Me.rdVI)
        Me.SplitContainer1.Panel1Collapsed = True
        '
        'SplitContainer1.Panel2
        '
        Me.SplitContainer1.Panel2.Controls.Add(Me.SplitContainer2)
        Me.SplitContainer1.Size = New System.Drawing.Size(974, 455)
        Me.SplitContainer1.SplitterDistance = 26
        Me.SplitContainer1.TabIndex = 1
        '
        'rdEN
        '
        Me.rdEN.AutoSize = True
        Me.rdEN.Location = New System.Drawing.Point(121, 5)
        Me.rdEN.Name = "rdEN"
        Me.rdEN.Size = New System.Drawing.Size(105, 17)
        Me.rdEN.TabIndex = 1
        Me.rdEN.Text = "Template English"
        Me.rdEN.UseVisualStyleBackColor = True
        '
        'rdVI
        '
        Me.rdVI.AutoSize = True
        Me.rdVI.Checked = True
        Me.rdVI.Location = New System.Drawing.Point(6, 5)
        Me.rdVI.Name = "rdVI"
        Me.rdVI.Size = New System.Drawing.Size(110, 17)
        Me.rdVI.TabIndex = 0
        Me.rdVI.TabStop = True
        Me.rdVI.Text = "Template Vietnam"
        Me.rdVI.UseVisualStyleBackColor = True
        '
        'SplitContainer2
        '
        Me.SplitContainer2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer2.FixedPanel = System.Windows.Forms.FixedPanel.Panel1
        Me.SplitContainer2.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer2.Name = "SplitContainer2"
        Me.SplitContainer2.Orientation = System.Windows.Forms.Orientation.Horizontal
        '
        'SplitContainer2.Panel1
        '
        Me.SplitContainer2.Panel1.Controls.Add(Me.rdSafety)
        Me.SplitContainer2.Panel1.Controls.Add(Me.rdIncident)
        Me.SplitContainer2.Panel1Collapsed = True
        '
        'SplitContainer2.Panel2
        '
        Me.SplitContainer2.Panel2.Controls.Add(Me.CrystalReportViewer1)
        Me.SplitContainer2.Size = New System.Drawing.Size(974, 455)
        Me.SplitContainer2.SplitterDistance = 28
        Me.SplitContainer2.TabIndex = 1
        '
        'rdSafety
        '
        Me.rdSafety.AutoSize = True
        Me.rdSafety.Location = New System.Drawing.Point(121, 6)
        Me.rdSafety.Name = "rdSafety"
        Me.rdSafety.Size = New System.Drawing.Size(83, 17)
        Me.rdSafety.TabIndex = 1
        Me.rdSafety.Text = "Safety Alert"
        Me.rdSafety.UseVisualStyleBackColor = True
        '
        'rdIncident
        '
        Me.rdIncident.AutoSize = True
        Me.rdIncident.Checked = True
        Me.rdIncident.Location = New System.Drawing.Point(6, 5)
        Me.rdIncident.Name = "rdIncident"
        Me.rdIncident.Size = New System.Drawing.Size(109, 17)
        Me.rdIncident.TabIndex = 0
        Me.rdIncident.TabStop = True
        Me.rdIncident.Text = "Incident/Accident"
        Me.rdIncident.UseVisualStyleBackColor = True
        '
        'FrmPrint
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(974, 455)
        Me.Controls.Add(Me.SplitContainer1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.LookAndFeel.SkinName = "Blue"
        Me.Name = "FrmPrint"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "FrmPrint"
        Me.WindowState = System.Windows.Forms.FormWindowState.Maximized
        Me.SplitContainer1.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel1.PerformLayout()
        Me.SplitContainer1.Panel2.ResumeLayout(False)
        Me.SplitContainer1.ResumeLayout(False)
        Me.SplitContainer2.Panel1.ResumeLayout(False)
        Me.SplitContainer2.Panel1.PerformLayout()
        Me.SplitContainer2.Panel2.ResumeLayout(False)
        Me.SplitContainer2.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents CrystalReportViewer1 As CrystalDecisions.Windows.Forms.CrystalReportViewer
    Friend WithEvents SplitContainer1 As System.Windows.Forms.SplitContainer
    Friend WithEvents rdVI As System.Windows.Forms.RadioButton
    Friend WithEvents rdEN As System.Windows.Forms.RadioButton
    Friend WithEvents SplitContainer2 As System.Windows.Forms.SplitContainer
    Friend WithEvents rdIncident As System.Windows.Forms.RadioButton
    Friend WithEvents rdSafety As System.Windows.Forms.RadioButton
End Class
