IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetCTTBThongSoGSTT')
   exec('CREATE PROCEDURE GetCTTBThongSoGSTT AS BEGIN SET NOCOUNT ON; END')
GO



ALTER procedure GetCTTBThongSoGSTT
	@MS_MAY NVARCHAR(30),
	@MS_LOAI_CV INT
 AS

SELECT DISTINCT T1.MS_BO_PHAN, T2.TEN_BO_PHAN,ISNULL(T2.STT,9999) AS STT
FROM            dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T1 INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS T2 ON T2.MS_MAY = T1.MS_MAY AND T2.MS_BO_PHAN = T1.MS_BO_PHAN INNER JOIN
                         dbo.THONG_SO_GSTT AS T3 ON T1.MS_TS_GSTT = T3.MS_TS_GSTT
WHERE (T1.MS_MAY = @MS_MAY) AND (ISNULL(MS_LOAI_CV,-99) = @MS_LOAI_CV OR @MS_LOAI_CV = -1) 
ORDER BY ISNULL(T2.STT,9999) , TEN_BO_PHAN
