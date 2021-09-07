
--DROP TABLE aaaaa_ton_kho
--exec [SP_NHU_Y_GET_XUAT_NHAP_KHO] 19, '01-01-2016','02-01-2016',0,1
ALTER PROCEDURE [dbo].[SP_NHU_Y_GET_XUAT_NHAP_KHO]
	@MS_KHO INT ,
	@TU_NGAY DATETIME ,
	@DEN_NGAY DATETIME ,
	@TYPE_LANGUAGE INT,
	@VND INT

AS
BEGIN

DECLARE @DEN_NGAY_KK DATETIME


SELECT * INTO #KIEM_KE_TMP FROM KIEM_KE
WHERE NGAY = (SELECT TOP 1 NGAY FROM KIEM_KE WHERE DATEDIFF(MINUTE,@TU_NGAY,NGAY)>0)


SELECT TOP 1 @DEN_NGAY_KK  =  NGAY FROM #KIEM_KE_TMP  WHERE (MS_KHO =  @MS_KHO OR @MS_KHO = -1) ORDER BY NGAY DESC

IF @DEN_NGAY_KK IS NULL
	SET @DEN_NGAY_KK = @DEN_NGAY


--Lấy tồn hiện tại
SELECT        D.MS_PT, SUM(D.SL_VT) AS SL_TON_HT, SUM(D.SL_VT * A.DON_GIA * CASE @VND WHEN 1 THEN A.TY_GIA ELSE A.TY_GIA_USD END) AS GIA_TRI_TON_HT
INTO #TON_HT
FROM            dbo.IC_DON_HANG_NHAP_VAT_TU AS A INNER JOIN
						dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS B ON A.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT AND A.MS_PT = B.MS_PT AND A.ID = B.ID INNER JOIN
						dbo.IC_PHU_TUNG AS C ON A.MS_PT = C.MS_PT INNER JOIN
						dbo.VI_TRI_KHO_VAT_TU AS D ON B.MS_DH_NHAP_PT = D.MS_DH_NHAP_PT AND B.MS_PT = D.MS_PT AND B.MS_VI_TRI = D.MS_VI_TRI AND B.ID = D.ID 
WHERE       (D.MS_KHO =  @MS_KHO OR @MS_KHO = -1)
GROUP BY D.MS_PT

--SELECT * INTO TON_HT FROM #TON_HT	

--Lấy số lượng xuất từ đến ngày đến hiện tại
SELECT        T5.MS_PT, SUM(T5.SL_VT) AS SL_XUAT_HT, SUM(T5.SL_VT * T2.DON_GIA * CASE @VND WHEN 1 THEN T2.TY_GIA ELSE T2.TY_GIA_USD END) AS GIA_TRI_XUAT_HT
INTO #XUAT_HT
FROM            dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT AND T1.ID = T2.ID INNER JOIN
                         dbo.IC_DON_HANG_XUAT AS T3 INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU AS T4 ON T3.MS_DH_XUAT_PT = T4.MS_DH_XUAT_PT INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T5 ON T4.MS_DH_XUAT_PT = T5.MS_DH_XUAT_PT AND T4.MS_PT = T5.MS_PT ON T1.MS_DH_NHAP_PT = T5.MS_DH_NHAP_PT AND T1.MS_PT = T5.MS_PT AND
                          T1.MS_VI_TRI = T5.MS_VI_TRI AND T1.ID = T5.ID_XUAT
WHERE         (T3.MS_KHO =  @MS_KHO OR @MS_KHO = -1) AND (T3.NGAY >= @DEN_NGAY)
GROUP BY T5.MS_PT, T2.MS_PT

--Lấy số lượng xuất trong khoảng từ ngày đến ngày kk GAN NHAT
SELECT        T3.MS_PT, SUM(T3.SL_VT) AS SL_XUAT_DNKK, SUM(T4.DON_GIA * T4.TY_GIA * T3.SL_VT) AS GIA_TRI_XUAT_DNKK
INTO #XUAT_DN_KK
FROM            dbo.IC_DON_HANG_XUAT AS T1 INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU AS T2 ON T1.MS_DH_XUAT_PT = T2.MS_DH_XUAT_PT INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T3 ON T2.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT AND T2.MS_PT = T3.MS_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T4 ON T3.MS_PT = T4.MS_PT AND T3.MS_DH_NHAP_PT = T4.MS_DH_NHAP_PT AND T3.ID_XUAT = T4.ID
WHERE        (T1.MS_KHO =  @MS_KHO OR @MS_KHO = -1) AND (T1.NGAY >= @TU_NGAY) AND (T1.NGAY < @DEN_NGAY_KK)
GROUP BY T3.MS_PT


