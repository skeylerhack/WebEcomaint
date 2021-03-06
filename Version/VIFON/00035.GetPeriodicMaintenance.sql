
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetPeriodicMaintenance')
   exec('CREATE PROCEDURE GetPeriodicMaintenance AS BEGIN SET NOCOUNT ON; END')
GO


ALTER procedure GetPeriodicMaintenance
	@startDate DATETIME,
	@endDate DATETIME,
	@workSiteID nvarchar(50),
	@formationID NVARCHAR(255),	
	@typeOfDevice NVARCHAR(20),
	@groupDevice NVARCHAR(20),
	@deviceID NVARCHAR(30),
	@userName NVARCHAR(255),
	@timeOut bit 
AS
begin

	
SELECT     TOP (100) PERCENT A.MS_MAY, A.MS_LOAI_BT, A.NGAY_HC_CUOI AS NGAY_CUOI , A.CHU_KY, A.MS_DV_TG, A.NGAY_KE AS NGAY_BTKT INTO #HIEU_CHUAN_KE
FROM         dbo.MGetNgayHieuChuanKeBaoTri(@startDate, @endDate, @userName, @workSiteID, @formationID, @typeOfDevice, @groupDevice, 1) AS A 
WHERE     (A.MS_MAY = @deviceID OR @deviceID = '-1') 
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
	


SELECT DISTINCT A.MS_MAY, E.TEN_MAY, TEN_LOAI_BT, NGAY_CUOI, NGAY_BTKT,CONVERT(NVARCHAR(10), C.RUN_TIME) + ' ' + D.TEN_DVT_RT AS TGCM, 
	CAST      (dbo.[GetThoiGianHienTaiDHD](A.MS_MAY, C.MS_DV_TG , C.CHU_KY, A.NGAY_BTKT, A.NGAY_CUOI) AS NVARCHAR)  + ' ' + TEN_DVT_RT AS TGCM_HIEN_TAI,
	A.MS_LOAI_BT, THU_TU, TEN_NHOM_MAY, CONVERT(FLOAT, ISNULL( dbo.[GetThoiGianHienTaiDHD](A.MS_MAY, C.MS_DV_TG , 
	C.CHU_KY, A.NGAY_BTKT, A.NGAY_CUOI),0)) AS TG_THUC_HIEN ,  ISNULL(C.RUN_TIME,0) AS RUN_TIME INTO #TMP
FROM #HIEU_CHUAN_KE  A INNER JOIN LOAI_BAO_TRI B ON B.MS_LOAI_BT = A.MS_LOAI_BT INNER JOIN
V_MAY_LOAI_BTPN_CHU_KY_MAX C ON A.MS_MAY = C.MS_MAY AND C.MS_LOAI_BT = A.MS_LOAI_BT INNER JOIN  
dbo.DON_VI_TINH_RUN_TIME AS D ON C.MS_DVT_RT = D.MS_DVT_RT INNER JOIN 
MAY E ON A.MS_MAY = E.MS_MAY INNER JOIN NHOM_MAY F ON
E.MS_NHOM_MAY = F.MS_NHOM_MAY
WHERE NGAY_BTKT BETWEEN @startDate AND @endDate
ORDER BY A.MS_MAY ,A.MS_LOAI_BT, NGAY_CUOI, NGAY_BTKT


IF @timeOut = 1
BEGIN
	SELECT T.MS_MAY DeviceID, T.TEN_MAY DeviceName, TEN_LOAI_BT TypeOfMaintenanceName, NGAY_CUOI LastDate, NGAY_BTKT NextDate,T.TGCM RuntimeCycle, T.TGCM_HIEN_TAI CurrentRunTime, T.MS_LOAI_BT TypesOfMaintenanceID, T.THU_TU [Index], T.TEN_NHOM_MAY DeviceGroupName, T.TG_THUC_HIEN DateProcessed, T.RUN_TIME Runtime, T1.MUC_UU_TIEN PriorityID FROM #TMP T LEFT JOIN MAY T1 ON T.MS_MAY = T1.MS_MAY 
	WHERE CONVERT(NUMERIC,T.TG_THUC_HIEN) >= T.RUN_TIME ORDER BY T.MS_MAY, T.TEN_LOAI_BT, T.NGAY_CUOI,T.NGAY_BTKT
END
ELSE
BEGIN 
	SELECT T.MS_MAY DeviceID, T.TEN_MAY DeviceName, TEN_LOAI_BT TypeOfMaintenanceName, NGAY_CUOI LastDate, NGAY_BTKT NextDate,T.TGCM RuntimeCycle, T.TGCM_HIEN_TAI CurrentRunTime, T.MS_LOAI_BT TypeOfMaintenanceID, T.THU_TU [Index], T.TEN_NHOM_MAY DeviceGroupName, T.TG_THUC_HIEN DateProcessed, T.RUN_TIME Runtime, T1.MUC_UU_TIEN PriorityID FROM #TMP T LEFT JOIN MAY T1 ON T.MS_MAY = T1.MS_MAY 
	ORDER BY T.MS_MAY, T.TEN_LOAI_BT, T.NGAY_CUOI,T.NGAY_BTKT
END

END
