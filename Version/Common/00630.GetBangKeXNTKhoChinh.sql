


----	exec GetBangKeXNTKhoChinh 17,'10/01/2016','10/31/2016',0, '*1*'
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

--Lấy số lượng tồn hiện tại
SELECT     MS_PT, SUM(SL_VT) AS SL_TON_VTK, SUM(GT_HT) AS GT_VTK INTO #TON_HT
FROM         (SELECT     VTKVT.MS_KHO, VTKVT.MS_VI_TRI, VTKVT.MS_DH_NHAP_PT, VTKVT.MS_PT, VTKVT.ID, VTKVT.SL_VT, VTKVT.SL_VT * NVT.DON_GIA * NVT.TY_GIA AS GT_HT
                       FROM          dbo.IC_DON_HANG_NHAP_VAT_TU AS NVT INNER JOIN
                                              dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS NVTCT ON NVT.MS_DH_NHAP_PT = NVTCT.MS_DH_NHAP_PT AND NVT.MS_PT = NVTCT.MS_PT AND 
                                              NVT.ID = NVTCT.ID RIGHT OUTER JOIN
                                              dbo.VI_TRI_KHO_VAT_TU AS VTKVT ON NVTCT.ID = VTKVT.ID AND NVTCT.MS_DH_NHAP_PT = VTKVT.MS_DH_NHAP_PT AND NVTCT.MS_PT = VTKVT.MS_PT AND 
                                              NVTCT.MS_VI_TRI = VTKVT.MS_VI_TRI
WHERE (VTKVT.MS_KHO = @MS_KHO )) AS VI_TRI_KHO_VAT_TU  GROUP BY MS_PT

--Lấy số lượng nhập từ ngày đến hiện tại
SELECT     NCT.MS_PT,SUM(NCT.SL_VT) AS SL_NHAP_DNHT, SUM(NCT.SL_VT * NVT.DON_GIA * NVT.TY_GIA) AS GT_NHAP_DNHT INTO #NHAP_TU_DEN
FROM         dbo.IC_DON_HANG_NHAP AS DHN INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU AS NVT ON DHN.MS_DH_NHAP_PT = NVT.MS_DH_NHAP_PT INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS NCT ON NVT.MS_DH_NHAP_PT = NCT.MS_DH_NHAP_PT AND NVT.MS_PT = NCT.MS_PT AND NVT.ID = NCT.ID
WHERE     (	CONVERT(DATETIME,CONVERT(NVARCHAR(10),DHN.NGAY ,101)) >= @TU_NGAY) AND (DHN.MS_KHO = @MS_KHO )
GROUP BY NCT.MS_PT

--Lấy số lượng xuất từ ngày đến hiện tại
SELECT     XCT.MS_PT,  SUM(XCT.SL_VT) AS SL_XUAT_DNHT, SUM(XCT.SL_VT * NVT.DON_GIA * NVT.TY_GIA) AS GT_XUAT_DNHT INTO #XUAT_TN_HT
FROM         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS NVTCT INNER JOIN
					  dbo.IC_DON_HANG_NHAP_VAT_TU AS NVT ON NVTCT.MS_DH_NHAP_PT = NVT.MS_DH_NHAP_PT AND NVTCT.MS_PT = NVT.MS_PT AND NVTCT.ID = NVT.ID INNER JOIN
					  dbo.IC_DON_HANG_XUAT AS DHX INNER JOIN
					  dbo.IC_DON_HANG_XUAT_VAT_TU AS XVT ON DHX.MS_DH_XUAT_PT = XVT.MS_DH_XUAT_PT INNER JOIN
					  dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS XCT ON XVT.MS_DH_XUAT_PT = XCT.MS_DH_XUAT_PT AND XVT.MS_PT = XCT.MS_PT ON NVTCT.MS_DH_NHAP_PT = XCT.MS_DH_NHAP_PT AND 
					  NVTCT.MS_PT = XCT.MS_PT AND NVTCT.MS_VI_TRI = XCT.MS_VI_TRI AND NVTCT.ID = XCT.ID_XUAT