--Lấy số lượng xuất trong khoảng từ ngày đến ngày
SELECT        T3.MS_PT, SUM(T3.SL_VT) AS SL_XUAT_TK, SUM(T4.DON_GIA * T4.TY_GIA * T3.SL_VT) AS GIA_TRI_XUAT_TK
INTO #XUAT_TK
FROM            dbo.IC_DON_HANG_XUAT AS T1 INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU AS T2 ON T1.MS_DH_XUAT_PT = T2.MS_DH_XUAT_PT INNER JOIN
                         dbo.IC_DON_HANG_XUAT_VAT_TU_CHI_TIET AS T3 ON T2.MS_DH_XUAT_PT = T3.MS_DH_XUAT_PT AND T2.MS_PT = T3.MS_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T4 ON T3.MS_PT = T4.MS_PT AND T3.MS_DH_NHAP_PT = T4.MS_DH_NHAP_PT AND T3.ID_XUAT = T4.ID
WHERE        (T1.MS_KHO =  @MS_KHO OR @MS_KHO = -1) AND (T1.NGAY >= @TU_NGAY) AND (T1.NGAY < @DEN_NGAY)
GROUP BY T3.MS_PT
--SELECT * INTO XUAT_TK FROM #XUAT_TK	

--Lấy số lượng nhập từ đến ngày đến hiện tại
SELECT        T3.MS_PT, SUM(T3.SL_VT) AS SL_NHAP_TMP, SUM(T3.SL_VT * T2.DON_GIA * CASE @VND WHEN 1 THEN T2.TY_GIA ELSE T2.TY_GIA_USD END) AS GIA_TRI_NHAP
INTO #NHAP_HT
FROM            dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T3 ON T2.MS_DH_NHAP_PT = T3.MS_DH_NHAP_PT AND T2.MS_PT = T3.MS_PT AND T2.ID = T3.ID
WHERE        (T1.MS_KHO =  @MS_KHO OR @MS_KHO = -1)  AND (T1.NGAY >= @DEN_NGAY)
GROUP BY T3.MS_PT
--SELECT * INTO NHAP_HT FROM #NHAP_HT	

--	Lấy số lượng nhập từ ngày đến ngày
SELECT DISTINCT T3.MS_PT, SUM(T3.SL_VT) AS SL_NHAP_TK, SUM(T2.DON_GIA * CASE @VND WHEN 1 THEN T2.TY_GIA ELSE T2.TY_GIA_USD END * T3.SL_VT) AS GIA_TRI_NHAP_TK
INTO #NHAP_TK
FROM            dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T3 ON T2.MS_DH_NHAP_PT = T3.MS_DH_NHAP_PT AND T2.MS_PT = T3.MS_PT AND T2.ID = T3.ID
WHERE       (T1.MS_KHO =  @MS_KHO OR @MS_KHO = -1)  AND (T1.NGAY >= @TU_NGAY) AND (T1.NGAY < @DEN_NGAY)
GROUP BY T3.MS_PT

--	Lấy số lượng nhập từ ngày đến ngày
SELECT DISTINCT T3.MS_PT, SUM(T3.SL_VT) AS SL_NHAP_DNKK, SUM(T2.DON_GIA * CASE @VND WHEN 1 THEN T2.TY_GIA ELSE T2.TY_GIA_USD END * T3.SL_VT) AS GIA_TRI_NHAP_DNKK
INTO #NHAP_DN_KK
FROM            dbo.IC_DON_HANG_NHAP AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T3 ON T2.MS_DH_NHAP_PT = T3.MS_DH_NHAP_PT AND T2.MS_PT = T3.MS_PT AND T2.ID = T3.ID
WHERE       (T1.MS_KHO =  @MS_KHO OR @MS_KHO = -1)  AND (T1.NGAY >= @TU_NGAY) AND (T1.NGAY < @DEN_NGAY_KK)
GROUP BY T3.MS_PT

