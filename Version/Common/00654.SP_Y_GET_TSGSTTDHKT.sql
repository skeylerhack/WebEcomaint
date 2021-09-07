


--exec SP_Y_GET_TSGSTTDHKT 'admin',0,'10/28/2016','10/28/2016','-1',-1,'-1','-1','-1','-1','-1',-1


ALTER procedure [dbo].[SP_Y_GET_TSGSTTDHKT]
	@USERNAME VARCHAR (64), 
	@LANGUAGE INT,
	@TU_NGAY DATETIME,
	@DEN_NGAY DATETIME,
	@MS_NHA_XUONG VARCHAR (50), 
	@MS_HE_THONG INT ,
	@MS_LOAI_MAY VARCHAR(30),
	@MS_MAY VARCHAR (30),
	@MS_TINH VARCHAR(50),
	@MS_QUAN VARCHAR(50),
	@MS_DUONG VARCHAR(50),
	@MS_LOAI_CV INT
AS
BEGIN 


SELECT * INTO #MAY_USER
	FROM [dbo].[MGetMayUserNgay](@DEN_NGAY,@USERNAME,@MS_NHA_XUONG,@MS_HE_THONG,-1,@MS_LOAI_MAY,'-1',@MS_MAY,@LANGUAGE)


SELECT        T4.MS_TS_GSTT, T4.TEN_TS_GSTT, T4.MS_DV_DO, T4.LOAI_TS, T4.GHI_CHU, T4.MS_BP_GSTT, T4.DUONG_DAN, T4.MS_LOAI_CV
INTO #THONG_SO_GSTT
FROM            dbo.NHOM_LOAI_CONG_VIEC AS T2 INNER JOIN
                         dbo.USERS AS T3 ON T2.GROUP_ID = T3.GROUP_ID INNER JOIN
                         dbo.THONG_SO_GSTT AS T4 ON T2.MS_LOAI_CV = T4.MS_LOAI_CV
WHERE (USERNAME = @USERNAME) AND (T4.MS_LOAI_CV = @MS_LOAI_CV OR @MS_LOAI_CV = -1) AND (ISNULL(T4.MS_LOAI_CV,'') <> '')
UNION 
SELECT * FROM
(
SELECT        T4.MS_TS_GSTT, T4.TEN_TS_GSTT, T4.MS_DV_DO, T4.LOAI_TS, T4.GHI_CHU, T4.MS_BP_GSTT, T4.DUONG_DAN, ISNULL(T4.MS_LOAI_CV,-99) AS MS_LOAI_CV
FROM            dbo.THONG_SO_GSTT AS T4 
WHERE  (ISNULL(MS_LOAI_CV,'') = '')
) A WHERE (MS_LOAI_CV = @MS_LOAI_CV OR @MS_LOAI_CV = -1)



