

-- DROP TABLE MAY_CVBT_TMPIN ; 
--SELECT  CONVERT(BIT,1) AS CHON, * INTO MAY_CVBT_TMPIN FROM MAY WHERE MS_MAY = 'BUE-1506'; EXEC spBaoCaoCongViecBaoTri 'MAY_CVBT_TMPIN', -1, N'LBTRI', '05/01/2020', '09/30/2020',1,'-1',-1,0,'0','pbt','0',0, 'aDMIN'

--SELECT  CONVERT(BIT,1) AS CHON, * INTO MAY_CVBT_TMPIN FROM MAY ; EXEC spBaoCaoCongViecBaoTri 'MAY_CVBT_TMPIN', -1, N'LBTRI', '01/01/2018', '01/30/2018',1,'-1',-1,0,'0','pbt','0',0, 'aDMIN'

ALTER PROC [dbo].[spBaoCaoCongViecBaoTri]
	@MayTmp NVARCHAR(50),
	@MsLBTri INT,
	@TenLBTri NVARCHAR(50),
	@TNgay DATETIME,
	@DNgay DATETIME,
	@NNgu INT,
	@MSDV NVARCHAR(50),
	@MSTO INT,
	@iLoaiBC INT,
	@KHTT NVARCHAR(250),
	@PBT NVARCHAR(250),
	@CVC NVARCHAR(250),
	@iTuyChonCV int,
	@UserName NVARCHAR(50)
AS
--@iTuyChonCV 0 all cv 9 + phụ
--@iTuyChonCV 1 CV 9

-- @iLoaiBC 0 In ALL
-- @iLoaiBC 1 In KHTT
-- @iLoaiBC 2 In PBT
-- @iLoaiBC 3 In Cong Viec VP

DECLARE @sSql NVARCHAR(4000)


CREATE TABLE #MAY_TMP (MS_MAY NVARCHAR(250) NULL, TEN_MAY NVARCHAR(500) NULL)  

SET @sSql = ' INSERT INTO #MAY_TMP SELECT MS_MAY, TEN_MAY FROM ' + @MayTmp + ' WHERE ISNULL(CHON,0) = 1'
EXEC (@sSql)

SET @sSql = ' DROP TABLE ' + @MayTmp
EXEC (@sSql)

SELECT     T3.MS_TO, T3.MS_DON_VI INTO #USER_DV
FROM         dbo.NHOM_TO_PHONG_BAN AS T1 INNER JOIN
                      dbo.USERS AS T2 ON T1.GROUP_ID = T2.GROUP_ID INNER JOIN
                      dbo.TO_PHONG_BAN AS T3 ON T1.MS_TO = T3.MS_TO
WHERE (T2.USERNAME = @UserName) AND (T3.MS_DON_VI = @MSDV OR @MSDV = '-1') 
	 AND (T3.MS_TO = @MSTO OR @MSTO = -1) 

--tao KHTT tam
SELECT CONVERT(FLOAT,CASE ISNULL(CO_KH,0) WHEN 1 THEN THOI_GIAN_DK ELSE NULL END) AS TG_CO_KH,
CONVERT(FLOAT,CASE ISNULL(CO_KH,0) WHEN 0 THEN THOI_GIAN_DK ELSE NULL END) AS TG_KG_KH,A.* INTO #KHTH_TMP 
FROM dbo.CONG_NHAN AS B INNER JOIN
         dbo.KE_HOACH_THUC_HIEN AS A ON B.MS_CONG_NHAN = A.MS_CONG_NHAN INNER JOIN
         dbo.[TO] AS C ON B.MS_TO = C.MS_TO1 INNER JOIN
         dbo.TO_PHONG_BAN AS D ON C.MS_TO = D.MS_TO INNER JOIN 
         #USER_DV E ON D.MS_DON_VI = E.MS_DON_VI AND D.MS_TO = E.MS_TO
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY,101))  BETWEEN @TNgay AND @DNgay)
	AND  (@iLoaiBC = 0 OR @iLoaiBC = 3)  AND (D.MS_DON_VI = @MSDV OR @MSDV = '-1') 
	 AND (D.MS_TO = @MSTO OR @MSTO = -1)

IF(@iTuyChonCV = 1)
begin 
SELECT COUNT(A.MS_PHIEU_BAO_TRI) AS COT_MER ,A.MS_PHIEU_BAO_TRI INTO #COT_PBT
FROM            (SELECT        MS_PHIEU_BAO_TRI, SUM(SO_GIO) AS SO_GIO_TT, MIN(NGAY) AS TU_NGAY_TT,MAX(DEN_NGAY) AS DEN_NGAY_TT
                          FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET
                          GROUP BY MS_PHIEU_BAO_TRI) AS T3 RIGHT OUTER JOIN
                         dbo.PHIEU_BAO_TRI AS A INNER JOIN
                         dbo.PHIEU_BAO_TRI_CONG_VIEC AS B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI INNER JOIN
                         #MAY_TMP AS C ON A.MS_MAY = C.MS_MAY INNER JOIN
                         dbo.LOAI_BAO_TRI AS D ON A.MS_LOAI_BT = D.MS_LOAI_BT INNER JOIN
                         dbo.CONG_VIEC AS E ON B.MS_CV = E.MS_CV INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS X ON A.MS_MAY = X.MS_MAY AND B.MS_BO_PHAN = X.MS_BO_PHAN ON T3.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI	
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY_BD_KH,101)) BETWEEN @TNgay AND @DNgay )
	AND (A.MS_LOAI_BT = @MsLBTri  OR @MsLBTri = -1)  AND  (@iLoaiBC = 0 OR @iLoaiBC = 2) 
