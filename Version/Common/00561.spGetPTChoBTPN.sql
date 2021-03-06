IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetPTchoBTPN')
   exec('CREATE PROCEDURE spGetPTchoBTPN AS BEGIN SET NOCOUNT ON; END')
GO
--spGetPTChoBTPN 'HAM-1504','01','-1',-1,'TRUNGNV',0
ALTER PROC [dbo].spGetPTChoBTPN
	@MS_MAY NVARCHAR(100) = '-1',
	@MS_BO_PHAN NVARCHAR(100) = '-1',
	@MS_LOAI_VT NVARCHAR(100) = '-1',
	@MS_LOAI_PT INT = -1,	
	@USERNAME NVARCHAR(100) = 'ADMIN',
	@NNgu INT
	
AS 


SELECT CASE @NNgu WHEN 0 THEN T3.TEN_LOAI_VT_TV WHEN 1 THEN T3.TEN_LOAI_VT_TA ELSE T3.TEN_LOAI_VT_TH END AS TEN_LOAI_VT, 
	T1.MS_PT, T2.TEN_PT, T2.TEN_PT_VIET, T2.QUY_CACH, T1.SO_LUONG, T2.DVT, 1 AS ACTIVE
FROM         dbo.CAU_TRUC_THIET_BI_PHU_TUNG AS T1 INNER JOIN
                      dbo.IC_PHU_TUNG AS T2 ON T1.MS_PT = T2.MS_PT INNER JOIN
                      dbo.LOAI_VT AS T3 ON T2.MS_LOAI_VT = T3.MS_LOAI_VT INNER JOIN
                      dbo.IC_PHU_TUNG_LOAI_PHU_TUNG AS T4 ON T2.MS_PT = T4.MS_PT INNER JOIN
                      dbo.NHOM_LOAI_PHU_TUNG AS T5 ON T4.MS_LOAI_PT = T5.MS_LOAI_PT INNER JOIN
                      dbo.USERS AS T6 ON T5.GROUP_ID = T6.GROUP_ID
WHERE     (T2.ACTIVE_PT = 1) AND (T3.MS_LOAI_VT = @MS_LOAI_VT OR @MS_LOAI_VT = '-1') AND (T1.ACTIVE = 1) 
	AND (T1.MS_MAY = @MS_MAY) AND (T1.MS_BO_PHAN = @MS_BO_PHAN) AND (T6.USERNAME = @USERNAME) AND (T4.MS_LOAI_PT = @MS_LOAI_PT OR @MS_LOAI_PT = -1) 
UNION 
SELECT CASE @NNgu WHEN 0 THEN T3.TEN_LOAI_VT_TV WHEN 1 THEN T3.TEN_LOAI_VT_TA ELSE T3.TEN_LOAI_VT_TH END AS TEN_LOAI_VT, 
	T1.MS_PT, T2.TEN_PT, T2.TEN_PT_VIET, T2.QUY_CACH, T1.SO_LUONG, T2.DVT, 1 AS ACTIVE
FROM         dbo.CAU_TRUC_THIET_BI AS T1 INNER JOIN
                      dbo.IC_PHU_TUNG AS T2 ON T1.MS_PT = T2.MS_PT INNER JOIN
                      dbo.LOAI_VT AS T3 ON T2.MS_LOAI_VT = T3.MS_LOAI_VT INNER JOIN
                      dbo.IC_PHU_TUNG_LOAI_PHU_TUNG AS T4 ON T2.MS_PT = T4.MS_PT INNER JOIN
                      dbo.NHOM_LOAI_PHU_TUNG AS T5 ON T4.MS_LOAI_PT = T5.MS_LOAI_PT INNER JOIN
                      dbo.USERS AS T6 ON T5.GROUP_ID = T6.GROUP_ID
WHERE     (T2.ACTIVE_PT = 1) AND (T3.MS_LOAI_VT = @MS_LOAI_VT OR @MS_LOAI_VT = '-1') AND (T4.MS_LOAI_PT = @MS_LOAI_PT OR @MS_LOAI_PT = -1) 
	AND (T1.MS_MAY = @MS_MAY) AND (T1.MS_BO_PHAN = @MS_BO_PHAN)
UNION 
SELECT CASE @NNgu WHEN 0 THEN T2.TEN_LOAI_VT_TV WHEN 1 THEN T2.TEN_LOAI_VT_TA ELSE T2.TEN_LOAI_VT_TH END AS TEN_LOAI_VT, 
	T3.MS_PT, T1.TEN_PT, T1.TEN_PT_VIET, T1.QUY_CACH, T3.SO_LUONG, T1.DVT, 1 AS ACTIVE
FROM         dbo.IC_PHU_TUNG AS T1 INNER JOIN
                      dbo.LOAI_VT AS T2 ON T1.MS_LOAI_VT = T2.MS_LOAI_VT INNER JOIN
                      dbo.CAU_TRUC_THIET_BI_PHU_TUNG AS T3 ON T1.MS_PT = T3.MS_PT INNER JOIN
                      dbo.IC_PHU_TUNG_LOAI_PHU_TUNG AS T4 ON T1.MS_PT = T4.MS_PT INNER JOIN
                      dbo.NHOM_LOAI_PHU_TUNG AS T5 ON T4.MS_LOAI_PT = T5.MS_LOAI_PT INNER JOIN
                      dbo.USERS AS T6 ON T5.GROUP_ID = T6.GROUP_ID
WHERE     (T1.ACTIVE_PT = 1) AND (T4.MS_LOAI_PT = @MS_LOAI_PT OR @MS_LOAI_PT = -1) AND (T1.MS_LOAI_VT = @MS_LOAI_VT OR @MS_LOAI_VT = '-1') 
AND (T3.MS_MAY = @MS_MAY) AND (T3.MS_BO_PHAN = @MS_BO_PHAN) AND (T6.USERNAME = @USERNAME) AND (T3.ACTIVE = 1)
ORDER BY MS_PT,TEN_PT