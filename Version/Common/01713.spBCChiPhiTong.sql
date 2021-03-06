

--SELECT * FROM AAAAAAA WHERE MA_SO = 'VF01.03.02.01'
--SELECT TEN_N_XUONG,SUM(TONG),HU_HONG FROM AAAAAAA1 WHERE TEN_N_XUONG = N'Khu chế biến gạo G2' GROUP BY TEN_N_XUONG,HU_HONG
ALTER PROCEDURE [dbo].[spBCChiPhiTong]
	@TNgay DATE = '07/05/2010',
	@DNgay DATE = '08/05/2019',
	@UName NVARCHAR(100) = 'ADMIN'
AS 

BEGIN

SELECT MS_MAY,MS_N_XUONG,Ten_N_XUONG,MS_HE_THONG,TEN_HE_THONG,MS_LOAI_MAY,TEN_LOAI_MAY,MS_NHOM_MAY,TEN_NHOM_MAY,MS_BP_CHIU_PHI,TEN_BP_CHIU_PHI INTO #MayUser FROM          dbo.MGetMayUserNgay(@DNgay, @UName, '-1', -1, - 1, '-1', '-1', '-1', 3)


SELECT T1.MS_PHIEU_BAO_TRI, T1.MS_MAY, MS_N_XUONG, Ten_N_XUONG, MS_HE_THONG, TEN_HE_THONG, MS_LOAI_MAY, TEN_LOAI_MAY, MS_NHOM_MAY, TEN_NHOM_MAY, MS_BP_CHIU_PHI, TEN_BP_CHIU_PHI, CHI_PHI_PHU_TUNG, CHI_PHI_VAT_TU, CHI_PHI_NHAN_CONG, CHI_PHI_DV, CHI_PHI_KHAC , CHI_PHI_HANG_NGAY, ISNULL(CHI_PHI_PHU_TUNG,0) + ISNULL(CHI_PHI_VAT_TU,0) + ISNULL(CHI_PHI_NHAN_CONG,0) + ISNULL(CHI_PHI_DV,0) + ISNULL(CHI_PHI_KHAC,0) + ISNULL(CHI_PHI_HANG_NGAY,0) AS TONG, HU_HONG
INTO #TMP
FROM 
(
SELECT        T1.MS_PHIEU_BAO_TRI,T1.MS_MAY, SUM(T2.CHI_PHI_PHU_TUNG) AS CHI_PHI_PHU_TUNG,SUM(T2.CHI_PHI_VAT_TU) AS CHI_PHI_VAT_TU, SUM(T2.CHI_PHI_NHAN_CONG) AS CHI_PHI_NHAN_CONG, SUM(T2.CHI_PHI_DV) AS CHI_PHI_DV, SUM(T2.CHI_PHI_KHAC) 
                         AS CHI_PHI_KHAC , CONVERT(FLOAT,NULL) AS CHI_PHI_HANG_NGAY, 
						 T3.HU_HONG
FROM            dbo.PHIEU_BAO_TRI AS T1 INNER JOIN
                         dbo.PHIEU_BAO_TRI_CHI_PHI AS T2 ON T2.MS_PHIEU_BAO_TRI = T1.MS_PHIEU_BAO_TRI INNER JOIN dbo.LOAI_BAO_TRI T3 ON T3.MS_LOAI_BT = T1.MS_LOAI_BT
WHERE (CONVERT(DATE,T1.NGAY_BD_KH) BETWEEN @TNgay AND @DNgay) AND (T1.TINH_TRANG_PBT >=3) 
GROUP BY T1.MS_PHIEU_BAO_TRI,T1.MS_MAY,T3.HU_HONG
UNION
SELECT        'CP-HN' AS MS_PHIEU_BAO_TRI, T2.MS_MAY , 0 AS CHI_PHI_PHU_TUNG, CONVERT(FLOAT,NULL) AS CHI_PHI_VAT_TU, CONVERT(FLOAT,NULL) AS CHI_PHI_NHAN_CONG, 0 AS CHI_PHI_DV, 0 AS CHI_PHI_KHAC, SUM(ISNULL(T2.CHI_PHI_VT, 0) + ISNULL(T2.CHI_PHI_NC, 0)) 
                         AS CHI_PHI_HANG_NGAY, 1 AS HU_HONG
FROM            dbo.CONG_VIEC_HANG_NGAY AS T1 INNER JOIN
                         dbo.CONG_VIEC_HANG_NGAY_THIET_BI AS T2 ON T1.STT_CV = T2.STT_CV INNER JOIN
                         #MayUser AS T3 ON T2.MS_MAY = T3.MS_MAY 
WHERE (CONVERT(DATE,T1.NGAY_TH) BETWEEN @TNgay AND @DNgay)
GROUP BY T2.MS_MAY



) T1 
INNER JOIN #MayUser T2 ON T1.MS_MAY = T2.MS_MAY 

