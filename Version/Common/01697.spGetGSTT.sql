--	exec [spGetGSTT] 'cha11',0,'03/06/2019','03/06/2020',-1, -1,-1,'-1',-1
ALTER PROCEDURE [dbo].[spGetGSTT] 
	@USERNAME VARCHAR(64)= 'admin', 
	@LANGUAGE INT = 0, 
	@TU_NGAY DATETIME ='10/10/2019', 
	@DEN_NGAY DATETIME ='10/18/2020', 
	@MS_NHA_XUONG VARCHAR(50)='-1', 
	@MS_HE_THONG INT=-1, 
	@MS_LOAI_MAY VARCHAR(30) ='-1', 
	@MS_MAY VARCHAR(30) ='AIC-0002', 
	@MS_LOAI_CV INT ='-1'
AS BEGIN
	SET FMTONLY OFF;

	DECLARE @CTY NVARCHAR(50)
SELECT @CTY = [PRIVATE] FROM THONG_TIN_CHUNG

	SELECT	MS_MAY,TEN_MAY,MS_N_XUONG	INTO	#MAY_USER
	FROM	[dbo].[MGetMayUserNgay](@DEN_NGAY, @USERNAME, @MS_NHA_XUONG, @MS_HE_THONG, -1, @MS_LOAI_MAY, '-1', @MS_MAY, @LANGUAGE);

	SELECT T2.*,dbo.MGetGiaTriThongSoGSTT(T2.MS_TS_GSTT) AS TEN_GT_GSTT,T1.MS_N_XUONG INTO #HC FROM dbo.MGetHieuChuanKeGSTT(@TU_NGAY, @DEN_NGAY, @USERNAME, @MS_NHA_XUONG, @MS_HE_THONG, -1, @MS_LOAI_MAY, '-1', @MS_LOAI_CV, 1, @LANGUAGE) T2 INNER JOIN #MAY_USER T1 ON T1.MS_MAY = T2.MS_MAY INNER JOIN dbo.THONG_SO_GSTT T3 ON T3.MS_TS_GSTT = T2.MS_TS_GSTT
	WHERE (CONVERT(DATE, T2.NGAY_KE) BETWEEN CONVERT(DATE, @TU_NGAY) AND CONVERT(DATE, @DEN_NGAY)) 


	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY TEMP.MS_MAY) AS STT, TEMP.MS_MAY, TEMP.TEN_MAY,
		CASE @CTY WHEN N'REMINGTON' THEN TEMP.TEN_BO_PHAN  ELSE (
		SELECT	TOP 1 MS_BO_PHAN + ' - ' +	ISNULL(TEN_BO_PHAN, '')
			FROM	CAU_TRUC_THIET_BI
			WHERE MS_BO_PHAN=
			(
			SELECT	TOP 1		CASE WHEN ISNULL(MS_BO_PHAN_CHA, '')=MS_MAY THEN MS_BO_PHAN ELSE MS_BO_PHAN_CHA END
				FROM	CAU_TRUC_THIET_BI
				WHERE MS_BO_PHAN=TEMP.MS_BO_PHAN AND MS_MAY=TEMP.MS_MAY
			)			AND MS_MAY=TEMP.MS_MAY
		)+' - '+
		TEMP.TEN_BO_PHAN END  AS TEN_BO_PHAN, TEMP.TEN_TS_GSTT, TEMP.CHU_KY_DO, TEMP.NGAY_KT_CUOI, TEMP.TEN_GIA_TRI, ISNULL(TEMP.DAT, 0) DAT, MIN(TEMP.NGAY_KT_KE) AS NGAY_KT_KE,  TEN_GT_GSTT, STT_BP, CACH_THUC_HIEN, THOI_GIAN,@MS_NHA_XUONG AS MS_NHA_XUONG, @MS_HE_THONG AS MS_HE_THONG, @MS_LOAI_MAY AS MS_LOAI_MAY, @MS_MAY AS MS_MAY_FIL, 	@MS_LOAI_CV AS MS_LOAI_CV, @TU_NGAY AS TNGAY, @DEN_NGAY AS DNGAY,TEMP.MS_TS_GSTT
	FROM
	(
	SELECT	DISTINCT	T1.MS_MAY, T2.TEN_MAY, T1.MS_BO_PHAN+' - '+CASE @LANGUAGE WHEN 0 THEN T3.TEN_BO_PHAN
WHEN 1 THEN ISNULL(NULLIF(T3.TEN_BO_PHAN_ANH, ''), T3.TEN_BO_PHAN)ELSE ISNULL(NULLIF(T3.TEN_BO_PHAN_HOA, ''), T3.TEN_BO_PHAN)END AS TEN_BO_PHAN, T2.TEN_TS_GSTT,   CONVERT(NVARCHAR(10), T1.CHU_KY_DO) + ' ' + T2.TEN_DV_TG AS CHU_KY_DO , T2.NGAY_CUOI AS NGAY_KT_CUOI, dbo.MGetLisTGSTTThongSo(T2.STT_CUOI, T1.MS_MAY, T1.MS_TS_GSTT,
                                        T1.MS_BO_PHAN, T1.MS_TT) AS TEN_GIA_TRI , 
										0 AS DAT, 
										--T1.DAT,
										T2.NGAY_KE AS NGAY_KT_KE, 

T2.MS_N_XUONG, T1.MS_TS_GSTT, T1.MS_BO_PHAN, T3.STT AS STT_BP, T1.CACH_THUC_HIEN, T1.THOI_GIAN,T2.TEN_GT_GSTT
		FROM	dbo.CAU_TRUC_THIET_BI_TS_GSTT T1
					INNER JOIN #HC T2 ON T2.MS_MAY=T1.MS_MAY AND T2.MS_BO_PHAN=T1.MS_BO_PHAN AND T2.MS_TS_GSTT=T1.MS_TS_GSTT AND T2.MS_TT=T1.MS_TT
					INNER JOIN dbo.CAU_TRUC_THIET_BI T3 ON T3.MS_MAY=T1.MS_MAY AND T3.MS_BO_PHAN=T1.MS_BO_PHAN
		WHERE T1.ACTIVE=1 
	) TEMP
	GROUP BY TEMP.MS_MAY, TEMP.TEN_MAY, TEMP.TEN_BO_PHAN, TEMP.TEN_TS_GSTT, TEMP.MS_BO_PHAN, TEMP.CHU_KY_DO, TEMP.NGAY_KT_CUOI, TEMP.TEN_GIA_TRI, 
	TEMP.DAT, 
	TEMP.MS_TS_GSTT, TEMP.STT_BP, TEMP.CACH_THUC_HIEN, TEMP.THOI_GIAN,TEMP.TEN_GT_GSTT
	ORDER BY STT;
END;
