Imports System.Collections
Imports System.Collections.Generic
Imports System.Data
Imports System.Diagnostics
Imports System.Security.Cryptography
Imports System.Text

Public Class Protect
    Public Function EnCrypt(ByVal strEnCrypt As String, ByVal key As String) As String
        Try
            Dim keyArr As Byte() = Nothing
            Dim EnCryptArr As Byte() = UTF8Encoding.UTF8.GetBytes(strEnCrypt)
            Dim MD5Hash As New MD5CryptoServiceProvider()
            keyArr = MD5Hash.ComputeHash(UTF8Encoding.UTF8.GetBytes(key))
            Dim tripDes As New TripleDESCryptoServiceProvider()
            tripDes.Key = keyArr
            tripDes.Mode = CipherMode.ECB
            tripDes.Padding = PaddingMode.ISO10126
            Dim transform As ICryptoTransform = tripDes.CreateEncryptor()
            Dim arrResult As Byte() = transform.TransformFinalBlock(EnCryptArr, 0, EnCryptArr.Length)
            Return Convert.ToBase64String(arrResult, 0, arrResult.Length)
        Catch ex As Exception
        End Try
        Return ""
    End Function

    Public Function DeCrypt(ByVal strDecypt As String, ByVal key As String) As String
        Try
            Dim keyArr As Byte() = Nothing
            Dim DeCryptArr As Byte() = Convert.FromBase64String(strDecypt)
            Dim MD5Hash As New MD5CryptoServiceProvider()
            keyArr = MD5Hash.ComputeHash(UTF8Encoding.UTF8.GetBytes(key))
            Dim tripDes As New TripleDESCryptoServiceProvider()
            tripDes.Key = keyArr
            tripDes.Mode = CipherMode.ECB
            tripDes.Padding = PaddingMode.ISO10126
            Dim transform As ICryptoTransform = tripDes.CreateDecryptor()
            Dim arrResult As Byte() = transform.TransformFinalBlock(DeCryptArr, 0, DeCryptArr.Length)
            Return UTF8Encoding.UTF8.GetString(arrResult)
        Catch ex As Exception
        End Try
        Return ""
    End Function
End Class