WHERE	(ISNULL(CHI_PHI_PHU_TUNG,0) + ISNULL(CHI_PHI_VAT_TU,0) + ISNULL(CHI_PHI_NHAN_CONG,0) + ISNULL(CHI_PHI_DV,0) + ISNULL(CHI_PHI_KHAC,0) + ISNULL(CHI_PHI_HANG_NGAY,0))> 0
ORDER BY T1.MS_PHIEU_BAO_TRI



----------SELECT TMP.MS_PHIEU_BAO_TRI,
----------       TMP.MS_MAY,
----------       TMP.MS_N_XUONG,
----------       TMP.Ten_N_XUONG,
----------       TMP.MS_HE_THONG,
----------       TMP.TEN_HE_THONG,
----------       TMP.MS_LOAI_MAY,
----------       TMP.TEN_LOAI_MAY,
----------       TMP.MS_NHOM_MAY,
----------       TMP.TEN_NHOM_MAY,
----------       TMP.MS_BP_CHIU_PHI,
----------       TMP.TEN_BP_CHIU_PHI,
----------       TMP.CHI_PHI_PHU_TUNG,
----------       TMP.CHI_PHI_VAT_TU,
----------       TMP.CHI_PHI_NHAN_CONG,
----------       TMP.CHI_PHI_DV,
----------       TMP.CHI_PHI_KHAC,
----------       TMP.CHI_PHI_HANG_NGAY
----------        ,(TMP.CHI_PHI_PHU_TUNG+TMP.CHI_PHI_VAT_TU+ TMP.CHI_PHI_NHAN_CONG+ TMP.CHI_PHI_DV+ TMP.CHI_PHI_KHAC+ TMP.CHI_PHI_HANG_NGAY) AS TONG	,HU_HONG           
----------		INTO #TMP
----------FROM
----------(
----------SELECT DISTINCT 
----------                      T4.MS_PHIEU_BAO_TRI, T5.MS_MAY, T8.MS_N_XUONG, T8.Ten_N_XUONG, ISNULL(T11.MS_HE_THONG, N'0') AS MS_HE_THONG, ISNULL(T11.TEN_HE_THONG, N'No line') AS TEN_HE_THONG, 
----------                      T7.MS_LOAI_MAY, T7.TEN_LOAI_MAY, T6.MS_NHOM_MAY, T6.TEN_NHOM_MAY, T1.MS_BP_CHIU_PHI, T1.TEN_BP_CHIU_PHI, T2.CHI_PHI_PHU_TUNG, T2.CHI_PHI_VAT_TU, 
----------                      T2.CHI_PHI_NHAN_CONG, T2.CHI_PHI_DV, T2.CHI_PHI_KHAC, 0 AS CHI_PHI_HANG_NGAY, T10.HU_HONG
----------FROM         dbo.BO_PHAN_CHIU_PHI AS T1 INNER JOIN
----------                      dbo.PHIEU_BAO_TRI_CHI_PHI AS T2 INNER JOIN
----------                      dbo.MAY_NHA_XUONG_NGAY_MAX AS T3 INNER JOIN
----------                      dbo.PHIEU_BAO_TRI AS T4 INNER JOIN
----------                      dbo.MAY AS T5 ON T4.MS_MAY = T5.MS_MAY INNER JOIN
----------                      dbo.NHOM_MAY AS T6 ON T5.MS_NHOM_MAY = T6.MS_NHOM_MAY ON T3.MS_MAY = T5.MS_MAY INNER JOIN
----------                      dbo.LOAI_MAY AS T7 ON T6.MS_LOAI_MAY = T7.MS_LOAI_MAY INNER JOIN
----------                      dbo.NHA_XUONG AS T8 ON T3.MS_N_XUONG = T8.MS_N_XUONG ON T2.MS_PHIEU_BAO_TRI = T4.MS_PHIEU_BAO_TRI INNER JOIN
----------                      dbo.MAY_BPCP_NGAY_MAX AS T9 ON T5.MS_MAY = T9.MS_MAY ON T1.MS_BP_CHIU_PHI = T9.MS_BP_CHIU_PHI INNER JOIN
----------                      dbo.LOAI_BAO_TRI AS T10 ON T4.MS_LOAI_BT = T10.MS_LOAI_BT LEFT OUTER JOIN
----------                      dbo.HE_THONG AS T11 INNER JOIN
----------                      dbo.MAY_HE_THONG_NGAY_MAX AS T12 ON T11.MS_HE_THONG = T12.MS_HE_THONG ON T5.MS_MAY = T12.MS_MAY
----------WHERE     (T4.NGAY_BD_KH > @TNgay) AND (T4.NGAY_BD_KH < @DNgay) AND (T4.TINH_TRANG_PBT >= 3)

----------UNION
----------SELECT     'CP-HN' , T7.MS_MAY, T3.MS_N_XUONG, T3.Ten_N_XUONG, ISNULL(T10.MS_HE_THONG, N'0') AS MS_HE_THONG, ISNULL(T10.TEN_HE_THONG, N'No line') AS TEN_HE_THONG, 
----------                      T5.MS_LOAI_MAY, T5.TEN_LOAI_MAY, T9.MS_NHOM_MAY, T9.TEN_NHOM_MAY, T1.MS_BP_CHIU_PHI, T1.TEN_BP_CHIU_PHI, 0 AS CHI_PHI_HANG_NGAY, 0 AS Expr2, 0 AS Expr3, 0 AS Expr4, 
----------                      0 AS Expr5, SUM(CASE WHEN T7.CHI_PHI_VT IS NULL 
----------                      THEN 0 ELSE T7.CHI_PHI_VT END + CASE WHEN T7.CHI_PHI_NC IS NULL 
----------                      THEN 0 ELSE T7.CHI_PHI_NC END) , 1 
----------FROM         dbo.BO_PHAN_CHIU_PHI AS T1 INNER JOIN
----------                      dbo.MAY_BPCP_NGAY_MAX AS T2 INNER JOIN
----------                      dbo.NHA_XUONG AS T3 INNER JOIN
----------                      dbo.MAY_NHA_XUONG_NGAY_MAX AS T4 ON T3.MS_N_XUONG = T4.MS_N_XUONG INNER JOIN
----------                      dbo.LOAI_MAY AS T5 INNER JOIN
----------                      dbo.CONG_VIEC_HANG_NGAY AS T6 INNER JOIN
----------                      dbo.CONG_VIEC_HANG_NGAY_THIET_BI AS T7 ON T6.STT_CV = T7.STT_CV INNER JOIN
----------                      dbo.MAY AS T8 ON T7.MS_MAY = T8.MS_MAY INNER JOIN
----------                      dbo.NHOM_MAY AS T9 ON T8.MS_NHOM_MAY = T9.MS_NHOM_MAY ON T5.MS_LOAI_MAY = T9.MS_LOAI_MAY ON T4.MS_MAY = T8.MS_MAY ON T2.MS_MAY = T8.MS_MAY ON 
----------                      T1.MS_BP_CHIU_PHI = T2.MS_BP_CHIU_PHI LEFT OUTER JOIN
----------                      dbo.HE_THONG AS T10 INNER JOIN
----------                      dbo.MAY_HE_THONG_NGAY_MAX AS T11 ON T10.MS_HE_THONG = T11.MS_HE_THONG ON T8.MS_MAY = T11.MS_MAY
----------WHERE     (T6.NGAY_TH >= @TNgay) AND (T6.NGAY_TH < @DNgay)
----------GROUP BY T7.MS_MAY, T4.MS_MAY, T11.MS_MAY, T3.MS_N_XUONG, T3.Ten_N_XUONG, T10.MS_HE_THONG, T10.TEN_HE_THONG, T5.MS_LOAI_MAY, T5.TEN_LOAI_MAY, T9.MS_NHOM_MAY, 
----------                      T9.TEN_NHOM_MAY, T1.MS_BP_CHIU_PHI, T1.TEN_BP_CHIU_PHI

----------)TMP
----------WHERE 
------------((TMP.CHI_PHI_PHU_TUNG+TMP.CHI_PHI_VAT_TU + TMP.CHI_PHI_NHAN_CONG+ TMP.CHI_PHI_DV+ TMP.CHI_PHI_KHAC+ TMP.CHI_PHI_HANG_NGAY) IS NOT NULL ) AND 
----------((TMP.CHI_PHI_PHU_TUNG+TMP.CHI_PHI_VAT_TU + TMP.CHI_PHI_NHAN_CONG+ TMP.CHI_PHI_DV+ TMP.CHI_PHI_KHAC+ TMP.CHI_PHI_HANG_NGAY) <> 0 )



