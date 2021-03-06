--spTinhGiaLai
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spTinhGiaLai')
   exec('CREATE PROCEDURE [dbo].[spTinhGiaLai] AS BEGIN SET NOCOUNT ON; END')
GO
-- EXEC spTinhGiaLai '04/01/2014','04/30/2014','TGLAI_TMPadministrator'
ALTER procedure [dbo].spTinhGiaLai
	@TuNgay DATETIME,
	@DenNgay DATETIME,
	@BTam NVARCHAR(50)
AS
--DROP TABLE #BT_GIA
--DROP TABLE #GIA_MOI
--DROP TABLE #PBT_GIA
DECLARE @sSql NVARCHAR(4000)
--CAP NHAP GIA TU BEN DATA TRUNG GIAN
CREATE TABLE #BT_GIA([MS_PT] [nvarchar](20) NULL,[DG] [decimal](38, 20) NULL)
SET @sSql = ' INSERT INTO #BT_GIA SELECT MS_PT, DG FROM ' + @BTam
EXEC (@sSql)


--LAY CAC DON HANG NHAP VA PHU TUNG CAN CAP NHAP GIA THEO DUNG DON HANG XUAT TRONG GIAI DOAN CAN TINH LAI
SELECT DISTINCT A.MS_DH_NHAP_PT, A.MS_PT,A.ID , CONVERT(DECIMAL (38,20),DG) AS GIA INTO #GIA_MOI
FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS A INNER JOIN
                      dbo.IC_DON_HANG_XUAT AS B ON A.MS_DH_XUAT_PT = B.MS_DH_XUAT_PT INNER JOIN 
                      #BT_GIA C ON A.MS_PT = C.MS_PT
WHERE CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY ,101)) BETWEEN @TuNgay AND @DenNgay
UNION
SELECT DISTINCT T1.MS_DH_NHAP_PT ,T1.MS_PT,T1.ID, CONVERT(DECIMAL (38,20),DG) AS GIA 
FROM         dbo.IC_DON_HANG_NHAP_VAT_TU AS T1 INNER JOIN
                      dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT INNER JOIN
                      dbo.IC_DON_HANG_XUAT AS T3 ON T2.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT INNER JOIN
                      dbo.IC_PHU_TUNG AS T4 ON T2.MS_PT = T4.MS_PT INNER JOIN
                      dbo.LOAI_VT AS T5 ON T4.MS_LOAI_VT = T5.MS_LOAI_VT INNER JOIN 
                      #BT_GIA T6 ON T1.MS_PT = T6.MS_PT
WHERE     (T5.VAT_TU = 1) AND (ISNULL(T3.MS_PHIEU_BAO_TRI, N'') <> '') 
AND (CONVERT(DATETIME, CONVERT(NVARCHAR(10), T3.NGAY, 101)) BETWEEN @TuNgay AND @DenNgay)
ORDER BY A.MS_DH_NHAP_PT,A.MS_PT

-- cap nhap gia lai trong IC_DON_HANG_NHAP_VAT_TU 
UPDATE IC_DON_HANG_NHAP_VAT_TU SET DON_GIA = GIA, DON_GIA_GOC = GIA, THANH_TIEN = ISNULL(GIA,0) * ISNULL(SL_THUC_NHAP,0)
FROM IC_DON_HANG_NHAP_VAT_TU A INNER JOIN #GIA_MOI B ON A.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT AND A.MS_PT = B.MS_PT AND A.ID = B.ID

-- cap nhap gia lai trong PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO 
UPDATE PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO SET DON_GIA = GIA
FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO A INNER JOIN #GIA_MOI B ON A.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT AND A.MS_PT = B.MS_PT AND A.ID = B.ID


--CHI LAY NHUNG PBT TRONG GIAI DOAN TINH GIA  LAI DE CAP NHAP LAI PHIEU_BAO_TRI_CHI_PHI
SELECT DISTINCT T3.MS_PHIEU_BAO_TRI INTO #PBT_GIA_VT
FROM         dbo.IC_DON_HANG_NHAP_VAT_TU AS T1 INNER JOIN
                      dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT INNER JOIN
                      dbo.IC_DON_HANG_XUAT AS T3 ON T2.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT INNER JOIN
                      dbo.IC_PHU_TUNG AS T4 ON T2.MS_PT = T4.MS_PT INNER JOIN
                      dbo.LOAI_VT AS T5 ON T4.MS_LOAI_VT = T5.MS_LOAI_VT
