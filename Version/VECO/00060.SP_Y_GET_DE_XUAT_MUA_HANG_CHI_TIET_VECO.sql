IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Y_GET_DE_XUAT_MUA_HANG_CHI_TIET_VECO')
   exec('CREATE PROCEDURE SP_Y_GET_DE_XUAT_MUA_HANG_CHI_TIET_VECO AS BEGIN SET NOCOUNT ON; END')
GO
ALTER procedure [dbo].[SP_Y_GET_DE_XUAT_MUA_HANG_CHI_TIET_VECO]
AS
BEGIN


CREATE TABLE #TMP(
	MS_DE_XUAT [nvarchar](250) NULL,
	MS_PT [nvarchar](250) NULL,
	SL_DX FLOAT NOT NULL,
	SL_NH FLOAT NOT NULL
 ) 

DECLARE @DDH_XMH BIT
SELECT TOP 1 @DDH_XMH = DDH_DXMH FROM THONG_TIN_CHUNG

IF @DDH_XMH = 0 
BEGIN
	INSERT INTO #TMP (MS_DE_XUAT, MS_PT, SL_DX, SL_NH )
	SELECT  MS_DE_XUAT, T1.MS_PT, ROUND(T1.SL_DX,2) AS SL_DX, ROUND(T2.SL_NH,2) AS SL_NH
	FROM
	(
			SELECT MS_DE_XUAT, MS_PT, SUM(SL_DA_DUYET) AS SL_DX FROM DE_XUAT_MUA_HANG_CHI_TIET 
			GROUP BY MS_DE_XUAT, MS_PT
	) T1 INNER JOIN 
	(
	SELECT   MS_DDH AS MSDX, MS_PT,  SUM(B.SL_THUC_NHAP) AS SL_NH
	FROM         dbo.IC_DON_HANG_NHAP AS A INNER JOIN
						  dbo.IC_DON_HANG_NHAP_VAT_TU AS B ON A.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT
	WHERE     (A.MS_DANG_NHAP = 3) 
	GROUP BY MS_DDH, MS_PT
	) T2 ON T1.MS_DE_XUAT = T2.MSDX AND T1.MS_PT = T2.MS_PT
END
ELSE
BEGIN
	INSERT INTO #TMP (MS_DE_XUAT, MS_PT, SL_DX, SL_NH )
	SELECT  MS_DE_XUAT, T1.MS_PT, T1.SL_DX, T2.SL_NH 
	FROM
	(
			SELECT MS_DE_XUAT, MS_PT, SUM(SL_DA_DUYET) AS SL_DX FROM DE_XUAT_MUA_HANG_CHI_TIET 
			GROUP BY MS_DE_XUAT, MS_PT
	) T1 INNER JOIN 
	(
	SELECT   MS_DE_XUAT AS MSDX, MS_PT,  SUM(SL_DAT_HANG) AS SL_NH
	FROM  dbo.DON_DAT_HANG_CHI_TIET 
	GROUP BY MS_DE_XUAT , MS_PT
	) T2 ON T1.MS_DE_XUAT = T2.MSDX AND T1.MS_PT = T2.MS_PT
END



SELECT    A.MS_DE_XUAT, A.MS_PT,A.MS_PT_CTY, A.TEN_PT, A.PART_NO, A.QUY_CACH, A.DVT, A.NHAN_HIEU, A.HANG_SX, A.CONG_DUNG, A.HAN_SU_DUNG, A.TON_KHO, A.TON_MIN, A.TON_MAX, A.DA_DAT_MUA, 
                      A.DA_DE_XUAT, A.SL_DE_XUAT, A.SL_DA_DUYET, A.DON_GIA, A.NGOAI_TE, A.TY_GIA, A.TY_GIA_USD, A.THANH_TIEN, A.THANH_TIEN_VND, A.THANH_TIEN_USD, A.THUE_VAT, A.SO_HOA_DON, 
                      A.NHA_CUNG_CAP, A.NGAY_GIAO_HANG, A.NGAY_DE_XUAT_CUOI, A.NHA_CUNG_CAP_CUOI, A.DON_GIA_CUOI, A.NGOAI_TE_CUOI, A.GHI_CHU, 
                      SL_NH AS SL_DA_NHAP,TEN_TT AS TEN_TRANG_THAI, MS_TT AS MS_TTHAI,A.TEN_MAY,A.TEN_N_XUONG, A.LIFE_TIME,A.BY_WHOM, A.BUYING_NEW,A.REPLACING_FOR, A.DUONG_DAN_TL
					  ,A.SPARE, A.MAINTENANCE, a.TRANSFER_TO 
				
FROM 
(SELECT		CASE ISNULL(SL_DX,0) WHEN 0 THEN 0 
			ELSE
				CASE ISNULL(SL_DX,0) - ISNULL(SL_NH,0) WHEN 0 THEN 2 
				ELSE 1 END 
			END AS TTHAI,SL_NH,
   A.MS_DE_XUAT, A.MS_PT,B.MS_PT_CTY , A.TEN_PT, A.PART_NO, A.QUY_CACH, A.DVT, A.NHAN_HIEU, A.HANG_SX, A.CONG_DUNG, A.HAN_SU_DUNG, A.TON_KHO, A.TON_MIN, A.TON_MAX, A.DA_DAT_MUA, 
                      A.DA_DE_XUAT, A.SL_DE_XUAT, A.SL_DA_DUYET, A.DON_GIA, A.NGOAI_TE, A.TY_GIA, A.TY_GIA_USD, A.THANH_TIEN, A.THANH_TIEN_VND, A.THANH_TIEN_USD, A.THUE_VAT, A.SO_HOA_DON, 
                      A.NHA_CUNG_CAP, A.NGAY_GIAO_HANG, A.NGAY_DE_XUAT_CUOI, A.NHA_CUNG_CAP_CUOI, A.DON_GIA_CUOI, A.NGOAI_TE_CUOI, A.GHI_CHU,
					  A.TEN_MAY,A.TEN_N_XUONG, A.LIFE_TIME,A.BY_WHOM, A.BUYING_NEW,A.REPLACING_FOR, A.DUONG_DAN_TL
					  ,A.SPARE, A.MAINTENANCE, a.TRANSFER_TO 

FROM         dbo.DE_XUAT_MUA_HANG_CHI_TIET AS A INNER JOIN
                      dbo.IC_PHU_TUNG AS B ON A.MS_PT = B.MS_PT LEFT JOIN 
			#TMP C ON A.MS_DE_XUAT = C.MS_DE_XUAT AND A.MS_PT = C.MS_PT
) A INNER JOIN TRANG_THAI_DX B ON A.TTHAI = B.MS_TT
ORDER BY A.MS_DE_XUAT, A.MS_PT			

END








