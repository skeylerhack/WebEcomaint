
IF NOT EXISTS (SELECT * FROM THONG_TIN_CHUNG WHERE [PRIVATE] = 'ADC')
BEGIN
	UPDATE KE_HOACH_THUC_HIEN SET SPHUT = THOI_GIAN_DK  WHERE ISNULL(SPHUT ,0) = 0
END
GO
IF NOT EXISTS (SELECT * FROM THONG_TIN_CHUNG WHERE [PRIVATE] = 'ADC')
BEGIN

--SELECT MS_CONG_NHAN,STT,TEN_CONG_VIEC, THOI_GIAN_DK,SPHUT,
--2015-07-09 00:00:00.000
--NGAY ,TU_GIO,
--CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY,101) + ' ' + CONVERT(NVARCHAR(10),TU_GIO,108)) AS TNGIO,
--DATEADD(MINUTE, THOI_GIAN_DK, CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY,101) + ' ' + CONVERT(NVARCHAR(10),TU_GIO,108)) ) AS DNGIO,

--CONVERT(DATETIME,CONVERT(NVARCHAR(10),DATEADD(MINUTE, THOI_GIAN_DK, CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY,101) + ' ' + CONVERT(NVARCHAR(10),TU_GIO,108)) ),101)) AS DNGTT,
--CONVERT(DATETIME,CONVERT(NVARCHAR(10),DATEADD(MINUTE, THOI_GIAN_DK, CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY,101) + ' ' + CONVERT(NVARCHAR(10),TU_GIO,108)) ),108)) AS DGGTT,

--THOI_HAN,DEN_GIO FROM KE_HOACH_THUC_HIEN 
--WHERE ISNULL(TU_GIO,'') <> '' AND ISNULL(THOI_GIAN_DK,'') <> ''

UPDATE KE_HOACH_THUC_HIEN SET 
THOI_HAN = CONVERT(DATETIME,CONVERT(NVARCHAR(10),DATEADD(MINUTE, THOI_GIAN_DK, CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY,101) + ' ' + CONVERT(NVARCHAR(10),TU_GIO,108)) ),101)),
DEN_GIO = CONVERT(DATETIME,CONVERT(NVARCHAR(10),DATEADD(MINUTE, THOI_GIAN_DK, CONVERT(DATETIME,CONVERT(NVARCHAR(10),NGAY,101) + ' ' + CONVERT(NVARCHAR(10),TU_GIO,108)) ),108)) 
 WHERE ISNULL(TU_GIO,'') <> '' AND ISNULL(THOI_GIAN_DK,'') <> ''



END