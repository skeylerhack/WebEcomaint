IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetCTTBThongSoDenNgay')
   exec('CREATE PROCEDURE GetCTTBThongSoDenNgay AS BEGIN SET NOCOUNT ON; END')
GO
--tạo cây dến hạng
ALTER PROCEDURE [dbo].[GetCTTBThongSoDenNgay]
    @MS_MAY NVARCHAR(30) ='HCSHCM0101',
    @MS_LOAI_CV INT ='-1',
    @DenNgay DATETIME ='01/01/2030'
AS 
BEGIN
SELECT T1.MS_BO_PHAN, T2.TEN_BO_PHAN,ISNULL(T2.STT,9999) AS STT
INTO #HANG_MUC_DEN_HAN_GSTT 
FROM            dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T1 INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS T2 ON T2.MS_MAY = T1.MS_MAY AND T2.MS_BO_PHAN = T1.MS_BO_PHAN
WHERE        (T1.MS_MAY = @MS_MAY)
ORDER BY ISNULL(T2.STT,9999) ,T2.TEN_BO_PHAN
---
SELECT DISTINCT 
T6.MS_MAY, T7.NGAY_NHAP, T7.MS_N_XUONG, T8.Ten_N_XUONG, T8.DIA_CHI, T8.DIEN_TICH, T8.KHOANG_CACH, T8.GHI_CHU, T9.MS_LOAI_MAY, T5.MS_BO_PHAN, T5.TEN_BO_PHAN, T2.MS_TS_GSTT, 
                         T11.TEN_TS_GSTT, T12.TEN_GIA_TRI, T12.DAT, T4.MS_DV_TG, T4.CHU_KY_DO, CONVERT(NVARCHAR(10), T4.CHU_KY_DO) 
                         + ' ' + CASE 0 WHEN 0 THEN TEN_DV_TG WHEN 1 THEN TEN_DV_TG_ANH ELSE TEN_DV_TG_HOA END AS CHU_KY, T1.NGAY_KT
INTO  #MAY_TSGSTT_TMP
FROM            dbo.GIAM_SAT_TINH_TRANG AS T1 INNER JOIN
                         dbo.GIAM_SAT_TINH_TRANG_TS AS T2 ON T1.STT = T2.STT INNER JOIN
                         dbo.GIAM_SAT_TINH_TRANG_TS_DT AS T3 ON T2.STT = T3.STT AND T2.MS_MAY = T3.MS_MAY AND T2.MS_TS_GSTT = T3.MS_TS_GSTT AND T2.MS_BO_PHAN = T3.MS_BO_PHAN INNER JOIN
                         dbo.CAU_TRUC_THIET_BI_TS_GSTT AS T4 ON T2.MS_MAY = T4.MS_MAY AND T2.MS_BO_PHAN = T4.MS_BO_PHAN AND T2.MS_TS_GSTT = T4.MS_TS_GSTT INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS T5 ON T4.MS_MAY = T5.MS_MAY AND T4.MS_BO_PHAN = T5.MS_BO_PHAN INNER JOIN
                         dbo.MAY AS T6 ON T5.MS_MAY = T6.MS_MAY INNER JOIN
                         dbo.MAY_NHA_XUONG AS T7 INNER JOIN
                         dbo.NHA_XUONG AS T8 ON T7.MS_N_XUONG = T8.MS_N_XUONG ON T6.MS_MAY = T7.MS_MAY INNER JOIN
                         dbo.LOAI_MAY AS T9 INNER JOIN
                         dbo.NHOM_MAY AS T10 ON T9.MS_LOAI_MAY = T10.MS_LOAI_MAY ON T6.MS_NHOM_MAY = T10.MS_NHOM_MAY INNER JOIN
                         dbo.THONG_SO_GSTT AS T11 ON T4.MS_TS_GSTT = T11.MS_TS_GSTT INNER JOIN
                         dbo.GIA_TRI_TS_GSTT AS T12 ON T11.MS_TS_GSTT = T12.MS_TS_GSTT AND T3.STT_GT = T12.STT INNER JOIN
                         dbo.DON_VI_THOI_GIAN AS T13 ON T4.MS_DV_TG = T13.MS_DV_TG