SELECT MS_CHA,MA_SO,TEN,
NULLIF(SUM(CHI_PHI_PHU_TUNG_CO_KH),0)  AS CHI_PHI_PHU_TUNG_CO_KH, 
NULLIF(SUM(CHI_PHI_PHU_TUNG_NGOAI_KH),0)   AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
NULLIF(SUM(CHI_PHI_VAT_TU_CO_KH),0)   AS CHI_PHI_VAT_TU_CO_KH, 
NULLIF(SUM(CHI_PHI_VAT_TU_NGOAI_KH),0)   AS CHI_PHI_VAT_TU_NGOAI_KH, 
NULLIF(SUM(CHI_PHI_NHAN_CONG_CO_KH),0)   AS CHI_PHI_NHAN_CONG_CO_KH, 
NULLIF(SUM(CHI_PHI_NHAN_CONG_NGOAI_KH),0)   AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
NULLIF(SUM(CHI_PHI_DV_CO_KH),0)   AS CHI_PHI_DV_CO_KH, 
NULLIF(SUM(CHI_PHI_DV_NGOAI_KH),0)   AS CHI_PHI_DV_NGOAI_KH, 
NULLIF(SUM(CHI_PHI_KHAC_CO_KH),0)   AS CHI_PHI_KHAC_CO_KH, 
NULLIF(SUM(CHI_PHI_KHAC_NGOAI_KH),0)   AS CHI_PHI_KHAC_NGOAI_KH, 
NULLIF(SUM(CHI_PHI_HANG_NGAY_CO_KH),0)   AS CHI_PHI_HANG_NGAY_CO_KH, 
NULLIF(SUM(CHI_PHI_HANG_NGAY_NGOAI_KH),0)   AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
NULLIF(SUM(TONG_CO_KH),0)   AS TONG_CO_KH, 
NULLIF(SUM(TONG_NGOAI_KH),0)   AS TONG_NGOAI_KH,
NULLIF(SUM(TONG_CP),0)  AS TONG_CP,  LOAI	 FROM 
(
SELECT MS_CHA,MA_SO,TEN,
SUM(CHI_PHI_PHU_TUNG_CO_KH)  AS CHI_PHI_PHU_TUNG_CO_KH, 
SUM(CHI_PHI_PHU_TUNG_NGOAI_KH)   AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
SUM(CHI_PHI_VAT_TU_CO_KH)   AS CHI_PHI_VAT_TU_CO_KH, 
SUM(CHI_PHI_VAT_TU_NGOAI_KH)   AS CHI_PHI_VAT_TU_NGOAI_KH, 
SUM(CHI_PHI_NHAN_CONG_CO_KH)   AS CHI_PHI_NHAN_CONG_CO_KH, 
SUM(CHI_PHI_NHAN_CONG_NGOAI_KH)   AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
SUM(CHI_PHI_DV_CO_KH)   AS CHI_PHI_DV_CO_KH, 
SUM(CHI_PHI_DV_NGOAI_KH)   AS CHI_PHI_DV_NGOAI_KH, 
SUM(CHI_PHI_KHAC_CO_KH)   AS CHI_PHI_KHAC_CO_KH, 
SUM(CHI_PHI_KHAC_NGOAI_KH)   AS CHI_PHI_KHAC_NGOAI_KH, 
SUM(CHI_PHI_HANG_NGAY_CO_KH)   AS CHI_PHI_HANG_NGAY_CO_KH, 
SUM(CHI_PHI_HANG_NGAY_NGOAI_KH)   AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
SUM(TONG_CO_KH)   AS TONG_CO_KH, 
SUM(TONG_NGOAI_KH)   AS TONG_NGOAI_KH,SUM(TONG_CP)  AS TONG_CP, 0 AS LOAI

FROM (
SELECT DISTINCT NULL AS MS_CHA,CONVERT(NVARCHAR(500), -1) AS MA_SO ,CONVERT(NVARCHAR(1000), N'Nhà Máy') AS TEN , 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP
FROM #TMP T1 GROUP BY T1.HU_HONG ) T1
GROUP BY MS_CHA,MA_SO,TEN 

UNION
--nha xuong
SELECT DISTINCT CONVERT(NVARCHAR(500),-1) AS MS_CHA,T1.MS_N_XUONG AS MA_SO ,T1.Ten_N_XUONG, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T1.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T1.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP, 1 AS LOAI
FROM #TMP T1
GROUP BY T1.MS_N_XUONG ,T1.HU_HONG ,T1.Ten_N_XUONG  

UNION



SELECT DISTINCT MS_N_XUONG AS MS_CHA,MS_N_XUONG + 'MSLM' AS MA_SO, N'Loại Máy' AS TEN ,
NULL AS CHI_PHI_PHU_TUNG_CO_KH, 
NULL AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
NULL AS CHI_PHI_VAT_TU_CO_KH, 
NULL   AS CHI_PHI_VAT_TU_NGOAI_KH, 
NULL   AS CHI_PHI_NHAN_CONG_CO_KH, 
NULL   AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
NULL   AS CHI_PHI_DV_CO_KH, 
NULL   AS CHI_PHI_DV_NGOAI_KH, 
NULL   AS CHI_PHI_KHAC_CO_KH, 
NULL   AS CHI_PHI_KHAC_NGOAI_KH, 
NULL   AS CHI_PHI_HANG_NGAY_CO_KH, 
NULL   AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
NULL   AS TONG_CO_KH, 
NULL   AS TONG_NGOAI_KH,NULL AS TONG_CP, 2 AS LOAI
FROM #TMP T2	 
UNION
-- Loai May
SELECT DISTINCT T2.MS_N_XUONG + 'MSLM' AS MS_CHA,T2.MS_N_XUONG+ 'MSLM'+ T2.MS_LOAI_MAY  AS MA_SO ,T2.TEN_LOAI_MAY , 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP, 3 AS LOAI
FROM  #TMP T2 
GROUP BY T2.MS_N_XUONG  ,T2.TEN_LOAI_MAY,T2.HU_HONG  ,MS_LOAI_MAY
UNION
-- NHOM May
SELECT DISTINCT T2.MS_N_XUONG + 'MSLM'+ T2.MS_LOAI_MAY AS MS_CHA,
T2.MS_N_XUONG+ 'MSLM'+ T2.MS_LOAI_MAY+T2.MS_NHOM_MAY  AS MA_SO ,T2.TEN_NHOM_MAY , 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP, 4 AS LOAI
FROM  #TMP T2 
GROUP BY T2.MS_N_XUONG  ,T2.TEN_NHOM_MAY,T2.HU_HONG  ,MS_LOAI_MAY,MS_NHOM_MAY

UNION
-- May
SELECT DISTINCT T2.MS_N_XUONG + 'MSLM'+ T2.MS_LOAI_MAY+T2.MS_NHOM_MAY AS MS_CHA,
T2.MS_N_XUONG+ 'MSLM'+ T2.MS_LOAI_MAY+T2.MS_NHOM_MAY+T2.MS_MAY  AS MA_SO ,T2.MS_MAY , 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP, 5  AS LOAI
FROM  #TMP T2 
GROUP BY T2.MS_N_XUONG  ,T2.HU_HONG  ,MS_LOAI_MAY,MS_NHOM_MAY,T2.MS_MAY


UNION
-- pbt
SELECT DISTINCT T2.MS_N_XUONG + 'MSLM'+ T2.MS_LOAI_MAY+T2.MS_NHOM_MAY+T2.MS_MAY AS MS_CHA,
T2.MS_N_XUONG+ 'MSLM'+ T2.MS_LOAI_MAY+T2.MS_NHOM_MAY+T2.MS_MAY +T2.MS_PHIEU_BAO_TRI AS MA_SO ,T2.MS_PHIEU_BAO_TRI , 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP, 6  AS LOAI
FROM  #TMP T2 
GROUP BY T2.MS_N_XUONG  ,T2.HU_HONG  ,MS_LOAI_MAY,MS_NHOM_MAY,T2.MS_MAY,T2.MS_PHIEU_BAO_TRI

UNION	

--Day Chuyen
SELECT DISTINCT MS_N_XUONG AS MS_CHA,MS_N_XUONG + 'DChuyen' AS MA_SO, N'Dây Chuyền' AS TEN ,
NULL   AS CHI_PHI_PHU_TUNG_CO_KH, 
NULL   AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
NULL   AS CHI_PHI_VAT_TU_CO_KH, 
NULL   AS CHI_PHI_VAT_TU_NGOAI_KH, 
NULL   AS CHI_PHI_NHAN_CONG_CO_KH, 
NULL   AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
NULL   AS CHI_PHI_DV_CO_KH, 
NULL   AS CHI_PHI_DV_NGOAI_KH, 
NULL   AS CHI_PHI_KHAC_CO_KH, 
NULL   AS CHI_PHI_KHAC_NGOAI_KH, 
NULL   AS CHI_PHI_HANG_NGAY_CO_KH, 
NULL   AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
NULL   AS TONG_CO_KH, 
NULL   AS TONG_NGOAI_KH,NULL AS TONG_CP ,  2 AS LOAI
FROM #TMP T2	 
UNION

-- day chuyen
SELECT DISTINCT T2.MS_N_XUONG + 'DChuyen' AS MS_CHA,
T2.MS_N_XUONG+ 'DChuyen'+CONVERT(NVARCHAR(50),T2.MS_HE_THONG ) AS MA_SO ,T2.TEN_HE_THONG AS TEN, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP,3   AS LOAI
FROM  #TMP T2 
GROUP BY T2.MS_N_XUONG  ,T2.TEN_HE_THONG,T2.HU_HONG  ,MS_HE_THONG
UNION
-- NHOM May
SELECT DISTINCT T2.MS_N_XUONG + 'DChuyen' +CONVERT(NVARCHAR(50),T2.MS_HE_THONG ) AS MS_CHA,
T2.MS_N_XUONG + 'DChuyen' +CONVERT(NVARCHAR(50),T2.MS_HE_THONG )+T2.MS_NHOM_MAY  AS MA_SO ,T2.TEN_NHOM_MAY AS TEN , 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP, 4  AS LOAI
FROM  #TMP T2 
GROUP BY T2.MS_N_XUONG  ,T2.TEN_NHOM_MAY,T2.HU_HONG,MS_NHOM_MAY,MS_HE_THONG

UNION
-- May
SELECT DISTINCT T2.MS_N_XUONG + 'DChuyen'+CONVERT(NVARCHAR(50),T2.MS_HE_THONG )+T2.MS_NHOM_MAY AS MS_CHA,
T2.MS_N_XUONG + 'DChuyen' +CONVERT(NVARCHAR(50),T2.MS_HE_THONG )+T2.MS_NHOM_MAY+T2.MS_MAY  AS MA_SO ,T2.MS_MAY , 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP, 5  AS LOAI
FROM  #TMP T2 
GROUP BY T2.MS_N_XUONG  ,T2.HU_HONG  ,MS_NHOM_MAY,T2.MS_MAY,MS_HE_THONG


UNION
-- pbt
SELECT DISTINCT T2.MS_N_XUONG + 'DChuyen'+CONVERT(NVARCHAR(50),T2.MS_HE_THONG )+T2.MS_NHOM_MAY+T2.MS_MAY AS MS_CHA,
T2.MS_N_XUONG + 'DChuyen' +CONVERT(NVARCHAR(50),T2.MS_HE_THONG )+T2.MS_NHOM_MAY+T2.MS_MAY + T2.MS_PHIEU_BAO_TRI   AS MA_SO ,T2.MS_PHIEU_BAO_TRI , 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_PHU_TUNG) END  AS CHI_PHI_PHU_TUNG_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_VAT_TU) END  AS CHI_PHI_VAT_TU_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_NHAN_CONG) END  AS CHI_PHI_NHAN_CONG_NGOAI_KH,  
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_DV) END  AS CHI_PHI_DV_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_KHAC) END  AS CHI_PHI_KHAC_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(CHI_PHI_HANG_NGAY) END  AS CHI_PHI_HANG_NGAY_NGOAI_KH, 
CASE T2.HU_HONG  WHEN 0 THEN SUM(TONG) END  AS TONG_CO_KH, 
CASE T2.HU_HONG  WHEN 1 THEN SUM(TONG) END  AS TONG_NGOAI_KH,SUM(TONG)  AS TONG_CP, 6  AS LOAI
FROM  #TMP T2 
GROUP BY T2.MS_N_XUONG  ,T2.HU_HONG ,MS_NHOM_MAY,T2.MS_MAY,T2.MS_PHIEU_BAO_TRI,MS_HE_THONG



--SUM(TONG_CP)  DESC,
) T1 GROUP BY MS_CHA,MA_SO,TEN,T1.LOAI
ORDER BY SUM(TONG_CP)  DESC, T1.TEN
END
