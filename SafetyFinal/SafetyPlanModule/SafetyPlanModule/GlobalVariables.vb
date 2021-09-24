Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient

Public NotInheritable Class GlobalVariables
    Private Sub New()
    End Sub
    Public Shared Property SqlConnect() As SqlConnection
        Get
            Return m_SqlConnect
        End Get
        Set(ByVal value As SqlConnection)
            m_SqlConnect = Value
        End Set
    End Property
    Private Shared m_SqlConnect As SqlConnection
    Public Shared Property ConnectString() As [String]
        Get
            Return m_ConnectString
        End Get
        Set(ByVal value As [String])
            m_ConnectString = Value
        End Set
    End Property
    Private Shared m_ConnectString As [String]
End Class