WHERE (T6.MS_MAY = @MS_MAY)
AND (ISNULL(MS_LOAI_CV,-99) = @MS_LOAI_CV OR @MS_LOAI_CV = -1) 


SELECT        TMP1.MS_MAY, TMP1.NGAY_NHAP, TMP1.MS_N_XUONG, TMP1.Ten_N_XUONG, TMP1.DIA_CHI, TMP1.DIEN_TICH, TMP1.KHOANG_CACH, TMP1.GHI_CHU, TMP1.MS_LOAI_MAY, TMP1.MS_BO_PHAN, 
                         TMP1.TEN_BO_PHAN, TMP1.MS_TS_GSTT, TMP1.TEN_TS_GSTT, TMP1.CHU_KY, TMP1.NGAY_KT, GIA_TRI_TS_GSTT_1.TEN_GIA_TRI, GIA_TRI_TS_GSTT_1.DAT, CASE MS_DV_TG WHEN 1 THEN DATEADD(DAY,
                          CHU_KY_DO, TMP1.NGAY_KT) WHEN 2 THEN DATEADD(WEEK, CHU_KY_DO, TMP1.NGAY_KT) WHEN 3 THEN DATEADD(MONTH, CHU_KY_DO, TMP1.NGAY_KT) ELSE DATEADD(YEAR, CHU_KY_DO, 
                         TMP1.NGAY_KT) END AS NGAY
INTO #DU_LIEU_HANG_MUC_DEN_HAN_GSTT 
FROM            (SELECT        MS_MAY, NGAY_NHAP, MS_N_XUONG, Ten_N_XUONG, DIA_CHI, DIEN_TICH, KHOANG_CACH, GHI_CHU, MS_LOAI_MAY, MS_BO_PHAN, TEN_BO_PHAN, MS_TS_GSTT, TEN_TS_GSTT, CHU_KY, 
                                                    MAX(NGAY_KT) AS NGAY_KT
                          FROM           #MAY_TSGSTT_TMP AS TMP
                          GROUP BY MS_MAY, NGAY_NHAP, MS_N_XUONG, Ten_N_XUONG, DIA_CHI, DIEN_TICH, KHOANG_CACH, GHI_CHU, MS_LOAI_MAY, MS_BO_PHAN, TEN_BO_PHAN, MS_TS_GSTT, TEN_TS_GSTT, CHU_KY) 
                         AS TMP1 INNER JOIN
                         dbo.GIAM_SAT_TINH_TRANG_TS AS GIAM_SAT_TINH_TRANG_TS_1 ON TMP1.MS_MAY = GIAM_SAT_TINH_TRANG_TS_1.MS_MAY AND TMP1.MS_BO_PHAN = GIAM_SAT_TINH_TRANG_TS_1.MS_BO_PHAN AND 
                         TMP1.MS_TS_GSTT = GIAM_SAT_TINH_TRANG_TS_1.MS_TS_GSTT INNER JOIN
                         dbo.GIAM_SAT_TINH_TRANG AS GIAM_SAT_TINH_TRANG_1 ON GIAM_SAT_TINH_TRANG_TS_1.STT = GIAM_SAT_TINH_TRANG_1.STT AND TMP1.NGAY_KT = GIAM_SAT_TINH_TRANG_1.NGAY_KT INNER JOIN
                         dbo.CAU_TRUC_THIET_BI_TS_GSTT AS CAU_TRUC_THIET_BI_TS_GSTT_1 ON TMP1.MS_MAY = CAU_TRUC_THIET_BI_TS_GSTT_1.MS_MAY AND 
                         TMP1.MS_BO_PHAN = CAU_TRUC_THIET_BI_TS_GSTT_1.MS_BO_PHAN AND TMP1.MS_TS_GSTT = CAU_TRUC_THIET_BI_TS_GSTT_1.MS_TS_GSTT INNER JOIN
                         dbo.GIAM_SAT_TINH_TRANG_TS_DT AS GIAM_SAT_TINH_TRANG_TS_DT_1 ON GIAM_SAT_TINH_TRANG_TS_1.STT = GIAM_SAT_TINH_TRANG_TS_DT_1.STT AND 
                         GIAM_SAT_TINH_TRANG_TS_1.MS_MAY = GIAM_SAT_TINH_TRANG_TS_DT_1.MS_MAY AND GIAM_SAT_TINH_TRANG_TS_1.MS_TS_GSTT = GIAM_SAT_TINH_TRANG_TS_DT_1.MS_TS_GSTT AND
                         GIAM_SAT_TINH_TRANG_TS_1.MS_BO_PHAN = GIAM_SAT_TINH_TRANG_TS_DT_1.MS_BO_PHAN INNER JOIN
                         dbo.GIA_TRI_TS_GSTT AS GIA_TRI_TS_GSTT_1 ON GIAM_SAT_TINH_TRANG_TS_DT_1.MS_TS_GSTT = GIA_TRI_TS_GSTT_1.MS_TS_GSTT AND 
                         GIAM_SAT_TINH_TRANG_TS_DT_1.STT_GT = GIA_TRI_TS_GSTT_1.STT
