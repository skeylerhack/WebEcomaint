

ALTER proc [dbo].[Get_Loc_THONG_SO_GSTT_BP]
	@MS_BP_GSTT INT,
	@MS_MAY NVARCHAR(30),
	@MS_BO_PHAN NVARCHAR(50),
	@USERNAME NVARCHAR(250),
	@LOAI_TS BIT
AS

SELECT        T4.MS_TS_GSTT, T4.TEN_TS_GSTT, T4.MS_DV_DO, T4.LOAI_TS, T4.GHI_CHU, T4.MS_BP_GSTT, T4.DUONG_DAN, T4.MS_LOAI_CV
INTO #THONG_SO_GSTT
FROM            dbo.NHOM_LOAI_CONG_VIEC AS T2 INNER JOIN
                         dbo.USERS AS T3 ON T2.GROUP_ID = T3.GROUP_ID INNER JOIN
                         dbo.THONG_SO_GSTT AS T4 ON T2.MS_LOAI_CV = T4.MS_LOAI_CV
WHERE (USERNAME = @USERNAME) AND (ISNULL(T4.MS_LOAI_CV,'') <> '')
UNION 
SELECT * FROM
(
SELECT        T4.MS_TS_GSTT, T4.TEN_TS_GSTT, T4.MS_DV_DO, T4.LOAI_TS, T4.GHI_CHU, T4.MS_BP_GSTT, T4.DUONG_DAN, ISNULL(T4.MS_LOAI_CV,-99) AS MS_LOAI_CV
FROM            dbo.THONG_SO_GSTT AS T4 
WHERE  (ISNULL(MS_LOAI_CV,'') = '')
) A 


SELECT CONVERT(BIT, 0) AS CHON, T1.MS_TS_GSTT, T1.TEN_TS_GSTT, DON_VI_DO.TEN_DV_DO,GHI_CHU, T2.TEN_BP_GSTT_TV
FROM #THONG_SO_GSTT AS T1 LEFT JOIN DON_VI_DO ON T1.MS_DV_DO = DON_VI_DO.MS_DV_DO 
LEFT JOIN BO_PHAN_GSTT T2 ON T2.MS_BP_GSTT = T1.MS_BP_GSTT 
WHERE LOAI_TS=@LOAI_TS and (T1.MS_BP_GSTT=@MS_BP_GSTT OR @MS_BP_GSTT = '-1')
AND MS_TS_GSTT NOT IN (
		SELECT MS_TS_GSTT FROM CAU_TRUC_THIET_BI_TS_GSTT
		WHERE (MS_MAY=@MS_MAY)  AND (MS_BO_PHAN=@MS_BO_PHAN  OR @MS_BO_PHAN = '-1') )
ORDER BY T1.TEN_TS_GSTT
