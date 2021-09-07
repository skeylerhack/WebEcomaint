--SELECT * FROM IC_KHO
--SELECT * FROM LOAI_VT
--EXEC SP_NHU_Y_GET_PHU_TUNG_DE_XUAT 17,'2'

ALTER procedure [dbo].[SP_NHU_Y_GET_PHU_TUNG_DE_XUAT]
@MS_KHO INT,
@MS_LOAI_VT NVARCHAR(10)
AS
BEGIN 

SELECT TMP8.* FROM
(
SELECT DISTINCT MS_PT,MAX(DON_GIA_CUOI) AS DON_GIA_CUOI FROM 
(
SELECT DISTINCT CONVERT (BIT , 0 ) AS CHON,TMP1.MS_PT,TMP1.TEN_LOAI_VT_TV,TMP1.MS_PT_NCC AS PART_NO,
TMP1.TEN_PT,TMP1.QUY_CACH,TMP1.TEN_1 AS DVT, CASE WHEN TMP1.TON_TOI_THIEU IS NULL THEN 0 ELSE TMP1.TON_TOI_THIEU END AS TON_MIN,
CASE WHEN TMP1.TON_KHO_MAX IS NULL THEN 0 ELSE TMP1.TON_KHO_MAX END AS TON_MAX,
CASE WHEN TMP2.TON_KHO IS NULL THEN 0 ELSE TMP2.TON_KHO END AS TON_KHO ,
CASE WHEN TMP3.SL_DE_XUAT IS NULL THEN 0 ELSE TMP3.SL_DE_XUAT END AS SL_DE_XUAT,
CASE WHEN TMP4.SL_DAT_HANG IS NULL THEN 0 ELSE TMP4.SL_DAT_HANG END AS SL_DAT_HANG,
TMP5.NGAY_DUYET AS NGAY_CUOI,TMP5.DON_GIA AS DON_GIA_CUOI , TMP5.NGOAI_TE AS NGOAI_TE_CUOI, TMP5.NHA_CUNG_CAP AS NHA_CUNG_CAP_CUOI
--INTO TMP6
FROM 
(
	SELECT     dbo.IC_PHU_TUNG.MS_PT, dbo.IC_PHU_TUNG.MS_LOAI_VT, dbo.LOAI_VT.TEN_LOAI_VT_TV, dbo.IC_PHU_TUNG.MS_PT_NCC, 
                      dbo.IC_PHU_TUNG.TEN_PT, dbo.IC_PHU_TUNG.QUY_CACH, dbo.IC_PHU_TUNG.DVT, dbo.DON_VI_TINH.TEN_1, dbo.IC_PHU_TUNG.TON_TOI_THIEU, 
                      dbo.IC_PHU_TUNG.TON_KHO_MAX
	FROM         dbo.LOAI_VT RIGHT OUTER JOIN
                      dbo.DON_VI_TINH RIGHT OUTER JOIN
                      dbo.IC_PHU_TUNG ON dbo.DON_VI_TINH.DVT = dbo.IC_PHU_TUNG.DVT ON dbo.LOAI_VT.MS_LOAI_VT = dbo.IC_PHU_TUNG.MS_LOAI_VT 
    WHERE dbo.IC_PHU_TUNG.MS_LOAI_VT = @MS_LOAI_VT AND ACTIVE_PT = 1
) TMP1  INNER JOIN 

(SELECT MS_PT ,SUM( SL_VT) AS TON_KHO
FROM dbo.VI_TRI_KHO_VAT_TU
WHERE MS_KHO = @MS_KHO  
GROUP BY MS_PT) 

TMP2 ON TMP1.MS_PT = TMP2.MS_PT LEFT OUTER JOIN 

(SELECT     dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT, SUM (dbo.DE_XUAT_MUA_HANG_CHI_TIET.SL_DA_DUYET - CASE WHEN dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG IS NULL THEN 0 ELSE dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG END ) AS SL_DE_XUAT                    
FROM         dbo.DE_XUAT_MUA_HANG_CHI_TIET INNER JOIN
dbo.DE_XUAT_MUA_HANG ON dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT = dbo.DE_XUAT_MUA_HANG.MS_DE_XUAT LEFT OUTER JOIN
dbo.DON_DAT_HANG_CHI_TIET ON dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT = dbo.DON_DAT_HANG_CHI_TIET.MS_PT AND 
dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT = dbo.DON_DAT_HANG_CHI_TIET.MS_DE_XUAT
WHERE dbo.DE_XUAT_MUA_HANG.TRANG_THAI <> 4
GROUP BY dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT ) 

TMP3 ON TMP1.MS_PT = TMP3.MS_PT LEFT OUTER JOIN 

(SELECT     dbo.DON_DAT_HANG_CHI_TIET.MS_PT,SUM ( dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG - CASE WHEN dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP IS NULL THEN 0 ELSE dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP END ) AS SL_DAT_HANG
FROM         dbo.DON_DAT_HANG INNER JOIN
dbo.DON_DAT_HANG_CHI_TIET ON 
dbo.DON_DAT_HANG.MS_DON_DAT_HANG = dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG LEFT OUTER JOIN
dbo.IC_DON_HANG_NHAP INNER JOIN
dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT ON 
dbo.DON_DAT_HANG_CHI_TIET.MS_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT AND 
dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG = dbo.IC_DON_HANG_NHAP.MS_DDH
WHERE dbo.DON_DAT_HANG.TRANG_THAI <> 4 
GROUP BY dbo.DON_DAT_HANG_CHI_TIET.MS_PT ) 

TMP4 ON TMP1.MS_PT = TMP4.MS_PT LEFT OUTER JOIN 
(
SELECT TMP3.MS_PT,TMP3.NGAY_DUYET,TMP3.DON_GIA,TMP3.NGOAI_TE,TMP3.NHA_CUNG_CAP
FROM (SELECT MS_PT , MAX (NGAY_DUYET) AS NGAY_DUYET 
FROM (SELECT  dbo.DON_DAT_HANG.NGAY_DUYET, dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG, dbo.DON_DAT_HANG_CHI_TIET.MS_PT, 
dbo.DON_DAT_HANG_CHI_TIET.MS_CHI_TIET_DH, dbo.DON_DAT_HANG_CHI_TIET.DON_GIA, dbo.DON_DAT_HANG_CHI_TIET.NGOAI_TE
FROM         dbo.DON_DAT_HANG INNER JOIN
dbo.DON_DAT_HANG_CHI_TIET ON dbo.DON_DAT_HANG.MS_DON_DAT_HANG = dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG 
WHERE dbo.DON_DAT_HANG.TRANG_THAI = 3 OR dbo.DON_DAT_HANG.TRANG_THAI = 4 ) TMP1
GROUP BY TMP1.MS_PT ) TMP2 INNER JOIN 

(SELECT  dbo.DON_DAT_HANG.NGAY_DUYET, dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG, dbo.DON_DAT_HANG_CHI_TIET.MS_PT, 
dbo.DON_DAT_HANG_CHI_TIET.MS_CHI_TIET_DH, dbo.DON_DAT_HANG_CHI_TIET.DON_GIA, dbo.DON_DAT_HANG_CHI_TIET.NGOAI_TE,
dbo.DON_DAT_HANG.NHA_CUNG_CAP
FROM         dbo.DON_DAT_HANG INNER JOIN
dbo.DON_DAT_HANG_CHI_TIET ON dbo.DON_DAT_HANG.MS_DON_DAT_HANG = dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG 
WHERE dbo.DON_DAT_HANG.TRANG_THAI = 3 OR dbo.DON_DAT_HANG.TRANG_THAI = 4 
--order by ms_pt
) TMP3 ON TMP2.MS_PT = TMP3.MS_PT AND TMP2.NGAY_DUYET = TMP3.NGAY_DUYET 
)TMP5 ON TMP1.MS_PT = TMP5.MS_PT 
) TMP6
GROUP BY MS_PT
) TMP7 LEFT OUTER JOIN 
(
SELECT DISTINCT CONVERT (BIT , 0 ) AS CHON,TMP1.MS_PT,TMP1.TEN_LOAI_VT_TV,TMP1.MS_PT_NCC AS PART_NO,
TMP1.TEN_PT,TMP1.QUY_CACH,TMP1.TEN_1 AS DVT, CASE WHEN TMP1.TON_TOI_THIEU IS NULL THEN 0 ELSE TMP1.TON_TOI_THIEU END AS TON_MIN,
CASE WHEN TMP1.TON_KHO_MAX IS NULL THEN 0 ELSE TMP1.TON_KHO_MAX END AS TON_MAX,
CASE WHEN TMP2.TON_KHO IS NULL THEN 0 ELSE TMP2.TON_KHO END AS TON_KHO ,
CASE WHEN TMP3.SL_DE_XUAT IS NULL THEN 0 ELSE TMP3.SL_DE_XUAT END AS SL_DE_XUAT,
CASE WHEN TMP4.SL_DAT_HANG IS NULL THEN 0 ELSE TMP4.SL_DAT_HANG END AS SL_DAT_HANG,
TMP5.NGAY_DUYET AS NGAY_CUOI,TMP5.DON_GIA AS DON_GIA_CUOI , TMP5.NGOAI_TE AS NGOAI_TE_CUOI, TMP5.NHA_CUNG_CAP AS NHA_CUNG_CAP_CUOI
--INTO TMP6
FROM 
(
SELECT     dbo.IC_PHU_TUNG.MS_PT, dbo.IC_PHU_TUNG.MS_LOAI_VT, dbo.LOAI_VT.TEN_LOAI_VT_TV, dbo.IC_PHU_TUNG.MS_PT_NCC, 
                  dbo.IC_PHU_TUNG.TEN_PT, dbo.IC_PHU_TUNG.QUY_CACH, dbo.IC_PHU_TUNG.DVT, dbo.DON_VI_TINH.TEN_1, dbo.IC_PHU_TUNG.TON_TOI_THIEU, 
                  dbo.IC_PHU_TUNG.TON_KHO_MAX
FROM         dbo.LOAI_VT RIGHT OUTER JOIN
                  dbo.DON_VI_TINH RIGHT OUTER JOIN
                  dbo.IC_PHU_TUNG ON dbo.DON_VI_TINH.DVT = dbo.IC_PHU_TUNG.DVT ON dbo.LOAI_VT.MS_LOAI_VT = dbo.IC_PHU_TUNG.MS_LOAI_VT
WHERE dbo.IC_PHU_TUNG.MS_LOAI_VT=@MS_LOAI_VT AND ACTIVE_PT = 1
) TMP1 INNER JOIN 

(SELECT MS_PT ,SUM( SL_VT) AS TON_KHO
FROM dbo.VI_TRI_KHO_VAT_TU
WHERE MS_KHO = @MS_KHO  
GROUP BY MS_PT) 

TMP2 ON TMP1.MS_PT = TMP2.MS_PT LEFT OUTER JOIN 

(SELECT     dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT, SUM (dbo.DE_XUAT_MUA_HANG_CHI_TIET.SL_DA_DUYET - CASE WHEN dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG IS NULL THEN 0 ELSE dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG END ) AS SL_DE_XUAT                    
FROM         dbo.DE_XUAT_MUA_HANG_CHI_TIET INNER JOIN
dbo.DE_XUAT_MUA_HANG ON dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT = dbo.DE_XUAT_MUA_HANG.MS_DE_XUAT LEFT OUTER JOIN
dbo.DON_DAT_HANG_CHI_TIET ON dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT = dbo.DON_DAT_HANG_CHI_TIET.MS_PT AND 
dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_DE_XUAT = dbo.DON_DAT_HANG_CHI_TIET.MS_DE_XUAT
WHERE dbo.DE_XUAT_MUA_HANG.TRANG_THAI <> 4
GROUP BY dbo.DE_XUAT_MUA_HANG_CHI_TIET.MS_PT ) 

TMP3 ON TMP1.MS_PT = TMP3.MS_PT LEFT OUTER JOIN 

(SELECT     dbo.DON_DAT_HANG_CHI_TIET.MS_PT,SUM ( dbo.DON_DAT_HANG_CHI_TIET.SL_DAT_HANG - CASE WHEN dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP IS NULL THEN 0 ELSE dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP END ) AS SL_DAT_HANG
FROM         dbo.DON_DAT_HANG INNER JOIN
dbo.DON_DAT_HANG_CHI_TIET ON 
dbo.DON_DAT_HANG.MS_DON_DAT_HANG = dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG LEFT OUTER JOIN
dbo.IC_DON_HANG_NHAP INNER JOIN
dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT ON 
dbo.DON_DAT_HANG_CHI_TIET.MS_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT AND 
dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG = dbo.IC_DON_HANG_NHAP.MS_DDH
WHERE dbo.DON_DAT_HANG.TRANG_THAI <> 4 
GROUP BY dbo.DON_DAT_HANG_CHI_TIET.MS_PT ) 

TMP4 ON TMP1.MS_PT = TMP4.MS_PT LEFT OUTER JOIN 
(
SELECT TMP3.MS_PT,TMP3.NGAY_DUYET,TMP3.DON_GIA,TMP3.NGOAI_TE,TMP3.NHA_CUNG_CAP
FROM (SELECT MS_PT , MAX (NGAY_DUYET) AS NGAY_DUYET 
FROM (SELECT  dbo.DON_DAT_HANG.NGAY_DUYET, dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG, dbo.DON_DAT_HANG_CHI_TIET.MS_PT, 
dbo.DON_DAT_HANG_CHI_TIET.MS_CHI_TIET_DH, dbo.DON_DAT_HANG_CHI_TIET.DON_GIA, dbo.DON_DAT_HANG_CHI_TIET.NGOAI_TE
FROM         dbo.DON_DAT_HANG INNER JOIN
dbo.DON_DAT_HANG_CHI_TIET ON dbo.DON_DAT_HANG.MS_DON_DAT_HANG = dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG 
WHERE dbo.DON_DAT_HANG.TRANG_THAI = 3 OR dbo.DON_DAT_HANG.TRANG_THAI = 4 ) TMP1
GROUP BY TMP1.MS_PT ) TMP2 INNER JOIN 

(SELECT  dbo.DON_DAT_HANG.NGAY_DUYET, dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG, dbo.DON_DAT_HANG_CHI_TIET.MS_PT, 
dbo.DON_DAT_HANG_CHI_TIET.MS_CHI_TIET_DH, dbo.DON_DAT_HANG_CHI_TIET.DON_GIA, dbo.DON_DAT_HANG_CHI_TIET.NGOAI_TE,
dbo.DON_DAT_HANG.NHA_CUNG_CAP
FROM         dbo.DON_DAT_HANG INNER JOIN
dbo.DON_DAT_HANG_CHI_TIET ON dbo.DON_DAT_HANG.MS_DON_DAT_HANG = dbo.DON_DAT_HANG_CHI_TIET.MS_DON_DAT_HANG 
WHERE dbo.DON_DAT_HANG.TRANG_THAI = 3 OR dbo.DON_DAT_HANG.TRANG_THAI = 4 
--order by ms_pt
) TMP3 ON TMP2.MS_PT = TMP3.MS_PT AND TMP2.NGAY_DUYET = TMP3.NGAY_DUYET 
)TMP5 ON TMP1.MS_PT = TMP5.MS_PT 
) TMP8 ON TMP7.MS_PT = TMP8.MS_PT AND (TMP7.DON_GIA_CUOI = TMP8.DON_GIA_CUOI OR TMP8.DON_GIA_CUOI IS NULL)
WHERE TON_MIN > TON_KHO
ORDER BY TMP8.MS_PT
--chỉ tính những vật tư có tồn tối thiểu > tồn hiện tại, số lượng đề xuất = tồn tối thiểu - tồn hiện tại
END 
