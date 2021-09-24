Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient

Class SQLFunction
    Private strCon As [String]
    Shared sqlcon As SqlConnection

    Public Sub New()
    End Sub
    Public Function KetNoi(ByVal con As SQLConnectEntity) As [Boolean]
        If con.SQLMode = True Then
            strCon = " Data Source =" + con.ServerName + "; Initial Catalog =" + con.DatabaseName + "; Integrated Security = True"
        Else
            strCon = " Data Source =" + con.ServerName + ";Initial Catalog =" + con.DatabaseName + ";User ID =" + con.Username + ";PWD =" + con.Password
        End If
        sqlcon = New SqlConnection(strCon)
        GlobalVariables.SqlConnect = sqlcon
        'Commons.IConnections.ConnectionString() = strCon
        GlobalVariables.ConnectString = strCon
        Try
            sqlcon.Open()
            Return True
        Catch generatedExceptionName As Exception
            Return False
        Finally
            sqlcon.Close()
        End Try
    End Function
    Public Function KetNoi(ByVal str_con As [String]) As [Boolean]
        strCon = str_con
        sqlcon = New SqlConnection(str_con)
        GlobalVariables.SqlConnect = sqlcon
        'Commons.IConnections.ConnectionString() = strCon
        GlobalVariables.ConnectString = strCon
        Try
            sqlcon.Open()
            Return True
        Catch generatedExceptionName As Exception
            Return False
        Finally
            sqlcon.Close()
        End Try
    End Function
    Public Function GetData(ByVal query As [String], ByVal type As CommandType) As DataSet
        Try
            Dim ds As New DataSet()
            sqlcon = New SqlConnection(strCon)
            If sqlcon.State = ConnectionState.Closed Then
                sqlcon.Open()
            End If
            Dim com As New SqlCommand()
            com.Connection = sqlcon
            com.CommandText = query
            com.CommandType = type
            com.CommandTimeout = 99999999
            Dim da As New SqlDataAdapter(com)
            da.Fill(ds)
            Return ds
        Catch generatedExceptionName As Exception
            Return New DataSet()
            Throw
        Finally
            sqlcon.Close()
        End Try
    End Function
    Public Function GetData(ByVal query As [String]) As DataSet
        Try
            Dim ds As New DataSet()
            sqlcon = New SqlConnection(strCon)
            If sqlcon.State = ConnectionState.Closed Then
                sqlcon.Open()
            End If
            Dim com As New SqlCommand()
            com.Connection = sqlcon
            com.CommandText = query
            com.CommandType = CommandType.Text
            com.CommandTimeout = 99999999
            Dim da As New SqlDataAdapter(com)
            da.Fill(ds)
            Return ds
        Catch generatedExceptionName As Exception
            Return New DataSet()
            Throw
        Finally
            sqlcon.Close()
        End Try
    End Function
    Public Function GetSqlConnect() As SqlConnection
        Return sqlcon
    End Function
End Class