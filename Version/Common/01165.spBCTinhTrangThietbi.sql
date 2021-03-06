IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spBCTinhTrangThietbi')
   exec('CREATE PROCEDURE spBCTinhTrangThietbi AS BEGIN SET NOCOUNT ON; END')
GO


alter PROCEDURE spBCTinhTrangThietbi
	@TuNgay DATETIME = '01/01/2015',
	@DenNgay DATETIME = '01/01/2017',
	@iLoai INT = 0,
	@UserName NVARCHAR(50) = 'Admin',
	@MsNXuong nvarchar(50) = '-1',
	@MsHeThong int = -1,
	@MsLoaiMay NVARCHAR (50) = '-1',
	@MsNhomMay NVARCHAR (50) = '-1',
	@NNgu int = 0,
	@iBThuong BIT = 1,
	@iYCSD BIT = 0,
	@iKHTT BIT = 0,	
	@iBaoTri BIT = 0,
	@iDangBaoTri BIT = 0
	
	
AS
--@iLoai = 0  TRONG KHOANG THOI GIAN
--@iLoai = 1  NHO HON DEN NGAY
--@iBaoCao = 1 DANG HOAT DONG
--@iBaoCao = 2 DANG BAO TRI


DECLARE @TTBThuong NVARCHAR (MAX) = 'TTBThuong'
DECLARE @TTYCSD NVARCHAR (MAX) = 'TTYCSD'
DECLARE @TTKHTT NVARCHAR (MAX) = 'TTKHTT'
DECLARE @TTBaoTri NVARCHAR (MAX) = 'TTBaoTri'
DECLARE @TTDangBaoTri NVARCHAR (MAX) = 'TTDangBaoTri'


SELECT TOP 1 @TTBThuong = CASE @NNgu WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTBThuong'
SELECT TOP 1 @TTYCSD = CASE @NNgu WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTYCSD'
SELECT TOP 1 @TTKHTT = CASE @NNgu WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTKHTT'
SELECT TOP 1 @TTBaoTri = CASE @NNgu WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTBaoTri'
SELECT TOP 1 @TTDangBaoTri = CASE @NNgu WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTDangBaoTri'


SELECT DISTINCT MS_MAY,TEN_MAY, TEN_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,MS_N_XUONG,MS_NHOM_MAY INTO #MAY_USER FROM 
	dbo.MGetMayUserNgay(@DenNgay,@UserName,@MsNXuong,@MsHeThong,-1,@MsLoaiMay,'-1','-1',@NNgu) 



SELECT DISTINCT MS_MAY,CONVERT(NVARCHAR(MAX),
MS_PHIEU_BAO_TRI + ' - ' + T2.TEN_LOAI_BT + ' - ' + T1.LY_DO_BT) AS TT_CT,
CONVERT(DATE,T1.NGAY_BD_KH) AS NGAY_BD , T1.NGAY_KT_KH AS NGAY_KT,
CONVERT(NVARCHAR(MAX),@TTDangBaoTri) AS TT_BTRI, CONVERT(INT,5) AS TT
 INTO #PBT_B FROM PHIEU_BAO_TRI T1 INNER JOIN LOAI_BAO_TRI T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT
WHERE (TINH_TRANG_PBT = 2)  
AND 
	(CASE 
		WHEN @iLoai = 0 AND CONVERT(DATE,NGAY_BD_KH) BETWEEN @TuNgay AND @DenNgay THEN 1
		WHEN @iLoai = 1 AND CONVERT(DATE,NGAY_BD_KH)  <= @DenNgay THEN 1    
    ELSE 0
	END = 1)


SELECT DISTINCT MS_MAY,CONVERT(NVARCHAR(MAX),
MS_PHIEU_BAO_TRI + ' - ' + T2.TEN_LOAI_BT + ' - ' + T1.LY_DO_BT) AS TT_CT,
T1.NGAY_BD_KH AS NGAY_BD , T1.NGAY_KT_KH AS NGAY_KT,
CONVERT(NVARCHAR(MAX),@TTBaoTri) AS TT_BTRI, CONVERT(INT,4) AS TT
INTO #PBT FROM PHIEU_BAO_TRI T1 INNER JOIN LOAI_BAO_TRI T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT
WHERE (TINH_TRANG_PBT < 2)  AND 
	(CASE 
		WHEN @iLoai = 0 AND CONVERT(DATE,NGAY_BD_KH) BETWEEN @TuNgay AND @DenNgay THEN 1
		WHEN @iLoai = 1 AND CONVERT(DATE,NGAY_BD_KH)  <= @DenNgay THEN 1    
    ELSE 0
	END = 1)