WHERE        (CASE MS_DV_TG WHEN 1 THEN DATEADD(DAY, CHU_KY_DO, TMP1.NGAY_KT) WHEN 2 THEN DATEADD(WEEK, CHU_KY_DO, TMP1.NGAY_KT) WHEN 3 THEN DATEADD(MONTH, CHU_KY_DO, 
                         TMP1.NGAY_KT) ELSE DATEADD(YEAR, CHU_KY_DO, TMP1.NGAY_KT) END <= @DenNgay) AND (GIAM_SAT_TINH_TRANG_TS_1.MS_MAY = @MS_MAY)
SELECT @MS_MAY MS_BO_PHAN,@MS_MAY TEN_BO_PHAN,NULL MS_BO_PHAN_CHA, CONVERT(NVARCHAR(10),NULL) AS MS_TS_GSTT, @MS_MAY AS MSBP , 9999 AS STT
-------
UNION
SELECT T1.MS_BO_PHAN, T1.MS_BO_PHAN + ' - ' + T1.TEN_BO_PHAN ,T1.MS_BO_PHAN_CHA, NULL AS MS_TS_GSTT,T1.MS_BO_PHAN AS MSBP, ISNULL(T1.STT,9999) AS STT
FROM            dbo.CAU_TRUC_THIET_BI AS T1 --INNER JOIN dbo.CAU_TRUC_THIET_BI_TS_GSTT T2 ON T2.MS_BO_PHAN = T1.MS_BO_PHAN AND T2.MS_MAY = T1.MS_MAY
WHERE T1.MS_MAY = @MS_MAY
UNION
--SELECT NULL, T2.TEN_TS_GSTT, T1.MS_BO_PHAN , T1.MS_TS_GSTT, T1.MS_BO_PHAN AS MSBP


SELECT DISTINCT  NULL,T1.TEN_TS_GSTT,T2.MS_BO_PHAN,T1.MS_TS_GSTT,T2.MS_BO_PHAN AS MSBP,ISNULL(T2.STT,9999) AS STT
-- T2.MS_BO_PHAN, T2.TEN_BO_PHAN, T1.MS_TS_GSTT, T1.TEN_TS_GSTT, T2.STT
FROM            #DU_LIEU_HANG_MUC_DEN_HAN_GSTT AS T1 INNER JOIN
                         #HANG_MUC_DEN_HAN_GSTT AS T2 ON T1.MS_BO_PHAN = T2.MS_BO_PHAN
--ORDER BY STT,MS_BO_PHAN
END

