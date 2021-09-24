Imports System.Runtime.InteropServices


Public NotInheritable Class VirtualMouse
    Private Sub New()
    End Sub
    <DllImport("user32.dll")> _
    Private Shared Sub mouse_event(ByVal dwFlags As Integer, ByVal dx As Integer, ByVal dy As Integer, ByVal dwData As Integer, ByVal dwExtraInfo As Integer)
    End Sub
    Private Const MOUSEEVENTF_MOVE As Integer = &H1
    Private Const MOUSEEVENTF_LEFTDOWN As Integer = &H2
    Private Const MOUSEEVENTF_LEFTUP As Integer = &H4
    Private Const MOUSEEVENTF_RIGHTDOWN As Integer = &H8
    Private Const MOUSEEVENTF_RIGHTUP As Integer = &H10
    Private Const MOUSEEVENTF_MIDDLEDOWN As Integer = &H20
    Private Const MOUSEEVENTF_MIDDLEUP As Integer = &H40
    Private Const MOUSEEVENTF_ABSOLUTE As Integer = &H8000
    Public Shared Sub Move(ByVal xDelta As Integer, ByVal yDelta As Integer)
        mouse_event(MOUSEEVENTF_MOVE, xDelta, yDelta, 0, 0)
    End Sub
    Public Shared Sub MoveTo(ByVal x As Integer, ByVal y As Integer)
        mouse_event(MOUSEEVENTF_ABSOLUTE Or MOUSEEVENTF_MOVE, x, y, 0, 0)
    End Sub
    Public Shared Sub LeftClick()
        mouse_event(MOUSEEVENTF_LEFTDOWN, System.Windows.Forms.Control.MousePosition.X, System.Windows.Forms.Control.MousePosition.Y, 0, 0)
        mouse_event(MOUSEEVENTF_LEFTUP, System.Windows.Forms.Control.MousePosition.X, System.Windows.Forms.Control.MousePosition.Y, 0, 0)
    End Sub

    Public Shared Sub LeftDown()
        mouse_event(MOUSEEVENTF_LEFTDOWN, System.Windows.Forms.Control.MousePosition.X, System.Windows.Forms.Control.MousePosition.Y, 0, 0)
    End Sub

    Public Shared Sub LeftUp()
        mouse_event(MOUSEEVENTF_LEFTUP, System.Windows.Forms.Control.MousePosition.X, System.Windows.Forms.Control.MousePosition.Y, 0, 0)
    End Sub

    Public Shared Sub RightClick()
        mouse_event(MOUSEEVENTF_RIGHTDOWN, System.Windows.Forms.Control.MousePosition.X, System.Windows.Forms.Control.MousePosition.Y, 0, 0)
        mouse_event(MOUSEEVENTF_RIGHTUP, System.Windows.Forms.Control.MousePosition.X, System.Windows.Forms.Control.MousePosition.Y, 0, 0)
    End Sub

    Public Shared Sub RightDown()
        mouse_event(MOUSEEVENTF_RIGHTDOWN, System.Windows.Forms.Control.MousePosition.X, System.Windows.Forms.Control.MousePosition.Y, 0, 0)
    End Sub

    Public Shared Sub RightUp()
        mouse_event(MOUSEEVENTF_RIGHTUP, System.Windows.Forms.Control.MousePosition.X, System.Windows.Forms.Control.MousePosition.Y, 0, 0)
    End Sub
End Class

