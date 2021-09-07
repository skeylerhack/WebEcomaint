IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetThongSoGiamSatTinhTrang')
   exec('CREATE PROCEDURE GetThongSoGiamSatTinhTrang AS BEGIN SET NOCOUNT ON; END')
GO
----

--exec GetThongSoGiamSatTinhTrang 'admin', 0,-1,0 

ALTER proc [dbo].[GetThongSoGiamSatTinhTrang]
	@USERNAME NVARCHAR(50),
	@NGON_NGU INT,
	@MS_BP_GSTT INT,
	@LOAI BIT
AS


SELECT DISTINCT MS_LOAI_CV INTO #LOAI_CV_TMP FROM NHOM_LOAI_CONG_VIEC A INNER JOIN USERS B ON A.GROUP_ID = B.GROUP_ID WHERE USERNAME = @USERNAME

SELECT        TOP (100) PERCENT CONVERT(NUMERIC, T1.MS_TS_GSTT) AS MS_TS_GSTT, case @NGON_NGU when 0 then T1.TEN_TS_GSTT when 1 then isnull(t1.TEN_TS_GSTT_ANH,t1.TEN_TS_GSTT) when 2 then isnull(t1.TEN_TS_GSTT_HOA,t1.TEN_TS_GSTT) end as TEN_TS_GSTT, T2.MS_DV_DO, T2.TEN_DV_DO, T1.LOAI_TS, T1.GHI_CHU, T3.MS_BP_GSTT, 
	CASE @NGON_NGU WHEN 0 THEN TEN_BP_GSTT_TV WHEN 1 THEN TEN_BP_GSTT_TA ELSE TEN_BP_GSTT_TH END AS TEN_BP_GSTT, T1.DUONG_DAN, T1.MS_LOAI_CV
FROM            dbo.THONG_SO_GSTT AS T1 LEFT OUTER JOIN
                         dbo.DON_VI_DO AS T2 ON T1.MS_DV_DO = T2.MS_DV_DO INNER JOIN
                         dbo.BO_PHAN_GSTT AS T3 ON T1.MS_BP_GSTT = T3.MS_BP_GSTT
						 INNER JOIN #LOAI_CV_TMP T4 ON T4.MS_LOAI_CV = T1.MS_LOAI_CV
WHERE        (T1.MS_BP_GSTT = @MS_BP_GSTT OR @MS_BP_GSTT = -1) AND (T1.LOAI_TS = @LOAI) AND (ISNULL(T1.MS_LOAI_CV,'') <> '')

 

UNION

SELECT        T4.MS_TS_GSTT, TEN_TS_GSTT, T2.MS_DV_DO,T2.TEN_DV_DO, T4.LOAI_TS, T4.GHI_CHU, T3.MS_BP_GSTT, TEN_BP_GSTT_TV, 
				T4.DUONG_DAN, T4.MS_LOAI_CV
FROM            dbo.THONG_SO_GSTT AS T4 
				LEFT OUTER JOIN dbo.DON_VI_DO AS T2 ON T4.MS_DV_DO = T2.MS_DV_DO
				INNER JOIN dbo.BO_PHAN_GSTT AS T3 ON T4.MS_BP_GSTT = T3.MS_BP_GSTT
WHERE  (ISNULL(MS_LOAI_CV,'') = '') AND (T4.MS_BP_GSTT = @MS_BP_GSTT OR @MS_BP_GSTT = -1) AND (T4.LOAI_TS = @LOAI)

ORDER BY TEN_TS_GSTT 
		

		
drop table #LOAI_CV_TMP