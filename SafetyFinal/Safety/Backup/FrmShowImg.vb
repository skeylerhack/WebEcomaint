Public Class FrmShowImg

    Public Sub New()

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.

    End Sub
    Public Sub New(ByVal img As Image)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        PictureBox1.Image = img
        Me.StartPosition = FormStartPosition.CenterScreen
    End Sub
    Public Sub New(ByVal img As Image, ByVal manual As Boolean)

        ' This call is required by the Windows Form Designer.
        InitializeComponent()

        ' Add any initialization after the InitializeComponent() call.
        PictureBox1.Image = img
        If manual = True Then
            Me.StartPosition = FormStartPosition.Manual
        Else
            Me.StartPosition = FormStartPosition.CenterScreen
        End If

    End Sub
    Private Sub XtraForm1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load

    End Sub

    
    Private Sub FrmShowImg_KeyDown(ByVal sender As System.Object, ByVal e As System.Windows.Forms.KeyEventArgs) Handles MyBase.KeyDown
        If e.KeyCode = Keys.Escape Then
            Me.Close()
        End If
        If e.KeyData = (Keys.S Or Keys.Control) Then
            Dim op As New SaveFileDialog()
            op.Filter = "Image Files (*.bmp, *.jpg,*.png,*.ico ,*.gif)|*.bmp;*.jpg;*.png;*.ico;*.gif"
            If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
                PictureBox1.Image.Save(op.FileName)
                Me.Close()
            End If

        End If
    End Sub

    
    Private Sub SaveToolStripMenuItem_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles SaveToolStripMenuItem.Click
        Dim op As New SaveFileDialog()
        op.Filter = "Image Files (*.bmp, *.jpg,*.png,*.ico ,*.gif)|*.bmp;*.jpg;*.png;*.ico;*.gif"
        If op.ShowDialog() = Windows.Forms.DialogResult.OK Then
            PictureBox1.Image.Save(op.FileName)
            Me.Close()
        End If
    End Sub
End Class