GROUP BY A.MS_PHIEU_BAO_TRI
end
else
BEGIN
SELECT SUM(COT_MER) AS COT_MER , MS_PHIEU_BAO_TRI INTO #COT_PBT1 FROM  
(
	SELECT COUNT(A.MS_PHIEU_BAO_TRI) AS COT_MER ,A.MS_PHIEU_BAO_TRI 
	FROM            (SELECT        MS_PHIEU_BAO_TRI, SUM(SO_GIO) AS SO_GIO_TT, MIN(NGAY) AS TU_NGAY_TT,MAX(DEN_NGAY) AS DEN_NGAY_TT
							  FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET
							  GROUP BY MS_PHIEU_BAO_TRI) AS T3 RIGHT OUTER JOIN
							 dbo.PHIEU_BAO_TRI AS A INNER JOIN
							 dbo.PHIEU_BAO_TRI_CONG_VIEC AS B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI INNER JOIN
							 #MAY_TMP AS C ON A.MS_MAY = C.MS_MAY INNER JOIN
							 dbo.LOAI_BAO_TRI AS D ON A.MS_LOAI_BT = D.MS_LOAI_BT INNER JOIN
							 dbo.CONG_VIEC AS E ON B.MS_CV = E.MS_CV INNER JOIN
							 dbo.CAU_TRUC_THIET_BI AS X ON A.MS_MAY = X.MS_MAY AND B.MS_BO_PHAN = X.MS_BO_PHAN ON T3.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI	
	WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY_BD_KH,101)) BETWEEN @TNgay AND @DNgay )
		AND (A.MS_LOAI_BT = @MsLBTri  OR @MsLBTri = -1)  AND  (@iLoaiBC = 0 OR @iLoaiBC = 2) 
	GROUP BY A.MS_PHIEU_BAO_TRI
	UNION
	
	SELECT COUNT(A.MS_PHIEU_BAO_TRI) AS COT_MER ,A.MS_PHIEU_BAO_TRI 
	FROM            (SELECT        MS_PHIEU_BAO_TRI, SUM(SO_GIO) AS SO_GIO_TT, MIN(NGAY) AS TU_NGAY_TT,MAX(DEN_NGAY) AS DEN_NGAY_TT
							  FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO 
							  GROUP BY MS_PHIEU_BAO_TRI) AS T3 
							  RIGHT OUTER JOIN dbo.PHIEU_BAO_TRI AS A ON T3.MS_PHIEU_BAO_TRI = A.MS_PHIEU_BAO_TRI 
							 INNER JOIN dbo.PHIEU_BAO_TRI_CV_PHU_TRO  AS B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI 
							 INNER JOIN	#MAY_TMP AS C ON A.MS_MAY = C.MS_MAY 
							 INNER JOIN dbo.LOAI_BAO_TRI AS D ON A.MS_LOAI_BT = D.MS_LOAI_BT 
							 
	WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY_BD_KH,101)) BETWEEN @TNgay AND @DNgay )
		AND (A.MS_LOAI_BT = @MsLBTri  OR @MsLBTri = -1)  AND  (@iLoaiBC = 0 OR @iLoaiBC = 2) 
	GROUP BY A.MS_PHIEU_BAO_TRI
) T1 GROUP BY MS_PHIEU_BAO_TRI
end 



IF(@iTuyChonCV = 0)
begin 
SELECT  ROW_NUMBER() OVER(ORDER BY NGAY_BD_KH, MS_PBT, MS_MAY, TEN_MAY, TEN_LOAI_BT,TEN_BO_PHAN,TEN_CV) AS STT ,
*  FROM
(
-- Lấy bên KHTT cho các Hang mục chưa chuyển PBT
SELECT CONVERT(nvarchar(250),@KHTT) AS LOAI_BC, D.TEN_LOAI_BT,A.MS_MAY, B.TEN_MAY, 
(X.MS_BO_PHAN + ' - ' +  
CASE @NNgu WHEN 0 THEN X.TEN_BO_PHAN WHEN 1 THEN ISNULL(NULLIF(X.TEN_BO_PHAN_ANH,''),X.TEN_BO_PHAN) ELSE ISNULL(NULLIF(X.TEN_BO_PHAN_HOA,''),X.TEN_BO_PHAN) END

) AS TEN_BO_PHAN, 

		CASE @NNgu WHEN 0 THEN E.MO_TA_CV WHEN 1 THEN ISNULL(NULLIF(E.MO_TA_CV_ANH,''),MO_TA_CV) ELSE ISNULL(NULLIF(E.MO_TA_CV_HOA,''),MO_TA_CV) END AS TEN_CV, 
	CASE D.HU_HONG WHEN 0 THEN 
		CASE ISNULL(A.THOI_GIAN_DU_KIEN,0) WHEN 0 THEN NULL ELSE A.THOI_GIAN_DU_KIEN END ELSE NULL END AS TG_KH_CO_KH, 
	CASE D.HU_HONG WHEN 1 THEN 
		CASE ISNULL(A.THOI_GIAN_DU_KIEN,0) WHEN 0 THEN NULL ELSE A.THOI_GIAN_DU_KIEN END ELSE NULL END  AS TG_KH_KG_KH,
	C.NGAY AS NGAY_BD_KH, C.NGAY_DK_HT AS NGAY_KT_KH, 
	CONVERT(nvarchar(10),NULL) AS HOAN_THANH,
		CONVERT(FLOAT, NULL) AS TG_TT_CO_KH, 
		CONVERT(FLOAT, NULL) AS TG_TT_KG_KH, 
	CONVERT(NVARCHAR(150), NULL) AS MS_PBT, CONVERT(NVARCHAR(4000), NULL) AS NGUOI_TH_PBT,
	CONVERT(DATETIME, NULL) AS TU_NGAY_TT, CONVERT(DATETIME, NULL) AS DEN_NGAY_TT, 
	CONVERT(NVARCHAR(500), NULL) AS TT_SAU_BT,CONVERT(FLOAT, NULL) AS TG_NM, 
	CONVERT(FLOAT, NULL) AS PTTG_TT_KH,  A.GHI_CHU , CONVERT(INT,1) AS COT_MER,

	CONVERT(FLOAT, NULL) AS CO_KH_COUNT, 
	CONVERT(FLOAT, NULL) AS KG_KH_COUNT,

	CONVERT(NVARCHAR(500), NULL) AS  MS_BO_PHAN, CONVERT(INT, NULL) AS MS_CV,
	CASE D.HU_HONG WHEN 0 THEN 
		CASE ISNULL(A.THOI_GIAN_DU_KIEN,0) WHEN 0 THEN NULL ELSE A.THOI_GIAN_DU_KIEN END ELSE NULL END AS TG_TT_CO_KH_SUM, 
	CASE D.HU_HONG WHEN 1 THEN 
		CASE ISNULL(A.THOI_GIAN_DU_KIEN,0) WHEN 0 THEN NULL ELSE A.THOI_GIAN_DU_KIEN END ELSE NULL END  AS TG_TT_KG_KH_SUM
FROM            KE_HOACH_TONG_CONG_VIEC AS A INNER JOIN
                         #MAY_TMP AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
                         dbo.KE_HOACH_TONG_THE AS C ON A.HANG_MUC_ID = C.HANG_MUC_ID INNER JOIN
                         dbo.LOAI_BAO_TRI AS D ON C.MS_LOAI_BT = D.MS_LOAI_BT INNER JOIN
                         dbo.CONG_VIEC AS E ON A.MS_CV = E.MS_CV INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS X ON A.MS_MAY = X.MS_MAY AND A.MS_BO_PHAN = X.MS_BO_PHAN
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),C.NGAY,101)) BETWEEN @TNgay AND @DNgay) AND (ISNULL(A.MS_PHIEU_BAO_TRI,'') = '') 
	AND (C.MS_LOAI_BT = @MsLBTri  OR @MsLBTri = -1) AND  (@iLoaiBC = 0 OR @iLoaiBC = 1  ) 

