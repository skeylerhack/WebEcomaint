

--	exec GetKHTT '02/01/2016', '02/29/2016', '-1',  -1, '-1', '-1', 'BOL-1501', 'ADMIN'
-- SELECT * FROM KHBT_NAMAdministrator

ALTER procedure [dbo].[GetKHTT] 
	@NgayBD DATETIME,
	@NgayKT DATETIME,
	@MsNXuong nvarchar(50),
	@HThong NVARCHAR(255),	
	@LoaiMay NVARCHAR(20),
	@NhomMay NVARCHAR(20),
	@MsMay NVARCHAR(30),
	@UserName NVARCHAR(255)
AS
begin

			
	
SELECT     TOP (100) PERCENT A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI AS NGAY_CUOI , A.CHU_KY, A.MS_DV_TG, A.NGAY_KE AS NGAY_BTKT INTO #HIEU_CHUAN_KE
FROM         dbo.MGetNgayHieuChuanKeBaoTri(@NgayBD, @NgayKT, @UserName, @MsNXuong, @HThong, @LoaiMay, @NhomMay, 1) AS A INNER JOIN
                      dbo.MAY_NHA_XUONG_NGAY_MAX AS B ON A.MS_MAY = B.MS_MAY INNER JOIN
                      dbo.NHA_XUONG AS C ON B.MS_N_XUONG = C.MS_N_XUONG
WHERE     (A.MS_MAY = @MsMay OR @MsMay = '-1') 
ORDER BY A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI, A.CHU_KY, A.MS_DV_TG, A.NGAY_KE



DELETE A
FROM         dbo.LOAI_BAO_TRI_QH INNER JOIN
                      #HIEU_CHUAN_KE AS A ON dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CD = A.MS_LOAI_BT INNER JOIN
                      #HIEU_CHUAN_KE AS B ON A.MS_MAY = B.MS_MAY AND 
                      dbo.LOAI_BAO_TRI_QH.MS_LOAI_BT_CT = B.MS_LOAI_BT 
WHERE                      
CASE A.MS_DV_TG WHEN 1 THEN  DATEADD(DAY,A.CHU_KY,B.NGAY_BTKT)
						WHEN 2 THEN DATEADD(DAY,7 * A.CHU_KY ,B.NGAY_BTKT)
						WHEN 3 THEN DATEADD(MONTH,A.CHU_KY,B.NGAY_BTKT) 
						WHEN 4 THEN DATEADD(YEAR,A.CHU_KY,B.NGAY_BTKT)												
						ELSE 
							DATEADD(YEAR,1,@NgayKT)												
						END  >= B.NGAY_BTKT 
AND CASE A.MS_DV_TG WHEN 1 THEN  DATEADD(DAY,-A.CHU_KY,B.NGAY_BTKT)
						WHEN 2 THEN DATEADD(DAY, -(7 * A.CHU_KY) ,B.NGAY_BTKT)
						WHEN 3 THEN DATEADD(MONTH,-A.CHU_KY,B.NGAY_BTKT) 
						WHEN 4 THEN DATEADD(YEAR,-A.CHU_KY,B.NGAY_BTKT)												
						ELSE 
							DATEADD(YEAR,-1,@NgayKT)												
						END <= B.NGAY_BTKT 
						                      

--Xóa bảo trì định kỳ đã lập bên kế hoạch tổng thể và phiếu bảo trì TRONG 1/4 CHU KY
DELETE T
FROM #HIEU_CHUAN_KE T INNER JOIN
dbo.KE_HOACH_TONG_THE T1 ON T.MS_MAY = T1.MS_MAY AND 
T.MS_LOAI_BT = T1.MS_LOAI_BT 
WHERE
CASE T.MS_DV_TG WHEN 1 THEN  DATEADD(DAY,CHU_KY/4,NGAY_BTKT)
						WHEN 2 THEN DATEADD(DAY,(7 * CHU_KY) / 4 ,NGAY_BTKT)
						WHEN 3 THEN DATEADD(MONTH,CHU_KY/4,NGAY_BTKT) 
						WHEN 4 THEN DATEADD(YEAR,CHU_KY/4,NGAY_BTKT)												
						ELSE 
							DATEADD(YEAR,1,@NgayKT)												
						END  >= T1.NGAY 