SELECT DISTINCT MS_MAY,CONVERT(NVARCHAR(MAX),T1.TEN_HANG_MUC) AS TT_CT, T1.NGAY AS NGAY_BD ,T1.NGAY_DK_HT AS NGAY_KT,
CONVERT(NVARCHAR(MAX),@TTKHTT) AS TT_BTRI, CONVERT(INT,3) AS TT
INTO #KHTT FROM KE_HOACH_TONG_THE T1 WHERE  
	(CASE 
		WHEN @iLoai = 0 AND CONVERT(DATE,T1.NGAY) BETWEEN @TuNgay AND @DenNgay THEN 1
		WHEN @iLoai = 1 AND CONVERT(DATE,T1.NGAY)  <= @DenNgay THEN 1    
    ELSE 0
	END = 1)


SELECT  DISTINCT MS_MAY,CONVERT(NVARCHAR(MAX),T1.MS_YEU_CAU + ' - ' + MO_TA_TINH_TRANG) AS TT_CT, T1.NGAY AS NGAY_BD, NULL AS NGAY_KT,
CONVERT(NVARCHAR(MAX),@TTYCSD) AS TT_BTRI, CONVERT(INT,2) AS TT
INTO #YCSD FROM YEU_CAU_NSD T1 INNER JOIN YEU_CAU_NSD_CHI_TIET T2 ON T1.STT = T2.STT 
WHERE ISNULL(THUC_HIEN_DSX,0) = 1 AND 
	(CASE 
		WHEN @iLoai = 0 AND CONVERT(DATE,NGAY) BETWEEN @TuNgay AND @DenNgay THEN 1
		WHEN @iLoai = 1 AND CONVERT(DATE,NGAY)  <= @DenNgay THEN 1    
    ELSE 0
	END = 1)


DELETE T1 FROM #YCSD T1 INNER JOIN #PBT T2 ON T1.MS_MAY = T2.MS_MAY
DELETE T1 FROM #YCSD T1 INNER JOIN #KHTT T2 ON T1.MS_MAY = T2.MS_MAY
DELETE T1 FROM #KHTT T1 INNER JOIN #PBT T2 ON T1.MS_MAY = T2.MS_MAY

SELECT * INTO #PBT_A FROM #PBT UNION
SELECT * FROM #KHTT UNION 
SELECT * FROM #YCSD


SELECT T1.MS_MAY, T1.TEN_MAY,CONVERT(NVARCHAR(MAX),ISNULL(TT_BTRI,@TTBThuong)) AS TINH_TRANG_MAY,TT_CT,NGAY_BD,NGAY_KT, ISNULL(TT,1) AS TT INTO #TT_PBT
FROM #MAY_USER T1 INNER JOIN #PBT_B T2 ON T1.MS_MAY = T2.MS_MAY
UNION
SELECT T1.MS_MAY, T1.TEN_MAY,CONVERT(NVARCHAR(MAX),ISNULL(TT_BTRI,@TTBThuong)) AS TINH_TRANG_MAY,TT_CT,NGAY_BD,NGAY_KT, ISNULL(TT,1) AS TT
FROM #MAY_USER T1 LEFT JOIN #PBT_A T2 ON T1.MS_MAY = T2.MS_MAY 
WHERE NOT EXISTS (SELECT * FROM #PBT_B A WHERE T1.MS_MAY = A.MS_MAY)



SELECT DISTINCT MS_MAY,TINH_TRANG_MAY,MAX(NGAY_BD) AS NGAY_BD INTO #MAY_LOC
FROM #TT_PBT 
WHERE ISNULL(MS_MAY,'') <> ''
GROUP BY MS_MAY,TINH_TRANG_MAY
HAVING MAX(ISNULL(NGAY_BD,@DenNgay))<= @DenNgay



IF (@iBThuong = 0) DELETE  #TT_PBT WHERE ISNULL(TT,1) = 1
IF (@iYCSD = 0)  DELETE  #TT_PBT WHERE ISNULL(TT,1) = 2
IF (@iKHTT = 0)  DELETE  #TT_PBT WHERE ISNULL(TT,1) = 3
IF (@iBaoTri = 0)  DELETE  #TT_PBT WHERE ISNULL(TT,1) = 4
IF (@iDangBaoTri = 0) DELETE  #TT_PBT WHERE ISNULL(TT,1) = 5


SELECT T1.MS_MAY, T1.TEN_MAY,T1.TINH_TRANG_MAY,TT_CT,T1.NGAY_BD,T1.NGAY_KT
 FROM #TT_PBT T1 INNER JOIN #MAY_LOC T2 ON T1.MS_MAY = T2.MS_MAY AND ISNULL(T1.NGAY_BD,@DenNgay) = ISNULL(T2.NGAY_BD,@DenNgay)
ORDER BY T1.MS_MAY

