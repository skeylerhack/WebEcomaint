
ALTER procedure [dbo].[GET_rptDANH_SACH_NOI_LAP_DAT_THIET_BI] 
	@MS_MAY NVARCHAR(30) = 'BANG-BEL-001'
AS 

CREATE TABLE #TMP(
	[STT] INT,
	[NGAY_NHAP] [DATETIME] NULL,
	[Ten_N_XUONG] [NVARCHAR](250) NULL,
	[DIA_CHI] [NVARCHAR](250) NULL,
	[TEN_HE_THONG] [NVARCHAR](250) NULL,
	[TEN_BP_CHIU_PHI] [NVARCHAR](250) NULL,
	[TEN_DON_VI] [NVARCHAR](255) NULL
) 
INSERT	INTO #TMP(STT,NGAY_NHAP)
SELECT ROW_NUMBER() OVER(ORDER BY NGAY_NHAP DESC) AS STT,T1.NGAY_NHAP FROM (
SELECT DISTINCT NGAY_NHAP FROM dbo.MAY_HE_THONG WHERE MS_MAY = @MS_MAY
UNION	SELECT DISTINCT NGAY_NHAP FROM MAY_NHA_XUONG WHERE MS_MAY = @MS_MAY
UNION	SELECT DISTINCT NGAY_NHAP FROM MAY_BO_PHAN_CHIU_PHI WHERE MS_MAY = @MS_MAY) T1 ORDER BY T1.NGAY_NHAP DESC	


--ROW_NUMBER() OVER(ORDER BY MAY_NHA_XUONG.ms_may DESC) AS STT, 
UPDATE #TMP SET Ten_N_XUONG = T1.Ten_N_XUONG,DIA_CHI = T1.DIA_CHI FROM (
SELECT    dbo.MAY_NHA_XUONG.NGAY_NHAP, 
                      dbo.NHA_XUONG.Ten_N_XUONG, dbo.NHA_XUONG.DIA_CHI,NULL AS TEN_HE_THONG, NULL TEN_BP_CHIU_PHI,NULL AS TEN_DON_VI
FROM         dbo.MAY_NHA_XUONG INNER JOIN
                      dbo.NHA_XUONG ON dbo.MAY_NHA_XUONG.MS_N_XUONG = dbo.NHA_XUONG.MS_N_XUONG INNER JOIN
                      dbo.MAY ON dbo.MAY_NHA_XUONG.MS_MAY = dbo.MAY.MS_MAY INNER JOIN
                      dbo.NHOM_MAY ON dbo.MAY.MS_NHOM_MAY = dbo.NHOM_MAY.MS_NHOM_MAY INNER JOIN
                      dbo.LOAI_MAY ON dbo.NHOM_MAY.MS_LOAI_MAY = dbo.LOAI_MAY.MS_LOAI_MAY
WHERE    dbo.MAY.MS_MAY = @MS_MAY) T1 INNER JOIN #TMP T2 ON T1.NGAY_NHAP = T2.NGAY_NHAP

UPDATE #TMP SET TEN_HE_THONG = T1.TEN_HE_THONG FROM (
SELECT     dbo.MAY_HE_THONG.NGAY_NHAP,dbo.HE_THONG.TEN_HE_THONG                   
FROM         dbo.MAY_HE_THONG INNER JOIN
                      dbo.HE_THONG ON dbo.MAY_HE_THONG.MS_HE_THONG = dbo.HE_THONG.MS_HE_THONG INNER JOIN
                      dbo.MAY INNER JOIN
                      dbo.NHOM_MAY ON dbo.MAY.MS_NHOM_MAY = dbo.NHOM_MAY.MS_NHOM_MAY INNER JOIN
                      dbo.LOAI_MAY ON dbo.NHOM_MAY.MS_LOAI_MAY = dbo.LOAI_MAY.MS_LOAI_MAY ON dbo.MAY_HE_THONG.MS_MAY = dbo.MAY.MS_MAY
WHERE     dbo.MAY.MS_MAY = @MS_MAY) T1 INNER JOIN #TMP T2 ON T1.NGAY_NHAP = T2.NGAY_NHAP

UPDATE #TMP SET TEN_BP_CHIU_PHI = T1.TEN_BP_CHIU_PHI,TEN_DON_VI = T1.TEN_DON_VI FROM (
SELECT     dbo.MAY_BO_PHAN_CHIU_PHI.NGAY_NHAP, 
                      dbo.BO_PHAN_CHIU_PHI.TEN_BP_CHIU_PHI, dbo.DON_VI.TEN_DON_VI
FROM         dbo.MAY_BO_PHAN_CHIU_PHI INNER JOIN
                      dbo.BO_PHAN_CHIU_PHI ON dbo.MAY_BO_PHAN_CHIU_PHI.MS_BP_CHIU_PHI = dbo.BO_PHAN_CHIU_PHI.MS_BP_CHIU_PHI INNER JOIN
                      dbo.DON_VI ON dbo.BO_PHAN_CHIU_PHI.MSDV = dbo.DON_VI.MS_DON_VI INNER JOIN
                      dbo.MAY INNER JOIN
                      dbo.NHOM_MAY ON dbo.MAY.MS_NHOM_MAY = dbo.NHOM_MAY.MS_NHOM_MAY INNER JOIN
                      dbo.LOAI_MAY ON dbo.NHOM_MAY.MS_LOAI_MAY = dbo.LOAI_MAY.MS_LOAI_MAY ON 
                      dbo.MAY_BO_PHAN_CHIU_PHI.MS_MAY = dbo.MAY.MS_MAY
WHERE   dbo.MAY.MS_MAY =@MS_MAY) T1 INNER JOIN #TMP T2 ON T1.NGAY_NHAP = T2.NGAY_NHAP




SELECT * FROM #TMP ORDER BY STT
