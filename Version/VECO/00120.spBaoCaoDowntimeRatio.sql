
--EXEC spBaoCaoDowntimeRatio 
ALTER proc [dbo].[spBaoCaoDowntimeRatio]
	@tNgay datetime = '2017/01/15',
	@dNgay datetime = '2017/02/10',
	@nhaXuong nvarchar(max)
AS
BEGIN	
	SELECT CONVERT(NVARCHAR(100), NULL) [Date], 
		CONVERT(NVARCHAR(100), '') [Cal], 
		CONVERT(NVARCHAR(100), '') [Shut down], 
		CONVERT(NVARCHAR(100), '') [Downtime], 
		CONVERT(NVARCHAR(100), '') [Act. Op], 
		CONVERT(NVARCHAR(100), '') [Calc. Op], 
		CONVERT(NVARCHAR(100), '') [Shut down S], 
		CONVERT(NVARCHAR(100), '') [Downtime S], 
		CONVERT(NVARCHAR(100), '') [Act. Op S], 
		CONVERT(NVARCHAR(100), '') [DT ratio], 
		CONVERT(NVARCHAR(100), '') [Target] INTO #TMP
	DELETE #TMP
	DECLARE @minDay DATE = @tNgay
	DECLARE @cal NVARCHAR(100) = 1440
	WHILE @minDay <= @dNgay
	BEGIN
		SELECT TOP 1 @cal = SO_PHUT FROM NGAY_NGHI_NX WHERE MONTH(NGAY_NGHI) = MONTH(@minDay) AND DAY(NGAY_NGHI) = DAY(@minDay) AND MS_N_XUONG IN (SELECT Item FROM dbo.UDF_ConvertListItem2Table(@nhaXuong,','))
		INSERT INTO #TMP ([DATE], [Cal]) 
		SELECT  @minDay, CASE @cal WHEN 0 THEN 1440 ELSE @cal END
	    SET @cal = 0
		SET @minDay = DATEADD(DAY, 1, @minDay)	
	END		
	SELECT * FROM #TMP
END