UNION



--Lấy all cac PBT
SELECT CONVERT(nvarchar(250),@PBT) AS LOAI_BC,D.TEN_LOAI_BT, A.MS_MAY, TEN_MAY, (X.MS_BO_PHAN + ' - ' + 
CASE @NNgu WHEN 0 THEN X.TEN_BO_PHAN WHEN 1 THEN ISNULL(NULLIF(X.TEN_BO_PHAN_ANH,''),X.TEN_BO_PHAN) ELSE ISNULL(NULLIF(X.TEN_BO_PHAN_HOA,''),X.TEN_BO_PHAN) END) AS TEN_BO_PHAN,
CASE @NNgu WHEN 0 THEN E.MO_TA_CV WHEN 1 THEN E.MO_TA_CV_ANH ELSE E.MO_TA_CV_HOA END AS TEN_CV,

CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN 
	CASE ISNULL(B.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE B.SO_GIO_KH END END ) AS TG_KH_CO_KH, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(B.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE B.SO_GIO_KH END END ) AS TG_KH_KG_KH, 
A.NGAY_BD_KH , A.NGAY_KT_KH ,

CONVERT(NVARCHAR(10),CASE WHEN A.TINH_TRANG_PBT>2 THEN 'X' ELSE NULL END) AS HOAN_THANH,

CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN 
	CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS TG_TT_CO_KH, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS TG_TT_KG_KH,
	
A.MS_PHIEU_BAO_TRI, CONVERT(NVARCHAR(4000), CASE WHEN TINH_TRANG_PBT >=3 THEN dbo.GetNhanSuPBT(A.MS_PHIEU_BAO_TRI,B.MS_BO_PHAN,B.MS_CV,0)  ELSE NULL END) AS NGUOI_TH_PBT, T3.TU_NGAY_TT , T3.DEN_NGAY_TT , A.TT_SAU_BT ,CASE ISNULL(T4.TG_NM,0) WHEN 0 THEN NULL ELSE T4.TG_NM END AS TG_NM,  
CONVERT(FLOAT, CASE ISNULL(T5.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT/T5.SO_GIO_KH END) AS PTTG_TT_KH,
B.GHI_CHU , CONVERT(INT,COT_MER) AS COT_MER, CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS CO_KH_COUNT, CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS KG_KH_COUNT,		
B.MS_BO_PHAN,B.MS_CV,CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN CASE ISNULL(T7.SO_GIO_TT_CHUA_HT,0) WHEN 0 THEN NULL ELSE T7.SO_GIO_TT_CHUA_HT END ELSE NULL END) AS TG_TT_CO_KH_SUM, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(T7.SO_GIO_TT_CHUA_HT,0) WHEN 0 THEN NULL ELSE T7.SO_GIO_TT_CHUA_HT END ELSE NULL END) AS TG_TT_KG_KH_SUM