WHERE     (CONVERT(DATETIME,CONVERT(NVARCHAR(10),DHX.NGAY ,101)) >= @TU_NGAY  ) AND (DHX.MS_KHO LIKE @MS_KHO)
GROUP BY XCT.MS_PT

--Tính chênh lệch kiểm kê từ đến ngày đến hiện tại
SELECT     KK.MS_PT, SUM(KK.SL_CHUNG_TU - KK.SL_KK_CT) AS SL_KK_DNHT, SUM((KK.SL_CHUNG_TU - KK.SL_KK_CT) * NVT.DON_GIA * NVT.TY_GIA) AS GT_KK_DNHT INTO #CL_KK_HT
FROM         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS NCT INNER JOIN
					  dbo.IC_DON_HANG_NHAP_VAT_TU AS NVT ON NCT.MS_DH_NHAP_PT = NVT.MS_DH_NHAP_PT AND NCT.MS_PT = NVT.MS_PT AND NCT.ID = NVT.ID INNER JOIN
					  dbo.KIEM_KE_VAT_TU_CHI_TIET AS KK ON NCT.MS_VI_TRI = KK.MS_VI_TRI AND NCT.MS_PT = KK.MS_PT AND NCT.MS_DH_NHAP_PT = KK.MS_DH_NHAP_PT AND NCT.ID = KK.ID_KK
WHERE     (CONVERT(DATETIME,CONVERT(NVARCHAR(10),KK.NGAY,101)) >= @TU_NGAY) AND (KK.MS_KHO = @MS_KHO )
GROUP BY KK.MS_PT

--Lấy số lượng di chuyển đi từ ngày đến hiện tại
SELECT     C.MS_PT, SUM(C.SL_CHUYEN) AS SL_CHUYEN_DI_DNHT, SUM(C.SL_CHUYEN * B.DON_GIA * B.TY_GIA) AS GT_CHUYEN_DI_DNHT INTO #DC_TN_HT
FROM         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS A INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU AS B ON A.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT AND A.MS_PT = B.MS_PT AND A.ID = B.ID INNER JOIN
                      dbo.DI_CHUYEN_VI_TRI_TRONG_KHO AS C ON A.MS_PT = C.MS_PT AND A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.ID = C.ID_DC
WHERE     (CONVERT(DATETIME,CONVERT(NVARCHAR(10),C.NGAY_CHUYEN,101)) >= @TU_NGAY) AND (C.MS_KHO = @MS_KHO )
GROUP BY C.MS_PT

--Lấy số lượng di chuyển đến từ ngày đến hiện tại
SELECT     C.MS_PT, SUM(C.SL_CHUYEN) AS SL_CHUYEN_DEN_DNHT, SUM(C.SL_CHUYEN * B.DON_GIA * B.TY_GIA) AS GT_CHUYEN_DEN_DNHT INTO #DC_DHT
FROM         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS A INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU AS B ON A.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT AND A.MS_PT = B.MS_PT AND A.ID = B.ID INNER JOIN
                      dbo.DI_CHUYEN_VI_TRI_TRONG_KHO AS C ON A.MS_PT = C.MS_PT AND A.MS_DH_NHAP_PT = C.MS_DH_NHAP_PT AND A.ID = C.ID_DC
WHERE     (CONVERT(DATETIME,CONVERT(NVARCHAR(10),C.NGAY_CHUYEN,101)) >= @TU_NGAY) AND (C.MS_KHO_1 = @MS_KHO )
GROUP BY C.MS_PT