--Lấy số lượng di chuyển đi từ đến ngày đến hiện tại
SELECT        T3.MS_PT, T3.MS_VI_TRI, SUM(T3.SL_CHUYEN) AS SL_CHUYEN_DI_TMP, 
                         SUM(T3.SL_CHUYEN * T2.DON_GIA * CASE @VND WHEN 1 THEN T2.TY_GIA ELSE T2.TY_GIA_USD END) AS GIA_TRI_CHUYEN_DI
INTO #DC_HT
FROM            dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT AND T1.ID = T2.ID INNER JOIN
                         dbo.DI_CHUYEN_VI_TRI_TRONG_KHO AS T3 ON T1.MS_PT = T3.MS_PT AND T1.MS_VI_TRI = T3.MS_VI_TRI AND T1.MS_DH_NHAP_PT = T3.MS_DH_NHAP_PT AND T1.ID = T3.ID_DC
WHERE        (T3.MS_KHO =  @MS_KHO OR @MS_KHO = -1) AND (T3.NGAY_CHUYEN >= @DEN_NGAY)
GROUP BY T3.MS_PT, T3.MS_VI_TRI
--SELECT * INTO DC_HT FROM #DC_HT	

--Lấy số lượng di chuyển đi từ ngày đến ngày
SELECT        T1.MS_PT, SUM(T1.SL_CHUYEN) AS SL_CHUYEN_DI, 
                         SUM(T2.DON_GIA * CASE @VND WHEN 1 THEN T2.TY_GIA ELSE T2.TY_GIA_USD END * T1.SL_CHUYEN) AS GIA_TRI_CHUYEN_DI
INTO #DC_TK
FROM            dbo.DI_CHUYEN_VI_TRI_TRONG_KHO AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT AND T1.ID_DC = T2.ID
WHERE        (T1.MS_KHO =  @MS_KHO OR @MS_KHO = -1) AND (T1.NGAY_CHUYEN >= @TU_NGAY) AND 
                         (T1.NGAY_CHUYEN < @DEN_NGAY)
GROUP BY T1.MS_PT
--SELECT * INTO DC_TK FROM #DC_TK	

--Lấy số lượng di chuyển đến từ đến ngày đến hiện tại
SELECT        T3.MS_PT, SUM(T3.SL_CHUYEN) AS SL_CHUYEN_DEN_TMP, 
                         SUM(T3.SL_CHUYEN * T2.DON_GIA * CASE @VND WHEN 1 THEN T2.TY_GIA ELSE T2.TY_GIA_USD END) AS GIA_TRI_CHUYEN_DEN
INTO #DC_D_HT
FROM            dbo.IC_DON_HANG_NHAP_VAT_TU_CHI_TIET AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT INNER JOIN
                         dbo.DI_CHUYEN_VI_TRI_TRONG_KHO AS T3 ON T1.MS_PT = T3.MS_PT AND T1.MS_VI_TRI = T3.MS_VI_TRI 
						 AND T1.MS_DH_NHAP_PT = T3.MS_DH_NHAP_PT AND T1.ID = T3.ID_DC
WHERE      (T3.MS_KHO_1 =  @MS_KHO OR @MS_KHO = -1) AND (T3.NGAY_CHUYEN >= @DEN_NGAY)
GROUP BY T3.MS_PT
--SELECT * INTO DC_D_HT FROM #DC_D_HT	

--Lấy số lượng di chuyển đến từ ngày đến ngày
SELECT        T1.MS_PT, SUM(T1.SL_CHUYEN) AS SL_CHUYEN_DEN, 
                         SUM(T2.DON_GIA * CASE @VND WHEN 1 THEN T2.TY_GIA ELSE T2.TY_GIA_USD END * T1.SL_CHUYEN) AS GIA_TRI_CHUYEN_DEN
INTO #DC_D_TK
FROM            dbo.DI_CHUYEN_VI_TRI_TRONG_KHO AS T1 INNER JOIN
                         dbo.IC_DON_HANG_NHAP_VAT_TU AS T2 ON T1.MS_DH_NHAP_PT = T2.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT AND T1.ID_DC = T2.ID
WHERE        (T1.MS_KHO_1 =  @MS_KHO OR @MS_KHO = -1) AND (T1.NGAY_CHUYEN >= @TU_NGAY) AND 
                         (T1.NGAY_CHUYEN < @DEN_NGAY)
