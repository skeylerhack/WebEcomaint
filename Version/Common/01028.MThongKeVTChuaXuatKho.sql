
--DROP TABLE AAA_TMP
--SELECT * FROM IC_KHO
--SELECT * INTO AAA_TMP  FROM IC_KHO WHERE MS_KHO = 5

--DROP TABLE AAA_DX
--SELECT MS_DANG_XUAT INTO AAA_DX FROM DANG_XUAT  WHERE MS_DANG_XUAT  IN(1)

--DROP TABLE AAA_LM
--SELECT MS_LOAI_MAY INTO AAA_LM FROM LOAI_MAY
--SELECT MS_DANG_XUAT INTO AAA_DX FROM DANG_XUAT  WHERE MS_DANG_XUAT  IN(1)
-- SELECT * FROM AAA_LM


--exec MThongKeVTChuaXuatKho '01/01/2012',-1,1
--exec MThongKeVTChuaXuatKho '01/01/2013',-1,0

ALTER procedure [dbo].[MThongKeVTChuaXuatKho]
	@SauNgay DATETIME,
	@LVatTu int, 
	@LBCao bit
as
--@LBCao = 1 Bao Cao Vat Tu chua Xuat Kho
--@LBCao = 0 Bao Cao Vat Tu khong thay the

DECLARE @DL_TMP TABLE (MA_SO NVARCHAR(500)) 

SELECT * INTO #KHO_TMP FROM AAA_TMP
IF @LBCao = 1 
	INSERT INTO @DL_TMP(MA_SO)
	SELECT DISTINCT MS_DANG_XUAT FROM AAA_DX
ELSE
	INSERT INTO @DL_TMP(MA_SO)
	SELECT DISTINCT MS_LOAI_MAY FROM AAA_LM

DECLARE @VT_TMP TABLE (MS_PT NVARCHAR(500)) 
IF @LBCao = 1 
BEGIN
	INSERT INTO @VT_TMP(MS_PT)
	SELECT   DISTINCT  dbo.IC_DON_HANG_XUAT_VAT_TU.MS_PT 
	FROM      dbo.IC_DON_HANG_XUAT INNER JOIN dbo.IC_DON_HANG_XUAT_VAT_TU ON 
		dbo.IC_DON_HANG_XUAT.MS_DH_XUAT_PT = dbo.IC_DON_HANG_XUAT_VAT_TU.MS_DH_XUAT_PT 
		INNER JOIN @DL_TMP AS DXUAT_TMP ON DXUAT_TMP.MA_SO = dbo.IC_DON_HANG_XUAT.MS_DANG_XUAT 
	WHERE NGAY >= @SauNgay
END
ELSE
BEGIN
	INSERT INTO @VT_TMP(MS_PT)
	SELECT DISTINCT B.MS_PT  
	FROM dbo.PHIEU_BAO_TRI_CONG_VIEC AS A INNER JOIN dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG AS B ON 
	A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI AND A.MS_CV = B.MS_CV AND A.MS_BO_PHAN = B.MS_BO_PHAN 
	INNER JOIN dbo.PHIEU_BAO_TRI AS C ON A.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI 
	INNER JOIN dbo.MAY AS D ON C.MS_MAY = D.MS_MAY INNER JOIN dbo.NHOM_MAY AS E ON 
	D.MS_NHOM_MAY = E.MS_NHOM_MAY INNER JOIN @DL_TMP AS LM_TMP ON LM_TMP.MA_SO = E.MS_LOAI_MAY 
	WHERE C.NGAY_BD_KH >= @SauNgay
	
	INSERT INTO @VT_TMP(MS_PT)
	SELECT DISTINCT B.MS_PT  
	FROM dbo.PHIEU_BAO_TRI_CV_PHU_TRO AS A INNER JOIN dbo.PHIEU_BAO_TRI_CV_PHU_TRO_PHU_TUNG AS B ON 
	A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI 
	INNER JOIN dbo.PHIEU_BAO_TRI AS C ON A.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI 
	INNER JOIN dbo.MAY AS D ON C.MS_MAY = D.MS_MAY INNER JOIN dbo.NHOM_MAY AS E ON 
	D.MS_NHOM_MAY = E.MS_NHOM_MAY INNER JOIN @DL_TMP AS LM_TMP ON LM_TMP.MA_SO = E.MS_LOAI_MAY 
	WHERE C.NGAY_BD_KH >= @SauNgay
END



SELECT dbo.IC_PHU_TUNG.MS_PT, dbo.IC_PHU_TUNG.TEN_PT, dbo.IC_PHU_TUNG.MS_PT_NCC, dbo.IC_PHU_TUNG.MS_PT_CTY, 
                      dbo.IC_PHU_TUNG.QUY_CACH, dbo.DON_VI_TINH.TEN_1, SUM(dbo.VI_TRI_KHO_VAT_TU.SL_VT) AS SL_TON, 
                      SUM(ISNULL(dbo.VI_TRI_KHO_VAT_TU.SL_VT, 0) * ISNULL(dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA, 0)) AS THANH_TIEN, 
                      SUM(ISNULL(dbo.VI_TRI_KHO_VAT_TU.SL_VT, 0) * ISNULL(dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA, 0) * dbo.IC_DON_HANG_NHAP_VAT_TU.TY_GIA_USD / dbo.IC_DON_HANG_NHAP_VAT_TU.TY_GIA) AS TT_USD
FROM         dbo.VI_TRI_KHO_VAT_TU INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU ON dbo.VI_TRI_KHO_VAT_TU.MS_DH_NHAP_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT AND 
                      dbo.VI_TRI_KHO_VAT_TU.MS_PT = dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT INNER JOIN
                      dbo.IC_PHU_TUNG ON dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT = dbo.IC_PHU_TUNG.MS_PT INNER JOIN
                      dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT INNER JOIN #KHO_TMP AS KHO_TMP ON
                      dbo.VI_TRI_KHO_VAT_TU.MS_KHO = KHO_TMP.MS_KHO 
WHERE     (dbo.VI_TRI_KHO_VAT_TU.SL_VT > 0)
AND (dbo.IC_PHU_TUNG.MS_PT NOT IN (SELECT DISTINCT MS_PT  FROM @VT_TMP A))
AND (-1 = @LVatTu OR IC_PHU_TUNG.MS_LOAI_VT = @LVatTu )
GROUP BY dbo.IC_PHU_TUNG.MS_PT, dbo.IC_PHU_TUNG.MS_PT_NCC, dbo.IC_PHU_TUNG.MS_PT_CTY, dbo.IC_PHU_TUNG.TEN_PT, dbo.IC_PHU_TUNG.QUY_CACH, 
                      dbo.DON_VI_TINH.TEN_1
ORDER BY dbo.IC_PHU_TUNG.MS_PT, dbo.IC_PHU_TUNG.TEN_PT
