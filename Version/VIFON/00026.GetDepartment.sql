

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetDepartment')
   exec('CREATE PROCEDURE GetDepartment AS BEGIN SET NOCOUNT ON; END')
GO

ALTER proc [dbo].[GetDepartment]
	@isALL bit = 1,
	@unitID NVARCHAR(50) = '-1',
	@username NVARCHAR(50) = 'Admin'
AS

SELECT DISTINCT T1.GROUP_ID, T2.MS_DON_VI,T1.MS_TO INTO #PB_USER
FROM            dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
                         dbo.TO_PHONG_BAN AS T2 ON T1.MS_TO = T2.MS_TO INNER JOIN
                         dbo.USERS AS T3 ON T1.GROUP_ID = T3.GROUP_ID
WHERE        (T3.USERNAME = @username)


if @isALL = 0
	SELECT T1.MS_TO AS ID , TEN_TO AS [Name] FROM dbo.TO_PHONG_BAN T1 INNER JOIN #PB_USER T4 ON T1.MS_DON_VI = T4.MS_DON_VI AND T1.MS_TO = T4.MS_TO
		WHERE     (T1.MS_DON_VI = @unitID OR @unitID = '-1')
	ORDER BY TEN_TO		

else
	SELECT T1.MS_TO AS ID , TEN_TO AS [Name] FROM dbo.TO_PHONG_BAN T1 INNER JOIN #PB_USER T4 ON T1.MS_DON_VI = T4.MS_DON_VI AND T1.MS_TO = T4.MS_TO
		WHERE     (T1.MS_DON_VI = @unitID OR @unitID = '-1')
	UNION
	SELECT '-1', ' < ALL > ' ORDER BY [Name] 

