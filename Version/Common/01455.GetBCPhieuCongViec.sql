--SELECT * FROM PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET ORDER BY NGAY DESC

ALTER PROC [dbo].[GetBCPhieuCongViec]
	@TNgay datetime = '11/01/2018',
	@DNgay datetime = '11/28/2018',
	@MSNX NVARCHAR(150) = '-1',
	@MSHT INT = -1,
	@MsNV NVARCHAR(50) =  '003364', --'100313', --1413  --1119
	@USERNAME NVARCHAR(50) = 'ADMIN',
	@NNgu int = 1, 
	@NVIEN BIT = 1, --Công việc văn phòng
	@CVHN NVARCHAR(500) = N'Công việc văn phòng',
	@BTNS NVARCHAR(500) = N'Bao tri theo phieu'
AS

SELECT * INTO #MAY_TB FROM [dbo].[MGetMayUserNgay]( @DNgay,@USERNAME,@MSNX,@MSHT,-1,'-1','-1','-1',@NNgu)

DECLARE @DTNGAY TABLE (NGAY DATETIME)
INSERT  @DTNGAY  (NGAY)
SELECT DATEADD(DAY, NUMBER, @TNgay) AS NGAY 
FROM 
    (SELECT DISTINCT NUMBER FROM MASTER.DBO.SPT_VALUES
     WHERE NAME IS NULL
    ) N
WHERE DATEADD(DAY, NUMBER, @TNgay) <= @DNgay

Set @TNgay = CONVERT(DATETIME, @TNgay +  ' 00:00:00' )
Set @DNgay = CONVERT(DATETIME, @DNgay + ' 23:59:59')


SELECT DISTINCT NGAY_MIN INTO #NGAY FROM
(
	SELECT DISTINCT MIN(NGAY) AS NGAY_MIN FROM dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET 
	WHERE (MS_CONG_NHAN = @MsNV)
	GROUP BY MS_PHIEU_BAO_TRI, MS_CV, MS_BO_PHAN HAVING (MIN(NGAY) BETWEEN @TNgay AND @DNgay) 
	UNION
	SELECT DISTINCT MIN(NGAY) AS NGAY_MIN FROM dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO 
	WHERE (MS_CONG_NHAN = @MsNV)
	GROUP BY MS_PHIEU_BAO_TRI,STT,ID_STT HAVING (MIN(NGAY) BETWEEN @TNgay AND @DNgay) 
	UNION
--Lay ngay tu PBTNS
	SELECT DISTINCT MIN(NGAY) AS NGAY_MIN FROM dbo.PHIEU_BAO_TRI_NHAN_SU 
	WHERE  (MS_CONG_NHAN = @MsNV)
	GROUP BY STT HAVING (MIN(NGAY) BETWEEN @TNgay AND @DNgay) 
	UNION
--Lay ngay tu GSTT
	SELECT DISTINCT MIN(NGAY_KT) AS NGAY_MIN FROM dbo.GIAM_SAT_TINH_TRANG 
	WHERE  (MS_CONG_NHAN = @MsNV)
	GROUP BY STT HAVING (MIN(NGAY_KT) BETWEEN @TNgay AND @DNgay) 
) A 

IF @NVIEN = 1 -- Xoa cac ngay da ton tai trong PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET+KE_HOACH_THUC_HIEN	khi co check Công việc văn phòng
	BEGIN
		DELETE FROM @DTNGAY  WHERE NGAY IN ( 
						SELECT DISTINCT NGAY_MIN FROM #NGAY
						UNION 
						SELECT DISTINCT NGAY FROM dbo.KE_HOACH_THUC_HIEN WHERE (NGAY BETWEEN @TNgay AND @DNgay) AND (MS_CONG_NHAN = @MsNV))	
	END

ELSE -- Xoa cac ngay da ton tai PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET
	BEGIN
		DELETE FROM @DTNGAY  WHERE NGAY IN (SELECT DISTINCT NGAY_MIN FROM #NGAY)
	
	END 
	


SELECT MIN(T4.NGAY) AS NGAY_WHERE, CONVERT(INT, NULL) AS STT, 
			CASE @NNgu WHEN 0 THEN  CV.MO_TA_CV WHEN 1 THEN ISNULL(CV.MO_TA_CV_ANH,MO_TA_CV) ELSE MO_TA_CV_HOA END AS MO_TA_CV, 
			CASE ISNULL(HU_HONG,0) WHEN 0 THEN 'X' ELSE NULL END AS BT_KH,
			SUM(T4.TONG_GIO_KH) SO_PHUT_KH,
			SUM(T4.SO_GIO) SO_PHUT_TT,
			(T5.MS_BO_PHAN + ' - ' + CASE @NNgu WHEN 0 THEN  T5.TEN_BO_PHAN WHEN 1 THEN ISNULL(T5.TEN_BO_PHAN_ANH,T5.TEN_BO_PHAN) ELSE T5.TEN_BO_PHAN_HOA END) AS TEN_BO_PHAN, T2.MS_MAY, T1.TEN_MAY, T2.TT_SAU_BT AS DANH_GIA, T4.MS_PHIEU_BAO_TRI, 
			CASE @NNgu WHEN 0 THEN T7.TEN_TINH_TRANG WHEN 1 THEN T7.TEN_TINH_TRANG_ANH ELSE T7.TEN_TINH_TRANG_HOA END AS TEN_TINH_TRANG	,T2.LY_DO_BT
INTO #PBT_TMP
FROM          #MAY_TB AS T1 INNER JOIN
                        dbo.PHIEU_BAO_TRI AS T2 ON T1.MS_MAY = T2.MS_MAY INNER JOIN
                        dbo.PHIEU_BAO_TRI_CONG_VIEC AS T3 ON T2.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI INNER JOIN
                        dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET AS T4 INNER JOIN
                        dbo.CONG_VIEC AS CV ON T4.MS_CV = CV.MS_CV  ON 
                        T3.MS_PHIEU_BAO_TRI = T4.MS_PHIEU_BAO_TRI AND T3.MS_CV = T4.MS_CV AND T3.MS_BO_PHAN = T4.MS_BO_PHAN INNER JOIN
                        dbo.CAU_TRUC_THIET_BI T5 ON T1.MS_MAY = T5.MS_MAY AND T3.MS_BO_PHAN = T5.MS_BO_PHAN INNER JOIN 
						LOAI_BAO_TRI T6 ON T2.MS_LOAI_BT = T6.MS_LOAI_BT INNER JOIN TINH_TRANG_PBT T7 ON T2.TINH_TRANG_PBT = T7.STT
WHERE      (T4.MS_CONG_NHAN = @MsNV)
GROUP BY T4.MS_PHIEU_BAO_TRI, CASE @NNgu WHEN 0 THEN  CV.MO_TA_CV WHEN 1 THEN ISNULL(CV.MO_TA_CV_ANH,MO_TA_CV) ELSE MO_TA_CV_HOA END, 
T2.MS_MAY, T1.TEN_MAY, T2.TT_SAU_BT, CASE @NNgu WHEN 0 THEN  T5.TEN_BO_PHAN WHEN 1 THEN ISNULL(T5.TEN_BO_PHAN_ANH,T5.TEN_BO_PHAN) ELSE T5.TEN_BO_PHAN_HOA END,HU_HONG, 
CASE @NNgu WHEN 0 THEN T7.TEN_TINH_TRANG WHEN 1 THEN T7.TEN_TINH_TRANG_ANH ELSE T7.TEN_TINH_TRANG_HOA END , T5.MS_BO_PHAN,T2.LY_DO_BT
HAVING (MIN(T4.NGAY) BETWEEN @TNgay AND @DNgay) 
UNION
SELECT MIN(T4.NGAY) AS NGAY_WHERE, CONVERT(INT, NULL) AS STT, 
			T3.TEN_CONG_VIEC AS MO_TA_CV, 
			CASE ISNULL(HU_HONG,0) WHEN 0 THEN 'X' ELSE NULL END AS BT_KH,
			SUM(T4.TONG_GIO_KH) SO_PHUT_KH,
			SUM(T4.SO_GIO) SO_PHUT_TT,
			

			NULL AS TEN_BO_PHAN, T2.MS_MAY, T1.TEN_MAY, T2.TT_SAU_BT AS DANH_GIA, T4.MS_PHIEU_BAO_TRI, 
			CASE @NNgu WHEN 0 THEN T7.TEN_TINH_TRANG WHEN 1 THEN T7.TEN_TINH_TRANG_ANH ELSE T7.TEN_TINH_TRANG_HOA END AS TEN_TINH_TRANG	,T2.LY_DO_BT

FROM          #MAY_TB AS T1 INNER JOIN
                        dbo.PHIEU_BAO_TRI AS T2 ON T1.MS_MAY = T2.MS_MAY INNER JOIN
                        dbo.PHIEU_BAO_TRI_CV_PHU_TRO AS T3 ON T2.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI INNER JOIN
                        dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO AS T4 ON T3.MS_PHIEU_BAO_TRI = T4.MS_PHIEU_BAO_TRI AND T3.STT = T4.STT INNER JOIN 
						LOAI_BAO_TRI T6 ON T2.MS_LOAI_BT = T6.MS_LOAI_BT INNER JOIN 
						TINH_TRANG_PBT T7 ON T2.TINH_TRANG_PBT = T7.STT
WHERE      (T4.MS_CONG_NHAN = @MsNV)
GROUP BY T4.MS_PHIEU_BAO_TRI, 
T3.TEN_CONG_VIEC, 
T2.MS_MAY, T1.TEN_MAY, T2.TT_SAU_BT,HU_HONG, 
CASE @NNgu WHEN 0 THEN T7.TEN_TINH_TRANG WHEN 1 THEN T7.TEN_TINH_TRANG_ANH ELSE T7.TEN_TINH_TRANG_HOA END,T2.LY_DO_BT
HAVING (MIN(T4.NGAY) BETWEEN @TNgay AND @DNgay) 
UNION
SELECT MIN(T3.NGAY) AS NGAY_WHERE, CONVERT(INT, NULL) AS STT, 
			NULL AS MO_TA_CV,CASE ISNULL(HU_HONG,0) WHEN 0 THEN 'X' ELSE NULL END AS BT_KH,
			SUM(T3.TONG_GIO_KH) SO_PHUT_KH,SUM(T3.SO_GIO) SO_PHUT_TT,			
			@BTNS AS TEN_BO_PHAN, T2.MS_MAY, T1.TEN_MAY, T2.TT_SAU_BT AS DANH_GIA, T3.MS_PHIEU_BAO_TRI, 
			CASE @NNgu WHEN 0 THEN T7.TEN_TINH_TRANG WHEN 1 THEN T7.TEN_TINH_TRANG_ANH ELSE T7.TEN_TINH_TRANG_HOA END AS TEN_TINH_TRANG,T2.LY_DO_BT
FROM          #MAY_TB AS T1 INNER JOIN
                        dbo.PHIEU_BAO_TRI AS T2 ON T1.MS_MAY = T2.MS_MAY INNER JOIN
                        dbo.PHIEU_BAO_TRI_NHAN_SU AS T3 ON T2.MS_PHIEU_BAO_TRI = T3.MS_PHIEU_BAO_TRI INNER JOIN 
						LOAI_BAO_TRI T6 ON T2.MS_LOAI_BT = T6.MS_LOAI_BT INNER JOIN 
						TINH_TRANG_PBT T7 ON T2.TINH_TRANG_PBT = T7.STT
WHERE      (T3.MS_CONG_NHAN = @MsNV)
GROUP BY T3.MS_PHIEU_BAO_TRI, 
T2.MS_MAY, T1.TEN_MAY, T2.TT_SAU_BT,HU_HONG, 
CASE @NNgu WHEN 0 THEN T7.TEN_TINH_TRANG WHEN 1 THEN T7.TEN_TINH_TRANG_ANH ELSE T7.TEN_TINH_TRANG_HOA END,T2.LY_DO_BT
HAVING (MIN(T3.NGAY) BETWEEN @TNgay AND @DNgay) 




SELECT     NGAY_WHERE, STT , MS_PHIEU_BAO_TRI,MS_MAY , TEN_MAY,LY_DO_BT,BT_KH,DANH_GIA,TEN_TINH_TRANG,MO_TA_CV, TEN_BO_PHAN, SO_PHUT_KH,SO_PHUT_TT
INTO #DT_DL
FROM         #PBT_TMP AS A WHERE     (NGAY_WHERE BETWEEN @TNgay AND @DNgay)
ORDER BY NGAY_WHERE , MS_PHIEU_BAO_TRI, MO_TA_CV,TEN_BO_PHAN

	
DECLARE @HoanThanh NVARCHAR(150)	
DECLARE @ChuaHoanThanh NVARCHAR(150)

SELECT @HoanThanh = (CASE @NNgu WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END)  FROM LANGUAGES WHERE FORM = N'ucBaoCaoPhieuCongViec' AND KEYWORD = N'HoanThanh'
SELECT @ChuaHoanThanh = (CASE @NNgu WHEN 0 THEN VIETNAM WHEN 1 THEN ENGLISH ELSE CHINESE END)  FROM LANGUAGES WHERE FORM = N'ucBaoCaoPhieuCongViec' AND KEYWORD = N'ChuaHoanThanh'

IF @NVIEN = 0
	BEGIN  

		SELECT NGAY_WHERE, ROW_NUMBER() OVER(PARTITION BY NGAY_WHERE ORDER BY NGAY_WHERE , MS_PHIEU_BAO_TRI,TEN_BO_PHAN, MO_TA_CV) AS STT,
		MS_PHIEU_BAO_TRI,MS_MAY,TEN_MAY,LY_DO_BT,BT_KH,DANH_GIA,TEN_TINH_TRANG,
		TEN_BO_PHAN,MO_TA_CV, SO_PHUT_KH,SO_PHUT_TT 
		FROM 
		(SELECT  
			NGAY_WHERE,  MS_PHIEU_BAO_TRI,MS_MAY,TEN_MAY,LY_DO_BT,BT_KH,DANH_GIA,TEN_TINH_TRANG,
			MO_TA_CV,TEN_BO_PHAN, SO_PHUT_KH,SO_PHUT_TT  FROM #DT_DL	
		UNION SELECT 
			NGAY ,		NULL ,			NULL,NULL,		NULL ,		NULL , NULL ,  NULL , 
			NULL ,	NULL ,	NULL ,	NULL FROM @DTNGAY ) A
		ORDER BY NGAY_WHERE , MS_PHIEU_BAO_TRI,TEN_BO_PHAN, MO_TA_CV
	END
ELSE
	BEGIN
		SELECT NGAY_WHERE, ROW_NUMBER() OVER(PARTITION BY NGAY_WHERE ORDER BY NGAY_WHERE , MS_PHIEU_BAO_TRI,TEN_BO_PHAN,MO_TA_CV) AS STT,
			MS_PHIEU_BAO_TRI,MS_MAY,TEN_MAY,LY_DO_BT,BT_KH,DANH_GIA,TEN_TINH_TRANG,
			TEN_BO_PHAN,MO_TA_CV, SO_PHUT_KH,SO_PHUT_TT 
		FROM 
			(
		SELECT  NGAY_WHERE,  MS_PHIEU_BAO_TRI,MS_MAY,TEN_MAY,LY_DO_BT,BT_KH,DANH_GIA,TEN_TINH_TRANG,
			MO_TA_CV,TEN_BO_PHAN, SO_PHUT_KH,SO_PHUT_TT 
			FROM #DT_DL	
		UNION 
		SELECT NGAY ,  NULL , NULL , NULL, NULL ,NULL , NULL ,  NULL , 
			NULL ,NULL, NULL ,NULL FROM @DTNGAY 

		UNION SELECT     NGAY,  @CVHN AS MS_PHIEU_BAO_TRI, NULL,NULL, NULL AS LY_DO_BT, CASE CO_KH WHEN 1 THEN 'X' ELSE NULL END AS BT_KH,GHI_CHU AS DANH_GIA,
		 CASE DA_XONG WHEN 1 THEN @HoanThanh ELSE @ChuaHoanThanh END AS TINH_TRANG,
		 TEN_CONG_VIEC, NULL ,NULL , THOI_GIAN_DK
		FROM         dbo.KE_HOACH_THUC_HIEN WHERE (NGAY BETWEEN @TNgay AND @DNgay) AND   (MS_CONG_NHAN = @MsNV) 

		UNION
--GSTT
		SELECT        T1.NGAY_KT, ISNULL(T1.SO_PHIEU,'GSTT') AS MS_PHIEU_BAO_TRI, T2.MS_MAY, T4.TEN_MAY, T1.NHAN_XET AS LY_DO_BT, NULL AS BT_KH, T2.GHI_CHU AS DANH_GIA, NULL  AS TINH_TRANG, T3.TEN_TS_GSTT, T5.TEN_BO_PHAN, 
                         T2.THOI_GIAN, T2.TG_TT
			FROM            dbo.GIAM_SAT_TINH_TRANG AS T1 INNER JOIN
									 dbo.GIAM_SAT_TINH_TRANG_TS AS T2 ON T1.STT = T2.STT INNER JOIN
									 dbo.THONG_SO_GSTT AS T3 ON T2.MS_TS_GSTT = T3.MS_TS_GSTT INNER JOIN
									 dbo.MAY AS T4 ON T2.MS_MAY = T4.MS_MAY INNER JOIN
									 dbo.CAU_TRUC_THIET_BI AS T5 ON T2.MS_MAY = T5.MS_MAY AND T2.MS_BO_PHAN = T5.MS_BO_PHAN
			 WHERE (NGAY_KT BETWEEN @TNgay AND @DNgay) AND   (T1.MS_CONG_NHAN = @MsNV) 

		) A
		ORDER BY NGAY_WHERE , MS_PHIEU_BAO_TRI,TEN_BO_PHAN, MO_TA_CV


	END