SELECT T2.STT , T1.MS_MAY , T1.MS_TS_GSTT , T1.MS_BO_PHAN,T1.MS_TT , T1.NGAY_KT_CUOI 
into #GIAM_SAT_TINH_TRANG_TS_TMP
FROM (
	SELECT     dbo.GIAM_SAT_TINH_TRANG_TS.MS_MAY, dbo.GIAM_SAT_TINH_TRANG_TS.MS_TS_GSTT,dbo.GIAM_SAT_TINH_TRANG_TS.MS_TT, dbo.GIAM_SAT_TINH_TRANG_TS.MS_BO_PHAN, 
	MAX(GIAM_SAT_TINH_TRANG_TMP.NGAY_KT) AS NGAY_KT_CUOI
	FROM         dbo.GIAM_SAT_TINH_TRANG_TS INNER JOIN
	(
		SELECT     STT, CONVERT(DATETIME, CONVERT(NVARCHAR(10), NGAY_KT, 101) + ' '+ CONVERT(NVARCHAR(8), GIO_KT, 108)) AS NGAY_KT
		FROM          dbo.GIAM_SAT_TINH_TRANG AS T
	) AS GIAM_SAT_TINH_TRANG_TMP ON 
		dbo.GIAM_SAT_TINH_TRANG_TS.STT = GIAM_SAT_TINH_TRANG_TMP.STT
		GROUP BY dbo.GIAM_SAT_TINH_TRANG_TS.MS_MAY, dbo.GIAM_SAT_TINH_TRANG_TS.MS_TS_GSTT, dbo.GIAM_SAT_TINH_TRANG_TS.MS_BO_PHAN,dbo.GIAM_SAT_TINH_TRANG_TS.MS_TT 
) T1 INNER JOIN 
	(
SELECT     dbo.GIAM_SAT_TINH_TRANG_TS.MS_MAY, dbo.GIAM_SAT_TINH_TRANG_TS.MS_TS_GSTT, dbo.GIAM_SAT_TINH_TRANG_TS.MS_BO_PHAN, dbo.GIAM_SAT_TINH_TRANG_TS.MS_TT, 
	MAX(GIAM_SAT_TINH_TRANG_TMP.NGAY_KT) AS NGAY_KT_CUOI, dbo.GIAM_SAT_TINH_TRANG_TS.STT
	FROM         dbo.GIAM_SAT_TINH_TRANG_TS INNER JOIN
	(SELECT     STT, CONVERT(DATETIME, CONVERT(NVARCHAR(10), NGAY_KT, 101) + ' '+ CONVERT(NVARCHAR(8), GIO_KT, 108)) AS NGAY_KT
	FROM          dbo.GIAM_SAT_TINH_TRANG AS T) AS GIAM_SAT_TINH_TRANG_TMP ON 
	dbo.GIAM_SAT_TINH_TRANG_TS.STT = GIAM_SAT_TINH_TRANG_TMP.STT
	GROUP BY dbo.GIAM_SAT_TINH_TRANG_TS.MS_MAY, dbo.GIAM_SAT_TINH_TRANG_TS.MS_TS_GSTT, dbo.GIAM_SAT_TINH_TRANG_TS.MS_BO_PHAN, 
	dbo.GIAM_SAT_TINH_TRANG_TS.STT,dbo.GIAM_SAT_TINH_TRANG_TS.MS_TT
) T2 ON T1.MS_MAY  = T2.MS_MAY AND T1.MS_TS_GSTT = T2.MS_TS_GSTT AND 
T1.MS_BO_PHAN = T2.MS_BO_PHAN AND T1.NGAY_KT_CUOI = T2.NGAY_KT_CUOI and T1.MS_TT = T2.MS_TT

--DINH TINH

SELECT DISTINCT CTTB.MS_MAY, T1.TEN_MAY, CTTB.MS_BO_PHAN + ' - ' + CTTB.TEN_BO_PHAN AS TEN_BO_PHAN , GSTT.TEN_TS_GSTT, 
CONVERT(VARCHAR(8), CTTB_GSTT.CHU_KY_DO) + ' ' + CASE @LANGUAGE WHEN 1 THEN dbo.DON_VI_THOI_GIAN.TEN_DV_TG_ANH 
WHEN 2 THEN dbo.DON_VI_THOI_GIAN.TEN_DV_TG_HOA ELSE dbo.DON_VI_THOI_GIAN.TEN_DV_TG END AS CHU_KY_DO, GSTT_TMP.NGAY_KT_CUOI, 
dbo.MGetListGSTTThongSo(GSTT_TMP.STT,GSTT_TMP.MS_MAY,GSTT_TMP.MS_TS_GSTT,GSTT_TMP.MS_BO_PHAN,GSTT_TMP.MS_TT) AS TEN_GIA_TRI, CONVERT(BIT,NULL) AS DAT, 
CASE CTTB_GSTT.MS_DV_TG WHEN 1 THEN DATEADD(DAY, CTTB_GSTT.CHU_KY_DO, 
GSTT_TMP.NGAY_KT_CUOI) WHEN 2 THEN DATEADD(DAY, 
CTTB_GSTT.CHU_KY_DO * 7.25, GSTT_TMP.NGAY_KT_CUOI) 
WHEN 3 THEN DATEADD(MONTH, CTTB_GSTT.CHU_KY_DO, 
GSTT_TMP.NGAY_KT_CUOI) WHEN 4 THEN DATEADD(YEAR, CTTB_GSTT.CHU_KY_DO, 
GSTT_TMP.NGAY_KT_CUOI) END AS NGAY_KT_KE,T1.MS_N_XUONG ,
GSTT_TMP.MS_TS_GSTT,CTTB.MS_BO_PHAN,CTTB.STT AS STT_BP