FROM          


  (SELECT        Y.MS_PHIEU_BAO_TRI, SUM(SO_GIO) AS SO_GIO_TT, MIN(NGAY) AS TU_NGAY_TT,MAX(DEN_NGAY) AS DEN_NGAY_TT
                          FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET X INNER JOIN PHIEU_BAO_TRI Y ON X.MS_PHIEU_BAO_TRI = Y.MS_PHIEU_BAO_TRI
						  WHERE Y.TINH_TRANG_PBT >=3
                          GROUP BY Y.MS_PHIEU_BAO_TRI
						  ) AS T3 RIGHT OUTER JOIN
                         dbo.PHIEU_BAO_TRI AS A INNER JOIN dbo.PHIEU_BAO_TRI_CONG_VIEC AS B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI INNER JOIN
                         #MAY_TMP AS C ON A.MS_MAY = C.MS_MAY INNER JOIN
                         dbo.LOAI_BAO_TRI AS D ON A.MS_LOAI_BT = D.MS_LOAI_BT INNER JOIN
                         dbo.CONG_VIEC AS E ON B.MS_CV = E.MS_CV INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS X ON A.MS_MAY = X.MS_MAY AND B.MS_BO_PHAN = X.MS_BO_PHAN ON T3.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI LEFT JOIN 
(SELECT        Y.MS_PHIEU_BAO_TRI, SUM(X.THOI_GIAN_SUA_CHUA) AS TG_NM
FROM            dbo.THOI_GIAN_NGUNG_MAY AS X INNER JOIN
                         dbo.THOI_GIAN_NGUNG_MAY_SO_LAN AS Y ON X.MS_LAN = Y.MS_LAN
WHERE        (ISNULL(Y.MS_PHIEU_BAO_TRI, N'') <> '')
GROUP BY X.THOI_GIAN_SUA, Y.MS_PHIEU_BAO_TRI) T4 ON A.MS_PHIEU_BAO_TRI = T4.MS_PHIEU_BAO_TRI   LEFT JOIN 
(SELECT        MS_PHIEU_BAO_TRI, SUM(SO_GIO_KH) AS SO_GIO_KH
                  FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC
                  GROUP BY MS_PHIEU_BAO_TRI) AS T5 ON A.MS_PHIEU_BAO_TRI = T5.MS_PHIEU_BAO_TRI LEFT JOIN #COT_PBT1 T6 ON A.MS_PHIEU_BAO_TRI = T6.MS_PHIEU_BAO_TRI
LEFT JOIN 
(SELECT        Y.MS_PHIEU_BAO_TRI,X.MS_CV,X.MS_BO_PHAN, SUM(X.SO_GIO_KH) AS SO_GIO_TT_CHUA_HT
                          FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC X INNER JOIN PHIEU_BAO_TRI Y ON X.MS_PHIEU_BAO_TRI = Y.MS_PHIEU_BAO_TRI
						  WHERE Y.TINH_TRANG_PBT < 3
                          GROUP BY Y.MS_PHIEU_BAO_TRI,X.MS_CV,X.MS_BO_PHAN) AS T7 ON A.MS_PHIEU_BAO_TRI = T7.MS_PHIEU_BAO_TRI AND B.MS_CV = T7.MS_CV AND B.MS_BO_PHAN = T7.MS_BO_PHAN
                          
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY_BD_KH,101)) BETWEEN @TNgay AND @DNgay )
	AND (A.MS_LOAI_BT = @MsLBTri  OR @MsLBTri = -1)  AND  (@iLoaiBC = 0 OR @iLoaiBC = 2) 


UNION



SELECT CONVERT(nvarchar(250),@PBT) AS LOAI_BC,D.TEN_LOAI_BT, A.MS_MAY, TEN_MAY, 
'' AS TEN_BO_PHAN,
B.TEN_CONG_VIEC AS TEN_CV,
CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN 
	CASE ISNULL(B.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE B.SO_GIO_KH END END ) AS TG_KH_CO_KH, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(B.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE B.SO_GIO_KH END END ) AS TG_KH_KG_KH, 
A.NGAY_BD_KH , A.NGAY_KT_KH ,

CONVERT(NVARCHAR(10),CASE WHEN A.TINH_TRANG_PBT>2 THEN 'X' ELSE NULL END) AS HOAN_THANH,

CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN 
	CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS TG_TT_CO_KH, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS TG_TT_KG_KH,
	
A.MS_PHIEU_BAO_TRI, CONVERT(NVARCHAR(4000), CASE WHEN TINH_TRANG_PBT >=3 THEN dbo.GetNhanSuPBT(A.MS_PHIEU_BAO_TRI,0,T3.STT,1)  ELSE NULL END) AS NGUOI_TH_PBT, T3.TU_NGAY_TT , T3.DEN_NGAY_TT , A.TT_SAU_BT ,0 AS TG_NM,  
CONVERT(FLOAT, CASE ISNULL(T5.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT/T5.SO_GIO_KH END) AS PTTG_TT_KH,
'' AS GHI_CHU , CONVERT(INT,COT_MER) AS COT_MER, CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS CO_KH_COUNT, CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS KG_KH_COUNT,		
'' AS MS_BO_PHAN,'' AS MS_CV,CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN CASE ISNULL(T7.SO_GIO_TT_CHUA_HT,0) WHEN 0 THEN NULL ELSE T7.SO_GIO_TT_CHUA_HT END ELSE NULL END) AS TG_TT_CO_KH_SUM, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(T7.SO_GIO_TT_CHUA_HT,0) WHEN 0 THEN NULL ELSE T7.SO_GIO_TT_CHUA_HT END ELSE NULL END) AS TG_TT_KG_KH_SUM

	
	
	
FROM          
  (SELECT        Y.MS_PHIEU_BAO_TRI,X.STT ,SUM(SO_GIO) AS SO_GIO_TT, MIN(NGAY) AS TU_NGAY_TT,MAX(DEN_NGAY) AS DEN_NGAY_TT
                          FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_PHU_TRO X INNER JOIN PHIEU_BAO_TRI Y ON X.MS_PHIEU_BAO_TRI = Y.MS_PHIEU_BAO_TRI
						  WHERE Y.TINH_TRANG_PBT >=3
                          GROUP BY Y.MS_PHIEU_BAO_TRI, X.STT) AS T3 RIGHT OUTER JOIN
                         dbo.PHIEU_BAO_TRI AS A ON T3.MS_PHIEU_BAO_TRI = A.MS_PHIEU_BAO_TRI LEFT JOIN 
						 dbo.PHIEU_BAO_TRI_CV_PHU_TRO  AS B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI INNER JOIN
                         #MAY_TMP AS C ON A.MS_MAY = C.MS_MAY INNER JOIN
                         dbo.LOAI_BAO_TRI AS D ON A.MS_LOAI_BT = D.MS_LOAI_BT LEFT JOIN 
						 #COT_PBT1 T6 ON A.MS_PHIEU_BAO_TRI = T6.MS_PHIEU_BAO_TRI LEFT JOIN 

