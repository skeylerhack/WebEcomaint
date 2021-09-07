IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetItemInventory')
   exec('CREATE PROCEDURE spGetItemInventory AS BEGIN SET NOCOUNT ON; END')
GO


ALTER PROC [dbo].[spGetItemInventory]
	@ItemID NVARCHAR(50) = '-1',
	@WarehouseID NVARCHAR(50) = '-1'
AS
BEGIN

SELECT ISNULL(SUM(Quantity),0) AS Quantity FROM ItemInventory WHERE (CONVERT(NVARCHAR(50),ItemID) = @ItemID OR @ItemID = '-1' )  AND (CONVERT(NVARCHAR(50),WarehouseID) = @WarehouseID  OR @WarehouseID = '-1') 

END