INTO #TEMP_DINH_TINH
FROM         dbo.CAU_TRUC_THIET_BI_TS_GSTT AS CTTB_GSTT INNER JOIN
                      #GIAM_SAT_TINH_TRANG_TS_TMP AS GSTT_TMP ON CTTB_GSTT.MS_MAY = GSTT_TMP.MS_MAY AND CTTB_GSTT.MS_BO_PHAN = GSTT_TMP.MS_BO_PHAN AND 
                      CTTB_GSTT.MS_TS_GSTT = GSTT_TMP.MS_TS_GSTT INNER JOIN
                      #THONG_SO_GSTT GSTT ON CTTB_GSTT.MS_TS_GSTT = GSTT.MS_TS_GSTT INNER JOIN
                      dbo.CAU_TRUC_THIET_BI AS CTTB ON CTTB_GSTT.MS_MAY = CTTB.MS_MAY AND CTTB_GSTT.MS_BO_PHAN = CTTB.MS_BO_PHAN INNER JOIN
                      dbo.DON_VI_THOI_GIAN ON CTTB_GSTT.MS_DV_TG = dbo.DON_VI_THOI_GIAN.MS_DV_TG INNER JOIN
                      #MAY_USER AS T1 ON CTTB.MS_MAY = T1.MS_MAY                      