WHERE     (T5.VAT_TU = 1) AND (ISNULL(T3.MS_PHIEU_BAO_TRI, N'') <> '') 
AND (CONVERT(DATETIME, CONVERT(NVARCHAR(10), T3.NGAY, 101)) BETWEEN @TuNgay AND @DenNgay)
ORDER BY T3.MS_PHIEU_BAO_TRI

-- CAP NHAP CHI PHI VAT TU
UPDATE PHIEU_BAO_TRI_CHI_PHI SET CHI_PHI_VAT_TU = CHI_PHI_VT, CHI_PHI_VAT_TU_USD = CHI_PHI_VT_USD 
FROM PHIEU_BAO_TRI_CHI_PHI A INNER JOIN
(SELECT     C.MS_PHIEU_BAO_TRI, SUM(ISNULL(B.SL_VT, 0) * ISNULL(A.DON_GIA, 0) * A.TY_GIA) AS CHI_PHI_VT, 
SUM(ISNULL(B.SL_VT, 0) * ISNULL(A.DON_GIA, 0) * A.TY_GIA_USD) AS CHI_PHI_VT_USD
FROM         dbo.IC_DON_HANG_NHAP_VAT_TU AS A INNER JOIN
                      dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS B ON A.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT AND A.MS_PT = B.MS_PT AND A.ID = B.ID_XUAT INNER JOIN
                      dbo.IC_DON_HANG_XUAT AS C ON B.MS_DH_XUAT_PT = C.MS_DH_XUAT_PT INNER JOIN
                      dbo.IC_PHU_TUNG AS D ON B.MS_PT = D.MS_PT INNER JOIN
                      dbo.LOAI_VT E ON D.MS_LOAI_VT = E.MS_LOAI_VT INNER JOIN 
                      #PBT_GIA_VT F ON C.MS_PHIEU_BAO_TRI = F.MS_PHIEU_BAO_TRI
WHERE     (E.VAT_TU = 1)
GROUP BY C.MS_PHIEU_BAO_TRI) B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI  INNER JOIN 
                      #PBT_GIA_VT C ON C.MS_PHIEU_BAO_TRI = A.MS_PHIEU_BAO_TRI


--CHI LAY NHUNG PBT TRONG GIAI DOAN TINH GIA  LAI DE CAP NHAP LAI PHIEU_BAO_TRI_CHI_PHI
SELECT DISTINCT A.MS_PHIEU_BAO_TRI INTO #PBT_GIA
FROM         dbo.PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO AS A INNER JOIN
                      dbo.IC_DON_HANG_XUAT AS B ON A.MS_DH_XUAT_PT = B.MS_DH_XUAT_PT
WHERE CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY ,101)) BETWEEN @TuNgay AND @DenNgay
ORDER BY A.MS_PHIEU_BAO_TRI

-- CAP NHAP CHI PHI PHU TUNG
UPDATE PHIEU_BAO_TRI_CHI_PHI SET CHI_PHI_PHU_TUNG = TONG_CP_PT, CHI_PHI_PHU_TUNG_USD = TONG_CP_PT_USD
FROM PHIEU_BAO_TRI_CHI_PHI A INNER JOIN
(SELECT T1.MS_PHIEU_BAO_TRI, SUM(SL_TT*DON_GIA*TI_GIA) AS TONG_CP_PT, SUM(SL_TT*DON_GIA*TI_GIA_USD) AS TONG_CP_PT_USD 
FROM PHIEU_BAO_TRI_CONG_VIEC_PHU_TUNG_CHI_TIET_KHO T1 INNER JOIN 
                      #PBT_GIA T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI
WHERE SL_TT IS NOT NULL AND SL_TT > 0
GROUP BY T1.MS_PHIEU_BAO_TRI) B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI   INNER JOIN 
                      #PBT_GIA C ON A.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI
