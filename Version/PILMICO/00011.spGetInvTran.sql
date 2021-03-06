

ALTER PROC [dbo].[spGetInvTran]
	@WorkOrder NVARCHAR(100) = 'WO-201810000001',
	@EquipmentID NVARCHAR(100) = 'ACI-01-01-01',
	@Language INT = 0,
	@Type INT = 0--  1(0) - Goods Issue; 2(1)- Goods Receive(for material return) 
AS 

SELECT CONVERT(BIT,CASE @Type WHEN 0 THEN 1 ELSE 0 END) AS CHON, T1.DocNum, T1.TransactionTime, T3.TEN_KHO,T1.ItemID, T2.TEN_PT, T1.Quantity AS SL_XUAT, CONVERT(FLOAT, 0) AS SL_TRA, T1.Currency, T1.WarehouseID,  T1.ItemPrice, T1.Type, T1.Status, T1.DocNumOld, T1.DateInsert, 
                         T1.DateUpdate, T1.Completed, T1.CompletionTime, T1.ID, T1.WorkOrder, T3.MS_KHO
FROM            PilmicoIntegration.dbo.InventoryTransaction AS T1 INNER JOIN
                         dbo.IC_PHU_TUNG AS T2 ON CONVERT(NVARCHAR(100), T1.ItemID) = T2.MS_PT INNER JOIN
                         dbo.IC_KHO AS T3 ON T1.WarehouseID = T3.MS_KHO_INT
WHERE ([Type] = 1) AND (WorkOrder = @WorkOrder) AND (ISNULL(Completed,0) = 0)
UNION
SELECT CONVERT(BIT,CASE @Type WHEN 0 THEN 1 ELSE 0 END) AS CHON,T1.DocNum, T1.TransactionTime, T3.TEN_KHO, T1.ItemID, T2.TEN_PT, T1.Quantity AS SL_XUAT, CONVERT(FLOAT, 0) AS SL_TRA, T1.Currency, T1.WarehouseID, T1.ItemPrice, T1.Type, T1.Status, T1.DocNumOld, T1.DateInsert, 
                         T1.DateUpdate, T1.Completed, T1.CompletionTime, T1.ID, T1.WorkOrder, T3.MS_KHO
FROM            PilmicoIntegration.dbo.InventoryTransaction AS T1 INNER JOIN
                         dbo.IC_PHU_TUNG AS T2 ON CONVERT(NVARCHAR(100), T1.ItemID) = T2.MS_PT INNER JOIN
                         dbo.IC_KHO AS T3 ON T1.WarehouseID = T3.MS_KHO_INT
WHERE ([Type] = 2) AND (WorkOrder = @WorkOrder) AND (ISNULL(Completed,0) = 0)
ORDER BY TransactionTime


--SELECT  ID, TransactionTime, DocNum, WorkOrder, WarehouseID, ItemID, CONVERT(FLOAT,0) AS SL_XUAT, Quantity AS SL_TRA, ItemPrice, Currency, Type, Status, DocNumOld, DateInsert, DateUpdate, Completed, CompletionTime
-- FROM  PilmicoIntegration.dbo.InventoryTransaction  WHERE ([Type] = 1) AND (WorkOrder = @WorkOrder) AND (ISNULL(Completed,0) = 0)
--UNION
--SELECT  ID, TransactionTime, DocNum, WorkOrder, WarehouseID, ItemID, CONVERT(FLOAT,0) AS SL_TRA, Quantity AS SL_TRA, ItemPrice, Currency, Type, Status, DocNumOld, DateInsert, DateUpdate, Completed, CompletionTime
-- FROM  PilmicoIntegration.dbo.InventoryTransaction  WHERE ([Type] = 2) AND (WorkOrder = @WorkOrder) AND (ISNULL(Completed,0) = 0)

 

--SELECT  ID, TransactionTime, DocNum, WorkOrder, WarehouseID, ItemID, Quantity AS SL_XUAT, CONVERT(FLOAT,0) AS SL_TRA, ItemPrice, Currency, Type, Status, DocNumOld, DateInsert, DateUpdate, Completed, CompletionTime
-- FROM  PilmicoIntegration.dbo.InventoryTransaction  WHERE ([Type] = 1) AND (WorkOrder = @WorkOrder) AND (ISNULL(Completed,0) = 0)
-- UNION
--SELECT  ID, TransactionTime, DocNum, WorkOrder, WarehouseID, ItemID, CONVERT(FLOAT,0) AS SL_TRA, Quantity AS SL_TRA, ItemPrice, Currency, Type, Status, DocNumOld, DateInsert, DateUpdate, Completed, CompletionTime
-- FROM  PilmicoIntegration.dbo.InventoryTransaction  WHERE ([Type] = 2) AND (WorkOrder = @WorkOrder) AND (ISNULL(Completed,0) = 0)


--SELECT CONVERT(BIT,CASE @Type WHEN 0 THEN 1 ELSE 0 END) AS CHON,
--T1.DocNum,T1.TransactionTime, T4.TEN_KHO,T1.WorkOrder,T5.MS_PT,
--CASE @Language WHEN 0 THEN T5.TEN_PT WHEN 1 THEN T5.TEN_PT_ANH ELSE T5.TEN_PT_HOA END AS TEN_PT
--,T5.QUY_CACH,ISNULL(SL_XUAT,0) AS SL_XUAT,ISNULL(SL_PB,0) AS SL_PB,ISNULL(SL_TRA,0) AS SL_TRA, ISNULL(SL_XUAT,0) - ISNULL(SL_PB,0) - ISNULL(SL_TRA,0) AS SL_CL,DON_GIA,Currency, T1.WarehouseID,T4.MS_KHO,@EquipmentID AS MS_MAY, CASE WHEN ISNULL(SL_TRA,0) = 0 THEN 1 ELSE 2 END AS XUAT_NHAP FROM
--(SELECT T1.DocNum, T1.WarehouseID,T1.WorkOrder,T1.ItemID,SUM(ISNULL(Quantity,0)) AS SL_XUAT,AVG(T1.ItemPrice) AS DON_GIA, ISNULL(T1.Currency,'VND') AS Currency,T1.TransactionTime  FROM PilmicoIntegration.dbo.InventoryTransaction T1 WHERE [Type] = 1 AND WorkOrder = @WorkOrder AND Completed = 0 GROUP BY DocNum,T1.WarehouseID,T1.WorkOrder,T1.ItemID,T1.TransactionTime,T1.Currency) T1
--LEFT JOIN
--(SELECT T1.DocNum,T1.WarehouseID,T1.WorkOrder,T1.ItemID,SUM(ISNULL(Quantity,0)) AS SL_TRA  FROM PilmicoIntegration.dbo.InventoryTransaction T1 WHERE [Type] = 2 AND WorkOrder = @WorkOrder AND Completed = 0 GROUP BY DocNum,T1.WarehouseID,T1.WorkOrder,T1.ItemID) T2 ON T1.WorkOrder = T2.WorkOrder AND T1.ItemID = T2.ItemID AND T1.WarehouseID = T2.WarehouseID AND T1.DocNum = T2.DocNum
--LEFT JOIN
--(
--SELECT T1.MS_DHX_SYNC,MS_KHO,MS_PHIEU_BAO_TRI,MS_PT,SUM(ISNULL(T2.SO_LUONG_THUC_XUAT,0)) AS SL_PB
--FROM            CMMS_PILMICO.dbo.IC_DON_HANG_XUAT AS T1 INNER JOIN CMMS_PILMICO.dbo.IC_DON_HANG_XUAT_VAT_TU AS T2 ON T1.MS_DH_XUAT_PT = T2.MS_DH_XUAT_PT
--WHERE MS_PHIEU_BAO_TRI = @WorkOrder
--GROUP BY T1.MS_DHX_SYNC,MS_KHO,MS_PHIEU_BAO_TRI,MS_PT) T3 ON T1.WorkOrder = T3.MS_PHIEU_BAO_TRI AND T1.ItemID = T3.MS_PT AND T1.WarehouseID = T3.MS_KHO AND T1.DocNum = T3.MS_DHX_SYNC
--LEFT JOIN CMMS_PILMICO.dbo.IC_KHO T4 ON CONVERT(NVARCHAR(50),T1.WarehouseID) = T4.MS_KHO_INT
--LEFT JOIN CMMS_PILMICO.dbo.IC_PHU_TUNG T5 ON CONVERT(NVARCHAR(50),T1.ItemID) = T5.MS_PT