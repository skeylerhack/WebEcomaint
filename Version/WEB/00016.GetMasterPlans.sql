--EXEC GetMasterPlans 'ADMINISTRATOR','05/01/2017', '10/28/2017', 0, 0
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetMasterPlans')
   exec('CREATE PROCEDURE GetMasterPlans AS BEGIN SET NOCOUNT ON; END')
GO

alter PROC [dbo].[GetMasterPlans]
	@username NVARCHAR(50),
	@fromDate DATETIME,
	@toDate DATETIME,
	@option int, 
	@lang int
AS
BEGIN
SELECT DISTINCT TEN_MAY, MS_MAY INTO #TMP2 FROM dbo.MGetMayUserNgay(@toDate, @username, '-1', '-1', -1, '-1', '-1','-1', @lang) A 

  DECLARE @THOI_GIAN TABLE(
  TONG_TG FLOAT,
   HANG_MUC_ID INT
 )

 SELECT   * INTO  #KHTT FROM KE_HOACH_TONG_THE WHERE (CONVERT(DATETIME, CONVERT(NVARCHAR(10), NGAY, 103), 103) BETWEEN @fromDate AND @toDate)

IF(@option = 0)
BEGIN
	INSERT INTO @THOI_GIAN
	SELECT SUM(ISNULL(THOI_GIAN_DU_KIEN,0)) AS TONG_TG, T1.HANG_MUC_ID 
	FROM #KHTT T1 INNER JOIN KE_HOACH_TONG_CONG_VIEC T2 ON T1.HANG_MUC_ID = T2.HANG_MUC_ID AND T1.MS_MAY = T2.MS_MAY
	WHERE  (MS_PHIEU_BAO_TRI IS NULL) AND (EOR_ID IS NULL) AND (KHONG_GQ = 0 OR KHONG_GQ IS NULL) AND (THUE_NGOAI = 0 OR THUE_NGOAI IS NULL) 
	GROUP BY T1.HANG_MUC_ID
	
	SELECT DISTINCT T.MS_MAY DeviceID, TEN_MAY DeviceName, T.HANG_MUC_ID ID, T.TEN_HANG_MUC PlanName , T.NGAY DateCreated, T.NGAY_DK_HT DateCompleted, T.GHI_CHU Note, T.MS_LOAI_BT TypeOfMaintenanceID, T.USERNAME Username, T.MS_UU_TIEN PriorityID, CONVERT(NVARCHAR(50),MS_CN_PT) AS StaffID,T7.HO + ' ' + T7.TEN ConfirmedBy, ISNULL(T2.TONG_TG, 0) as TotalHours, T.LY_DO_SC AS ReasonForRepairID,
	CASE @lang WHEN 0 THEN T4.TEN_LY_DO_VIET WHEN 1 THEN T4.TEN_LY_DO_ANH ELSE T4.TEN_LY_DO_HOA END ReasonForRepairName, 
		CASE @lang WHEN 0 THEN T5.TEN_UU_TIEN WHEN 1 THEN T5.TEN_TA ELSE T5.TEN_UU_TIEN END PriorityName, T6.TEN_LOAI_BT
		TypesOfMaintenanceName
		--, T.NGAY DateCreated as NGAY_OLD, T.NGAY_DK_HT DateCompleted  as NGAY_KT_OLD, NGAY_BTDK_GOC ,  T.LY_DO_SC, T.MS_CACH_TH, T.NGAY_BTPN
	FROM #KHTT AS T 
	LEFT JOIN KE_HOACH_TONG_CONG_VIEC T3 ON T3.HANG_MUC_ID = T.HANG_MUC_ID AND T3.MS_MAY = T.MS_MAY
	INNER JOIN #TMP2 T1 ON T.MS_MAY = T1.MS_MAY
	LEFT JOIN @THOI_GIAN T2 ON T.HANG_MUC_ID = T2.HANG_MUC_ID
	LEFT JOIN LY_DO_SUA_CHUA T4 ON T4.MS_LY_DO =T.LY_DO_SC
	LEFT JOIN MUC_UU_TIEN T5 ON T5.MS_UU_TIEN = T.MS_UU_TIEN 
	LEFT JOIN LOAI_BAO_TRI T6 ON T6.MS_LOAI_BT = T.MS_LOAI_BT 
	LEFT JOIN CONG_NHAN T7 ON T7.MS_CONG_NHAN = T.MS_CN_PT 
	WHERE  (T3.MS_PHIEU_BAO_TRI IS NULL) AND (T3.EOR_ID IS NULL) AND (T3.KHONG_GQ = 0 OR T3.KHONG_GQ IS NULL) AND (T3.THUE_NGOAI = 0 OR T3.THUE_NGOAI IS NULL)
	ORDER BY ID DESC

	
