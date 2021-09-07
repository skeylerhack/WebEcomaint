IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'Get_Loc_All_THONG_SO_GSTTs')
   exec('CREATE PROCEDURE Get_Loc_All_THONG_SO_GSTTs AS BEGIN SET NOCOUNT ON; END')
GO

--EXEC Get_Loc_All_THONG_SO_GSTTs 
ALTER proc [dbo].[Get_Loc_All_THONG_SO_GSTTs]
	@LOAI_TS BIT,
	@MS_MAY NVARCHAR(30),
	@MS_BO_PHAN NVARCHAR(50),
	@GIA_TRI NVARCHAR(250),
	@USERNAME NVARCHAR(250),
	@NNgu nvarchar(5)
AS



SELECT        T4.MS_TS_GSTT,  TEN_TS_GSTT, T4.MS_DV_DO, T4.LOAI_TS, T4.GHI_CHU, T4.MS_BP_GSTT, T4.DUONG_DAN, T4.MS_LOAI_CV
INTO #THONG_SO_GSTT
FROM            dbo.NHOM_LOAI_CONG_VIEC AS T2 INNER JOIN
                         dbo.USERS AS T3 ON T2.GROUP_ID = T3.GROUP_ID INNER JOIN
                         dbo.THONG_SO_GSTT AS T4 ON T2.MS_LOAI_CV = T4.MS_LOAI_CV
WHERE (USERNAME = @USERNAME) AND (ISNULL(T4.MS_LOAI_CV,'') <> '')
UNION 
SELECT * FROM
(
SELECT        T4.MS_TS_GSTT,  TEN_TS_GSTT, T4.MS_DV_DO, T4.LOAI_TS, T4.GHI_CHU, T4.MS_BP_GSTT, T4.DUONG_DAN, ISNULL(T4.MS_LOAI_CV,-99) AS MS_LOAI_CV
FROM            dbo.THONG_SO_GSTT AS T4 
WHERE  (ISNULL(MS_LOAI_CV,'') = '')
) A 


SELECT T1.MS_TS_GSTT, T1.TEN_TS_GSTT, DON_VI_DO.TEN_DV_DO,GHI_CHU
FROM #THONG_SO_GSTT AS T1 LEFT JOIN DON_VI_DO ON T1.MS_DV_DO = DON_VI_DO.MS_DV_DO 
WHERE LOAI_TS=@LOAI_TS AND T1.TEN_TS_GSTT LIKE '%' + @GIA_TRI +'%' AND
MS_TS_GSTT NOT IN (
					SELECT MS_TS_GSTT FROM CAU_TRUC_THIET_BI_TS_GSTT
					WHERE MS_MAY=@MS_MAY  AND MS_BO_PHAN=@MS_BO_PHAN)
ORDER BY T1.TEN_TS_GSTT