(SELECT        MS_PHIEU_BAO_TRI, SUM(SO_GIO_KH) AS SO_GIO_KH
                  FROM            dbo.PHIEU_BAO_TRI_CV_PHU_TRO
                  GROUP BY MS_PHIEU_BAO_TRI) AS T5 ON A.MS_PHIEU_BAO_TRI = T5.MS_PHIEU_BAO_TRI LEFT JOIN 
(SELECT        Y.MS_PHIEU_BAO_TRI, SUM(X.SO_GIO_KH) AS SO_GIO_TT_CHUA_HT
                          FROM            dbo.PHIEU_BAO_TRI_CV_PHU_TRO X INNER JOIN PHIEU_BAO_TRI Y ON X.MS_PHIEU_BAO_TRI = Y.MS_PHIEU_BAO_TRI
						  WHERE Y.TINH_TRANG_PBT < 3
                          GROUP BY Y.MS_PHIEU_BAO_TRI,X.TEN_CONG_VIEC ) AS T7 ON A.MS_PHIEU_BAO_TRI = T7.MS_PHIEU_BAO_TRI        
						  
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY_BD_KH,101)) BETWEEN @TNgay AND @DNgay )
	AND (A.MS_LOAI_BT = @MsLBTri  OR @MsLBTri = -1)  AND  (@iLoaiBC = 0 OR @iLoaiBC = 2) 

	
UNION
--Lấy all kế hoach nhan6n viên
SELECT  CONVERT(nvarchar(250),@CVC) AS LOAI_BC,@TenLBTri AS TEN_LOAI_BT,NULL AS MS_MAY, NULL AS TEN_MAY,NULL AS TEN_BO_PHAN,A.TEN_CONG_VIEC, 
CASE ISNULL(TG_CO_KH,0) WHEN 0 THEN NULL ELSE TG_CO_KH END AS TG_KH_CO_KH, 
CASE ISNULL(TG_KG_KH,0) WHEN 0 THEN NULL ELSE TG_KG_KH END AS TG_KH_KG_KH,
A.NGAY AS NGAY_BD_KH,  A.THOI_HAN AS NGAY_KT_KH,

CONVERT(NVARCHAR(10),CASE WHEN A.DA_XONG = 1 THEN 'X' ELSE NULL END) AS HOAN_THANH,

CONVERT(FLOAT, CASE A.DA_XONG WHEN 1 THEN 
	CASE ISNULL(TG_CO_KH,0) WHEN 0 THEN NULL ELSE TG_CO_KH END ELSE NULL END) AS TG_TT_CO_KH,
CONVERT(FLOAT, CASE A.DA_XONG WHEN 1 THEN 
	CASE ISNULL(TG_KG_KH,0) WHEN 0 THEN NULL ELSE TG_KG_KH END ELSE NULL END) AS TG_TT_KG_KH, 

CONVERT(NVARCHAR(150), NULL) AS MS_PBT, 

CONVERT(NVARCHAR(4000), HO + ' ' + TEN ) AS NGUOI_TH_PBT,


CONVERT(DATETIME, NULL) AS TU_NGAY_TT, CONVERT(DATETIME, NULL) AS DEN_NGAY_TT, 
CONVERT(NVARCHAR(500), NULL) AS TT_SAU_BT,CONVERT(FLOAT, NULL) AS TG_NM, 
CONVERT(FLOAT,CASE WHEN A.DA_XONG = 1 THEN 1 ELSE NULL END) AS PTTG_TT_KH,


A.GHI_CHU , CONVERT(INT,1) AS COT_MER,

CONVERT(FLOAT, CASE A.DA_XONG WHEN 1 THEN 
	CASE ISNULL(TG_CO_KH,0) WHEN 0 THEN NULL ELSE TG_CO_KH END ELSE NULL END) AS CO_KH_COUNT,
CONVERT(FLOAT, CASE A.DA_XONG WHEN 1 THEN 
	CASE ISNULL(TG_KG_KH,0) WHEN 0 THEN NULL ELSE TG_KG_KH END ELSE NULL END) AS KG_KH_COUNT,
	CONVERT(NVARCHAR(500), NULL) AS  MS_BO_PHAN, CONVERT(INT, NULL) AS MS_CV,
CONVERT(FLOAT, CASE ISNULL(A.DA_XONG,0) WHEN 0 THEN 
	CASE ISNULL(TG_CO_KH,0) WHEN 0 THEN NULL ELSE TG_CO_KH END ELSE NULL END) AS TG_TT_CO_KH_SUM,
CONVERT(FLOAT, CASE ISNULL(A.DA_XONG,0) WHEN 0 THEN 
	CASE ISNULL(TG_KG_KH,0) WHEN 0 THEN NULL ELSE TG_KG_KH END ELSE NULL END) AS TG_TT_KG_KH_SUM
FROM dbo.CONG_NHAN AS B INNER JOIN
         #KHTH_TMP AS A ON B.MS_CONG_NHAN = A.MS_CONG_NHAN INNER JOIN
         dbo.[TO] AS C ON B.MS_TO = C.MS_TO1 INNER JOIN
         dbo.TO_PHONG_BAN AS D ON C.MS_TO = D.MS_TO INNER JOIN 
         #USER_DV E ON D.MS_DON_VI = E.MS_DON_VI AND D.MS_TO = E.MS_TO
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY,101))  BETWEEN @TNgay AND @DNgay)
	AND  (@iLoaiBC = 0 OR @iLoaiBC = 3)  AND (D.MS_DON_VI = @MSDV OR @MSDV = '-1') 
	 AND (D.MS_TO = @MSTO OR @MSTO = -1)
)
T1

ORDER BY NGAY_BD_KH, MS_PBT, MS_MAY, TEN_MAY, TEN_LOAI_BT,TEN_BO_PHAN,TEN_CV


END 
ELSE
BEGIN
	

SELECT  ROW_NUMBER() OVER(ORDER BY NGAY_BD_KH, MS_PBT, MS_MAY, TEN_MAY, TEN_LOAI_BT,TEN_BO_PHAN,TEN_CV) AS STT ,
*  FROM
(
-- Lấy bên KHTT cho các Hang mục chưa chuyển PBT
SELECT CONVERT(nvarchar(250),@KHTT) AS LOAI_BC, D.TEN_LOAI_BT,A.MS_MAY, B.TEN_MAY, (X.MS_BO_PHAN + ' - ' + 
CASE @NNgu WHEN 0 THEN X.TEN_BO_PHAN WHEN 1 THEN ISNULL(NULLIF(X.TEN_BO_PHAN_ANH,''),X.TEN_BO_PHAN) ELSE ISNULL(NULLIF(X.TEN_BO_PHAN_HOA,''),X.TEN_BO_PHAN) END ) AS TEN_BO_PHAN, 
		CASE @NNgu WHEN 0 THEN E.MO_TA_CV WHEN 1 THEN E.MO_TA_CV_ANH ELSE E.MO_TA_CV_HOA END AS TEN_CV, 
	CASE D.HU_HONG WHEN 0 THEN 
		CASE ISNULL(A.THOI_GIAN_DU_KIEN,0) WHEN 0 THEN NULL ELSE A.THOI_GIAN_DU_KIEN END ELSE NULL END AS TG_KH_CO_KH, 
	CASE D.HU_HONG WHEN 1 THEN 
		CASE ISNULL(A.THOI_GIAN_DU_KIEN,0) WHEN 0 THEN NULL ELSE A.THOI_GIAN_DU_KIEN END ELSE NULL END  AS TG_KH_KG_KH,
	C.NGAY AS NGAY_BD_KH, C.NGAY_DK_HT AS NGAY_KT_KH, 
	CONVERT(nvarchar(10),NULL) AS HOAN_THANH,
		CONVERT(FLOAT, NULL) AS TG_TT_CO_KH, 
		CONVERT(FLOAT, NULL) AS TG_TT_KG_KH, 
	CONVERT(NVARCHAR(150), NULL) AS MS_PBT, CONVERT(NVARCHAR(4000), NULL) AS NGUOI_TH_PBT,
	CONVERT(DATETIME, NULL) AS TU_NGAY_TT, CONVERT(DATETIME, NULL) AS DEN_NGAY_TT, 
	CONVERT(NVARCHAR(500), NULL) AS TT_SAU_BT,CONVERT(FLOAT, NULL) AS TG_NM, 
	CONVERT(FLOAT, NULL) AS PTTG_TT_KH,  A.GHI_CHU , CONVERT(INT,1) AS COT_MER,

	CONVERT(FLOAT, NULL) AS CO_KH_COUNT, 
	CONVERT(FLOAT, NULL) AS KG_KH_COUNT,

	CONVERT(NVARCHAR(500), NULL) AS  MS_BO_PHAN, CONVERT(INT, NULL) AS MS_CV,
	CASE D.HU_HONG WHEN 0 THEN 
		CASE ISNULL(A.THOI_GIAN_DU_KIEN,0) WHEN 0 THEN NULL ELSE A.THOI_GIAN_DU_KIEN END ELSE NULL END AS TG_TT_CO_KH_SUM, 
	CASE D.HU_HONG WHEN 1 THEN 
		CASE ISNULL(A.THOI_GIAN_DU_KIEN,0) WHEN 0 THEN NULL ELSE A.THOI_GIAN_DU_KIEN END ELSE NULL END  AS TG_TT_KG_KH_SUM
FROM            KE_HOACH_TONG_CONG_VIEC AS A INNER JOIN
                         #MAY_TMP AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
                         dbo.KE_HOACH_TONG_THE AS C ON A.HANG_MUC_ID = C.HANG_MUC_ID INNER JOIN
                         dbo.LOAI_BAO_TRI AS D ON C.MS_LOAI_BT = D.MS_LOAI_BT INNER JOIN
                         dbo.CONG_VIEC AS E ON A.MS_CV = E.MS_CV INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS X ON A.MS_MAY = X.MS_MAY AND A.MS_BO_PHAN = X.MS_BO_PHAN
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),C.NGAY,101)) BETWEEN @TNgay AND @DNgay) AND (ISNULL(A.MS_PHIEU_BAO_TRI,'') = '') 
	AND (C.MS_LOAI_BT = @MsLBTri  OR @MsLBTri = -1) AND  (@iLoaiBC = 0 OR @iLoaiBC = 1  ) 

UNION



