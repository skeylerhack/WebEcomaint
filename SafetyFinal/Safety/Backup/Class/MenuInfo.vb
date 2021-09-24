Imports System.Data

Imports Commons.VS.Classes.Admin
Imports System.Reflection
Imports System.Windows.Forms
Imports System.Data.SqlClient
Imports System.Runtime.InteropServices
Imports Microsoft.ApplicationBlocks.Data
Namespace VS.Object
    Public Class MenuInfo
        Private _MenuID As Object
        Private _MenuText As Object
        Private _MenuEnglish As Object
        Private _MenuChinese As Object
        Private _MenuParent As Object
        Private _MenuLine As Object
        Private _MenuIndex As Object
        Private _ShortCutKey As Object
        Private _DllName As Object
        Private _ProjectName As Object
        Private _ClassName As Object
        Private _FunctionName As Object
        Private _MenuNote As Object
        Public Property MenuID() As Object
            Get
                Return _MenuID
            End Get
            Set(ByVal value As Object)
                _MenuID = value
            End Set
        End Property
        Public Property MenuText() As Object
            Get
                Return _MenuText
            End Get
            Set(ByVal value As Object)
                _MenuText = value
            End Set
        End Property
        Public Property MenuEnglish() As Object
            Get
                Return _MenuEnglish
            End Get
            Set(ByVal value As Object)
                _MenuEnglish = value
            End Set
        End Property
        Public Property MenuChinese() As Object
            Get
                Return _MenuChinese
            End Get
            Set(ByVal value As Object)
                _MenuChinese = value
            End Set
        End Property
        Public Property MenuParent() As Object
            Get
                Return _MenuParent
            End Get
            Set(ByVal value As Object)
                _MenuParent = value
            End Set
        End Property
        Public Property MenuLine() As Object
            Get
                Return _MenuLine
            End Get
            Set(ByVal value As Object)
                _MenuLine = value
            End Set
        End Property
        Public Property MenuIndex() As Object
            Get
                Return _MenuIndex
            End Get
            Set(ByVal value As Object)
                _MenuIndex = value
            End Set
        End Property
        Public Property ShortCutKey() As Object
            Get
                Return _ShortCutKey
            End Get
            Set(ByVal value As Object)
                _ShortCutKey = value
            End Set
        End Property
        Public Property DllName() As Object
            Get
                Return _DllName
            End Get
            Set(ByVal value As Object)
                _DllName = value
            End Set
        End Property
        Public Property ProjectName() As Object
            Get
                Return _ProjectName
            End Get
            Set(ByVal value As Object)
                _ProjectName = value
            End Set
        End Property
        Public Property ClassName() As Object
            Get
                Return _ClassName
            End Get
            Set(ByVal value As Object)
                _ClassName = value
            End Set
        End Property
        Public Property FunctionName() As Object
            Get
                Return _FunctionName
            End Get
            Set(ByVal value As Object)
                _FunctionName = value
            End Set
        End Property
        Public Property MenuNote() As Object
            Get
                Return _MenuNote
            End Get
            Set(ByVal value As Object)
                _MenuNote = value
            End Set
        End Property
    End Class
End Namespace
