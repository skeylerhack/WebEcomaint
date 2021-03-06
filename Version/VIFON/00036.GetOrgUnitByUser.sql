
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetOrgUnitByUser')
   exec('CREATE PROCEDURE GetOrgUnitByUser AS BEGIN SET NOCOUNT ON; END')
GO


ALTER proc [dbo].[GetOrgUnitByUser]
	@isAll bit = 1,
	@username NVARCHAR(50) = 'Admin'
AS

SELECT DISTINCT T2.MS_DON_VI INTO #PB_USER
FROM            dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
                         dbo.TO_PHONG_BAN AS T2 ON T1.MS_TO = T2.MS_TO INNER JOIN
                         dbo.USERS AS T3 ON T1.GROUP_ID = T3.GROUP_ID
WHERE        (T3.USERNAME = @username)

if @isAll = 0
	SELECT T1.MS_DON_VI ID, TEN_DON_VI [Name], TEN_NGAN ShortName FROM DON_VI T1 INNER JOIN #PB_USER T2 ON T1.MS_DON_VI = T2.MS_DON_VI   ORDER BY TEN_DON_VI 
else
	SELECT T1.MS_DON_VI ID, TEN_DON_VI [Name], TEN_NGAN ShortName FROM DON_VI T1 INNER JOIN #PB_USER T2 ON T1.MS_DON_VI = T2.MS_DON_VI
	UNION
	SELECT '-1', '< ALL >', '< ALL >'
	ORDER BY TEN_DON_VI 



