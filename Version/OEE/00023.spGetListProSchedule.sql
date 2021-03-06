
ALTER PROCEDURE [dbo].[spGetListProSchedule]
	@PrOID BIGINT = 10053,
	@DetailsID BIGINT = 65,
	@UserName NVARCHAR(50) ='admin',
	@NNgu INT	 = 0
AS
BEGIN
SELECT A.* INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(),@UserName,'-1',-1,-1,'-1','-1','-1',@NNgu) A 
SELECT ScheduleID, A.PrOID, A.DetailsID, MS_TO,A.MS_HE_THONG,A.MS_MAY,CaID,    
       A.PlannedQuantity,B.UOMID, A.PlannedStartTime, DueTime,(SELECT SUM(ActualQuantity - T.DefectQuantity) FROM dbo.ProductionRunDetails T WHERE T.PrOID =A.PrOID AND T.ItemID = B.ItemID AND T.MS_MAY = A.MS_MAY) AS	ActualQuantity,
	   A.StandardOutput,C.MS_DV_TG_Output,A.StandardSpeed,C.MS_DV_TG_Speed,A.WorkingCycle,A.NumberPerCycle,A.DownTimeRecord
	   FROM dbo.ProSchedule A
	   INNER JOIN dbo.PrODetails B ON B.DetailsID = A.DetailsID 
	   INNER JOIN dbo.ItemMay C ON C.ItemID = B.ItemID AND C.MS_MAY = A.MS_MAY
	   INNER JOIN #MAY E ON E.MS_MAY = A.MS_MAY
	   WHERE A.PrOID =@PrOID AND A.DetailsID =@DetailsID
	   ORDER BY DueTime DESC
END


