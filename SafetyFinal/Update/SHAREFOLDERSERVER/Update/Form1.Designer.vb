<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
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
        Dim resources As System.ComponentModel.ComponentResourceManager = New System.ComponentModel.ComponentResourceManager(GetType(Form1))
        Me.SplitContainer1 = New System.Windows.Forms.SplitContainer
        Me.btnChon = New DevExpress.XtraEditors.SimpleButton
        Me.lbDungluong = New System.Windows.Forms.Label
        Me.lbPhienBanCN = New System.Windows.Forms.Label
        Me.lbPhienbanHT = New System.Windows.Forms.Label
        Me.Label3 = New System.Windows.Forms.Label
        Me.Label2 = New System.Windows.Forms.Label
        Me.Label1 = New System.Windows.Forms.Label
        Me.PictureBox1 = New System.Windows.Forms.PictureBox
        Me.ProgressBarControl2 = New DevExpress.XtraEditors.ProgressBarControl
        Me.SplitContainer1.Panel1.SuspendLayout()
        Me.SplitContainer1.Panel2.SuspendLayout()
        Me.SplitContainer1.SuspendLayout()
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).BeginInit()
        CType(Me.ProgressBarControl2.Properties, System.ComponentModel.ISupportInitialize).BeginInit()
        Me.SuspendLayout()
        '
        'SplitContainer1
        '
        Me.SplitContainer1.Dock = System.Windows.Forms.DockStyle.Fill
        Me.SplitContainer1.FixedPanel = System.Windows.Forms.FixedPanel.Panel2
        Me.SplitContainer1.IsSplitterFixed = True
        Me.SplitContainer1.Location = New System.Drawing.Point(0, 0)
        Me.SplitContainer1.Name = "SplitContainer1"
        Me.SplitContainer1.Orientation = System.Windows.Forms.Orientation.Horizontal
        '
        'SplitContainer1.Panel1
        '
        Me.SplitContainer1.Panel1.Controls.Add(Me.btnChon)
        Me.SplitContainer1.Panel1.Controls.Add(Me.lbDungluong)
        Me.SplitContainer1.Panel1.Controls.Add(Me.lbPhienBanCN)
        Me.SplitContainer1.Panel1.Controls.Add(Me.lbPhienbanHT)
        Me.SplitContainer1.Panel1.Controls.Add(Me.Label3)
        Me.SplitContainer1.Panel1.Controls.Add(Me.Label2)
        Me.SplitContainer1.Panel1.Controls.Add(Me.Label1)
        Me.SplitContainer1.Panel1.Controls.Add(Me.PictureBox1)
        '
        'SplitContainer1.Panel2
        '
        Me.SplitContainer1.Panel2.Controls.Add(Me.ProgressBarControl2)
        Me.SplitContainer1.Size = New System.Drawing.Size(392, 152)
        Me.SplitContainer1.SplitterDistance = 126
        Me.SplitContainer1.SplitterWidth = 1
        Me.SplitContainer1.TabIndex = 0
        '
        'btnChon
        '
        Me.btnChon.Location = New System.Drawing.Point(135, 97)
        Me.btnChon.Name = "btnChon"
        Me.btnChon.Size = New System.Drawing.Size(248, 25)
        Me.btnChon.TabIndex = 32
        Me.btnChon.Text = "Cập nhật phiên bản"
        '
        'lbDungluong
        '
        Me.lbDungluong.AutoSize = True
        Me.lbDungluong.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.lbDungluong.Location = New System.Drawing.Point(249, 63)
        Me.lbDungluong.Name = "lbDungluong"
        Me.lbDungluong.Size = New System.Drawing.Size(31, 13)
        Me.lbDungluong.TabIndex = 10
        Me.lbDungluong.Text = "0 KB"
        '
        'lbPhienBanCN
        '
        Me.lbPhienBanCN.AutoSize = True
        Me.lbPhienBanCN.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.lbPhienBanCN.Location = New System.Drawing.Point(249, 35)
        Me.lbPhienBanCN.Name = "lbPhienBanCN"
        Me.lbPhienBanCN.Size = New System.Drawing.Size(44, 13)
        Me.lbPhienBanCN.TabIndex = 9
        Me.lbPhienBanCN.Text = "1.0.0.1"
        '
        'lbPhienbanHT
        '
        Me.lbPhienbanHT.AutoSize = True
        Me.lbPhienbanHT.Font = New System.Drawing.Font("Tahoma", 8.25!, System.Drawing.FontStyle.Bold)
        Me.lbPhienbanHT.Location = New System.Drawing.Point(249, 7)
        Me.lbPhienbanHT.Name = "lbPhienbanHT"
        Me.lbPhienbanHT.Size = New System.Drawing.Size(44, 13)
        Me.lbPhienbanHT.TabIndex = 8
        Me.lbPhienbanHT.Text = "1.0.0.1"
        '
        'Label3
        '
        Me.Label3.AutoSize = True
        Me.Label3.Location = New System.Drawing.Point(132, 63)
        Me.Label3.Name = "Label3"
        Me.Label3.Size = New System.Drawing.Size(107, 13)
        Me.Label3.TabIndex = 3
        Me.Label3.Text = "Dung lượng cập nhật"
        '
        'Label2
        '
        Me.Label2.AutoSize = True
        Me.Label2.Location = New System.Drawing.Point(132, 35)
        Me.Label2.Name = "Label2"
        Me.Label2.Size = New System.Drawing.Size(99, 13)
        Me.Label2.TabIndex = 2
        Me.Label2.Text = "Phiên bản cập nhật"
        '
        'Label1
        '
        Me.Label1.AutoSize = True
        Me.Label1.Location = New System.Drawing.Point(132, 7)
        Me.Label1.Name = "Label1"
        Me.Label1.Size = New System.Drawing.Size(92, 13)
        Me.Label1.TabIndex = 1
        Me.Label1.Text = "Phiên bản hiện tại"
        '
        'PictureBox1
        '
        Me.PictureBox1.BorderStyle = System.Windows.Forms.BorderStyle.FixedSingle
        Me.PictureBox1.Image = Global.Update.My.Resources.Resources.update
        Me.PictureBox1.Location = New System.Drawing.Point(2, 2)
        Me.PictureBox1.Name = "PictureBox1"
        Me.PictureBox1.Size = New System.Drawing.Size(124, 120)
        Me.PictureBox1.SizeMode = System.Windows.Forms.PictureBoxSizeMode.StretchImage
        Me.PictureBox1.TabIndex = 0
        Me.PictureBox1.TabStop = False
        '
        'ProgressBarControl2
        '
        Me.ProgressBarControl2.Dock = System.Windows.Forms.DockStyle.Fill
        Me.ProgressBarControl2.EditValue = "0"
        Me.ProgressBarControl2.Location = New System.Drawing.Point(0, 0)
        Me.ProgressBarControl2.Name = "ProgressBarControl2"
        Me.ProgressBarControl2.Properties.ShowTitle = True
        Me.ProgressBarControl2.Size = New System.Drawing.Size(392, 25)
        Me.ProgressBarControl2.TabIndex = 5
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 13.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(392, 152)
        Me.Controls.Add(Me.SplitContainer1)
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Icon = CType(resources.GetObject("$this.Icon"), System.Drawing.Icon)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "Form1"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "Cập nhật hệ thống"
        Me.SplitContainer1.Panel1.ResumeLayout(False)
        Me.SplitContainer1.Panel1.PerformLayout()
        Me.SplitContainer1.Panel2.ResumeLayout(False)
        Me.SplitContainer1.ResumeLayout(False)
        CType(Me.PictureBox1, System.ComponentModel.ISupportInitialize).EndInit()
        CType(Me.ProgressBarControl2.Properties, System.ComponentModel.ISupportInitialize).EndInit()
        Me.ResumeLayout(False)

    End Sub
    Friend WithEvents SplitContainer1 As System.Windows.Forms.SplitContainer
    Friend WithEvents btnChon As DevExpress.XtraEditors.SimpleButton
    Friend WithEvents PictureBox1 As System.Windows.Forms.PictureBox
    Friend WithEvents ProgressBarControl2 As DevExpress.XtraEditors.ProgressBarControl
    Friend WithEvents Label3 As System.Windows.Forms.Label
    Friend WithEvents Label2 As System.Windows.Forms.Label
    Friend WithEvents Label1 As System.Windows.Forms.Label
    Friend WithEvents lbDungluong As System.Windows.Forms.Label
    Friend WithEvents lbPhienBanCN As System.Windows.Forms.Label
    Friend WithEvents lbPhienbanHT As System.Windows.Forms.Label
End Class
