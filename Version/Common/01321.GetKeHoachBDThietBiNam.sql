
--	exec GetKeHoachBDThietBiNam '01/01/2018', '12/30/2018', 'VF01','ADMIN','-1',12,'Ma','Ten','KhuVuc','ViTri',1,0
--

ALTER procedure [dbo].[GetKeHoachBDThietBiNam] 
	@NGAY_BAT_DAU DATETIME,
	@NGAY_KET_THUC DATETIME,
	@MS_NHA_XUONG nvarchar(50),
	@UserName NVARCHAR(255),
	@LoaiMay NVARCHAR (20),
	@NHeThong int,
	@Ma nvarchar(150),
	@Ten nvarchar(150),
	@KhuVuc nvarchar(150),
	@ViTri nvarchar(150), 
	@TYPELANG int,
	@LoaiBC INT
AS
begin
--------------------

SELECT * INTO #MAY_USER FROM [dbo].[MGetMayUserNgay](@NGAY_BAT_DAU,@USERNAME,@MS_NHA_XUONG,@NHeThong,-1,@LoaiMay,'-1','-1',@TYPELANG)

SELECT A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI AS NGAY_CUOI , A.CHU_KY, A.MS_DV_TG, A.NGAY_KE AS NGAY_BTKT INTO #HIEU_CHUAN_KE
FROM         dbo.MGetNgayHieuChuanKeBaoTri(@NGAY_BAT_DAU, @NGAY_KET_THUC, @UserName, @MS_NHA_XUONG, -1, '-1', '-1', 1) AS A 
ORDER BY A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI, A.CHU_KY, A.MS_DV_TG, A.NGAY_KE


IF @LoaiBC = 0 
BEGIN
--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con
DELETE T1
FROM         dbo.LOAI_BAO_TRI_QH INNER JOIN
                      #HIEU_CHUAN_KE AS T1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = T1.MS_LOAI_BT INNER JOIN
                      #HIEU_CHUAN_KE AS T2 ON T1.MS_MAY = T2.MS_MAY AND dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = T2.MS_LOAI_BT 
WHERE DATEADD(DAY, CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4, T1.NGAY_BTKT) >= T2.NGAY_BTKT 
AND DATEADD(DAY, - (CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4), T1.NGAY_BTKT) <= T2.NGAY_BTKT 
 
--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con trong PBT
DELETE T1
FROM         dbo.LOAI_BAO_TRI_QH INNER JOIN
                      #HIEU_CHUAN_KE AS T1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = T1.MS_LOAI_BT INNER JOIN
                      PHIEU_BAO_TRI AS T2 ON T1.MS_MAY = T2.MS_MAY AND dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = T2.MS_LOAI_BT 
WHERE DATEADD(DAY, CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4, T1.NGAY_BTKT) >= T2.NGAY_BD_KH 
AND DATEADD(DAY, - (CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4), T1.NGAY_BTKT) <= T2.NGAY_BD_KH

--Xóa dữ liệu quan hệ trong khoảng 1/4 chu kỳ của bảo trì con trong KHTT 
DELETE T1
FROM         dbo.LOAI_BAO_TRI_QH INNER JOIN
                      #HIEU_CHUAN_KE AS T1 ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = T1.MS_LOAI_BT INNER JOIN
                      KE_HOACH_TONG_THE AS T2 ON T1.MS_MAY = T2.MS_MAY AND dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = T2.MS_LOAI_BT 
WHERE DATEADD(DAY, CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4, T1.NGAY_BTKT) >= T2.NGAY
AND DATEADD(DAY, - (CASE T1.MS_DV_TG WHEN 2 THEN T1.CHU_KY * 7 WHEN 3 THEN T1.CHU_KY * 30 WHEN 4 THEN T1.CHU_KY * 365 ELSE T1.CHU_KY END / 4), T1.NGAY_BTKT) <= T2.NGAY
 
  --Xóa bảo trì định kỳ đã lập bên kế hoạch tổng thể và phiếu bảo trì TRONG 1/4 CHU KY