--Lấy all cac PBT
SELECT CONVERT(nvarchar(250),@PBT) AS LOAI_BC,D.TEN_LOAI_BT, A.MS_MAY, TEN_MAY, (X.MS_BO_PHAN + ' - ' + 
CASE @NNgu WHEN 0 THEN X.TEN_BO_PHAN WHEN 1 THEN ISNULL(NULLIF(X.TEN_BO_PHAN_ANH,''),X.TEN_BO_PHAN) ELSE ISNULL(NULLIF(X.TEN_BO_PHAN_HOA,''),X.TEN_BO_PHAN) END) AS TEN_BO_PHAN,
CASE @NNgu WHEN 0 THEN E.MO_TA_CV WHEN 1 THEN E.MO_TA_CV_ANH ELSE E.MO_TA_CV_HOA END AS TEN_CV,

CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN 
	CASE ISNULL(B.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE B.SO_GIO_KH END END ) AS TG_KH_CO_KH, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(B.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE B.SO_GIO_KH END END ) AS TG_KH_KG_KH, 
A.NGAY_BD_KH , A.NGAY_KT_KH ,

CONVERT(NVARCHAR(10),CASE WHEN A.TINH_TRANG_PBT>2 THEN 'X' ELSE NULL END) AS HOAN_THANH,

CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN 
	CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS TG_TT_CO_KH, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS TG_TT_KG_KH,
	
A.MS_PHIEU_BAO_TRI, CONVERT(NVARCHAR(4000), CASE WHEN TINH_TRANG_PBT >=3 THEN dbo.GetNhanSuPBT(A.MS_PHIEU_BAO_TRI,B.MS_BO_PHAN,B.MS_CV,0)  ELSE NULL END) AS NGUOI_TH_PBT, T3.TU_NGAY_TT , T3.DEN_NGAY_TT , A.TT_SAU_BT ,CASE ISNULL(T4.TG_NM,0) WHEN 0 THEN NULL ELSE T4.TG_NM END AS TG_NM,  
CONVERT(FLOAT, CASE ISNULL(T5.SO_GIO_KH,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT/T5.SO_GIO_KH END) AS PTTG_TT_KH,
B.GHI_CHU , CONVERT(INT,COT_MER) AS COT_MER, CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS CO_KH_COUNT, CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN CASE ISNULL(T3.SO_GIO_TT,0) WHEN 0 THEN NULL ELSE T3.SO_GIO_TT END ELSE NULL END) AS KG_KH_COUNT,		
B.MS_BO_PHAN,B.MS_CV,CONVERT(FLOAT,CASE D.HU_HONG WHEN 0 THEN CASE ISNULL(T7.SO_GIO_TT_CHUA_HT,0) WHEN 0 THEN NULL ELSE T7.SO_GIO_TT_CHUA_HT END ELSE NULL END) AS TG_TT_CO_KH_SUM, 
CONVERT(FLOAT,CASE D.HU_HONG WHEN 1 THEN 
	CASE ISNULL(T7.SO_GIO_TT_CHUA_HT,0) WHEN 0 THEN NULL ELSE T7.SO_GIO_TT_CHUA_HT END ELSE NULL END) AS TG_TT_KG_KH_SUM


FROM          


  (SELECT        Y.MS_PHIEU_BAO_TRI, SUM(SO_GIO) AS SO_GIO_TT, MIN(NGAY) AS TU_NGAY_TT,MAX(DEN_NGAY) AS DEN_NGAY_TT
                          FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC_NHAN_SU_CHI_TIET X INNER JOIN PHIEU_BAO_TRI Y ON X.MS_PHIEU_BAO_TRI = Y.MS_PHIEU_BAO_TRI
						  WHERE Y.TINH_TRANG_PBT >=3
                          GROUP BY Y.MS_PHIEU_BAO_TRI) AS T3 RIGHT OUTER JOIN
                         dbo.PHIEU_BAO_TRI AS A INNER JOIN dbo.PHIEU_BAO_TRI_CONG_VIEC AS B ON A.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI INNER JOIN
                         #MAY_TMP AS C ON A.MS_MAY = C.MS_MAY INNER JOIN
                         dbo.LOAI_BAO_TRI AS D ON A.MS_LOAI_BT = D.MS_LOAI_BT INNER JOIN
                         dbo.CONG_VIEC AS E ON B.MS_CV = E.MS_CV INNER JOIN
                         dbo.CAU_TRUC_THIET_BI AS X ON A.MS_MAY = X.MS_MAY AND B.MS_BO_PHAN = X.MS_BO_PHAN ON T3.MS_PHIEU_BAO_TRI = B.MS_PHIEU_BAO_TRI LEFT JOIN 
(SELECT        Y.MS_PHIEU_BAO_TRI, SUM(X.THOI_GIAN_SUA_CHUA) AS TG_NM
FROM            dbo.THOI_GIAN_NGUNG_MAY AS X INNER JOIN
                         dbo.THOI_GIAN_NGUNG_MAY_SO_LAN AS Y ON X.MS_LAN = Y.MS_LAN
WHERE        (ISNULL(Y.MS_PHIEU_BAO_TRI, N'') <> '')
GROUP BY X.THOI_GIAN_SUA, Y.MS_PHIEU_BAO_TRI) T4 ON A.MS_PHIEU_BAO_TRI = T4.MS_PHIEU_BAO_TRI   LEFT JOIN 
(SELECT        MS_PHIEU_BAO_TRI, SUM(SO_GIO_KH) AS SO_GIO_KH
                  FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC
                  GROUP BY MS_PHIEU_BAO_TRI) AS T5 ON A.MS_PHIEU_BAO_TRI = T5.MS_PHIEU_BAO_TRI LEFT JOIN #COT_PBT T6 ON A.MS_PHIEU_BAO_TRI = T6.MS_PHIEU_BAO_TRI
