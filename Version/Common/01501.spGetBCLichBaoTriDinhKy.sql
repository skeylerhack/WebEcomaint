IF NOT EXISTS(SELECT *	FROM	sys.objects WHERE type='P' AND name='spGetBCLichBaoTriDinhKy')
EXEC('CREATE PROCEDURE spGetBCLichBaoTriDinhKy AS BEGIN SET NOCOUNT ON;  END');

GO
IF  EXISTS(SELECT *	FROM	sys.objects WHERE type='P' AND name='SP_NHU_Y_GET_KE_HOACH_BAO_TRI_TB_THANG_COLGATE')
EXEC('DROP PROCEDURE  SP_NHU_Y_GET_KE_HOACH_BAO_TRI_TB_THANG_COLGATE ');

-- exec [spGetBCLichBaoTriDinhKy] 'admin',0,'01/01/2019','01/31/2019','-1', -1,'-1',1
GO
ALTER PROCEDURE spGetBCLichBaoTriDinhKy
	@UserName NVARCHAR(50) ='admin',
	@NNgu INT =0,
	@TuNgay DATETIME =  '01/01/2019',
	@DenNgay DATETIME = '12/31/2019',
	@MsNhaXuong NVARCHAR(50) ='-1',
	@MsHeThong INT =-1,
	@MsLoaiMay nvarchar(50) ='-1',
	@LoaiBC INT = 1
AS
begin

--@LoaiBC = 0 Co xoa KHTT va PBT 
--@LoaiBC = 1 Khong xoa KHTT va PBT 


SELECT * INTO #MAY FROM dbo.MGetMayUserNgay(@TuNgay,@UserName,@MsNhaXuong,@MsHeThong,-1,@MsLoaiMay,'-1', '-1',@NNgu)  

SELECT     TOP (100) PERCENT A.MS_MAY, A.MS_LOAI_BT, convert(varchar, A.NGAY_HC_CUOI, 103) AS NGAY_CUOI , A.CHU_KY, A.MS_DV_TG, A.NGAY_KE AS NGAY_BTKT, CONVERT(BIT,0) AS CO_BT INTO #HIEU_CHUAN_KE
FROM         dbo.MGetNgayHieuChuanKeBaoTri(@TuNgay, @DenNgay, @UserName, @MsNhaXuong, @MsHeThong, @MsLoaiMay, '-1', 1) AS A  INNER JOIN #MAY T1 ON T1.MS_MAY = A.MS_MAY
ORDER BY A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI, A.CHU_KY, A.MS_DV_TG, A.NGAY_KE



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


--@LoaiBC = 0 Co xoa trong KHTT va PBT da lap
--@LoaiBC = 1 Khong xoa trong KHTT va PBT da lap
IF @LoaiBC = 0 
BEGIN
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
ELSE
BEGIN
	--Cap nhap các may có ngay cuối nằm trong 1/4 chu ky về 1 màu 
	INSERT INTO	#HIEU_CHUAN_KE(MS_MAY, MS_LOAI_BT, CHU_KY, MS_DV_TG, NGAY_BTKT,NGAY_CUOI,CO_BT)
	SELECT T1.MS_MAY,T2.MS_LOAI_BT,T2.CHU_KY ,T2.MS_DV_TG, T1.NGAY_BTDK_GOC,convert(varchar,NGAY_HC_CUOI,103),1 FROM dbo.PHIEU_BAO_TRI T1 INNER JOIN 
	(
				
								SELECT     dbo.MAY_LOAI_BTPN.MS_MAY, dbo.MAY_LOAI_BTPN.MS_LOAI_BT, T_1.MS_DV_TG, T_1.CHU_KY, ISNULL(NGAY_CUOI,T1.NGAY_DUA_VAO_SD) AS NGAY_HC_CUOI
								FROM         dbo.MAY_LOAI_BTPN INNER JOIN
														  (SELECT     T2.MS_MAY, T2.MS_LOAI_BT, T2.CHU_KY, T2.MS_DV_TG
															FROM          (SELECT     T1.MS_MAY, MS_LOAI_BT, MAX(NGAY_AD) AS NGAY_AD
																					FROM          dbo.MAY_LOAI_BTPN_CHU_KY AS T1 INNER JOIN 
															#MAY T3 ON T1.MS_MAY = T3.MS_MAY	
																					GROUP BY T1.MS_MAY, MS_LOAI_BT) AS T1 INNER JOIN
																				   dbo.MAY_LOAI_BTPN_CHU_KY AS T2 ON T1.MS_MAY = T2.MS_MAY AND T1.MS_LOAI_BT = T2.MS_LOAI_BT AND 
																				   T1.NGAY_AD = T2.NGAY_AD) AS T_1 ON dbo.MAY_LOAI_BTPN.MS_MAY = T_1.MS_MAY AND 
													  dbo.MAY_LOAI_BTPN.MS_LOAI_BT = T_1.MS_LOAI_BT INNER JOIN MAY T1 ON T1.MS_MAY = MAY_LOAI_BTPN.MS_MAY	
								WHERE     (T_1.CHU_KY IS NOT NULL) AND ISNULL(MS_DV_TG, 0 ) <> 0	
							) T2 ON T1.MS_MAY = T2.MS_MAY AND T1.MS_LOAI_BT = T2.MS_LOAI_BT 
	WHERE	NGAY_BTDK_GOC BETWEEN	@TuNgay AND @DenNgay

	UPDATE #HIEU_CHUAN_KE SET CO_BT = 1
	FROM #HIEU_CHUAN_KE T INNER JOIN
	dbo.KE_HOACH_TONG_THE T1 ON T.MS_MAY = T1.MS_MAY AND 	T.MS_LOAI_BT = T1.MS_LOAI_BT 
	WHERE DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_BTKT) >= T1.NGAY 
		AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_BTKT) <= T1.NGAY 
	
	UPDATE #HIEU_CHUAN_KE SET CO_BT = 1
	FROM #HIEU_CHUAN_KE T INNER JOIN dbo.PHIEU_BAO_TRI T1 ON T.MS_MAY = T1.MS_MAY AND T.MS_LOAI_BT = T1.MS_LOAI_BT 
	WHERE DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_BTKT) >= T1.NGAY_BD_KH 
	AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_BTKT) <= T1.NGAY_BD_KH 
	--	EXEC [SP_NHU_Y_GET_KE_HOACH_BAO_TRI_TB_THANG_COLGATE] '01-01-2019','12-31-2019','-1','-1','administrator','administrator',1,1,-1
		