WHERE GSTT.LOAI_TS = 1 AND CTTB_GSTT.ACTIVE=1
AND CASE CTTB_GSTT.MS_DV_TG 
	WHEN 1 THEN  DATEADD(DAY,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 2 THEN  DATEADD(WEEK,CTTB_GSTT.CHU_KY_DO ,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 3 THEN  DATEADD(MONTH,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 4 THEN  DATEADD(YEAR,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI) END >=  DATEADD(DAY,-1,  @TU_NGAY )
AND CASE CTTB_GSTT.MS_DV_TG 
	WHEN 1 THEN  DATEADD(DAY,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 2 THEN  DATEADD(WEEK,CTTB_GSTT.CHU_KY_DO ,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 3 THEN  DATEADD(MONTH,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 4 THEN  DATEADD(YEAR,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI) END <= @DEN_NGAY 


--DINH LUONG

SELECT DISTINCT 
--TEMP.*,MS_TINH=[dbo].[Get_CityCode](NHA_XUONG.MS_QG),MS_QUAN = NHA_XUONG.MS_QG,NHA_XUONG.MS_DUONG

TEMP.MS_MAY,TEMP.TEN_MAY, 
(SELECT TOP 1 ISNULL(TEN_BO_PHAN,'') FROM CAU_TRUC_THIET_BI WHERE MS_BO_PHAN = (
SELECT TOP 1 CASE  WHEN ISNULL(MS_BO_PHAN_CHA,'') = MS_MAY THEN MS_BO_PHAN ELSE MS_BO_PHAN_CHA END
  FROM CAU_TRUC_THIET_BI where MS_BO_PHAN = TEMP.MS_BO_PHAN AND MS_MAY = TEMP.MS_MAY)
AND MS_MAY = TEMP.MS_MAY) + ' - ' + 

TEMP.TEN_BO_PHAN AS TEN_BO_PHAN ,TEMP.TEN_TS_GSTT,TEMP.CHU_KY_DO,TEMP.NGAY_KT_CUOI,
	   TEMP.TEN_GIA_TRI,ISNULL(TEMP.DAT,0) DAT,TEMP.NGAY_KT_KE,dbo.MGetGiaTriThongSoGSTT(TEMP.MS_TS_GSTT) AS TEN_GT_GSTT, STT_BP

FROM
(
SELECT *  FROM #TEMP_DINH_TINH
UNION ALL
SELECT  DISTINCT
          CTTB.MS_MAY, 
          T1.TEN_MAY,
            CTTB.MS_BO_PHAN + ' - ' + CTTB.TEN_BO_PHAN  AS TEN_BO_PHAN, 
           TEN_TS_GSTT, CONVERT(VARCHAR(8), CTTB_GSTT.CHU_KY_DO) 
           + ' '+ CASE @LANGUAGE WHEN 1 THEN dbo.DON_VI_THOI_GIAN.TEN_DV_TG_ANH WHEN 2 THEN dbo.DON_VI_THOI_GIAN.TEN_DV_TG_HOA
           ELSE dbo.DON_VI_THOI_GIAN.TEN_DV_TG END AS CHU_KY_DO, GSTT_TMP.NGAY_KT_CUOI, 
          
          (CTTB_GSTT.TEN_GT +' (' + CAST(GIAM_SAT_TINH_TRANG_TS.GIA_TRI_DO AS VARCHAR(10)) +')') as TEN_GIA_TRI, 
          CTTB_GSTT.DAT, 
          
          CASE CTTB_GSTT.MS_DV_TG WHEN 1 THEN DATEADD(DAY, CTTB_GSTT.CHU_KY_DO, 
          GSTT_TMP.NGAY_KT_CUOI) WHEN 2 THEN DATEADD(DAY, 
          CTTB_GSTT.CHU_KY_DO * 7.25, GSTT_TMP.NGAY_KT_CUOI) 
          WHEN 3 THEN DATEADD(MONTH, CTTB_GSTT.CHU_KY_DO, 
          GSTT_TMP.NGAY_KT_CUOI) WHEN 4 THEN DATEADD(YEAR, CTTB_GSTT.CHU_KY_DO, 
          GSTT_TMP.NGAY_KT_CUOI) END AS NGAY_KT_KE, T1.MS_N_XUONG ,CTTB_GSTT.MS_TS_GSTT,CTTB.MS_BO_PHAN, CTTB.STT AS STT_BP
          
FROM         dbo.CAU_TRUC_THIET_BI_TS_GSTT CTTB_GSTT INNER JOIN
      #THONG_SO_GSTT GSTT ON CTTB_GSTT.MS_TS_GSTT = GSTT.MS_TS_GSTT INNER JOIN
      dbo.CAU_TRUC_THIET_BI CTTB ON CTTB_GSTT.MS_MAY = CTTB.MS_MAY AND 
      CTTB_GSTT.MS_BO_PHAN = CTTB.MS_BO_PHAN INNER JOIN
      dbo.DON_VI_THOI_GIAN ON CTTB_GSTT.MS_DV_TG = dbo.DON_VI_THOI_GIAN.MS_DV_TG INNER JOIN
      #MAY_USER T1 ON CTTB.MS_MAY = T1.MS_MAY INNER JOIN
      dbo.NHOM_MAY ON T1.MS_NHOM_MAY = dbo.NHOM_MAY.MS_NHOM_MAY INNER JOIN
      dbo.LOAI_MAY ON dbo.NHOM_MAY.MS_LOAI_MAY = dbo.LOAI_MAY.MS_LOAI_MAY INNER JOIN
      dbo.NHOM_LOAI_MAY ON dbo.LOAI_MAY.MS_LOAI_MAY = dbo.NHOM_LOAI_MAY.MS_LOAI_MAY INNER JOIN
      dbo.USERS ON dbo.NHOM_LOAI_MAY.GROUP_ID = dbo.USERS.GROUP_ID INNER JOIN
      #GIAM_SAT_TINH_TRANG_TS_TMP GSTT_TMP ON CTTB_GSTT.MS_MAY = GSTT_TMP.MS_MAY AND 
      CTTB_GSTT.MS_BO_PHAN = GSTT_TMP.MS_BO_PHAN AND 
      CTTB_GSTT.MS_TS_GSTT = GSTT_TMP.MS_TS_GSTT INNER JOIN
      dbo.GIAM_SAT_TINH_TRANG_TS ON CTTB_GSTT.MS_MAY = dbo.GIAM_SAT_TINH_TRANG_TS.MS_MAY AND 
      CTTB_GSTT.MS_BO_PHAN = dbo.GIAM_SAT_TINH_TRANG_TS.MS_BO_PHAN AND 
      CTTB_GSTT.MS_TS_GSTT = dbo.GIAM_SAT_TINH_TRANG_TS.MS_TS_GSTT AND 
      CTTB_GSTT.MS_TT = dbo.GIAM_SAT_TINH_TRANG_TS.MS_TT
WHERE GSTT.LOAI_TS =0  AND CTTB_GSTT.ACTIVE=1
AND CASE CTTB_GSTT.MS_DV_TG 
	WHEN 1 THEN  DATEADD(DAY,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 2 THEN  DATEADD(DAY,CTTB_GSTT.CHU_KY_DO * 7.25,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 3 THEN  DATEADD(MONTH,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 4 THEN  DATEADD(YEAR,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI) END >= DATEADD(DAY,-1,  @TU_NGAY ) 
AND CASE CTTB_GSTT.MS_DV_TG 
	WHEN 1 THEN  DATEADD(DAY,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 2 THEN  DATEADD(DAY,CTTB_GSTT.CHU_KY_DO * 7.25,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 3 THEN  DATEADD(MONTH,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI)
	WHEN 4 THEN  DATEADD(YEAR,CTTB_GSTT.CHU_KY_DO,GSTT_TMP.NGAY_KT_CUOI) END <= @DEN_NGAY 

)TEMP INNER JOIN NHA_XUONG ON NHA_XUONG.MS_N_XUONG = TEMP.MS_N_XUONG


ORDER BY 
MS_MAY, STT_BP,TEN_BO_PHAN


END
