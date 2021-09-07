

 --EXEC spBaoCaoHieuChuanKiemDinhKeHoach '2018', 'admin', '-1', -1, 'WEI', 0,0
ALTER PROC [dbo].[spBaoCaoHieuChuanKiemDinhKeHoach]
	@NAM NVARCHAR(5),
	@USERNAME NVARCHAR(50),
	@MsNXuong nvarchar(50),
	@NHeThong int,
	@LoaiMay NVARCHAR(20),
	@LoaiBC INT,
	@NNgu INT
AS
--LOAIBT 0: TẤT CẢ
--LOAIBT 1: HIỆU CHUẨN MÁY
--LOAIBT 2: HIỆU CHUẨN DHD
BEGIN

--@NgayHT DATETIME,
--	@UserName NVARCHAR(50),
--	@MsNXuong nvarchar(50),
--	@MsHeThong int,
--	@MsBPCPhi int,
--	@MsLoaiMay NVARCHAR (20),
--	@NhomMay NVARCHAR (20),
--	@MSMay NVARCHAR (100),
--	@NNgu int



	DECLARE @tNgay AS NVARCHAR(15) = '01/01/' + @NAM
	DECLARE @dNgay AS NVARCHAR(15) = '12/31/' + @NAM

	DECLARE @NgayHT DATETIME
	SET @NgayHT = GETDATE()
	SELECT A.* INTO #MAY FROM dbo.MGetMayUserNgay(@NgayHT,@USERNAME,@MsNXuong,@NHeThong,-1,@LoaiMay,'-1','-1', @NNgu) A 


	IF(@LoaiBC = 0)
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP FROM (
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 1) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 1 as MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH  FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKeMay](@tNgay,@dNgay,11,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			----WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay)  

			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 2) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 2 as MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH  FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKeMay](@tNgay,@dNgay,12,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY

			--WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) 

			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 3) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 3 as MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH  FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKeMay](@tNgay,@dNgay,13,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			--WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) 

			UNION

			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 1) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 1 as MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH  FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKePhuTung](@tNgay,@dNgay,11,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			--INNER JOIN HIEU_CHUAN_DHD T1 ON T.MS_MAY = T1.MS_MAY AND T.MS_PT = T1.MS_PT AND T.MS_VI_TRI = T1.MS_VI_TRI  and Year(T1.Ngay) = @NAM
			--WHERE YEAR(T.NGAY_KE) = YEAR(@dNgay) 

			UNION

			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 2) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 2 as MS_LOAI_HIEU_CHUAN, T.CHU_KY AS CHU_KY_TINH  FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKePhuTung](@tNgay,@dNgay,12,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 3) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				,T.NGAY_HC_CUOI, T.NGAY_KE,convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 3 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKePhuTung](@tNgay,@dNgay,13,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 4) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 4 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKePhuTung](@tNgay,@dNgay,14,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
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
	END
	ELSE IF(@LoaiBC = 1)	
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP1 FROM (
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 1) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 1 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKeMay](@tNgay,@dNgay,11,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 2) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 2 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKeMay](@tNgay,@dNgay,12,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, '' AS DUNG_CU_DO, '' AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 3) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 3 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKeMay](@tNgay,@dNgay,13,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
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
		SELECT * FROM #TMP1 					
		

	END
	ELSE IF(@LoaiBC = 2)	
	BEGIN
		SELECT IDENTITY(int, 1,1) as STT, pvt.* into #TMP2 FROM (
			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 1) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 1 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKePhuTung](@tNgay,@dNgay,11,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 2) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 2 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKePhuTung](@tNgay,@dNgay,12,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			UNION

			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 3) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 3 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKePhuTung](@tNgay,@dNgay,13,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
			UNION
			SELECT  T.MS_MAY, T2.TEN_MAY, T.MS_PT AS DUNG_CU_DO, T.MS_VI_TRI AS VI_TRI, (SELECT TEN_LOAI_HIEU_CHUAN FROM LOAI_HIEU_CHUAN WHERE MS_LOAI_HIEU_CHUAN = 4) AS TEN_LOAI_HIEU_CHUAN, 
				CONVERT(NVARCHAR(500), CONVERT(NVARCHAR(10),T.CHU_KY) + ' ' + CASE @NNgu WHEN 0 THEN T1.TEN_DV_TG WHEN 1 THEN T1.TEN_DV_TG_ANH ELSE T1.TEN_DV_TG_HOA END) AS CHU_KY
				, T.NGAY_HC_CUOI, T.NGAY_KE, convert(NVARCHAR(5), month(T.NGAY_KE)) AS THANG, T.MS_DV_TG, 4 as MS_LOAI_HIEU_CHUAN , T.CHU_KY AS CHU_KY_TINH FROM (
			SELECT * FROM [dbo].[MGetNgayHieuChuanKePhuTung](@tNgay,@dNgay,14,@USERNAME,@MsNXuong,@NHeThong,@LoaiMay,'-1',1) 
			) T LEFT JOIN DON_VI_THOI_GIAN T1 ON T.MS_DV_TG = T1.MS_DV_TG
			INNER JOIN #MAY T2 ON T.MS_MAY = T2.MS_MAY 
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
		SELECT * FROM #TMP2 
	END

END























