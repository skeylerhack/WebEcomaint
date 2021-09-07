
----	exec GetBangKeXNTKhoChinh 23,'06/01/2017','06/30/2017',0, '-1'
ALTER PROC [dbo].[GetBangKeXNTKhoChinh]
	@MS_KHO NVARCHAR(30),
	@TU_NGAY  DATETIME ,
	@DEN_NGAY  DATETIME ,
	@NNGU INT,
	@MS_LOAI_VT nvarchar(4000)

as
CREATE TABLE #LVT_TMP([MS_LOAI_VT] NVARCHAR(50))
DECLARE @sSql nvarchar(4000)
IF @MS_LOAI_VT = '-1'
	set @sSql = 'INSERT INTO #LVT_TMP SELECT MS_LOAI_VT FROM LOAI_VT '
ELSE
	set @sSql = 'INSERT INTO #LVT_TMP SELECT MS_LOAI_VT FROM LOAI_VT WHERE MS_LOAI_VT IN (' + REPLACE(@MS_LOAI_VT,'*','''')  + ') '
EXEC (@sSql)

----Lấy số lượng nhập tai kho where dang nhap khac 9
SELECT     NCT.MS_PT,SUM(NCT.SL_VT) AS SL_NHAPK9, SUM(NCT.SL_VT * NVT.DON_GIA) AS GT_NHAPK9 INTO #NHAP_K9
FROM         dbo.IC_DON_HANG_NHAP AS DHN INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU AS NVT ON DHN.MS_DH_NHAP_PT = NVT.MS_DH_NHAP_PT INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS NCT ON NVT.MS_DH_NHAP_PT = NCT.MS_DH_NHAP_PT AND NVT.MS_PT = NCT.MS_PT AND NVT.ID = NCT.ID
WHERE     (	CONVERT(DATETIME,CONVERT(NVARCHAR(10),DHN.NGAY ,101)) BETWEEN @TU_NGAY AND @DEN_NGAY ) AND (DHN.MS_KHO = @MS_KHO )  AND (MS_DANG_NHAP <> 9)
GROUP BY NCT.MS_PT


 
DECLARE @TonKho AS TypeInventory; 

INSERT INTO @TonKho  exec MTinhTonKhoTheoViTri @TU_NGAY, @DEN_NGAY,'-1','-1',@MS_KHO,'ADMIN',0

	

SELECT  MS_PT, TEN_PT, MS_LOAI_VT,TEN_LOAI_VT, SUM(TON_DAU_KY) TON_DAU_KY , SUM(GT_DAU_KY) GT_DAU_KY ,SUM(SL_NHAP_TNDN) SL_NHAP_TNDN , SUM(GT_NHAP_TNDN) GT_NHAP_TNDN, SUM(SL_XUAT_TNDN) SL_XUAT_TNDN, SUM(GT_XUAT_TNDN) GT_XUAT_TNDN
	,SUM(SL_CHUYEN_DI_TNDN) SL_CHUYEN_DI_TNDN	,SUM(GT_CHUYEN_DI_TNDN) GT_CHUYEN_DI_TNDN	,SUM(SL_CHUYEN_DEN_TNDN) SL_CHUYEN_DEN_TNDN	,SUM(GT_CHUYEN_DEN_TNDN) GT_CHUYEN_DEN_TNDN	,SUM(CHENH_LECH_KIEM_KE_TNDN) CHENH_LECH_KIEM_KE_TNDN	,SUM(GT_KIEM_KE_TNDN) GT_KIEM_KE_TNDN
	,	SUM(TON_CUOI_KY) TON_CUOI_KY,	SUM(GT_CUOI_KY) GT_CUOI_KY INTO #TON_KHO
	
 FROM @TonKho 
 GROUP BY  MS_PT, TEN_PT, MS_LOAI_VT,TEN_LOAI_VT
ORDER BY MS_PT




SELECT ROW_NUMBER() OVER (ORDER BY THT.MS_PT , THT.TEN_PT) AS STT,  THT.MS_PT, THT.TEN_PT,CASE @NNGU WHEN 0 THEN DVT.TEN_1 WHEN 2 THEN DVT.TEN_2 ELSE DVT.TEN_3 END AS DVT,THT.TEN_LOAI_VT, 

CASE PT.THEO_KHO WHEN 0 THEN (SELECT SUM(ISNULL(TON_TOI_THIEU, 0)) FROM IC_PHU_TUNG WHERE THT.MS_PT = MS_PT GROUP BY MS_PT) ELSE
(SELECT SUM(ISNULL(TON_TOI_THIEU, 0)) FROM IC_PHU_TUNG_KHO WHERE THT.MS_PT = MS_PT  GROUP BY MS_PT) END TON_TOI_THIEU
, CASE PT.THEO_KHO WHEN 0 THEN (SELECT SUM(ISNULL(TON_KHO_MAX, 0)) FROM IC_PHU_TUNG WHERE THT.MS_PT = MS_PT GROUP BY MS_PT) ELSE
(SELECT SUM(ISNULL(TON_KHO_MAX, 0)) FROM IC_PHU_TUNG_KHO WHERE THT.MS_PT = MS_PT  GROUP BY MS_PT) END TON_KHO_MAX,

SUM(ISNULL(TON_DAU_KY,0)) as SL_TON_DK ,ISNULL(GT_DAU_KY, 0) as GT_DK, ISNULL(SL_NHAPK9,0) SL_NHAPK9 , ISNULL(GT_NHAPK9,0) GT_NHAPK9,CHENH_LECH_KIEM_KE_TNDN,GT_KIEM_KE_TNDN, SUM(ISNULL(TON_CUOI_KY,0)) TON_CUOI_KY  , GT_CUOI_KY  AS GT_T_1
 FROM #TON_KHO THT
LEFT JOIN #NHAP_K9 AS NHAPK9 ON THT.MS_PT = NHAPK9.MS_PT 
LEFT JOIN IC_PHU_TUNG PT ON THT.MS_PT = PT.MS_PT 
LEFT JOIN dbo.DON_VI_TINH AS DVT ON PT.DVT = DVT.DVT
GROUP BY THT.MS_PT , THT.TEN_PT, DVT.TEN_1, DVT.TEN_2, DVT.TEN_3,THT.TEN_LOAI_VT, SL_NHAPK9, GT_NHAPK9,CHENH_LECH_KIEM_KE_TNDN,GT_KIEM_KE_TNDN, GT_CUOI_KY, PT.THEO_KHO,GT_DAU_KY
ORDER BY THT.MS_PT , THT.TEN_PT

