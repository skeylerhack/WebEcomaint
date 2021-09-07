IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDeviceStatus')
exec('CREATE PROCEDURE spGetDeviceStatus AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetDeviceStatus]
	@toDate DATETIME = '08/08/2017',
	@userName NVARCHAR(50) = 'Admin',
	@lang int = 0
AS
BEGIN
SET FMTONLY OFF
DECLARE @TTBThuong NVARCHAR (MAX) = 'TTBThuong'
DECLARE @TTYCSD NVARCHAR (MAX) = 'TTYCSD'
DECLARE @TTKHTT NVARCHAR (MAX) = 'TTKHTT'
DECLARE @TTBaoTri NVARCHAR (MAX) = 'TTBaoTri'
DECLARE @TTDangBaoTri NVARCHAR (MAX) = 'TTDangBaoTri'


SELECT TOP 1 @TTBThuong = CASE @lang WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTBThuong'
SELECT TOP 1 @TTYCSD = CASE @lang WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTYCSD'
SELECT TOP 1 @TTKHTT = CASE @lang WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTKHTT'
SELECT TOP 1 @TTBaoTri = CASE @lang WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTBaoTri'
SELECT TOP 1 @TTDangBaoTri = CASE @lang WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END FROM LANGUAGES WHERE KEYWORD = 'TTDangBaoTri'


SELECT DISTINCT MS_MAY,TEN_MAY, TEN_LOAI_MAY,TEN_NHOM_MAY,Ten_N_XUONG,MS_N_XUONG,MS_NHOM_MAY INTO #MAY_USER FROM 
	dbo.MGetMayUserNgay(@toDate,@userName,'-1','-1',-1,'-1','-1','-1',@lang) 

SELECT DISTINCT MS_MAY,CONVERT(NVARCHAR(MAX),
MS_PHIEU_BAO_TRI + ' - ' + T2.TEN_LOAI_BT + ' - ' + T1.LY_DO_BT) AS TT_CT,
CONVERT(DATE,T1.NGAY_BD_KH) AS NGAY_BD , T1.NGAY_KT_KH AS NGAY_KT,
CONVERT(NVARCHAR(MAX),@TTDangBaoTri) AS TT_BTRI, CONVERT(INT,5) AS TT
 INTO #PBT_B FROM PHIEU_BAO_TRI T1 INNER JOIN LOAI_BAO_TRI T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT
WHERE (TINH_TRANG_PBT = 2) AND CONVERT(DATE,NGAY_BD_KH) <= @toDate 

SELECT DISTINCT MS_MAY,CONVERT(NVARCHAR(MAX),
MS_PHIEU_BAO_TRI + ' - ' + T2.TEN_LOAI_BT + ' - ' + T1.LY_DO_BT) AS TT_CT,
T1.NGAY_BD_KH AS NGAY_BD , T1.NGAY_KT_KH AS NGAY_KT,
CONVERT(NVARCHAR(MAX),@TTBaoTri) AS TT_BTRI, CONVERT(INT,4) AS TT
INTO #PBT FROM PHIEU_BAO_TRI T1 INNER JOIN LOAI_BAO_TRI T2 ON T1.MS_LOAI_BT = T2.MS_LOAI_BT
WHERE (TINH_TRANG_PBT < 2)  AND 
	 CONVERT(DATE,NGAY_BD_KH)  <= @toDate 

SELECT DISTINCT MS_MAY,CONVERT(NVARCHAR(MAX),T1.TEN_HANG_MUC) AS TT_CT, T1.NGAY AS NGAY_BD ,T1.NGAY_DK_HT AS NGAY_KT,
CONVERT(NVARCHAR(MAX),@TTKHTT) AS TT_BTRI, CONVERT(INT,3) AS TT
INTO #KHTT FROM KE_HOACH_TONG_THE T1 WHERE  
	CONVERT(DATE,T1.NGAY)  <= @toDate

SELECT  DISTINCT MS_MAY,CONVERT(NVARCHAR(MAX),T1.MS_YEU_CAU + ' - ' + MO_TA_TINH_TRANG) AS TT_CT, T1.NGAY AS NGAY_BD, NULL AS NGAY_KT,
CONVERT(NVARCHAR(MAX),@TTYCSD) AS TT_BTRI, CONVERT(INT,2) AS TT
INTO #YCSD FROM YEU_CAU_NSD T1 INNER JOIN YEU_CAU_NSD_CHI_TIET T2 ON T1.STT = T2.STT 
WHERE ISNULL(THUC_HIEN_DSX,0) = 1 AND 
	 CONVERT(DATE,NGAY)  <= @toDate 

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



DECLARE @BThuong FLOAT = 0
DECLARE @YCSD  FLOAT = 0
DECLARE @KHTT FLOAT = 0
DECLARE @BaoTri  FLOAT = 0
DECLARE @DangBaoTri  FLOAT = 0

SELECT @BThuong = CONVERT(FLOAT, ISNULL(COUNT(*), 0)) FROM #TT_PBT WHERE TT = 1
SELECT @YCSD = CONVERT(FLOAT, ISNULL(COUNT(*), 0)) FROM #TT_PBT WHERE TT = 2
SELECT @KHTT = CONVERT(FLOAT, ISNULL(COUNT(*), 0)) FROM #TT_PBT WHERE TT = 3
SELECT @BaoTri = CONVERT(FLOAT, ISNULL(COUNT(*), 0)) FROM #TT_PBT WHERE TT = 4
SELECT @DangBaoTri = CONVERT(FLOAT, ISNULL(COUNT(*), 0)) FROM #TT_PBT WHERE TT = 5


DECLARE @Tong FLOAT = 0
SET @Tong = @BThuong + @YCSD + @KHTT + @BaoTri + @DangBaoTri
 SET FMTONLY OFF
 DECLARE @tblResults TABLE(
 name NVARCHAR(100),
 y FLOAT, 
 color NVARCHAR(100)
 )
 
INSERT INTO @tblResults (name, y, color)
VALUES ( @TTBThuong ,   case @Tong when 0 then 0 else ((@BThuong * 100) / @Tong) end, N'#20b2aa'),
( @TTYCSD ,  case @Tong when 0 then 0 else ((@YCSD * 100) / @Tong) end, N'#003366') ,
( @TTKHTT ,   case @Tong when 0 then 0 else ((@KHTT * 100) / @Tong) end, N'#b2c831') ,
( @TTBaoTri ,  case @Tong when 0 then 0 else ((@BaoTri * 100) / @Tong) end, N'#404040') ,
( @TTDangBaoTri ,  case @Tong when 0 then 0 else  ((@DangBaoTri * 100) / @Tong) end, N'#794044')

SELECT name, Round(y, 0) y, color FROM @tblResults



END



