
-- spGetNgayLVDD 

ALTER PROC [dbo].[spGetNgayLVDD]
	@UserName NVARCHAR(100) = 'ADMIN'
AS
--CREATE TABLE #DD_CHART_TMP(
--	[NGAY] [datetime] NULL,
--	[SO_PHUT_NGAY] [float] NULL,
--	[NGAY_DD] [datetime] NULL,
--	[SP_DA_DD] [float] NULL,
--	[SP_CL] [float] NULL,
--	[MA_SO] [int] NULL,
--	[LOAI] [int] NULL,
--	[GOC] [bit] NULL
--) 
CREATE TABLE #DD_CHART_TMP(
	[NGAY] [datetime] NULL,
	[SO_PHUT_NGAY] [float] NULL
) 

DECLARE @sSql NVARCHAR(4000)
--SET @sSql = 'INSERT INTO #DD_CHART_TMP ([NGAY],[SO_PHUT_NGAY],[NGAY_DD],[SP_DA_DD],[SP_CL],[MA_SO],[LOAI],[GOC]) SELECT [NGAY],SP_NGAY AS [SO_PHUT_NGAY],[NGAY_DD],[SP_DA_DD],[SP_CL],[MA_SO],[LOAI],[GOC] FROM DD_CHART_NS_TMP' + @UserName

SET @sSql = 'INSERT INTO #DD_CHART_TMP ([NGAY],[SO_PHUT_NGAY]) SELECT [NGAY],SP_NGAY AS [SO_PHUT_NGAY] FROM DD_CHART_NS_TMP' + @UserName + ' WHERE GOC = 1'

EXEC (@sSql)

SELECT * ,
DATEPART( WK, NGAY) AS TUAN, MONTH(NGAY) AS THANG, 
YEAR(NGAY) AS NAM,
DATEADD(wk, 0, DATEADD(DAY, 1-DATEPART(WEEKDAY, NGAY), DATEDIFF(dd, 0, NGAY))) as first_day  , --first day current week
DATEADD(wk, 1, DATEADD(DAY, 0-DATEPART(WEEKDAY, NGAY), DATEDIFF(dd, 0, NGAY))) as last_day 

INTO #DD_NV_TMP from #DD_CHART_TMP

SELECT CONVERT(NVARCHAR(100), NGAY,103) AS [DATA], SO_PHUT_NGAY AS S_PHUT, 1 AS LOAI, NAM AS ORD1 ,MONTH(NGAY) ORD2 FROM #DD_NV_TMP 
--WHERE GOC = 1
--ORDER BY NAM,ORD1
UNION

SELECT CONVERT(NVARCHAR(10),TUAN) + '/' + CONVERT(NVARCHAR(10),NAM) + ' - (' +  CONVERT(NVARCHAR(10),first_day,103) + ' - ' +  CONVERT(NVARCHAR(10),last_day,103) + ')', SUM(SO_PHUT_NGAY) AS SO_PHUT_NGAY,2 AS LOAI, NAM,TUAN FROM #DD_NV_TMP 
--WHERE GOC = 1
GROUP BY TUAN,NAM,first_day,last_day
--ORDER BY NAM,TUAN
UNION
SELECT  CONVERT(NVARCHAR(10),THANG) + '/' + CONVERT(NVARCHAR(10),NAM) , SUM(SO_PHUT_NGAY) AS SO_PHUT_NGAY,3 AS LOAI, NAM,THANG FROM #DD_NV_TMP 
--WHERE GOC = 1
GROUP BY THANG,NAM
ORDER BY LOAI,ORD1,ORD2