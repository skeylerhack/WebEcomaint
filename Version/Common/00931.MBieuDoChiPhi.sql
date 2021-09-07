
--select convert(Datetime, '01/12/17', 103)

-- exec MBieuDoChiPhi '11/01/2016' , '11/30/2016' ,'-1','-1','-1','-1',-1,'-1','-1',1,1,1,1,1,0,'11/2016'
-- exec MBieuDoChiPhi '06/01/2012' , '12/01/2012' ,'-1','-1','-1','-1',-1,'-1','-1',1,1,1,1,1,1,'01/2011'
ALTER PROCEDURE [dbo].[MBieuDoChiPhi]
	@TNgay DATETIME,
	@DNgay DATETIME,
	@MS_TINH NVARCHAR(50),
	@MS_QUAN NVARCHAR(50),
	@MS_DUONG NVARCHAR(50),
	@MSNX NVARCHAR(150),
	@MSHT INT,
	@MSLMAY NVARCHAR(50),
	@MSNHOMMAY NVARCHAR(50),	
	@PhuTung bit,
	@VatTu bit,	
	@NhanCong bit,
	@DichVu bit,
	@Khac bit,
	@LoaiBC int,
	@Thang NVARCHAR(50)
as
DECLARE @NGAY DATETIME
SET @NGAY=GETDATE()
--LoaiBC = 1 theo thiet bi
--LoaiBC = 2 theo thang


--SELECT DISTINCT  * INTO #MAY_TB FROM
--(
--SELECT DISTINCT A.MS_N_XUONG AS MSNX, DBO.MGetHTTheoNgay (M.MS_MAY,@NGAY) AS  MS_HT, 
--DBO.MGetBPCPhiTheoNgay(M.MS_MAY,@NGAY) AS MSBP, M.* 
--	FROM MAY M INNER JOIN PHIEU_BAO_TRI N ON M.MS_MAY = N.MS_MAY INNER JOIN dbo.NHOM_MAY AS X ON 
--	M.MS_NHOM_MAY = X.MS_NHOM_MAY INNER JOIN dbo.LOAI_MAY AS Y ON X.MS_LOAI_MAY = Y.MS_LOAI_MAY
--	INNER JOIN (SELECT * FROM [dbo].[MGetNXMayUserDiaDiem]('-1',@MSNX,@NGAY,'-1',@MS_TINH,@MS_QUAN,@MS_DUONG) ) A
--	ON A.MS_MAY = M.MS_MAY INNER JOIN dbo.PHIEU_BAO_TRI_CHI_PHI AS C ON N.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI	
--	INNER JOIN CHON_MAY_BDCP F ON M.MS_MAY = F.MS_MAY
--WHERE TINH_TRANG_PBT > 2 AND NGAY_BD_KH BETWEEN @TNgay AND @DNgay AND 
--	(@MSLMAY = '-1' OR X.MS_LOAI_MAY = @MSLMAY)   AND  (@MSNHOMMAY = '-1' OR M.MS_NHOM_MAY = @MSNHOMMAY) 
	
--) A INNER JOIN (SELECT MS_N_XUONG FROM [dbo].[MGetNhaXuongDiaDiem](@MS_TINH,@MS_QUAN,@MS_DUONG ,'-1') ) B 
--ON A.MSNX = B.MS_N_XUONG 
--WHERE (@MSHT = -1 OR MS_HT = @MSHT)   




SELECT * into #MAY  FROM dbo.MGetMayUserNgay(@NGAY,'admin',@MSNX,@MSHT,-1,@MSLMAY,@MSNHOMMAY,'-1',0) 	

SELECT DISTINCT M.* into #MAY_TB
	FROM #MAY M INNER JOIN PHIEU_BAO_TRI N ON M.MS_MAY = N.MS_MAY 
	INNER JOIN dbo.PHIEU_BAO_TRI_CHI_PHI AS C ON N.MS_PHIEU_BAO_TRI = C.MS_PHIEU_BAO_TRI	
	INNER JOIN CHON_MAY_BDCP F ON M.MS_MAY = F.MS_MAY
WHERE TINH_TRANG_PBT > 2 AND NGAY_BD_KH BETWEEN @TNgay AND @DNgay
	


