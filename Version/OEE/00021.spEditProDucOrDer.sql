

ALTER PROCEDURE [dbo].[spEditProDucOrDer]
	@IDPro BIGINT = -1,
	@PrOrNumber  nvarchar(50) ='LSX-001',
	@OrderDate  DATETIME = '2020-09-08 14:11:18.667',
	@StartDate  DATETIME = '2020-09-08 14:11:18.667',
	@DueDate  DATETIME = '2020-09-08 14:11:18.667',
	@Status  BIGINT =1,
	@Note NVARCHAR(500) ='test',
	@sBTDetail NVARCHAR(500)='TMPProDucDetailsadmin',
	@sBTSchedule NVARCHAR(500)='TMPProScheduleadmin'
AS 
BEGIN

CREATE TABLE #TEMPProDuctDetails (
[DetailsID] [bigint] NULL,
[PrOID] [bigint] NULL,
[ItemID] [bigint] NULL,
[ItemName] [nvarchar] (50),
[UOMID] [bigint] NULL,
[PlannedStartTime] [datetime] NULL,
[DueDate] [datetime] NULL,
[PlannedQuantity] [decimal] (18, 2) NULL,
[AllocatedQuantity] [int] NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPProDuctDetails SELECT * FROM ' + @sBTDetail
EXEC (@sSql)
--set @sSql = 'DROP TABLE ' + @sBTDetail
--EXEC (@sSql)

CREATE TABLE #TEMPSchedule(
[ScheduleID] [bigint] NULL,
[PrOID] [bigint] NULL,
[DetailsID] [bigint] NULL,
[MS_TO] [int] NULL,
[MS_HE_THONG] [int] NULL,
[MS_MAY] [nvarchar] (30) NULL,
[CaID] [int] NULL,
[PlannedQuantity] [numeric] (18, 2) NULL,
[UOMID] [bigint] NULL,
[PlannedStartTime] [datetime] NULL,
[DueTime] [datetime] NULL,
[AllocatedQuantity] [int] NULL,
[StandardOutput] [numeric] (18, 2) NULL,
[MS_DV_TG_Output] [bigint] NULL,
[StandardSpeed] [numeric] (18, 2) NULL,
[MS_DV_TG_Speed] [bigint] NULL,
[WorkingCycle] [int] NULL,
[NumberPerCycle] [numeric] (18, 2) NULL,
[DownTimeRecord] [numeric] (18, 2) NULL
) ON [PRIMARY]

set @sSql = 'INSERT INTO #TEMPSchedule SELECT * FROM ' + @sBTSchedule
EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @sBTSchedule
EXEC (@sSql)
IF @IDPro = -1
BEGIN
INSERT INTO dbo.ProductionOrder ( PrOrNumber, OrderDate, StartDate, DueDate,
                                   Status, Note )
VALUES  ( @PrOrNumber, -- PrOrNumber - nvarchar(50)
          @OrderDate, -- OrderDate - datetime
          @StartDate, -- StartDate - datetime
          @DueDate, -- DueDate - datetime
          @Status, -- Status - bigint
          @Note  -- Note - nvarchar(500)
          )
SELECT @IDPro = SCOPE_IDENTITY()
END
ELSE
BEGIN
UPDATE dbo.ProductionOrder
SET PrOrNumber = @PrOrNumber,
OrderDate =@OrderDate,
StartDate =@StartDate,
[Status] =@Status,
Note =@Note
WHERE ID =@IDPro
END
-- update lại những dữ liệu tồn tại mà khác DetailsID - -1
UPDATE A	
SET A.ItemID =B.ItemID,
A.ItemName = B.ItemName,
A.UOMID =B.UOMID,
A.PlannedStartTime =B.PlannedStartTime,
A.DueDate =B.DueDate,
A.PlannedQuantity =B.PlannedQuantity
FROM dbo.PrODetails A
INNER JOIN #TEMPProDuctDetails B ON B.PrOID = A.PrOID AND B.DetailsID = A.DetailsID WHERE B.DetailsID > 0 AND A.PrOID = @IDPro
INSERT INTO dbo.PrODetails ( PrOID, ItemID, ItemName, UOMID, PlannedQuantity,
                              PlannedStartTime, DueDate )
SELECT  @IDPro, ItemID, ItemName, UOMID,PlannedQuantity, PlannedStartTime, DueDate FROM #TEMPProDuctDetails A WHERE NOT EXISTS(SELECT * FROM dbo.PrODetails B WHERE A.ItemID=B.ItemID AND B.PrOID =A.PrOID)
-- cập nhật lại dbo.ProSchedule


IF (SELECT COUNT(*) FROM #TEMPSchedule) > 0 

BEGIN
UPDATE A 
SET 
A.MS_HE_THONG=	B.MS_HE_THONG,
A.MS_MAY= 	B.MS_MAY, 
A.CaID= 	B.CaID, 
A.MS_TO=	B.MS_TO,
A.PlannedQuantity=	B.PlannedQuantity,
A.PlannedStartTime=	B.PlannedStartTime,
A.DueTime=	B.DueTime,
A.StandardSpeed=	B.StandardSpeed,
A.StandardOutput=	B.StandardOutput,
A.WorkingCycle=	B.WorkingCycle,
A.NumberPerCycle= 	B.NumberPerCycle, 
A.DownTimeRecord =	B.DownTimeRecord 
FROM dbo.ProSchedule A INNER JOIN #TEMPSchedule B ON A.PrOID =B.PrOID AND A.DetailsID = B.DetailsID AND A.ScheduleID =B.ScheduleID
IF @IDPro <> -1
BEGIN
UPDATE A
SET A.PrOID = B.DetailsID
FROM #TEMPProDuctDetails A
INNER JOIN dbo.PrODetails B ON B.ItemID = A.ItemID WHERE B.PrOID = @IDPro 

UPDATE A
SET A.DetailsID = B.PrOID	
FROM #TEMPSchedule A INNER JOIN #TEMPProDuctDetails B ON B.DetailsID = A.DetailsID WHERE A.PrOID IS  NULL
END	
--update ProSchedule
INSERT INTO dbo.ProSchedule ( PrOID, DetailsID, MS_HE_THONG, MS_MAY, CaID,
                               MS_TO, PlannedQuantity, PlannedStartTime,
                               DueTime, EndTime, ActualQty, StandardSpeed,
                               StandardOutput, ActualQuantity, WorkingCycle,
                               NumberPerCycle, DownTimeRecord )
SELECT @IDPro,DetailsID,MS_HE_THONG,MS_MAY,CaID,MS_TO,PlannedQuantity,PlannedStartTime,DueTime,NULL,NULL,StandardSpeed,StandardOutput,NULL,WorkingCycle,NumberPerCycle,DownTimeRecord FROM #TEMPSchedule WHERE PrOID IS NULL
END	
SELECT @IDPro
END	