GROUP BY T1.MS_PT
--SELECT * INTO DC_D_TK FROM #DC_D_TK	


	--Tính chênh lệch kiểm kê từ đến ngày GAN NHAT VOI TU NGAY
	SELECT     B.MS_PT, SUM(B.SL_KK_CT-B.SL_CHUNG_TU)  AS CHENH_LECH_KIEM_KE_TMP_HT, 
		SUM(B.SL_KK_CT) AS SL_KK,
		ABS(SUM((B.SL_KK_CT) * CASE @VND WHEN 1 THEN A.TY_GIA  ELSE A.TY_GIA_USD END * A.DON_GIA)) AS GT_KK,
		ABS(SUM((B.SL_CHUNG_TU - B.SL_KK_CT) * CASE @VND WHEN 1 THEN A.TY_GIA  ELSE A.TY_GIA_USD END * A.DON_GIA)) AS GIA_TRI_CHENH_LECH_KK_HT
	INTO #CL_KK_GN
	FROM         dbo.IC_DON_HANG_NHAP_VAT_TU A INNER JOIN
						  dbo.KIEM_KE_VAT_TU_CHI_TIET B ON A.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT AND 
						  A.MS_PT = B.MS_PT AND A.ID = B.ID_KK
						  INNER JOIN #KIEM_KE_TMP T ON T.NGAY = B.NGAY AND T.MS_KHO = B.MS_KHO                           
	WHERE     	(T.MS_KHO =  @MS_KHO OR @MS_KHO = -1)
	GROUP BY B.MS_PT

--Tính chênh lệch kiểm kê TRONG KHOANG
	SELECT     B.MS_PT, SUM(B.SL_KK_CT-B.SL_CHUNG_TU )  AS CHENH_LECH_KIEM_KE_TK, 
		ABS(SUM((B.SL_CHUNG_TU - B.SL_KK_CT) * CASE @VND WHEN 1 THEN dbo.IC_DON_HANG_NHAP_VAT_TU.TY_GIA  ELSE dbo.IC_DON_HANG_NHAP_VAT_TU.TY_GIA_USD END * dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA)) AS GIA_TRI_CHENH_LECH_KK_TK
	INTO #CL_KK_TK
	FROM         dbo.IC_DON_HANG_NHAP_VAT_TU INNER JOIN
						  dbo.KIEM_KE_VAT_TU_CHI_TIET B ON dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT = B.MS_DH_NHAP_PT AND 
						  dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT = B.MS_PT AND dbo.IC_DON_HANG_NHAP_VAT_TU.ID = B.ID_KK
	WHERE     	(NGAY > @TU_NGAY AND  NGAY <=@DEN_NGAY)
	AND 	(B.MS_KHO =  @MS_KHO OR @MS_KHO = -1)
		GROUP BY B.MS_PT

	--DROP TABLE aaaaa_ton_kho
	  --exec [SP_NHU_Y_GET_XUAT_NHAP_KHO] -1, '01-01-2016','01-31-2016',0,1
	  --exec [SP_NHU_Y_GET_XUAT_NHAP_KHO] 18, '05-01-2016','05-30-2016',0,1
	  --exec [SP_NHU_Y_GET_XUAT_NHAP_KHO] 18, '05-30-2016','06-30-2016',0,1
	SELECT  [No] ,
	         MS_PT, TEN_PT,LOAI_VAT_TU, --QUY_CACH,
	         TEN_DVT  , 
			 round(GIA_TRI_TON_DAU,2)  as GIA_TRI_TON_DAU_THANG ,
			 SL_TON_DAU_THANG AS SL_TON_DAU_THANG,
			(SL_NHAP ) AS SL_NHAP, (GIA_TRI_NHAP ) AS GIA_TRI_NHAP,

            (SL_XUAT ) AS SL_XUAT,(GIA_TRI_XUAT) AS GIA_TRI_XUAT,
	         
			 SL_TON_DAU_THANG + SL_NHAP - SL_XUAT  AS SL_TON_HT , 
			 round(GIA_TRI_TON_DAU  + GIA_TRI_NHAP -GIA_TRI_XUAT ,2) as GIA_TRI_TON_HT
			 ,CO_KK, SL_KK,
			 A,B,C,D,E,
			 AA,BB,CC,DD,EE,FF,
			 AAA,BBB,CCC,DDD,EEE,
			 CO_KK

			 --GT_DUONG,GT_AM
	   --      ,KK_AM,KK_DUONG,CHENH_LECH_KIEM_KE_TMP_HT,SL_TON_DAU_THANG,SL_TON_HT,CHENH_LECH_KIEM_KE_TK,
			 --GT_KK ,  GIA_TRI_CHUYEN_DI , GIA_TRI_NHAP_TK , GIA_TRI_CHUYEN_DEN ,  CO_KK	,GIA_TRI_CHENH_LECH_KK_HT
--INTO aaaaa_ton_kho
	FROM 
	(
	SELECT DISTINCT ROW_NUMBER() OVER (ORDER BY LOAI_VAT_TU, MS_PT) AS [No],MS_CLASS,MS_PT, TEN_PT,LOAI_VAT_TU,MS_LOAI_VT, QUY_CACH, TEN_DVT , 
	--CASE WHEN ISNULL(CO_KK,0) = 0 THEN GIA_TRI_TON_HT + GIA_TRI_XUAT + GIA_TRI_CHUYEN_DI - GIA_TRI_NHAP_TK - GIA_TRI_CHUYEN_DEN  
	--	ELSE GT_KK + GIA_TRI_XUAT + GIA_TRI_CHUYEN_DI - GIA_TRI_NHAP_TK - GIA_TRI_CHUYEN_DEN   - 
	--	CASE WHEN CHENH_LECH_KIEM_KE_TMP_HT < 0 THEN - GIA_TRI_CHENH_LECH_KK_HT	ELSE CHENH_LECH_KIEM_KE_TMP_HT END END AS GIA_TRI_TON_DAU,

	CASE WHEN ISNULL(CO_KK,0) = 0 THEN GIA_TRI_TON_HT + GIA_TRI_XUAT_DNKK + GIA_TRI_CHUYEN_DI - GIA_TRI_NHAP_DNKK - GIA_TRI_CHUYEN_DEN  
		ELSE GT_KK + GIA_TRI_XUAT_DNKK + GIA_TRI_CHUYEN_DI - GIA_TRI_NHAP_DNKK - GIA_TRI_CHUYEN_DEN   - 
		CASE WHEN CHENH_LECH_KIEM_KE_TMP_HT < 0 THEN - GIA_TRI_CHENH_LECH_KK_HT	ELSE CHENH_LECH_KIEM_KE_TMP_HT END END AS GIA_TRI_TON_DAU,

	--CASE WHEN ISNULL(CO_KK,0) = 0 THEN SL_TON_HT + SL_XUAT_TK + SL_CHUYEN_DI - SL_NHAP_TK - SL_CHUYEN_DEN 
	--	ELSE SL_KK + SL_XUAT_TK + SL_CHUYEN_DI - SL_NHAP_TK - SL_CHUYEN_DEN -CHENH_LECH_KIEM_KE_TMP_HT	END AS SL_TON_DAU_THANG,

	CASE WHEN ISNULL(CO_KK,0) = 0 THEN SL_TON_HT + SL_XUAT_DNKK + SL_CHUYEN_DI - SL_NHAP_DNKK - SL_CHUYEN_DEN 
		ELSE SL_KK - SL_NHAP_DNKK - SL_CHUYEN_DEN + SL_XUAT_DNKK + SL_CHUYEN_DI - CHENH_LECH_KIEM_KE_TMP_HT 	END AS SL_TON_DAU_THANG,


	ABS(SL_NHAP_TK + SL_CHUYEN_DEN  +	CASE  WHEN CHENH_LECH_KIEM_KE_TK > 0  THEN  CHENH_LECH_KIEM_KE_TK ELSE 0 END	) AS SL_NHAP,

	(GIA_TRI_NHAP_TK + GIA_TRI_CHUYEN_DEN +	CASE  WHEN CHENH_LECH_KIEM_KE_TK > 0  THEN  GIA_TRI_CHENH_LECH_KK_TK ELSE 0 END	 ) AS GIA_TRI_NHAP,

	ABS(SL_XUAT_TK + SL_CHUYEN_DI  +	CASE WHEN CHENH_LECH_KIEM_KE_TK < 0 THEN - CHENH_LECH_KIEM_KE_TK ELSE 0 END) AS SL_XUAT,

	(GIA_TRI_XUAT + GIA_TRI_CHUYEN_DI +	CASE WHEN CHENH_LECH_KIEM_KE_TK < 0 THEN  GIA_TRI_CHENH_LECH_KK_TK ELSE 0 END) AS GIA_TRI_XUAT,
	(SL_CHUYEN_DEN-SL_CHUYEN_DI) AS MOVED,
	(GIA_TRI_CHUYEN_DEN - GIA_TRI_CHUYEN_DI) as MOVE_AMOUNT,
	SL_TON_HT + CHENH_LECH_KIEM_KE_TK AS	  SL_TON_HT,
	GIA_TRI_TON_HT,
	--KK_DUONG,	KK_AM,GT_DUONG,GT_AM,
	CHENH_LECH_KIEM_KE_TMP_HT,GIA_TRI_CHENH_LECH_KK_HT,CHENH_LECH_KIEM_KE_TK,
	GT_KK ,  GIA_TRI_CHUYEN_DI , GIA_TRI_NHAP_TK , GIA_TRI_CHUYEN_DEN   ,CO_KK,SL_KK,
	
		SL_TON_HT A, SL_XUAT_TK B, SL_CHUYEN_DI C, SL_NHAP_TK D, SL_CHUYEN_DEN E,
		SL_KK AA, SL_XUAT_TK BB, SL_CHUYEN_DI CC, SL_NHAP_TK DD, SL_CHUYEN_DEN EE, CHENH_LECH_KIEM_KE_TMP_HT FF,
		SL_TON_HT AAA, SL_XUAT_DNKK BBB, SL_CHUYEN_DI CCC, SL_NHAP_DNKK DDD, SL_CHUYEN_DEN EEE

	FROM
	( 
	SELECT  DISTINCT  A.MS_CLASS, A.MS_PT, A.TEN_PT,A.QUY_CACH,A.MS_LOAI_VT, CASE @TYPE_LANGUAGE WHEN 0 THEN B.TEN_1 ELSE B.TEN_2 END AS TEN_DVT,
	CASE @TYPE_LANGUAGE WHEN 0 THEN LOAI_VT.TEN_LOAI_VT_TV ELSE LOAI_VT.TEN_LOAI_VT_TA END AS LOAI_VAT_TU,

	--d hien tai E LA TK
	ISNULL(D.SL_XUAT_HT,0) AS SL_XUAT_HT ,ISNULL(D.GIA_TRI_XUAT_HT,0) AS GIA_TRI_XUAT_HT ,

	ISNULL(E.SL_XUAT_TK,0) AS SL_XUAT_TK ,	ISNULL(E.GIA_TRI_XUAT_TK,0)AS GIA_TRI_XUAT ,
	  
	ISNULL(F.SL_NHAP_TMP,0) AS SL_NHAP_TMP ,	ISNULL(F.GIA_TRI_NHAP,0) AS GIA_TRI_NHAP_TMP ,
	ISNULL( G.SL_NHAP_TK,0) AS SL_NHAP_TK , 	ISNULL( G.GIA_TRI_NHAP_TK,0) AS GIA_TRI_NHAP_TK , 

	ISNULL(H.SL_CHUYEN_DI_TMP,0) AS SL_CHUYEN_DI_TMP  ,	ISNULL(H.GIA_TRI_CHUYEN_DI,0) AS GIA_TRI_CHUYEN_DI_TMP  ,
	ISNULL( I.SL_CHUYEN_DI,0) AS SL_CHUYEN_DI , ISNULL( I.GIA_TRI_CHUYEN_DI,0) AS GIA_TRI_CHUYEN_DI ,

	ISNULL( J.SL_CHUYEN_DEN_TMP,0) AS SL_CHUYEN_DEN_TMP ,	ISNULL( J.GIA_TRI_CHUYEN_DEN,0) AS GIA_TRI_CHUYEN_DEN_TMP,
	ISNULL( K.SL_CHUYEN_DEN,0) AS SL_CHUYEN_DEN ,	ISNULL( K.GIA_TRI_CHUYEN_DEN,0) AS GIA_TRI_CHUYEN_DEN ,

	ISNULL(L.CHENH_LECH_KIEM_KE_TMP_HT,0) AS CHENH_LECH_KIEM_KE_TMP_HT  ,	ISNULL(L.GIA_TRI_CHENH_LECH_KK_HT,0) AS GIA_TRI_CHENH_LECH_KK_HT  ,
	--ISNULL(M.KK_DUONG,0) AS KK_DUONG,	ISNULL(M.KK_AM,0) AS KK_AM ,
	--ISNULL(M.GT_DUONG,0) AS GT_DUONG,	ISNULL(M.GT_AM,0) AS GT_AM,
	ISNULL(T1.CHENH_LECH_KIEM_KE_TK,0) AS CHENH_LECH_KIEM_KE_TK,ISNULL(T1.GIA_TRI_CHENH_LECH_KK_TK,0) AS GIA_TRI_CHENH_LECH_KK_TK,
	ISNULL(L.SL_KK,0) AS SL_KK,	ISNULL(L.GT_KK,0) AS GT_KK,
	ISNULL(C.SL_TON_HT,0)  - ISNULL(F.SL_NHAP_TMP,0)  + ISNULL(D.SL_XUAT_HT,0) AS SL_TON_HT, 
	ISNULL(C.GIA_TRI_TON_HT,0) - ISNULL(F.GIA_TRI_NHAP,0) + ISNULL(D.GIA_TRI_XUAT_HT,0) AS GIA_TRI_TON_HT , 
	CASE ISNULL(L.MS_PT,'') WHEN '' THEN 0 ELSE 1 END AS CO_KK,
	ISNULL(M.SL_XUAT_DNKK,0) AS SL_XUAT_DNKK,	ISNULL(M.GIA_TRI_XUAT_DNKK,0) AS GIA_TRI_XUAT_DNKK,
	ISNULL(O.SL_NHAP_DNKK,0) AS SL_NHAP_DNKK,	ISNULL(O.GIA_TRI_NHAP_DNKK,0) AS GIA_TRI_NHAP_DNKK
	
	FROM         
	--Lấy tồn hiện tại
	#TON_HT C LEFT OUTER JOIN dbo.IC_PHU_TUNG A ON C.MS_PT = A.MS_PT 
	 INNER JOIN dbo.DON_VI_TINH B ON A.DVT = B.DVT
	 INNER JOIN LOAI_VT ON A.MS_LOAI_VT=LOAI_VT.MS_LOAI_VT 	 
	 --Lấy số lượng xuất từ đến ngày đến hiện tại
	LEFT OUTER JOIN #XUAT_HT D	ON C.MS_PT = D.MS_PT 
	--Lấy số lượng xuất trong khoảng từ ngày đến ngày
	LEFT OUTER JOIN #XUAT_TK E ON C.MS_PT = E.MS_PT
	--Lấy số lượng nhập từ đến ngày đến hiện tại
	LEFT OUTER JOIN #NHAP_HT F ON C.MS_PT = F.MS_PT 
	--	Lấy số lượng nhập từ ngày đến ngày
	LEFT OUTER JOIN #NHAP_TK G	ON C.MS_PT = G.MS_PT 
	--Lấy số lượng di chuyển đi từ đến ngày đến hiện tại
	LEFT OUTER JOIN #DC_HT H ON C.MS_PT = H.MS_PT 
	--Lấy số lượng di chuyển đi từ ngày đến ngày
	LEFT OUTER JOIN #DC_TK I ON C.MS_PT = I.MS_PT 
	--Lấy số lượng di chuyển đến từ đến ngày đến hiện tại
	LEFT OUTER JOIN #DC_D_HT J	ON C.MS_PT = J.MS_PT 
	--Lấy số lượng di chuyển đến từ ngày đến ngày
	LEFT OUTER JOIN #DC_D_TK K ON C.MS_PT = K.MS_PT 
	--Tính chênh lệch kiểm kê từ đến ngày GAN NHAT VOI TU NGAY
	LEFT OUTER JOIN #CL_KK_GN L ON C.MS_PT = L.MS_PT 
	--Tính chênh lệch kiểm kê TRONG KHOANG
	LEFT OUTER JOIN #CL_KK_TK T1 ON C.MS_PT = T1.MS_PT 
	----Lấy số lượng xuất từ đến ngày kk
	LEFT OUTER JOIN #XUAT_DN_KK M	ON C.MS_PT = M.MS_PT 
	----Lấy số lượng NHAP từ đến ngày kk
	LEFT OUTER JOIN #NHAP_DN_KK O	ON C.MS_PT = O.MS_PT 

	INNER JOIN dbo.LOAI_VT N ON A.MS_LOAI_VT = N.MS_LOAI_VT

	) THONGKE 
)TEMP 


--SELECT * FROM aaaaa_ton_kho 
ORDER BY LOAI_VAT_TU, MS_PT


END
