IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetPhongBanUserAll')
   exec('CREATE PROCEDURE GetPhongBanUserAll AS BEGIN SET NOCOUNT ON; END')
GO


--EXEC GetPhongBanUserAll 1, -1,'TRUNGNV'
ALTER proc GetPhongBanUserAll
	@CoALL bit = 1,
	@MS_DV NVARCHAR(50) = '-1',
	@Username NVARCHAR(50) = 'Admin'
AS

SELECT DISTINCT T1.GROUP_ID, T2.MS_DON_VI,T1.MS_TO INTO #PB_USER
FROM            dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
                         dbo.TO_PHONG_BAN AS T2 ON T1.MS_TO = T2.MS_TO INNER JOIN
                         dbo.USERS AS T3 ON T1.GROUP_ID = T3.GROUP_ID
WHERE        (T3.USERNAME = @Username)


if @CoALL = 0
	SELECT T1.MS_TO AS MS_PB , TEN_TO AS TEN_PB FROM dbo.TO_PHONG_BAN T1 INNER JOIN #PB_USER T4 ON T1.MS_DON_VI = T4.MS_DON_VI AND T1.MS_TO = T4.MS_TO
		WHERE     (T1.MS_DON_VI = @MS_DV OR @MS_DV = '-1')
	ORDER BY TEN_TO		

else
	SELECT T1.MS_TO AS MS_PB , TEN_TO AS TEN_PB FROM dbo.TO_PHONG_BAN T1 INNER JOIN #PB_USER T4 ON T1.MS_DON_VI = T4.MS_DON_VI AND T1.MS_TO = T4.MS_TO
		WHERE     (T1.MS_DON_VI = @MS_DV OR @MS_DV = '-1')
	UNION
	SELECT '-1', ' < ALL > ' ORDER BY TEN_TO 