AND CASE T.MS_DV_TG WHEN 1 THEN  DATEADD(DAY,-CHU_KY/4,NGAY_BTKT)
						WHEN 2 THEN DATEADD(DAY, -(7 * CHU_KY) / 4 ,NGAY_BTKT)
						WHEN 3 THEN DATEADD(MONTH,-CHU_KY / 4,NGAY_BTKT) 
						WHEN 4 THEN DATEADD(YEAR,-CHU_KY / 4,NGAY_BTKT)												
						ELSE 
							DATEADD(YEAR,-1,@NgayKT)												
						END <= T1.NGAY 

DELETE T
FROM #HIEU_CHUAN_KE T INNER JOIN
dbo.PHIEU_BAO_TRI T1 ON T.MS_MAY = T1.MS_MAY AND 
T.MS_LOAI_BT = T1.MS_LOAI_BT 
WHERE
CASE T.MS_DV_TG WHEN 1 THEN  DATEADD(DAY,CHU_KY,NGAY_BTKT)
						WHEN 2 THEN DATEADD(DAY,7 * CHU_KY  / 4,NGAY_BTKT)
						WHEN 3 THEN DATEADD(MONTH,CHU_KY / 4,NGAY_BTKT) 
						WHEN 4 THEN DATEADD(YEAR,CHU_KY / 4,NGAY_BTKT)												
						ELSE 
							DATEADD(YEAR,1,@NgayKT)												
						END  >= T1.NGAY_BD_KH 
AND CASE T.MS_DV_TG WHEN 1 THEN  DATEADD(DAY,-CHU_KY / 4,NGAY_BTKT)
						WHEN 2 THEN DATEADD(DAY, -(7 * CHU_KY) / 4 ,NGAY_BTKT)
						WHEN 3 THEN DATEADD(MONTH,-CHU_KY / 4,NGAY_BTKT) 
						WHEN 4 THEN DATEADD(YEAR,-CHU_KY / 4,NGAY_BTKT)												
						ELSE 
							DATEADD(YEAR,-1,@NgayKT)												
						END <= T1.NGAY_BD_KH 

--DATEADD(DAY,  CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4, T.NGAY_BTKT) >= T1.NGAY_BD_KH 
--AND DATEADD(DAY, - (CASE T.MS_DV_TG WHEN 2 THEN T.CHU_KY * 7 WHEN 3 THEN T.CHU_KY * 30 WHEN 4 THEN T.CHU_KY * 365 ELSE T.CHU_KY END / 4), T.NGAY_BTKT) <= T1.NGAY_BD_KH 


SELECT CONVERT(BIT,0) AS chkChon, A.MS_MAY, E.TEN_MAY, TEN_LOAI_BT, NGAY_CUOI, NGAY_BTKT,CONVERT(NVARCHAR(10), C.RUN_TIME) + ' ' + D.TEN_DVT_RT AS TGCM, 
	CAST      (dbo.[GetThoiGianHienTaiDHD](A.MS_MAY, C.MS_DV_TG , C.CHU_KY, A.NGAY_BTKT, A.NGAY_CUOI) AS NVARCHAR)  + ' ' + TEN_DVT_RT AS TGCM_HIEN_TAI,
	A.MS_LOAI_BT, THU_TU, TEN_NHOM_MAY, CONVERT(FLOAT, ISNULL( dbo.[GetThoiGianHienTaiDHD](A.MS_MAY, C.MS_DV_TG , 
	C.CHU_KY, A.NGAY_BTKT, A.NGAY_CUOI),0)) AS TG_THUC_HIEN ,  ISNULL(C.RUN_TIME,0) AS RUN_TIME
FROM #HIEU_CHUAN_KE  A INNER JOIN LOAI_BAO_TRI B ON B.MS_LOAI_BT = A.MS_LOAI_BT INNER JOIN
V_MAY_LOAI_BTPN_CHU_KY_MAX C ON A.MS_MAY = C.MS_MAY AND C.MS_LOAI_BT = A.MS_LOAI_BT INNER JOIN  
dbo.DON_VI_TINH_RUN_TIME AS D ON C.MS_DVT_RT = D.MS_DVT_RT INNER JOIN 
MAY E ON A.MS_MAY = E.MS_MAY INNER JOIN NHOM_MAY F ON
E.MS_NHOM_MAY = F.MS_NHOM_MAY
WHERE NGAY_BTKT BETWEEN @NgayBD AND @NgayKT
ORDER BY A.MS_MAY ,A.MS_LOAI_BT, NGAY_CUOI, NGAY_BTKT
END