DELETE T
FROM #HIEU_CHUAN_KE T INNER JOIN
dbo.KE_HOACH_TONG_THE T1 ON T.MS_MAY = T1.MS_MAY AND 
T.MS_LOAI_BT = T1.MS_LOAI_BT 
WHERE DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_BTKT) >= T1.NGAY 
	AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_BTKT) <= T1.NGAY 

DELETE T
FROM #HIEU_CHUAN_KE T INNER JOIN dbo.PHIEU_BAO_TRI T1 ON T.MS_MAY = T1.MS_MAY AND T.MS_LOAI_BT = T1.MS_LOAI_BT 
WHERE DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_BTKT) >= T1.NGAY_BD_KH 
AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_BTKT) <= T1.NGAY_BD_KH 
END	



-------------


SELECT DISTINCT T.MS_MAY, A.TEN_MAY, T5.Ten_N_XUONG, T4.TEN_HE_THONG, T1.MS_BO_PHAN, T3.TEN_BO_PHAN, T.CHU_KY,MS_DV_TG,NGAY_CUOI,
	MONTH(T.NGAY_BTKT) AS THANG, A.MS_N_XUONG,A.MS_HE_THONG, T1.MS_LOAI_BT ,T.NGAY_BTKT AS NGAY_KE  
	INTO #TMPthongtinthietbi_tmp
FROM #MAY_USER AS A INNER JOIN
#HIEU_CHUAN_KE AS T INNER JOIN
dbo.MAY_LOAI_BTPN_CONG_VIEC AS T1 ON T.MS_MAY = T1.MS_MAY AND T.MS_LOAI_BT = T1.MS_LOAI_BT INNER JOIN
dbo.CONG_VIEC AS T2 ON T1.MS_CV = T2.MS_CV INNER JOIN
dbo.CAU_TRUC_THIET_BI AS T3 ON T1.MS_MAY = T3.MS_MAY AND T1.MS_BO_PHAN = T3.MS_BO_PHAN ON A.MS_MAY = T.MS_MAY INNER JOIN
dbo.MAY_HE_THONG_NGAY_MAX AS T4 ON T.MS_MAY = T4.MS_MAY INNER JOIN
dbo.MAY_NHA_XUONG_NGAY_MAX AS T5 ON T.MS_MAY = T5.MS_MAY LEFT OUTER JOIN
dbo.MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG AS T6 INNER JOIN
dbo.DON_VI_TINH INNER JOIN dbo.IC_PHU_TUNG ON dbo.DON_VI_TINH.DVT = dbo.IC_PHU_TUNG.DVT ON T6.MS_PT = dbo.IC_PHU_TUNG.MS_PT 
ON T1.MS_MAY = T6.MS_MAY AND T1.MS_LOAI_BT = T6.MS_LOAI_BT AND T1.MS_CV = T6.MS_CV AND T1.MS_BO_PHAN = T6.MS_BO_PHAN
WHERE NGAY_BTKT BETWEEN @NGAY_BAT_DAU AND @NGAY_KET_THUC 

SELECT MS_MAY, TEN_MAY, Ten_N_XUONG, TEN_HE_THONG, MS_BO_PHAN, TEN_BO_PHAN, CHU_KY, MS_DV_TG, NGAY_CUOI, 
	CONVERT(NVARCHAR(10),[1]) AS [1] , CONVERT(NVARCHAR(10),[2]) AS [2] , CONVERT(NVARCHAR(10),[3]) AS [3] , CONVERT(NVARCHAR(10),[4]) AS [4] , 
	CONVERT(NVARCHAR(10),[5]) AS [5] , CONVERT(NVARCHAR(10),[6]) AS [6] , CONVERT(NVARCHAR(10),[7]) AS [7] ,CONVERT(NVARCHAR(10),[8]) AS [8] , 
	CONVERT(NVARCHAR(10),[9]) AS [9], CONVERT(NVARCHAR(10),[10]) AS [10], CONVERT(NVARCHAR(10),[11]) AS [11], CONVERT(NVARCHAR(10),[12]) AS [12]
