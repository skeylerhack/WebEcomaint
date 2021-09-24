<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form2
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
        Me.XtraTabControl1 = New DevExpress.XtraTab.XtraTabControl
        Me.XtraTabPage2 = New DevExpress.XtraTab.XtraTabPage
        Me.XtraTabPage3 = New DevExpress.XtraTab.XtraTabPage
        CType(Me.XtraTabControl1, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.XtraTabControl1.SuspendLayout()
        Me.SuspendLayout()
        '
        'XtraTabControl1
        '
        Me.XtraTabControl1.Appearance.Font = New System.Drawing.Font("Tahoma", 9.0!)
        Me.XtraTabControl1.Appearance.Options.UseFont = True
        Me.XtraTabControl1.AppearancePage.Header.Font = New System.Drawing.Font("Tahoma", 10.0!)
        Me.XtraTabControl1.AppearancePage.Header.Options.UseFont = True
        Me.XtraTabControl1.AppearancePage.HeaderActive.Font = New System.Drawing.Font("Tahoma", 10.0!)
        Me.XtraTabControl1.AppearancePage.HeaderActive.Options.UseFont = True
        Me.XtraTabControl1.AppearancePage.HeaderDisabled.Font = New System.Drawing.Font("Tahoma", 10.0!)
        Me.XtraTabControl1.AppearancePage.HeaderDisabled.Options.UseFont = True
        Me.XtraTabControl1.AppearancePage.HeaderHotTracked.Font = New System.Drawing.Font("Tahoma", 10.0!)
        Me.XtraTabControl1.AppearancePage.HeaderHotTracked.Options.UseFont = True
        Me.XtraTabControl1.AppearancePage.PageClient.Font = New System.Drawing.Font("Tahoma", 10.0!)
        Me.XtraTabControl1.AppearancePage.PageClient.Options.UseFont = True
        Me.XtraTabControl1.Font = New System.Drawing.Font("Tahoma", 10.0!)
        Me.XtraTabControl1.Location = New System.Drawing.Point(59, 52)
        Me.XtraTabControl1.Name = "XtraTabControl1"
        Me.XtraTabControl1.SelectedTabPage = Me.XtraTabPage2
        Me.XtraTabControl1.Size = New System.Drawing.Size(633, 327)
        Me.XtraTabControl1.TabIndex = 2
        Me.XtraTabControl1.TabPages.AddRange(New DevExpress.XtraTab.XtraTabPage() {Me.XtraTabPage2, Me.XtraTabPage3})
        '
        'XtraTabPage2
        '
        Me.XtraTabPage2.Font = New System.Drawing.Font("Tahoma", 10.0!)
        Me.XtraTabPage2.Name = "XtraTabPage2"
        Me.XtraTabPage2.Size = New System.Drawing.Size(626, 295)
        Me.XtraTabPage2.Text = "General"
        '
        'XtraTabPage3
        '
        Me.XtraTabPage3.Font = New System.Drawing.Font("Tahoma", 10.0!)
        Me.XtraTabPage3.Margin = New System.Windows.Forms.Padding(3, 32, 3, 3)
        Me.XtraTabPage3.Name = "XtraTabPage3"
        Me.XtraTabPage3.Size = New System.Drawing.Size(626, 295)
        Me.XtraTabPage3.Text = "Action"
        '
        'Form2
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(764, 484)
        Me.Controls.Add(Me.XtraTabControl1)
        Me.Name = "Form2"
        Me.Text = "Form2"
        CType(Me.XtraTabControl1, System.ComponentModel.ISupportInitialize).EndInit()
        Me.XtraTabControl1.ResumeLayout(False)
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents XtraTabControl1 As DevExpress.XtraTab.XtraTabControl
    Friend WithEvents XtraTabPage2 As DevExpress.XtraTab.XtraTabPage
    Friend WithEvents XtraTabPage3 As DevExpress.XtraTab.XtraTabPage
End Class
