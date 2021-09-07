IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetCongNhanUser')
   exec('CREATE PROCEDURE GetCongNhanUser AS BEGIN SET NOCOUNT ON; END')
GO



--EXEC GetCongNhanUser '-1','-1','TRUNGNV'
ALTER proc [dbo].[GetCongNhanUser]
	@MS_DV nvarchar(50) = '-1',
	@MS_TO NVARCHAR(50) = '-1',
	@Username NVARCHAR(50) = 'Admin'
AS

SELECT DISTINCT T1.GROUP_ID, T2.MS_DON_VI,T1.MS_TO INTO #PB_USER
FROM            dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
                         dbo.TO_PHONG_BAN AS T2 ON T1.MS_TO = T2.MS_TO INNER JOIN
                         dbo.USERS AS T3 ON T1.GROUP_ID = T3.GROUP_ID
WHERE        (T3.USERNAME = @Username)

SELECT T3.MS_CONG_NHAN, T3.HO + ' ' + T3.TEN AS HOTEN, TEN
FROM         dbo.TO_PHONG_BAN AS T1 INNER JOIN
                      dbo.[TO] AS T2 ON T1.MS_TO = T2.MS_TO INNER JOIN
                      dbo.CONG_NHAN AS T3 ON T2.MS_TO1 = T3.MS_TO INNER JOIN #PB_USER T4 ON T1.MS_DON_VI = T4.MS_DON_VI AND T1.MS_TO = T4.MS_TO
WHERE     (ISNULL(T3.BO_VIEC,0) <> 1) AND (T1.MS_DON_VI = @MS_DV OR @MS_DV = '-1') 
AND (T1.MS_TO = @MS_TO OR @MS_TO = '-1')
ORDER BY T3.MS_CONG_NHAN ,TEN