END	


DECLARE @CTY NVARCHAR(50)
SELECT TOP 1 @CTY = [PRIVATE] FROM dbo.THONG_TIN_CHUNG
IF @LoaiBC = 1 AND @CTY = 'VIFON'
BEGIN
	--Cap nhap ngay ke = ngay da thay doi ben KHTT 
	UPDATE #HIEU_CHUAN_KE SET NGAY_BTKT = T1.NGAY
	FROM #HIEU_CHUAN_KE T INNER JOIN
	dbo.KE_HOACH_TONG_THE T1 ON T.MS_MAY = T1.MS_MAY AND 
	T.MS_LOAI_BT = T1.MS_LOAI_BT 
	WHERE DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_BTKT) >= T1.NGAY 
		AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_BTKT) <= T1.NGAY 

	UPDATE #HIEU_CHUAN_KE SET NGAY_BTKT = T1.NGAY_BD_KH
	FROM #HIEU_CHUAN_KE T INNER JOIN dbo.PHIEU_BAO_TRI T1 ON T.MS_MAY = T1.MS_MAY AND T.MS_LOAI_BT = T1.MS_LOAI_BT 
	WHERE DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_BTKT) >= T1.NGAY_BD_KH 
	AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_BTKT) <= T1.NGAY_BD_KH 
END	



--SELECT * FROM #HIEU_CHUAN_KE WHERE MS_MAY = 'DGD-01-04' --AND NGAY_BTKT BETWEEN @NGAY_BAT_DAU AND @NGAY_KET_THUC

SELECT DISTINCT A.MS_MAY, E.TEN_MAY, A.MS_LOAI_BT,TEN_LOAI_BT,CASE A.CO_BT WHEN 0 THEN B.THU_TU ELSE -1 END AS THU_TU,
NGAY_CUOI, CONVERT(NVARCHAR(10), A.CHU_KY) + ' ' + 
CASE @NNgu WHEN 0 THEN D.TEN_DV_TG WHEN 1 THEN D.TEN_DV_TG_ANH ELSE D.TEN_DV_TG_HOA END AS CHU_KY, NGAY_BTKT AS NGAY_KE,
E.MS_N_XUONG,E.Ten_N_XUONG,
CASE A.CO_BT WHEN 0 THEN ISNULL(G.R,0) ELSE 0 END AS R,
CASE A.CO_BT WHEN 0 THEN ISNULL(G.G,0) ELSE 0 END AS G,
CASE A.CO_BT WHEN 0 THEN ISNULL(	G.B,0) ELSE 0 END AS B
--ISNULL(R,0) AS R, ISNULL(G,0) AS G,ISNULL(B,0) AS B
FROM #HIEU_CHUAN_KE  A INNER JOIN LOAI_BAO_TRI B ON B.MS_LOAI_BT = A.MS_LOAI_BT INNER JOIN
V_MAY_LOAI_BTPN_CHU_KY_MAX C ON A.MS_MAY = C.MS_MAY AND C.MS_LOAI_BT = A.MS_LOAI_BT INNER JOIN  
dbo.DON_VI_THOI_GIAN AS D ON C.MS_DV_TG = D.MS_DV_TG INNER JOIN 
#MAY E ON A.MS_MAY = E.MS_MAY INNER JOIN NHOM_MAY F ON
E.MS_NHOM_MAY = F.MS_NHOM_MAY LEFT JOIN LOAI_BAO_TRI_MAU G ON A.MS_LOAI_BT = G.LOAI_BT
WHERE NGAY_BTKT BETWEEN @TuNgay AND @DenNgay 
ORDER BY A.MS_MAY ,A.MS_LOAI_BT, NGAY_CUOI, NGAY_BTKT



end