END
ELSE IF(@option = 1)
BEGIN	

	INSERT INTO @THOI_GIAN
	SELECT SUM(ISNULL(THOI_GIAN_DU_KIEN,0)) AS TONG_TG, T1.HANG_MUC_ID
	FROM #KHTT T1 INNER JOIN 
	KE_HOACH_TONG_CONG_VIEC T2 ON T1.HANG_MUC_ID = T2.HANG_MUC_ID AND T1.MS_MAY = T2.MS_MAY
	WHERE (THUE_NGOAI = 1) AND (MS_PHIEU_BAO_TRI IS NULL) AND (EOR_ID IS NULL) OR (MS_PHIEU_BAO_TRI IS NULL) AND (EOR_ID IS NULL) AND (KHONG_GQ = 1)
	GROUP BY T1.HANG_MUC_ID
	
	SELECT DISTINCT T.MS_MAY DeviceID, TEN_MAY DeviceName, T.HANG_MUC_ID ID, T.TEN_HANG_MUC PlanName , T.NGAY DateCreated, T.NGAY_DK_HT DateCompleted, T.GHI_CHU Note, T.MS_LOAI_BT TypeOfMaintenanceID, T.USERNAME Username, T.MS_UU_TIEN PriorityID, CONVERT(NVARCHAR(50),MS_CN_PT) AS StaffID,T7.HO + ' ' + T7.TEN ConfirmedBy, ISNULL(T2.TONG_TG, 0) as TotalHours,T.LY_DO_SC AS ReasonForRepairID,
	CASE @lang WHEN 0 THEN T4.TEN_LY_DO_VIET WHEN 1 THEN T4.TEN_LY_DO_ANH ELSE T4.TEN_LY_DO_HOA END ReasonForRepairName
	, 
		CASE @lang WHEN 0 THEN T5.TEN_UU_TIEN WHEN 1 THEN T5.TEN_TA ELSE T5.TEN_UU_TIEN END PriorityName, T6.TEN_LOAI_BT TypesOfMaintenanceName
		--, T.NGAY DateCreated as NGAY_OLD, T.NGAY_DK_HT DateCompleted  as NGAY_KT_OLD, NGAY_BTDK_GOC ,  T.MS_CACH_TH, T.NGAY_BTPN
	FROM #KHTT AS T 
	INNER JOIN KE_HOACH_TONG_CONG_VIEC T3 ON T3.HANG_MUC_ID = T.HANG_MUC_ID AND T3.MS_MAY = T.MS_MAY
	INNER JOIN #TMP2 T1 ON T.MS_MAY = T1.MS_MAY
	LEFT JOIN @THOI_GIAN T2 ON T.HANG_MUC_ID = T2.HANG_MUC_ID
	LEFT JOIN LY_DO_SUA_CHUA T4 ON T4.MS_LY_DO =T.LY_DO_SC
		LEFT JOIN MUC_UU_TIEN T5 ON T5.MS_UU_TIEN = T.MS_UU_TIEN 
	LEFT JOIN LOAI_BAO_TRI T6 ON T6.MS_LOAI_BT = T.MS_LOAI_BT 			
	LEFT JOIN CONG_NHAN T7 ON T7.MS_CONG_NHAN = T.MS_CN_PT 

	WHERE   (THUE_NGOAI = 1) AND (MS_PHIEU_BAO_TRI IS NULL) AND (EOR_ID IS NULL) OR (MS_PHIEU_BAO_TRI IS NULL) AND (EOR_ID IS NULL) AND (KHONG_GQ = 1)
	ORDER BY ID DESC

