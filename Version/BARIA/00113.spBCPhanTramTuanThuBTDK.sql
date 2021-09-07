
--spBCPhanTramTuanThuBTDK '02/01/2017','02/28/2017'
ALTER PROCEDURE [dbo].[spBCPhanTramTuanThuBTDK]
	@TU_NGAY DATETIME,
	@DEN_NGAY DATETIME,
	@USERNAME VARCHAR (64) = 'ADMIN', 
	@LANGUAGE INT = 0,
	@MS_NHA_XUONG VARCHAR (50) = '-1', 
	@MS_HE_THONG INT = -1,
	@MS_LOAI_MAY VARCHAR(100) = '-1',
	@MS_NHOM_MAY VARCHAR(100)= '-1'
AS
BEGIN 


SELECT DISTINCT MS_MAY INTO #MAY_USER
	FROM [dbo].[MGetMayUserNgay](@DEN_NGAY,@USERNAME,@MS_NHA_XUONG,@MS_HE_THONG,-1,@MS_LOAI_MAY,@MS_NHOM_MAY,'-1',@LANGUAGE)


-- delete bang tam

	IF OBJECT_ID('tempdb..#TEMP') IS NOT NULL DROP TABLE #TEMP
	IF OBJECT_ID('tempdb..#TONGTG_TEMP') IS NOT NULL DROP TABLE #TONGTG_TEMP
	IF OBJECT_ID('tempdb..#Thang_Temp') IS NOT NULL DROP TABLE #Thang_Temp

	SELECT  DATEPART(MONTH, DATEADD(MONTH, x.number, @Tu_Ngay))AS THANG,YEAR(DATEADD(MONTH, x.number, @Tu_Ngay)) AS NAM,MS_HT_BT,TEN_HT_BT INTO #Thang_Temp
			FROM    master.dbo.spt_values x,HINH_THUC_BAO_TRI
			WHERE   x.type = 'P'        
			AND     x.number <= DATEDIFF(MONTH, @Tu_Ngay, @Den_Ngay)

	SELECT MONTH(T1.NGAY_BD_KH) AS M,SUM(T1.SO_GIO) AS TONG_GIO INTO #TONGTG_TEMP
	FROM 
	(
		SELECT T1.NGAY_BD_KH,SUM(T2.SO_GIO) AS SO_GIO, 1 AS CHINH
		FROM PHIEU_BAO_TRI T1 INNER JOIN PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI INNER JOIN 
			LOAI_BAO_TRI T3 ON T1.MS_LOAI_BT = T3.MS_LOAI_BT INNER JOIN HINH_THUC_BAO_TRI T4 ON T3.MS_HT_BT = T4.MS_HT_BT INNER JOIN 
			#MAY_USER T5 ON T1.MS_MAY = T5.MS_MAY
		WHERE ( CONVERT(DATETIME,CONVERT(NVARCHAR(10),  NGAY_BD_KH,101)) BETWEEN @TU_NGAY AND @DEN_NGAY)  AND (TINH_TRANG_PBT >  2)
		GROUP BY T1.NGAY_BD_KH
		UNION
		SELECT T1.NGAY_BD_KH,SUM(T2.SO_GIO) AS SG,0 AS CHINH
		FROM PHIEU_BAO_TRI T1 INNER JOIN PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI INNER JOIN 
			LOAI_BAO_TRI T3 ON T1.MS_LOAI_BT = T3.MS_LOAI_BT INNER JOIN HINH_THUC_BAO_TRI T4 ON T3.MS_HT_BT = T4.MS_HT_BT INNER JOIN 
			#MAY_USER T5 ON T1.MS_MAY = T5.MS_MAY
		WHERE ( CONVERT(DATETIME,CONVERT(NVARCHAR(10),  NGAY_BD_KH,101)) BETWEEN @TU_NGAY AND @DEN_NGAY)  AND (TINH_TRANG_PBT >  2)
		GROUP BY T1.NGAY_BD_KH	
	) T1 GROUP BY MONTH(T1.NGAY_BD_KH) 
	
		
	SELECT MS_HT_BT,YEAR(T1.NGAY_BD_KH) AS y,MONTH(T1.NGAY_BD_KH) AS M,SUM(SO_GIO) AS GIO INTO #TEMP 
	FROM
	(
		SELECT T3.MS_HT_BT,T1.NGAY_BD_KH,SUM(SO_GIO) AS SO_GIO,1 AS CV
		FROM PHIEU_BAO_TRI T1 INNER JOIN PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI INNER JOIN 
			LOAI_BAO_TRI T3 ON T1.MS_LOAI_BT = T3.MS_LOAI_BT INNER JOIN HINH_THUC_BAO_TRI T4 ON T3.MS_HT_BT = T4.MS_HT_BT INNER JOIN 
			#MAY_USER T5 ON T1.MS_MAY = T5.MS_MAY
		WHERE ( CONVERT(DATETIME,CONVERT(NVARCHAR(10),  NGAY_BD_KH,101)) BETWEEN @TU_NGAY AND @DEN_NGAY)  AND (TINH_TRANG_PBT > 2)
		GROUP BY T3.MS_HT_BT,T1.NGAY_BD_KH
		UNION
		SELECT T3.MS_HT_BT,T1.NGAY_BD_KH,SUM(SO_GIO) AS SO_GIO,0 AS CV
		FROM PHIEU_BAO_TRI T1 INNER JOIN PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO T2 ON T1.MS_PHIEU_BAO_TRI = T2.MS_PHIEU_BAO_TRI INNER JOIN 
			LOAI_BAO_TRI T3 ON T1.MS_LOAI_BT = T3.MS_LOAI_BT INNER JOIN HINH_THUC_BAO_TRI T4 ON T3.MS_HT_BT = T4.MS_HT_BT INNER JOIN 
			#MAY_USER T5 ON T1.MS_MAY = T5.MS_MAY
		WHERE ( CONVERT(DATETIME,CONVERT(NVARCHAR(10),  NGAY_BD_KH,101)) BETWEEN @TU_NGAY AND @DEN_NGAY)  AND (TINH_TRANG_PBT > 2)
		GROUP BY T3.MS_HT_BT,T1.NGAY_BD_KH
	) T1 GROUP BY MS_HT_BT,YEAR(T1.NGAY_BD_KH),MONTH(T1.NGAY_BD_KH)


	DECLARE @Columns NVARCHAR(4000),@query NVARCHAR(4000)
	SELECT @Columns = STUFF(
	 (SELECT  ', ' +QUOTENAME(CONVERT(VARCHAR,(convert(nvarchar,T.THANG)+'-'+convert(nvarchar,T.NAM)))) FROM
	 (SELECT DISTINCT v.THANG,v.NAM FROM ( SELECT T.thang,T.NAM,(T1.GIO/tm.TONG_GIO)AS PHAN_TRAM FROM #Thang_Temp T
								LEFT JOIN (SELECT * FROM #TEMP) T1 ON T.THANG=T1.M AND T.NAM=t1.y
								LEFT JOIN #TONGTG_TEMP tm ON T.thang=TM.M)as v) AS T
								ORDER BY T.NAM,T.THANG FOR XML PATH('')),1,2,'') 	
											
	SET @query = N'
	select ROW_NUMBER() OVER (ORDER BY TEN_HT_BT ASC) AS STT,*
	from
	(
	 SELECT (convert(nvarchar,T.thang)+''-''+convert(nvarchar,T.NAM))as ThoiGian,T.TEN_HT_BT, ROUND((T1.GIO/tm.TONG_GIO) ,2) AS PHAN_TRAM FROM #Thang_Temp T
	LEFT JOIN (SELECT * FROM #TEMP) T1 ON T.THANG=T1.M AND T.NAM=t1.y AND T.MS_HT_BT=T1.MS_HT_BT
	LEFT JOIN #TONGTG_TEMP tm ON T.thang=TM.M
	) d
	pivot
	(
	  max(PHAN_TRAM)
	  for d.ThoiGian in ('+@Columns+')
	) piv ORDER BY TEN_HT_BT;';
	EXEC (@query)
END