INTO #TMP_PIVOL FROM
	(SELECT     MS_MAY, TEN_MAY, Ten_N_XUONG, TEN_HE_THONG, MS_BO_PHAN, TEN_BO_PHAN, CHU_KY,MS_DV_TG, 
		NGAY_CUOI, THANG,MS_LOAI_BT FROM #TMPthongtinthietbi_tmp) p
PIVOT 
	(SUM(MS_LOAI_BT)  FOR [THANG] IN ([1], [2], [3], [4], [5], [6], [7],[8],[9],[10],[11],[12])) AS pvt 

UPDATE #TMP_PIVOL SET [1] = 'X' WHERE [1] IS NOT NULL
UPDATE #TMP_PIVOL SET [2] = 'X' WHERE [2] IS NOT NULL
UPDATE #TMP_PIVOL SET [3] = 'X' WHERE [3] IS NOT NULL
UPDATE #TMP_PIVOL SET [4] = 'X' WHERE [4] IS NOT NULL
UPDATE #TMP_PIVOL SET [5] = 'X' WHERE [5] IS NOT NULL
UPDATE #TMP_PIVOL SET [6] = 'X' WHERE [6] IS NOT NULL
UPDATE #TMP_PIVOL SET [7] = 'X' WHERE [7] IS NOT NULL
UPDATE #TMP_PIVOL SET [8] = 'X' WHERE [8] IS NOT NULL
UPDATE #TMP_PIVOL SET [9] = 'X' WHERE [9] IS NOT NULL
UPDATE #TMP_PIVOL SET [10] = 'X' WHERE [10] IS NOT NULL
UPDATE #TMP_PIVOL SET [11] = 'X' WHERE [11] IS NOT NULL
UPDATE #TMP_PIVOL SET [12] = 'X' WHERE [12] IS NOT NULL

 
 SELECT ROW_NUMBER() OVER(PARTITION BY MS_MAY ORDER BY TEN_MAY, Ten_N_XUONG, TEN_HE_THONG, MS_BO_PHAN, TEN_BO_PHAN, CHU_KY, A.MS_DV_TG, NGAY_CUOI) AS STT , 
 CONVERT(NVARCHAR(2000),	ISNULL(MS_MAY,'') + '     ' +  	@Ten + ' : ' + ISNULL(TEN_MAY,'') + '     ' +  @KhuVuc + ' : ' + ISNULL(Ten_N_XUONG,'') + '     ' +  	@ViTri + ' : ' + ISNULL(TEN_HE_THONG,'') + '     ')  As MS_MAY, 
	
	MS_BO_PHAN, TEN_BO_PHAN, 
	CONVERT(NVARCHAR(200) ,CONVERT(NVARCHAR(10) ,CHU_KY ) + ' '  + CASE @TYPELANG WHEN 0 THEN TEN_DV_TG WHEN 1 THEN TEN_DV_TG_ANH ELSE TEN_DV_TG_HOA END ) AS CHU_KY_TG
	, NGAY_CUOI, [1], [2], [3], [4], [5], [6], [7],[8],[9],[10],[11],[12]
 FROM #TMP_PIVOL A INNER JOIN DON_VI_THOI_GIAN B ON A.MS_DV_TG = B.MS_DV_TG  

 ORDER BY MS_MAY, TEN_MAY, Ten_N_XUONG, TEN_HE_THONG, MS_BO_PHAN, TEN_BO_PHAN, CHU_KY, A.MS_DV_TG, NGAY_CUOI

 
--	exec GetKeHoachBDThietBiNam '01/01/2013', '12/31/2013', '-1','administrator','-1',-1,'Ma','Ten','KhuVuc','ViTri',0
END

