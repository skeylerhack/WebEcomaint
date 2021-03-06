

 --EXEC spBaoCaoHieuChuanKiemDinhTheoKeHoach '2022', 'admin', '-1', -1,-1,-1,-1, 0,0
 

ALTER PROC [dbo].[spBaoCaoHieuChuanKiemDinhTheoKeHoach]
	@NAM NVARCHAR(5),
	@USERNAME NVARCHAR(50),
	@MsNXuong nvarchar(50),
	@NHeThong int,
	@MsBPCP INT =-1,
	@LoaiMay NVARCHAR(20),
	@MsNhomMay NVARCHAR(30) ='-1',
	@LoaiBC INT,
	@NNgu INT
AS
--LOAIBT 0: TẤT CẢ
--LOAIBT 1: HIỆU CHUẨN MÁY
--LOAIBT 2: HIỆU CHUẨN DHD
BEGIN
	DECLARE @tNgay AS NVARCHAR(15) = '01/01/' + @NAM
	DECLARE @dNgay AS NVARCHAR(15) = '12/31/' + @NAM
	DECLARE @NgayHT DATETIME
	SET @NgayHT = GETDATE()
	SELECT A.* INTO #MAY FROM dbo.MGetMayUserNgay(@NgayHT,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,@MsNhomMay,'-1', @NNgu) A 

	

	DECLARE	@CTy NVARCHAR(50)
	SELECT TOP 1 @CTy =  [PRIVATE]  FROM dbo.THONG_TIN_CHUNG 

	-- tất cả
	IF(@NAM < YEAR(GETDATE()))
	BEGIN
	IF(@LoaiBC = 0)
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP FROM (
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO,'' AS TEN_PT, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = T.MS_LOAI_HIEU_CHUAN) AS TEN_LOAI_HIEU_CHUAN, CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, T.MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH,T2.Ten_N_XUONG   FROM (
			SELECT * FROM [dbo].[MGetChuKyNgayHieuChuanKeMay](@tNgay,@dNgay,-1,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,@MsNhomMay,1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			----WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay)  
			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO,T.TEN_PT, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = T.MS_LOAI_HIEU_CHUAN) AS TEN_LOAI_HIEU_CHUAN, CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, T.MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH,T2.Ten_N_XUONG   FROM (
			
			SELECT * FROM [dbo].[MGetChuKyNgayHieuChuanKePhuTung](@tNgay,@dNgay,-1,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,'-1',1) 
			UNION	
SELECT T1.MS_MAY, T1.MS_PT, T2.TEN_PT,T1.MS_VI_TRI, MAX(NGAY) AS NGAY_HC_CUOI, CASE T1.MS_LOAI_HIEU_CHUAN WHEN 1 THEN T3.CHU_KY_HC_NOI 
									WHEN 2 THEN T3.CHU_KY_HC_NGOAI 
									WHEN 3 THEN T3.CHU_KY_KD 
									ELSE T3.CHU_KY_KT END AS CHU_KY,T3.MS_DV_TG,
0 AS SO_NGAY,0 AS SO_NGAY_CK,MAX(NGAY) AS NGAY_KE,T1.MS_LOAI_HIEU_CHUAN

FROM dbo.HIEU_CHUAN_DHD T1 INNER JOIN dbo.IC_PHU_TUNG T2 ON T2.MS_PT = T1.MS_PT INNER JOIN dbo.CHU_KY_HIEU_CHUAN T3 ON T3.MS_MAY = T1.MS_MAY AND T3.MS_PT = T1.MS_PT AND T3.MS_VI_TRI = T1.MS_VI_TRI

GROUP BY  T1.MS_MAY, T1.MS_PT, T2.TEN_PT,T1.MS_VI_TRI, CASE T1.MS_LOAI_HIEU_CHUAN WHEN 1 THEN T3.CHU_KY_HC_NOI 
									WHEN 2 THEN T3.CHU_KY_HC_NGOAI 
									WHEN 3 THEN T3.CHU_KY_KD 
									ELSE T3.CHU_KY_KT END ,T3.MS_DV_TG,
T1.MS_LOAI_HIEU_CHUAN,MONTH(NGAY)


			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			--WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) 
			INNER JOIN HIEU_CHUAN_DHD T3 ON T.MS_MAY = T3.MS_MAY AND T.MS_PT = T3.MS_PT AND T.MS_VI_TRI = T3.MS_VI_TRI  and Year(T3.Ngay) = @NAM
		) A 
		PIVOT
		(
			COUNT(A.NGAY_KE) 
			FOR A.THANG IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
		)AS pvt		
		
		UPDATE #TMP SET [1] = NULL WHERE [1] = 0
		UPDATE #TMP SET [2] = NULL WHERE [2] = 0
		UPDATE #TMP SET [3] = NULL WHERE [3] = 0
		UPDATE #TMP SET [4] = NULL WHERE [4] = 0
		UPDATE #TMP SET [5] = NULL WHERE [5] = 0
		UPDATE #TMP SET [6] = NULL WHERE [6] = 0
		UPDATE #TMP SET [7] = NULL WHERE [7] = 0
		UPDATE #TMP SET [8] = NULL WHERE [8] = 0
		UPDATE #TMP SET [9] = NULL WHERE [9] = 0
		UPDATE #TMP SET [10] = NULL WHERE [10] = 0
		UPDATE #TMP SET [11] = NULL WHERE [11] = 0
		UPDATE #TMP SET [12] = NULL WHERE [12] = 0
		SELECT * FROM #TMP
		IF UPPER(@CTy) = 'TRUNGNGUYEN' 
		BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, CASE WHEN ISNULL(TEN_PT,'') = '' THEN '' ELSE TEN_PT + ' - ' END  + VI_TRI AS TEN_PT , Ten_N_XUONG AS VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP 
		END
		ELSE
        BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, TEN_PT, VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP 
        END

	END
	ELSE IF(@LoaiBC = 1)	
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP1 FROM (
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO,'' AS TEN_PT, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = T.MS_LOAI_HIEU_CHUAN) AS TEN_LOAI_HIEU_CHUAN, CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, T.MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH,T2.Ten_N_XUONG   FROM (
			SELECT * FROM [dbo].[MGetChuKyNgayHieuChuanKeMay](@tNgay,@dNgay,-1,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,@MsNhomMay,1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			--WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) 
		) A 
		PIVOT
		(
			COUNT(A.NGAY_KE) 
			FOR A.THANG IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
		)AS pvt	
		UPDATE #TMP1 SET [1] = NULL WHERE [1] = 0
		UPDATE #TMP1 SET [2] = NULL WHERE [2] = 0
		UPDATE #TMP1 SET [3] = NULL WHERE [3] = 0
		UPDATE #TMP1 SET [4] = NULL WHERE [4] = 0
		UPDATE #TMP1 SET [5] = NULL WHERE [5] = 0
		UPDATE #TMP1 SET [6] = NULL WHERE [6] = 0
		UPDATE #TMP1 SET [7] = NULL WHERE [7] = 0
		UPDATE #TMP1 SET [8] = NULL WHERE [8] = 0
		UPDATE #TMP1 SET [9] = NULL WHERE [9] = 0
		UPDATE #TMP1 SET [10] = NULL WHERE [10] = 0
		UPDATE #TMP1 SET [11] = NULL WHERE [11] = 0
		UPDATE #TMP1 SET [12] = NULL WHERE [12] = 0
		 					
		IF UPPER(@CTy) = 'TRUNGNGUYEN' 
		BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, CASE WHEN ISNULL(TEN_PT,'') = '' THEN '' ELSE TEN_PT + ' - ' END  + VI_TRI AS TEN_PT, Ten_N_XUONG AS VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP1
		END
		ELSE
        BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, TEN_PT, VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP1

		END
	END
	ELSE 
	IF(@LoaiBC = 2)	
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP2 FROM (
			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO,T.TEN_PT, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = T.MS_LOAI_HIEU_CHUAN) AS TEN_LOAI_HIEU_CHUAN, CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T3.TEN_DV_TG WHEN 1 THEN T3.TEN_DV_TG_ANH ELSE T3.TEN_DV_TG_HOA END) AS CHU_KY, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, T.MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH ,T2.Ten_N_XUONG  FROM (
			SELECT * FROM [dbo].[MGetChuKyNgayHieuChuanKePhuTung](@tNgay,@dNgay,-1,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T3 ON T.MS_DV_TG = T3.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			--WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) 	
			INNER JOIN HIEU_CHUAN_DHD T1 ON T.MS_MAY = T1.MS_MAY AND T.MS_PT = T1.MS_PT AND T.MS_VI_TRI = T1.MS_VI_TRI  and Year(T1.Ngay) = @NAM
		) A
		PIVOT
		(
			COUNT(A.NGAY_KE) 
			FOR A.THANG IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
		)AS pvt		
		UPDATE #TMP2 SET [1] = NULL WHERE [1] = 0
		UPDATE #TMP2 SET [2] = NULL WHERE [2] = 0
		UPDATE #TMP2 SET [3] = NULL WHERE [3] = 0
		UPDATE #TMP2 SET [4] = NULL WHERE [4] = 0
		UPDATE #TMP2 SET [5] = NULL WHERE [5] = 0
		UPDATE #TMP2 SET [6] = NULL WHERE [6] = 0
		UPDATE #TMP2 SET [7] = NULL WHERE [7] = 0
		UPDATE #TMP2 SET [8] = NULL WHERE [8] = 0
		UPDATE #TMP2 SET [9] = NULL WHERE [9] = 0
		UPDATE #TMP2 SET [10] = NULL WHERE [10] = 0
		UPDATE #TMP2 SET [11] = NULL WHERE [11] = 0
		UPDATE #TMP2 SET [12] = NULL WHERE [12] = 0

		IF UPPER(@CTy) = 'TRUNGNGUYEN' 
		BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, CASE WHEN ISNULL(TEN_PT,'') = '' THEN '' ELSE TEN_PT + ' - ' END + VI_TRI AS TEN_PT, Ten_N_XUONG AS VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP2
		END
		ELSE
        BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, TEN_PT, VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP2

		END
	END
	END	
	ELSE
    BEGIN
    IF(@LoaiBC = 0)
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP3 FROM (
		-- hiệu chuẩn mấy
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO,'' AS TEN_PT, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = T.MS_LOAI_HIEU_CHUAN) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, T.MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH,T2.Ten_N_XUONG  FROM (
			SELECT * FROM [dbo].[MGetChuKyNgayHieuChuanKeMay](@tNgay,@dNgay,-1,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,@MsNhomMay,1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) OR YEAR(T.NGAY_HC_CUOI) = YEAR(@dNgay)
			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO,T.TEN_PT,T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = T.MS_LOAI_HIEU_CHUAN) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG,T.MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH ,T2.Ten_N_XUONG FROM (
			SELECT * FROM [dbo].[MGetChuKyNgayHieuChuanKePhuTung](@tNgay,@dNgay,-1,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay)  OR YEAR(T.NGAY_HC_CUOI) = YEAR(@dNgay)
		) A 
		PIVOT
		(
			COUNT(A.NGAY_KE) 
			FOR A.THANG IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
		)AS pvt		
		
		UPDATE #TMP3 SET [1] = NULL WHERE [1] = 0
		UPDATE #TMP3 SET [2] = NULL WHERE [2] = 0
		UPDATE #TMP3 SET [3] = NULL WHERE [3] = 0
		UPDATE #TMP3 SET [4] = NULL WHERE [4] = 0
		UPDATE #TMP3 SET [5] = NULL WHERE [5] = 0
		UPDATE #TMP3 SET [6] = NULL WHERE [6] = 0
		UPDATE #TMP3 SET [7] = NULL WHERE [7] = 0
		UPDATE #TMP3 SET [8] = NULL WHERE [8] = 0
		UPDATE #TMP3 SET [9] = NULL WHERE [9] = 0
		UPDATE #TMP3 SET [10] = NULL WHERE [10] = 0
		UPDATE #TMP3 SET [11] = NULL WHERE [11] = 0
		UPDATE #TMP3 SET [12] = NULL WHERE [12] = 0

		IF UPPER(@CTy) = 'TRUNGNGUYEN' 
		BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, CASE WHEN ISNULL(TEN_PT,'') = '' THEN '' ELSE TEN_PT + ' - ' END + VI_TRI AS TEN_PT, Ten_N_XUONG AS VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP3
		END
		ELSE
        BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, TEN_PT, VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP3

		END
	END
	--- hiệu chuẩn mấy
	ELSE IF(@LoaiBC = 1)	
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP4 FROM (
				SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO,'' AS TEN_PT, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = T.MS_LOAI_HIEU_CHUAN) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, T.MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH,T2.Ten_N_XUONG  FROM (
			SELECT * FROM [dbo].[MGetChuKyNgayHieuChuanKeMay](@tNgay,@dNgay,-1,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,@MsNhomMay,1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) 
		) A 
		PIVOT
		(
			COUNT(A.NGAY_KE) 
			FOR A.THANG IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
		)AS pvt	
		UPDATE #TMP4 SET [1] = NULL WHERE [1] = 0
		UPDATE #TMP4 SET [2] = NULL WHERE [2] = 0
		UPDATE #TMP4 SET [3] = NULL WHERE [3] = 0
		UPDATE #TMP4 SET [4] = NULL WHERE [4] = 0
		UPDATE #TMP4 SET [5] = NULL WHERE [5] = 0
		UPDATE #TMP4 SET [6] = NULL WHERE [6] = 0
		UPDATE #TMP4 SET [7] = NULL WHERE [7] = 0
		UPDATE #TMP4 SET [8] = NULL WHERE [8] = 0
		UPDATE #TMP4 SET [9] = NULL WHERE [9] = 0
		UPDATE #TMP4 SET [10] = NULL WHERE [10] = 0
		UPDATE #TMP4 SET [11] = NULL WHERE [11] = 0
		UPDATE #TMP4 SET [12] = NULL WHERE [12] = 0

		IF UPPER(@CTy) = 'TRUNGNGUYEN' 
		BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, CASE WHEN ISNULL(TEN_PT,'') = '' THEN '' ELSE TEN_PT + ' - ' END + VI_TRI AS TEN_PT, Ten_N_XUONG AS VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP4
		END
		ELSE
        BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, TEN_PT, VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP4

		END		
	END
	-- hiệu chuẩn dụng cụ đo
	ELSE IF(@LoaiBC = 2)	
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP5 FROM (

					SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO,T.TEN_PT, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = T.MS_LOAI_HIEU_CHUAN) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG,T.MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH,T2.Ten_N_XUONG  FROM (
			SELECT * FROM [dbo].[MGetChuKyNgayHieuChuanKePhuTung](@tNgay,@dNgay,-1,@USERNAME,@MsNXuong,@NHeThong,@MsBPCP,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) 
		) A
		PIVOT
		(
			COUNT(A.NGAY_KE) 
			FOR A.THANG IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])
		)AS pvt		
		UPDATE #TMP5 SET [1] = NULL WHERE [1] = 0
		UPDATE #TMP5 SET [2] = NULL WHERE [2] = 0
		UPDATE #TMP5 SET [3] = NULL WHERE [3] = 0
		UPDATE #TMP5 SET [4] = NULL WHERE [4] = 0
		UPDATE #TMP5 SET [5] = NULL WHERE [5] = 0
		UPDATE #TMP5 SET [6] = NULL WHERE [6] = 0
		UPDATE #TMP5 SET [7] = NULL WHERE [7] = 0
		UPDATE #TMP5 SET [8] = NULL WHERE [8] = 0
		UPDATE #TMP5 SET [9] = NULL WHERE [9] = 0
		UPDATE #TMP5 SET [10] = NULL WHERE [10] = 0
		UPDATE #TMP5 SET [11] = NULL WHERE [11] = 0
		UPDATE #TMP5 SET [12] = NULL WHERE [12] = 0
		
		IF UPPER(@CTy) = 'TRUNGNGUYEN' 
		BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, CASE WHEN ISNULL(TEN_PT,'') = '' THEN '' ELSE TEN_PT + ' - ' END + VI_TRI AS TEN_PT, Ten_N_XUONG AS VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP5
		END
		ELSE
        BEGIN
			SELECT STT, MS_MAY, TEN_MAY, DUNG_CU_DO, TEN_PT, VI_TRI, TEN_LOAI_HIEU_CHUAN, CHU_KY, NGAY_HC_CUOI, MS_DV_TG, MS_LOAI_HIEU_CHUAN, CHU_KY_TINH, [1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12] FROM #TMP5

		END		
	END

    END

END























