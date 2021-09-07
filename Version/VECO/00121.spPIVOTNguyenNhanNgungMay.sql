IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spPIVOTNguyenNhanNgungMay')
   exec('CREATE PROCEDURE spPIVOTNguyenNhanNgungMay AS BEGIN SET NOCOUNT ON; END')
 Go

--EXEC spPIVOTNguyenNhanNgungMay 
ALTER proc [dbo].[spPIVOTNguyenNhanNgungMay]
	@tNgay datetime = '2017/01/15',
	@dNgay datetime = '2017/02/10',
	@nguyenNhanNM nvarchar(500) =  '-1'--'-1' --  '7,8,9,10'
	,@USERNAME NVARCHAR(15) = 'ADMIN'
AS
BEGIN


DECLARE @Str AS NVARCHAR(MAX)
DECLARE @DynamicPivotQuery AS NVARCHAR(MAX)
DECLARE @ColumnName AS NVARCHAR(MAX) = '[Date]'
DECLARE @ColumnName1 AS NVARCHAR(MAX) = 'CONVERT(NVARCHAR(100), [Date]) [Date]'

IF @nguyenNhanNM = '-1'
BEGIN
	SET @Str = 'SELECT DISTINCT TEN_NGUYEN_NHAN, IN_DOWNTIME INTO TMPNNNM FROM NGUYEN_NHAN_DUNG_MAY'

END
ELSE
BEGIN
	SET @Str = 'SELECT DISTINCT TEN_NGUYEN_NHAN, IN_DOWNTIME INTO TMPNNNM FROM NGUYEN_NHAN_DUNG_MAY WHERE MS_NGUYEN_NHAN IN (' + @nguyenNhanNM + ') '
END

	EXEC sp_executesql @Str


	SELECT @ColumnName= ISNULL(@ColumnName + ',','') + QUOTENAME(TEN_NGUYEN_NHAN) ,  
	@ColumnName1 = ISNULL(@ColumnName1 + ',','')  + 'CONVERT(NVARCHAR(100), ' + QUOTENAME(TEN_NGUYEN_NHAN) + ') ' + QUOTENAME(TEN_NGUYEN_NHAN) 
	FROM TMPNNNM ORDER BY IN_DOWNTIME
	DROP TABLE TMPNNNM



SET @DynamicPivotQuery = 
  N'SELECT ' + @ColumnName1 + '  INTO TMP1 FROM NGUYEN_NHAN_DUNG_MAY 
  PIVOT( COUNT(TEN_NGUYEN_NHAN) FOR TEN_NGUYEN_NHAN IN (' + @ColumnName + ')) AS PVTTable'

		EXEC sp_executesql @DynamicPivotQuery

		DELETE TMP1
		SELECT * INTO #TMP FROM TMP1
		DROP TABLE TMP1				
		DECLARE @minDay DATE = @tNgay		
		WHILE @minDay <= @dNgay
		BEGIN		
			INSERT INTO #TMP ([Date]) 
			SELECT  @minDay
			SET @minDay = DATEADD(DAY, 1, @minDay)	
		END		
		SELECT * FROM #TMP
END