LEFT JOIN 
(SELECT        Y.MS_PHIEU_BAO_TRI,X.MS_CV,X.MS_BO_PHAN, SUM(X.SO_GIO_KH) AS SO_GIO_TT_CHUA_HT
                          FROM            dbo.PHIEU_BAO_TRI_CONG_VIEC X INNER JOIN PHIEU_BAO_TRI Y ON X.MS_PHIEU_BAO_TRI = Y.MS_PHIEU_BAO_TRI
						  WHERE Y.TINH_TRANG_PBT < 3
                          GROUP BY Y.MS_PHIEU_BAO_TRI,X.MS_CV,X.MS_BO_PHAN) AS T7 ON A.MS_PHIEU_BAO_TRI = T7.MS_PHIEU_BAO_TRI AND B.MS_CV = T7.MS_CV AND B.MS_BO_PHAN = T7.MS_BO_PHAN
                          
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY_BD_KH,101)) BETWEEN @TNgay AND @DNgay )
	AND (A.MS_LOAI_BT = @MsLBTri  OR @MsLBTri = -1)  AND  (@iLoaiBC = 0 OR @iLoaiBC = 2) 


UNION
--Lấy all kế hoach nhan6n viên
SELECT  CONVERT(nvarchar(250),@CVC) AS LOAI_BC,@TenLBTri AS TEN_LOAI_BT,NULL AS MS_MAY, NULL AS TEN_MAY,NULL AS TEN_BO_PHAN,A.TEN_CONG_VIEC, 
CASE ISNULL(TG_CO_KH,0) WHEN 0 THEN NULL ELSE TG_CO_KH END AS TG_KH_CO_KH, 
CASE ISNULL(TG_KG_KH,0) WHEN 0 THEN NULL ELSE TG_KG_KH END AS TG_KH_KG_KH,
A.NGAY AS NGAY_BD_KH,  A.THOI_HAN AS NGAY_KT_KH,

CONVERT(NVARCHAR(10),CASE WHEN A.DA_XONG = 1 THEN 'X' ELSE NULL END) AS HOAN_THANH,

CONVERT(FLOAT, CASE A.DA_XONG WHEN 1 THEN 
	CASE ISNULL(TG_CO_KH,0) WHEN 0 THEN NULL ELSE TG_CO_KH END ELSE NULL END)AS TG_TT_CO_KH,
CONVERT(FLOAT, CASE A.DA_XONG WHEN 1 THEN 
	CASE ISNULL(TG_KG_KH,0) WHEN 0 THEN NULL ELSE TG_KG_KH END ELSE NULL END) AS TG_TT_KG_KH, 

CONVERT(NVARCHAR(150), NULL) AS MS_PBT, 
CONVERT(NVARCHAR(4000), HO + ' ' + TEN ) AS NGUOI_TH_PBT,
CONVERT(DATETIME, NULL) AS TU_NGAY_TT, CONVERT(DATETIME, NULL) AS DEN_NGAY_TT, 
CONVERT(NVARCHAR(500), NULL) AS TT_SAU_BT,CONVERT(FLOAT, NULL) AS TG_NM, 
CONVERT(FLOAT,CASE WHEN A.DA_XONG = 1 THEN 1 ELSE NULL END) AS PTTG_TT_KH,

A.GHI_CHU , CONVERT(INT,1) AS COT_MER,

CONVERT(FLOAT, CASE A.DA_XONG WHEN 1 THEN 
	CASE ISNULL(TG_CO_KH,0) WHEN 0 THEN NULL ELSE TG_CO_KH END ELSE NULL END) AS CO_KH_COUNT,
CONVERT(FLOAT, CASE A.DA_XONG WHEN 1 THEN 
	CASE ISNULL(TG_KG_KH,0) WHEN 0 THEN NULL ELSE TG_KG_KH END ELSE NULL END) AS KG_KH_COUNT,
	CONVERT(NVARCHAR(500), NULL) AS  MS_BO_PHAN, CONVERT(INT, NULL) AS MS_CV,
CONVERT(FLOAT, CASE ISNULL(A.DA_XONG,0) WHEN 0 THEN 
	CASE ISNULL(TG_CO_KH,0) WHEN 0 THEN NULL ELSE TG_CO_KH END ELSE NULL END) AS TG_TT_CO_KH_SUM,
CONVERT(FLOAT, CASE ISNULL(A.DA_XONG,0) WHEN 0 THEN 
	CASE ISNULL(TG_KG_KH,0) WHEN 0 THEN NULL ELSE TG_KG_KH END ELSE NULL END) AS TG_TT_KG_KH_SUM

FROM dbo.CONG_NHAN AS B INNER JOIN
         #KHTH_TMP AS A ON B.MS_CONG_NHAN = A.MS_CONG_NHAN INNER JOIN
         dbo.[TO] AS C ON B.MS_TO = C.MS_TO1 INNER JOIN
         dbo.TO_PHONG_BAN AS D ON C.MS_TO = D.MS_TO INNER JOIN 
         #USER_DV E ON D.MS_DON_VI = E.MS_DON_VI AND D.MS_TO = E.MS_TO
WHERE (CONVERT(DATETIME,CONVERT(NVARCHAR(10),A.NGAY,101))  BETWEEN @TNgay AND @DNgay)
	AND  (@iLoaiBC = 0 OR @iLoaiBC = 3)  AND (D.MS_DON_VI = @MSDV OR @MSDV = '-1') 
	 AND (D.MS_TO = @MSTO OR @MSTO = -1)
)
T1

ORDER BY NGAY_BD_KH, MS_PBT, MS_MAY, TEN_MAY, TEN_LOAI_BT,TEN_BO_PHAN,TEN_CV


END