--Lấy số lượng nhập tai kho where dang nhap khac 9
SELECT     NCT.MS_PT,SUM(NCT.SL_VT) AS SL_NHAPK9, SUM(NCT.SL_VT * NVT.DON_GIA * NVT.TY_GIA) AS GT_NHAPK9 INTO #NHAP_K9
FROM         dbo.IC_DON_HANG_NHAP AS DHN INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU AS NVT ON DHN.MS_DH_NHAP_PT = NVT.MS_DH_NHAP_PT INNER JOIN
                      dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS NCT ON NVT.MS_DH_NHAP_PT = NCT.MS_DH_NHAP_PT AND NVT.MS_PT = NCT.MS_PT AND NVT.ID = NCT.ID
WHERE     (	CONVERT(DATETIME,CONVERT(NVARCHAR(10),DHN.NGAY ,101)) BETWEEN @TU_NGAY AND @DEN_NGAY ) AND (DHN.MS_KHO = @MS_KHO )  AND (MS_DANG_NHAP <> 9)
GROUP BY NCT.MS_PT


SELECT ROW_NUMBER() OVER (ORDER BY THT.MS_PT , TEN_PT, CASE @NNGU WHEN 0 THEN LVT.TEN_LOAI_VT_TV WHEN 1 THEN TEN_LOAI_VT_TA ELSE LVT.TEN_LOAI_VT_TH END) AS STT,
THT.MS_PT , TEN_PT, CASE @NNGU WHEN 0 THEN LVT.TEN_LOAI_VT_TV WHEN 1 THEN TEN_LOAI_VT_TA ELSE LVT.TEN_LOAI_VT_TH END AS TEN_LOAI_VT,
CASE @NNGU WHEN 0 THEN DVT.TEN_1 WHEN 2 THEN DVT.TEN_2 ELSE DVT.TEN_3 END AS DVT,
ISNULL(SL_TON_VTK,0) + ISNULL(SL_XUAT_DNHT,0) - ISNULL(SL_NHAP_DNHT,0) - ISNULL(SL_KK_DNHT,0) + 
	ISNULL(SL_CHUYEN_DI_DNHT,0) - ISNULL(SL_CHUYEN_DEN_DNHT,0) AS SL_TON_DK,
ISNULL(GT_VTK,0) + ISNULL(GT_XUAT_DNHT,0) - ISNULL(GT_NHAP_DNHT,0) - ISNULL(GT_KK_DNHT,0) + 
	ISNULL(GT_CHUYEN_DI_DNHT,0) - ISNULL(GT_CHUYEN_DEN_DNHT,0)   AS GT_DK, ISNULL(SL_NHAPK9,0) SL_NHAPK9 , ISNULL(GT_NHAPK9,0) GT_NHAPK9
FROM #TON_HT AS THT LEFT JOIN 
#NHAP_TU_DEN AS NHAP ON THT.MS_PT = NHAP.MS_PT LEFT JOIN
#XUAT_TN_HT AS XUAT ON THT.MS_PT = XUAT.MS_PT LEFT JOIN
#CL_KK_HT AS KK ON THT.MS_PT = KK.MS_PT LEFT JOIN
#DC_TN_HT AS DC ON THT.MS_PT = DC.MS_PT LEFT JOIN
#DC_DHT AS DC_DEN ON THT.MS_PT = DC_DEN.MS_PT LEFT JOIN 
#NHAP_K9 AS NHAPK9 ON THT.MS_PT = NHAPK9.MS_PT 
LEFT JOIN IC_PHU_TUNG PT ON THT.MS_PT = PT.MS_PT INNER JOIN LOAI_VT LVT ON PT.MS_LOAI_VT = LVT.MS_LOAI_VT INNER JOIN
                      dbo.DON_VI_TINH AS DVT ON PT.DVT = DVT.DVT INNER JOIN #LVT_TMP LVTC ON LVT.MS_LOAI_VT = LVTC.MS_LOAI_VT
ORDER BY THT.MS_PT , TEN_PT, CASE @NNGU WHEN 0 THEN LVT.TEN_LOAI_VT_TV WHEN 1 THEN TEN_LOAI_VT_TA ELSE LVT.TEN_LOAI_VT_TH END 



