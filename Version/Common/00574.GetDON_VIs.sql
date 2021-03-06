--EXEC GetDON_VIs 'TRUNGNV'
ALTER proc [dbo].[GetDON_VIs]
	@Username nvarchar(50) = 'Admin'
AS

SELECT DISTINCT T2.MS_DON_VI INTO #PB_USER
FROM            dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
                         dbo.TO_PHONG_BAN AS T2 ON T1.MS_TO = T2.MS_TO INNER JOIN
                         dbo.USERS AS T3 ON T1.GROUP_ID = T3.GROUP_ID
WHERE        (T3.USERNAME = @Username)


SELECT * FROM DON_VI T INNER JOIN #PB_USER T1 ON T.MS_DON_VI = T1.MS_DON_VI  ORDER BY TEN_DON_VI