END
ELSE
BEGIN	
	INSERT INTO @THOI_GIAN
	SELECT SUM(ISNULL(THOI_GIAN_DU_KIEN,0)) AS TONG_TG, T1.HANG_MUC_ID 
		FROM #KHTT T1 INNER JOIN 
		KE_HOACH_TONG_CONG_VIEC T2 ON T1.HANG_MUC_ID = T2.HANG_MUC_ID AND T1.MS_MAY = T2.MS_MAY
		WHERE  (MS_PHIEU_BAO_TRI IS NOT NULL OR  EOR_ID IS NOT NULL) AND (CONVERT(DATETIME, CONVERT(NVARCHAR(10), NGAY, 103), 103) BETWEEN @fromDate AND @toDate) 
		
		GROUP BY T1.HANG_MUC_ID
	
	SELECT DISTINCT T.MS_MAY DeviceID, TEN_MAY DeviceName, T.HANG_MUC_ID ID, T.TEN_HANG_MUC PlanName , T.NGAY DateCreated, T.NGAY_DK_HT DateCompleted, T.GHI_CHU Note, T.MS_LOAI_BT TypeOfMaintenanceID, T.USERNAME Username, T.MS_UU_TIEN PriorityID, CONVERT(NVARCHAR(50),MS_CN_PT) AS StaffID,T7.HO + ' ' + T7.TEN ConfirmedBy, ISNULL(T2.TONG_TG, 0) as TotalHours,T.LY_DO_SC AS ReasonForRepairID,
		CASE @lang WHEN 0 THEN T4.TEN_LY_DO_VIET WHEN 1 THEN T4.TEN_LY_DO_ANH ELSE T4.TEN_LY_DO_HOA END ReasonForRepairName,
	CASE @lang WHEN 0 THEN T5.TEN_UU_TIEN WHEN 1 THEN T5.TEN_TA ELSE T5.TEN_UU_TIEN END PriorityName, T6.TEN_LOAI_BT TypesOfMaintenanceName
	FROM #KHTT AS T 
	INNER JOIN KE_HOACH_TONG_CONG_VIEC T3 ON T3.HANG_MUC_ID = T.HANG_MUC_ID AND T3.MS_MAY = T.MS_MAY
	INNER JOIN #TMP2 T1 ON T.MS_MAY = T1.MS_MAY
	LEFT JOIN @THOI_GIAN T2 ON T.HANG_MUC_ID = T2.HANG_MUC_ID
	LEFT JOIN LY_DO_SUA_CHUA T4 ON T4.MS_LY_DO =T.LY_DO_SC
		LEFT JOIN MUC_UU_TIEN T5 ON T5.MS_UU_TIEN = T.MS_UU_TIEN 
			LEFT JOIN LOAI_BAO_TRI T6 ON T6.MS_LOAI_BT = T.MS_LOAI_BT 
			LEFT JOIN CONG_NHAN T7 ON T7.MS_CONG_NHAN = T.MS_CN_PT 

	WHERE  (MS_PHIEU_BAO_TRI IS NOT NULL OR  EOR_ID IS NOT NULL) AND (CONVERT(DATETIME, CONVERT(NVARCHAR(10), NGAY, 103), 103) BETWEEN @fromDate AND @toDate)
	ORDER BY ID DESC
END
END