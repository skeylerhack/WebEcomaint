Imports System.Collections.Generic
Imports System.Linq
Imports System.Text

Class SQLConnectEntity
#Region "Property"
    Private dbName As [String]
    Private svName As [String]
    Private dbMode As [Boolean]
    Private dbUser As [String]
    Private dbPassword As [String]
#End Region
#Region "Contructor"

    Public Sub New()
    End Sub
    Public Sub New(ByVal svName As [String], ByVal dbName As [String], ByVal dbMode As [Boolean], ByVal dbUser As [String], ByVal dbPassword As [String])
        Me.ServerName = svName
        Me.DatabaseName = dbName
        Me.SQLMode = dbMode
        Me.Username = dbUser
        Me.Password = dbPassword
    End Sub
#End Region
#Region "Set/Get Property"
    Public Property ServerName() As String
        Get
            Return svName
        End Get

        Set(ByVal value As String)
            svName = value
        End Set
    End Property

    Public Property DatabaseName() As String
        Get
            Return dbName
        End Get

        Set(ByVal value As String)
            dbName = value
        End Set
    End Property

    Public Property SQLMode() As Boolean
        Get
            Return dbMode
        End Get

        Set(ByVal value As Boolean)
            dbMode = value
        End Set
    End Property

    Public Property Username() As String
        Get
            Return dbUser
        End Get

        Set(ByVal value As String)
            dbUser = value
        End Set
    End Property

    Public Property Password() As String
        Get
            Return dbPassword
        End Get

        Set(ByVal value As String)
            dbPassword = value
        End Set
    End Property
#End Region
End Class
