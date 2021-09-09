﻿IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetBCTGNMTong')
   exec('CREATE PROCEDURE spGetBCTGNMTong AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC [dbo].[spGetBCTGNMTong]
	@Nam DATETIME = '01/01/2018',
	@HeThong INT = 13,
	@PTram INT = 0,
	@sbTGNN NVARCHAR(100) ='TGNMAdmin'
AS
CREATE TABLE #BTGT 
(
	[MS_NGUYEN_NHAN] [int] NULL,
	[TEN_NGUYEN_NHAN] [nvarchar] (500),
)
DECLARE @sSql	NVARCHAR(MAX)
SET @sSql	= 'INSERT INTO #BTGT( MS_NGUYEN_NHAN, TEN_NGUYEN_NHAN ) SELECT MS_NGUYEN_NHAN,TEN_NGUYEN_NHAN FROM '+@sbTGNN
EXEC (@sSql)

DECLARE @target FLOAT;
--SET @target = (SELECT TOP 1 GIO_KH FROM  dbo.KHSX_NGAY 
--WHERE ISNULL(LOAI,0) = 1 AND NGAY BETWEEN CONVERT(DATE,'01/01/'+CONVERT(NVARCHAR(4),YEAR(@Nam))) AND CONVERT(DATE,'12/31/'+CONVERT(NVARCHAR(4),YEAR(@Nam)))
--AND	MS_HE_THONG IN(SELECT MS_HE_THONG FROM dbo.HE_THONG WHERE NHOM_IN = (SELECT NHOM_IN FROM dbo.HE_THONG WHERE MS_HE_THONG = @HeThong)))

SET @target = (SELECT TOP 1 GIO_KH FROM  dbo.KHSX_NGAY 
WHERE ISNULL(LOAI,0) = 1 AND NGAY BETWEEN CONVERT(DATE,'01/01/'+CONVERT(NVARCHAR(4),YEAR(@Nam))) AND CONVERT(DATE,'12/31/'+CONVERT(NVARCHAR(4),YEAR(@Nam)))
AND	MS_N_XUONG IN(SELECT NHOM_IN FROM dbo.HE_THONG WHERE MS_HE_THONG = @HeThong))

--Tạo table chứa từ tháng đến tháng
SELECT CASE WHEN YEAR(THANG) = YEAR(@Nam) -1 THEN -1 ELSE CONVERT(INT,MONTH(THANG)) END
AS THANG,THANG AS TU_NGAY,T.DEN_NGAY,T1.MS_NGUYEN_NHAN,TEN_NGUYEN_NHAN	INTO #TMP FROM 
(
SELECT THANG,DATEADD(DAY,-1,DATEADD(MONTH, 1,THANG)) AS DEN_NGAY FROM 
(SELECT CONVERT(DATETIME,CONVERT(NVARCHAR(2), 1) + '/' + CONVERT(NVARCHAR(2),x.number)+ '/' + CONVERT(NVARCHAR(4),YEAR(@Nam)) + ' 00:00:00',104) AS THANG FROM master.dbo.spt_values x WHERE   x.type = 'P' AND  x.number BETWEEN 1 AND 12
UNION
SELECT CONVERT(DATETIME,CONVERT(NVARCHAR(2), 1) + '/' + CONVERT(NVARCHAR(2),12)+ '/' + CONVERT(NVARCHAR(4),YEAR(@Nam)-1) + ' 00:00:00',104) AS THANG
) T1
) T , #BTGT T1 
ORDER BY THANG,TEN_NGUYEN_NHAN

SELECT 
MONTH(T1.NGAY) AS THANG,T1.MS_NGUYEN_NHAN,SUM(T1.THOI_GIAN_SUA) AS TGNM INTO #TGNGUNG FROM dbo.THOI_GIAN_NGUNG_MAY T1 INNER JOIN dbo.THOI_GIAN_NGUNG_MAY_SO_LAN T2 ON T2.MS_LAN = T1.MS_LAN
 WHERE CONVERT(DATE,T1.NGAY) BETWEEN CONVERT(DATE,'01/01/' + CONVERT(NVARCHAR(4),YEAR(@Nam))) AND CONVERT(DATE,CONVERT(DATE,'12/31/' + CONVERT(NVARCHAR(4),YEAR(@Nam)))) AND MS_HE_THONG = @HeThong AND  ISNULL(T2.KHONG_DC,0) = 0
 GROUP BY MONTH(T1.NGAY),T1.MS_NGUYEN_NHAN 
 UNION
 SELECT 
-1 AS THANG,T1.MS_NGUYEN_NHAN,SUM(T1.THOI_GIAN_SUA) AS TGNM  FROM dbo.THOI_GIAN_NGUNG_MAY T1 INNER JOIN dbo.THOI_GIAN_NGUNG_MAY_SO_LAN T2 ON T2.MS_LAN = T1.MS_LAN
 WHERE CONVERT(DATE,T1.NGAY) BETWEEN CONVERT(DATE,'12/01/' + CONVERT(NVARCHAR(4),YEAR(@Nam) -1 )) AND CONVERT(DATE,CONVERT(DATE,'12/31/' + CONVERT(NVARCHAR(4),YEAR(@Nam) -1))) AND MS_HE_THONG = @HeThong AND  ISNULL(T2.KHONG_DC,0) = 0
 GROUP BY T1.MS_NGUYEN_NHAN 
 ORDER BY THANG

SELECT T1.THANG,T1.MS_NGUYEN_NHAN,TEN_NGUYEN_NHAN,TGNM INTO #TGNMDATA FROM #TMP T1 LEFT JOIN #TGNGUNG T2 ON T1.THANG = T2.THANG AND T1.MS_NGUYEN_NHAN = T2.MS_NGUYEN_NHAN
ORDER BY T1.THANG

SELECT MONTH(NGAY) AS THANG,SUM(TGCM) AS TGCM INTO #BTSUM FROM 
(
SELECT T1.NGAY , 
CASE  WHEN NULLIF(SUM(T1.THOI_GIAN_SUA),0)  > 0 THEN 
CASE WHEN ISNULL(GIO_KH,0) = 0 THEN 24 ELSE GIO_KH END
ELSE NULL END AS TGCM 
 FROM dbo.THOI_GIAN_NGUNG_MAY T1 INNER JOIN dbo.THOI_GIAN_NGUNG_MAY_SO_LAN T2 ON T2.MS_LAN = T1.MS_LAN LEFT JOIN dbo.KHSX_NGAY T3 ON T1.NGAY = T3.NGAY AND T1.MS_HE_THONG = T3.MS_HE_THONG AND ISNULL(T3.LOAI,0) = 0
 WHERE CONVERT(DATE,T1.NGAY) BETWEEN CONVERT(DATE,'01/01/' + CONVERT(NVARCHAR(4),YEAR(@Nam))) AND CONVERT(DATE,CONVERT(DATE,'12/31/' + CONVERT(NVARCHAR(4),YEAR(@Nam)))) AND T1.MS_HE_THONG = @HeThong AND  ISNULL(T2.KHONG_DC,0) = 0
 GROUP BY T1.NGAY,GIO_KH
 ) T GROUP BY MONTH(NGAY)

SELECT T1.THANG,TEN_NGUYEN_NHAN,NULLIF( CASE @PTram WHEN 0 THEN CONVERT(DECIMAL(10,2), TGNM/60 ) ELSE CONVERT(DECIMAL(10,5), TGNM/60 / TGCM) END,0) AS PT    INTO #SUM FROM #TGNMDATA T1 LEFT JOIN 
(
SELECT THANG,TGCM FROM #BTSUM
 UNION
 SELECT -1 AS THANG,SUM(TGCM) AS TGCM FROM 
(
SELECT T1.NGAY , 
CASE  WHEN NULLIF(SUM(T1.THOI_GIAN_SUA),0)  > 0 THEN 
CASE WHEN ISNULL(GIO_KH,0) = 0 THEN 24 ELSE GIO_KH END
ELSE NULL END AS TGCM 
 FROM dbo.THOI_GIAN_NGUNG_MAY T1 INNER JOIN dbo.THOI_GIAN_NGUNG_MAY_SO_LAN T2 ON T2.MS_LAN = T1.MS_LAN LEFT JOIN dbo.KHSX_NGAY T3 ON T1.NGAY = T3.NGAY AND T1.MS_HE_THONG = T3.MS_HE_THONG AND  ISNULL(T3.LOAI,0) = 0
 WHERE CONVERT(DATE,T1.NGAY) BETWEEN CONVERT(DATE,'12/01/' + CONVERT(NVARCHAR(4),YEAR(@Nam)-1)) AND CONVERT(DATE,CONVERT(DATE,'12/31/' + CONVERT(NVARCHAR(4),YEAR(@Nam)-1))) AND T1.MS_HE_THONG = @HeThong AND  ISNULL(T2.KHONG_DC,0) = 0
 GROUP BY T1.NGAY,GIO_KH
 ) T GROUP BY MONTH(NGAY)

 ) T2 ON T1.THANG = T2.THANG
 ORDER BY T1.THANG

 IF(@PTram = 1)
 BEGIN
		SELECT ROW_NUMBER() OVER(ORDER BY TEN_NGUYEN_NHAN)AS STT , pvt.*
		 FROM (
		SELECT TEN_NGUYEN_NHAN,THANG,PT FROM #SUM
		) A PIVOT
		(
			 SUM(A.PT) FOR A.THANG IN ([-1],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
		) AS pvt		

		UNION
        SELECT 9998 AS STT , pvt.*
		 FROM (
		SELECT THANG,'Total Downtime, %' AS TEN_NGUYEN_NHAN ,SUM(PT) AS PT FROM #SUM
		GROUP BY  THANG
		) A PIVOT
		(
			 SUM(A.PT) FOR A.THANG IN ([-1],[1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12])
		) AS pvt

		UNION 
		SELECT 9999,'Target',@target,@target,@target,@target,@target,@target,@target,@target,@target,@target,@target,@target,@target
		ORDER BY STT

	END
	ELSE
	BEGIN
        	SELECT ROW_NUMBER() OVER(ORDER BY TEN_NGUYEN_NHAN)AS STT , pvt.*
			 INTO #tempt
			 FROM (
			SELECT TEN_NGUYEN_NHAN,THANG,PT FROM #SUM WHERE THANG <> -1
			 UNION
	SELECT  TEN_NGUYEN_NHAN,13,NULLIF(SUM(PT),0)
	FROM #SUM WHERE THANG <> -1
	GROUP BY TEN_NGUYEN_NHAN 

			 UNION

	SELECT  'Total',THANG, NULLIF(SUM(PT),0)
	FROM #SUM  GROUP BY THANG 
			) A PIVOT
			(
				 SUM(A.PT) FOR A.THANG IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])
			) AS pvt		
			ORDER BY STT

				UPDATE #tempt SET [13] = (SELECT NULLIF(SUM([13]),0) FROM #tempt)
				WHERE TEN_NGUYEN_NHAN ='total'
			
			SELECT * FROM #tempt
	SELECT (SELECT NHOM_LINE FROM dbo.HE_THONG WHERE MS_HE_THONG =@HeThong ) AS NAME, pvt.*
	FROM (
		SELECT * FROM #BTSUM 
		UNION 
		SELECT '13',SUM(TGCM) FROM #BTSUM
		) A PIVOT
		(
			 SUM(A.TGCM) FOR A.THANG IN ([1],[2],[3],[4],[5],[6],[7],[8],[9],[10],[11],[12],[13])
		) AS pvt
	END