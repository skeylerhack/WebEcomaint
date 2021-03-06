IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetNhaXuongPhanQuyen')
   exec('CREATE PROCEDURE GetNhaXuongPhanQuyen AS BEGIN SET NOCOUNT ON; END')
GO


--EXEC GetNhaXuongPhanQuyen 'ADMIN'
ALTER proc [dbo].[GetNhaXuongPhanQuyen]
	@UserName nvarchar(50) = 'Admin'
AS

SELECT NX.*
FROM         dbo.NHA_XUONG AS NX INNER JOIN
                      dbo.NHOM_NHA_XUONG AS NNX ON NX.MS_N_XUONG = NNX.MS_N_XUONG INNER JOIN
                      dbo.USERS AS U ON NNX.GROUP_ID = U.GROUP_ID
WHERE USERNAME = @UserName                      
ORDER BY NX.MS_N_XUONG

