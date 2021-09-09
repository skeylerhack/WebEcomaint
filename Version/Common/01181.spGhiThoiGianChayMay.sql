
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGhiThoiGianChayMay')
   exec('CREATE PROCEDURE spGhiThoiGianChayMay AS BEGIN SET NOCOUNT ON; END')
GO
--spGhiThoiGianChayMay 'ThoiGianChayMayChonAdmin', '-1', 'admin'
ALTER PROCEDURE spGhiThoiGianChayMay
	@TABLEMAY NVARCHAR(50),
	@TABLELISTMAY NVARCHAR(50),
	@USERNAME NVARCHAR(50)
AS
BEGIN
			
	DECLARE @TMP AS NVARCHAR(MAX) = 'SELECT * INTO TMP1 FROM ' + @TABLEMAY
	EXEC(@TMP)		
	SELECT * INTO #TMP1 FROM TMP1		
	DROP TABLE TMP1

	INSERT THOI_GIAN_CHAY_MAY (MS_MAY , NGAY, CHI_SO_DONG_HO, SO_GIO_LUY_KE, USERNAME)
	SELECT MS_MAY , NGAY, CHI_SO_DONG_HO, SO_GIO_LUY_KE, @USERNAME FROM #TMP1 WHERE IS_UPDATE = 0 AND CHI_SO_DONG_HO <> 0		
			
	UPDATE THOI_GIAN_CHAY_MAY 
	SET
		CHI_SO_DONG_HO = T1.CHI_SO_DONG_HO,
		SO_GIO_LUY_KE = T1.SO_GIO_LUY_KE, 
		USERNAME = @USERNAME
	FROM THOI_GIAN_CHAY_MAY T INNER JOIN (	SELECT MS_MAY , NGAY, CHI_SO_DONG_HO, SO_GIO_LUY_KE FROM #TMP1 WHERE IS_UPDATE = 1) T1 ON T.MS_MAY = T1.MS_MAY AND T.NGAY = T1.NGAY

	
	IF(@TABLELISTMAY <> '-1')
	BEGIN
		SET @TMP  = 'SELECT * INTO TMP1 FROM ' + @TABLELISTMAY
		EXEC(@TMP)		
		SELECT * INTO #TMP2 FROM TMP1		
		DROP TABLE TMP1
		
			INSERT THOI_GIAN_CHAY_MAY (MS_MAY , NGAY, CHI_SO_DONG_HO, SO_GIO_LUY_KE, USERNAME)
			SELECT MS_MAY , NGAY, CHI_SO_DONG_HO, SO_GIO_LUY_KE, @USERNAME FROM #TMP2 WHERE IS_UPDATE = 0 AND CHI_SO_DONG_HO <> 0		
									
			UPDATE THOI_GIAN_CHAY_MAY 
			SET
				CHI_SO_DONG_HO = T1.CHI_SO_DONG_HO,
				SO_GIO_LUY_KE = T1.SO_GIO_LUY_KE, 
				USERNAME = @USERNAME
			FROM THOI_GIAN_CHAY_MAY T 
			INNER JOIN (SELECT MS_MAY , NGAY, CHI_SO_DONG_HO, SO_GIO_LUY_KE FROM #TMP2 WHERE IS_UPDATE = 1) 
			T1 ON T.MS_MAY = T1.MS_MAY AND T.NGAY = T1.NGAY
		
		
	END
	
END