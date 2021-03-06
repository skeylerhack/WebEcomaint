
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetKhoUserAll')
   exec('CREATE PROCEDURE GetKhoUserAll AS BEGIN SET NOCOUNT ON; END')
GO

--EXEC [GetKhoUserAll] 0, 'TRUNGNV'
ALTER proc [dbo].[GetKhoUserAll]
	@CoALL bit = 1,	
	@Username NVARCHAR(50) = 'Admin'
AS

SELECT     dbo.IC_KHO.MS_KHO, dbo.IC_KHO.TEN_KHO INTO #KHO_USER
FROM         dbo.IC_KHO INNER JOIN
                      dbo.NHOM_KHO ON dbo.IC_KHO.MS_KHO = dbo.NHOM_KHO.MS_KHO INNER JOIN
                      dbo.USERS ON dbo.NHOM_KHO.GROUP_ID = dbo.USERS.GROUP_ID
WHERE     (dbo.USERS.USERNAME = @UserName)


if @CoALL = 0
	SELECT MS_KHO,TEN_KHO FROM #KHO_USER A	ORDER BY TEN_KHO
else
	SELECT MS_KHO,TEN_KHO FROM #KHO_USER A	
	UNION
	SELECT '-1', ' < ALL > ' ORDER BY TEN_KHO

