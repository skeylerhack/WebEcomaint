
ALTER procedure [dbo].[spBCLeaderShipDetails]
	@TU_NGAY DATETIME = '10/14/2021',
	@DEN_NGAY DATETIME='10/14/2021',
	@LoaiBC BIGINT = NULL,
	@UserBC NVARCHAR(30) = NULL,
	@flag BIT = 1
	--- flag = 0 tổng quát
	----flag = 1 chi tiết
AS
BEGIN
IF @flag = 0
BEGIN
 SELECT DISTINCT B.DateCreate,B.UserName,D.Staffname, C.MA_SO INTO #TMP FROM dbo.Leadership A
INNER JOIN dbo.LeadershipDetails B ON A.ID = B.IDLeadership
INNER JOIN  dbo.LeadershipType C ON C.ID_TYPE = A.ID_TYPE
INNER JOIN dbo.ST_Safety D ON  B.UserName = D.Userlogin
WHERE B.DateCreate BETWEEN @TU_NGAY AND @DEN_NGAY AND (B.UserName =@UserBC OR @UserBC = '-1') AND (A.ID_TYPE =@LoaiBC OR @LoaiBC = -1) AND (B.No = 1 OR B.Yes = 1 OR B.NA =1)
		
DECLARE 
    @columns NVARCHAR(MAX) = '', 
    @sql     NVARCHAR(MAX) = '';
SELECT @columns+=QUOTENAME(MA_SO) + ',' FROM dbo.LeadershipType ORDER BY MA_SO;
SET @columns = LEFT(@columns, LEN(@columns) - 1);
SET @sql ='
SELECT ROW_NUMBER() OVER ( ORDER BY Staffname) AS STT,* FROM   
(
    SELECT 
        DateCreate, 
		UserName,
        Staffname,
		MA_SO
    FROM 
        #TMP
) t 
PIVOT(
    COUNT(DateCreate) 
    FOR MA_SO IN ('+ @columns +')
) AS pivot_table;';
EXECUTE sp_executesql @sql;
END 
ELSE

BEGIN
 SELECT B.UserName,D.Staffname,C.MA_SO,C.NAME_VN AS NAME_TYPE,B.DateCreate,A.Content,B.NOTE,B.Yes,B.No,B.NA FROM dbo.Leadership A
INNER JOIN dbo.LeadershipDetails B ON A.ID = B.IDLeadership
INNER JOIN  dbo.LeadershipType C ON C.ID_TYPE = A.ID_TYPE
INNER JOIN dbo.ST_Safety D ON  B.UserName = D.Userlogin
WHERE B.DateCreate BETWEEN @TU_NGAY AND @DEN_NGAY AND (B.UserName =@UserBC OR @UserBC = '-1') AND (A.ID_TYPE =@LoaiBC OR @LoaiBC = -1)
ORDER BY D.Staffname,C.MA_SO,B.DateCreate
END
END

GO