SELECT CONVERT(INT,NULL) AS STT ,*  INTO #MAY_BPCP FROM 
(
	SELECT A.MS_MAY ,A.TEN_MAY,MODEL,MO_TA, ROUND(ISNULL(CHI_PHI_BT,0) + ISNULL(CHI_PHI_HN,0),2) AS CHI_PHI_CO_KH,   
		ROUND(ISNULL(CHI_PHI,0),2) AS CHI_PHI_KHO_KH, ROUND(ISNULL(CHI_PHI_BT,0) + ISNULL(CHI_PHI_HN,0) +  ISNULL(CHI_PHI,0),2) AS TONG_CP
	FROM #MAY_TB A LEFT JOIN 
	(
	SELECT     dbo.PHIEU_BAO_TRI.MS_MAY, 
		(CASE @PhuTung WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_PHU_TUNG), 0) ELSE 0 END + 
		CASE @VatTu WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_VAT_TU), 0)  ELSE 0 END + 
		CASE @NhanCong WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_NHAN_CONG), 0) ELSE 0 END +  
		CASE @DichVu WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_DV), 0) ELSE 0 END + 
		CASE @Khac WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_KHAC), 0) ELSE 0 END ) AS CHI_PHI_BT
	FROM         dbo.PHIEU_BAO_TRI_CHI_PHI INNER JOIN
						  dbo.PHIEU_BAO_TRI ON dbo.PHIEU_BAO_TRI_CHI_PHI.MS_PHIEU_BAO_TRI = dbo.PHIEU_BAO_TRI.MS_PHIEU_BAO_TRI INNER JOIN
						  dbo.LOAI_BAO_TRI ON dbo.PHIEU_BAO_TRI.MS_LOAI_BT = dbo.LOAI_BAO_TRI.MS_LOAI_BT 
	WHERE     (LOAI_BAO_TRI.HU_HONG = 0) AND NGAY_BD_KH BETWEEN @TNgay AND @DNgay
		AND (TINH_TRANG_PBT > 2)
	GROUP BY dbo.PHIEU_BAO_TRI.MS_MAY
	) B ON A.MS_MAY = B.MS_MAY
	LEFT JOIN 
	(SELECT     MS_MAY, 
		(	CASE @NhanCong WHEN 1 THEN ISNULL(SUM(CHI_PHI_NC), 0)  ELSE 0 END +  
			CASE @VatTu WHEN 1 THEN ISNULL(SUM(CHI_PHI_VT), 0)  ELSE 0 END ) 		AS CHI_PHI_HN
		
	FROM         dbo.CONG_VIEC_HANG_NGAY_THIET_BI INNER JOIN
                      dbo.CONG_VIEC_HANG_NGAY ON dbo.CONG_VIEC_HANG_NGAY_THIET_BI.STT_CV = dbo.CONG_VIEC_HANG_NGAY.STT_CV
	WHERE dbo.CONG_VIEC_HANG_NGAY.NGAY_TH BETWEEN @TNgay AND @DNgay
	GROUP BY MS_MAY) C ON A.MS_MAY = C.MS_MAY
	LEFT JOIN 
	(
	SELECT     dbo.PHIEU_BAO_TRI.MS_MAY, 
		(CASE @PhuTung WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_PHU_TUNG), 0) ELSE 0 END +  
		CASE @VatTu WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_VAT_TU), 0) ELSE 0 END +  
		CASE @NhanCong WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_NHAN_CONG), 0) ELSE 0 END + 
		CASE @DichVu WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_DV), 0) ELSE 0 END +  
		CASE @Khac WHEN 1 THEN ISNULL(SUM(dbo.PHIEU_BAO_TRI_CHI_PHI.CHI_PHI_KHAC), 0) ELSE 0 END )		AS CHI_PHI
		
	FROM         dbo.PHIEU_BAO_TRI_CHI_PHI INNER JOIN
						  dbo.PHIEU_BAO_TRI ON dbo.PHIEU_BAO_TRI_CHI_PHI.MS_PHIEU_BAO_TRI = dbo.PHIEU_BAO_TRI.MS_PHIEU_BAO_TRI INNER JOIN
						  dbo.LOAI_BAO_TRI ON dbo.PHIEU_BAO_TRI.MS_LOAI_BT = dbo.LOAI_BAO_TRI.MS_LOAI_BT 
	WHERE     (LOAI_BAO_TRI.HU_HONG = 1) AND NGAY_BD_KH BETWEEN @TNgay AND @DNgay
		AND (TINH_TRANG_PBT > 2)
	GROUP BY dbo.PHIEU_BAO_TRI.MS_MAY
	) D ON A.MS_MAY = D.MS_MAY

) G


IF @LoaiBC = 1 
BEGIN
	SELECT DISTINCT STT , MS_MAY ,TEN_MAY ,MODEL , MO_TA, CHI_PHI_CO_KH,CHI_PHI_KHO_KH,TONG_CP FROM #MAY_BPCP 
	WHERE CHI_PHI_CO_KH <> 0 OR CHI_PHI_KHO_KH <> 0
	ORDER BY TONG_CP DESC, MS_MAY
END
ELSE
BEGIN
	SELECT DISTINCT STT , MS_MAY ,TEN_MAY ,TONG_CP,@Thang AS THANG FROM #MAY_BPCP 	WHERE TONG_CP <> 0
 ORDER BY TONG_CP DESC , MS_MAY
END

