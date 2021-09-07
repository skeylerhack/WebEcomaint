IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetInvTran')
   exec('CREATE PROCEDURE spGetInvTran AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROC spGetInvTran
	@WorkOrder NVARCHAR(100) = 'WO-201810000001',
	@EquipmentID NVARCHAR(100) = 'ACI-01-01-01',
	@Language INT = 0,
	@Type INT = 0--  1(0) - Goods Issue; 2(1)- Goods Receive(for material return) 
AS 



SELECT CONVERT(BIT,CASE @Type WHEN 0 THEN 1 ELSE 0 END) AS CHON,
T1.DocNum,T1.TransactionTime, T4.TEN_KHO,T1.WorkOrder,T5.MS_PT,
CASE @Language WHEN 0 THEN T5.TEN_PT WHEN 1 THEN T5.TEN_PT_ANH ELSE T5.TEN_PT_HOA END AS TEN_PT
,T5.QUY_CACH,ISNULL(SL_XUAT,0) AS SL_XUAT,ISNULL(SL_PB,0) AS SL_PB,ISNULL(SL_TRA,0) AS SL_TRA, ISNULL(SL_XUAT,0) - ISNULL(SL_PB,0) - ISNULL(SL_TRA,0) AS SL_CL,DON_GIA,Currency, T1.WarehouseID,T4.MS_KHO,@EquipmentID AS MS_MAY,T1.ID FROM
(SELECT T1.ID,T1.DocNum, T1.WarehouseID,T1.WorkOrder,T2.ItemID,SUM(ISNULL(Quantity,0)) AS SL_XUAT,AVG(T1.ItemPrice) AS DON_GIA, ISNULL(T1.Currency,'VND') AS Currency,T1.TransactionTime  FROM PilmicoIntegration.dbo.InventoryTransaction T1 INNER JOIN(
SELECT MAX(ID) AS ID,WorkOrder,ItemID,WarehouseID FROM PilmicoIntegration.dbo.InventoryTransaction WHERE Type = 1 AND WorkOrder = @WorkOrder GROUP BY WorkOrder,ItemID,WarehouseID ) T2 ON T1.ID = T2.ID AND T1.WorkOrder = T2.WorkOrder AND T1.ItemID = T2.ItemID AND T1.WarehouseID = T2.WarehouseID GROUP BY DocNum,T1.WarehouseID,T1.WorkOrder,T2.ItemID,T1.ID,T1.TransactionTime,T1.Currency) T1
LEFT JOIN
(SELECT T1.ID,T1.DocNum,T1.WarehouseID,T1.WorkOrder,T2.ItemID,SUM(ISNULL(Quantity,0)) AS SL_TRA  FROM PilmicoIntegration.dbo.InventoryTransaction T1 INNER JOIN(
SELECT MAX(ID) AS ID,WorkOrder,ItemID,WarehouseID FROM PilmicoIntegration.dbo.InventoryTransaction WHERE Type = 2 AND WorkOrder = @WorkOrder GROUP BY WorkOrder,ItemID,WarehouseID ) T2 ON T1.ID = T2.ID AND T1.WorkOrder = T2.WorkOrder AND T1.ItemID = T2.ItemID AND T1.WarehouseID = T2.WarehouseID GROUP BY DocNum,T1.WarehouseID,T1.WorkOrder,T2.ItemID,T1.ID) T2 ON T1.WorkOrder = T2.WorkOrder AND T1.ItemID = T2.ItemID AND T1.WarehouseID = T2.WarehouseID AND T1.DocNum = T2.DocNum
LEFT JOIN
(
SELECT T1.MS_DHX_SYNC,MS_KHO,MS_PHIEU_BAO_TRI,MS_PT,SUM(ISNULL(T2.SO_LUONG_THUC_XUAT,0)) AS SL_PB
FROM            CMMS_PILMICO.dbo.IC_DON_HANG_XUAT AS T1 INNER JOIN CMMS_PILMICO.dbo.IC_DON_HANG_XUAT_VAT_TU AS T2 ON T1.MS_DH_XUAT_PT = T2.MS_DH_XUAT_PT
WHERE MS_PHIEU_BAO_TRI = @WorkOrder
GROUP BY T1.MS_DHX_SYNC,MS_KHO,MS_PHIEU_BAO_TRI,MS_PT) T3 ON T1.WorkOrder = T3.MS_PHIEU_BAO_TRI AND T1.ItemID = T3.MS_PT AND T1.WarehouseID = T3.MS_KHO AND T1.DocNum = T3.MS_DHX_SYNC
LEFT JOIN CMMS_PILMICO.dbo.IC_KHO T4 ON CONVERT(NVARCHAR(50),T1.WarehouseID) = T4.MS_KHO_INT
LEFT JOIN CMMS_PILMICO.dbo.IC_PHU_TUNG T5 ON CONVERT(NVARCHAR(50),T1.ItemID) = T5.MS_PT