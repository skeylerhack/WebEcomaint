
ALTER PROCEDURE [dbo].[spEditItemMay]
	@IDItem BIGINT,
	@ItemCode  nvarchar(50),
	@ItemName  nvarchar(250),
	@ItemNameA  nvarchar(250),
	@ItemNameH  nvarchar(250),
	@OtherName  nvarchar(250),
	@Barcode  nvarchar(50),
	@IDItemGroup  BIGINT,
	@Description  nvarchar(50),
	@UOMConverionGroupID  BIGINT,
	@BasedUOM  BIGINT,
	@sBT NVARCHAR(50)
AS 
BEGIN
CREATE TABLE #TEMPItemMay (
[MS_MAY] [nvarchar] (30) NULL,
[StandardOutput] NUMERIC(18,2) NULL,
[MS_DV_TG_Output] [bigint] NULL,
[StandardSpeed] NUMERIC(18,2) NULL,
[MS_DV_TG_Speed] [bigint] NULL,
[DataCollectionCycle] [bigint] NULL,
[DownTimeRecord] [bigint] NULL,
[WorkingCycle] [int] NULL,
[NumberPerCyle] NUMERIC(18,2) NULL,
[TimeSendMgs] NUMERIC(18,2) NULL
) ON [PRIMARY]
DECLARE @sSql nvarchar(4000)
set @sSql = 'INSERT INTO #TEMPItemMay SELECT MS_MAY, StandardOutput, MS_DV_TG_Output, StandardSpeed,
       MS_DV_TG_Speed, DataCollectionCycle, DownTimeRecord, WorkingCycle,
       NumberPerCyle, TimeSendMgs FROM ' + @sBT
EXEC (@sSql)
set @sSql = 'DROP TABLE ' + @sBT
EXEC (@sSql)
IF @IDItem = -1
BEGIN
-- them itemmay
INSERT INTO dbo.Item (ItemCode, ItemName,ItemNameA,ItemNameH, OtherName, Barcode,
                        IDItemGroup, Description, UOMConverionGroupID,
                        BasedUOM )
VALUES  (@ItemCode ,@ItemName,@ItemNameA,@ItemNameH,@OtherName, @Barcode ,@IDItemGroup,@Description ,@UOMConverionGroupID ,
@BasedUOM )
SET @IDItem =( SELECT SCOPE_IDENTITY() )
END
ELSE
BEGIN
--sua item may
UPDATE dbo.Item
SET 
ItemCode =@ItemCode,
ItemName =@ItemName,
ItemNameA =@ItemNameA,
ItemNameH =@ItemNameH,
OtherName =@OtherName,
Barcode =@Barcode,
IDItemGroup =@IDItemGroup, 
Description = @Description, 
UOMConverionGroupID =@UOMConverionGroupID,
BasedUOM =@BasedUOM
WHERE ID =@IDItem
END	
IF (SELECT COUNT(*) FROM #TEMPItemMay) > 0
BEGIN
DELETE dbo.ItemMay WHERE ItemID =@IDItem
INSERT INTO	dbo.ItemMay(  MS_MAY, ItemID, StandardOutput, MS_DV_TG_Output,
                           StandardSpeed, MS_DV_TG_Speed, DataCollectionCycle,
                           DownTimeRecord, WorkingCycle, NumberPerCyle,
                           TimeSendMgs)
SELECT MS_MAY,@IDItem,StandardOutput, MS_DV_TG_Output, StandardSpeed, MS_DV_TG_Speed,
      DataCollectionCycle, DownTimeRecord, WorkingCycle, NumberPerCyle,
                           TimeSendMgs
      DownTimeRecord FROM #TEMPItemMay
END
ELSE
BEGIN
DELETE dbo.ItemMay WHERE ItemID =@IDItem
END
SELECT @IDItem
END	

