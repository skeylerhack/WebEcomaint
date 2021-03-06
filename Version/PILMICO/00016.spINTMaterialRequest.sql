USE CMMS_PILMICO
GO



create PROC [dbo].[spINTMaterialRequest]
	@MsPBT NVARCHAR(100) = 'WO-201810000113',
	@UserName NVARCHAR(100) = 'Admin'
AS


INSERT INTO PilmicoIntegration.[dbo].[MaterialRequest] ([WorkOrder],[ItemID],[UOMName],[Quantity],[OnhandQuantity],[UserIDOfRequest],[Type]) 
SELECT @MsPBT AS WorkOrder, MS_PT AS ItemID, TEN_DVT AS UOMName, CASE ISNULL([TYPE],0) WHEN 1 THEN SL_REQUEST ELSE SL_RETURN END AS Quantity,SL_TON AS OnhandQuantity, @UserName AS UserIDOfRequest, [TYPE] FROM CMMS_PILMICO.dbo.INT_RE_PIL_TMP WHERE  ((ISNULL(SL_REQUEST, 0) > 0) OR (ISNULL(SL_RETURN, 0) > 0)) AND (ISNULL(CHON,0) = 1) AND (ISNULL([TYPE],0) = 1) AND (ISNULL(SL_TON,0) > 0)
                


DECLARE @MsPT NVARCHAR(100)
DECLARE @UOMName NVARCHAR(100)
DECLARE @SLReturn FLOAT
DECLARE @SLTon FLOAT

DECLARE @ID BIGINT
DECLARE @DocNum BIGINT
DECLARE @QuaReturn FLOAT 
DECLARE @Quantity FLOAT 
DECLARE @SLConLai FLOAT 

Declare  TTRequest CURSOR FOR
	SELECT MS_PT,TEN_DVT, ISNULL(SUM(SL_RETURN),0) AS SL_RETURN, ISNULL(SUM(SL_TON),0) AS SL_TON FROM CMMS_PILMICO.dbo.INT_RE_PIL_TMP T1 WHERE [Type] = 2 AND (ISNULL(SL_TON,0) > 0) GROUP BY MS_PT,TEN_DVT
Open TTRequest
FETCH NEXT FROM TTRequest
INTO @MsPT,@UOMName,@SLReturn,@SLTon
While @@Fetch_Status = 0
Begin
	Declare  TTReturn CURSOR FOR
	SELECT ID,DocNum,Quantity, ISNULL(Quantity,0) - ISNULL(QuantityReturn,0) SLConLai , ISNULL(QuantityReturn,0) AS QuantityReturn FROM PilmicoIntegration.DBO.InventoryTransaction WHERE [Type] = 1 AND WorkOrder = @MsPBT AND CONVERT(NVARCHAR(100),ItemID) = @MsPT

		Open TTReturn
			FETCH NEXT FROM TTReturn
			INTO @ID,@DocNum,@Quantity,@SLConLai,@QuaReturn 
			While @@Fetch_Status = 0
			Begin
				DECLARE @SLQuantity FLOAT = 0
				SET @SLQuantity = CASE WHEN @SLReturn > @SLConLai THEN @SLConLai ELSE @SLReturn END 
IF @SLQuantity > 0 
BEGIN				
				INSERT INTO PilmicoIntegration.[dbo].[MaterialRequest] ([WorkOrder],[ItemID],[UOMName],[Quantity],[OnhandQuantity],[UserIDOfRequest],[Type],DocNumOld)
				SELECT @MsPBT AS [WorkOrder], @MsPT AS [ItemID],@UOMName AS [UOMName],CASE WHEN @SLReturn > @SLConLai THEN @SLConLai ELSE @SLReturn END [Quantity],@SLTon AS [OnhandQuantity],@UserName AS [UserIDOfRequest],2 AS [TYPE],@DocNum AS DocNumOld 

				UPDATE PilmicoIntegration.DBO.InventoryTransaction SET QuantityReturn = ISNULL(QuantityReturn,0) + @SLQuantity WHERE ID = @ID
END
				SET @SLReturn = @SLReturn - CASE WHEN @SLReturn > @SLConLai THEN @SLConLai ELSE @SLReturn END 

				
				IF @SLReturn <= 0 BREAK
				

				FETCH NEXT FROM TTReturn
				INTO  @ID,@DocNum,@Quantity,@SLConLai,@QuaReturn 

			End

			Close TTReturn
			Deallocate TTReturn
	
    FETCH NEXT FROM TTRequest
    INTO  @MsPT,@UOMName,@SLReturn,@SLTon

End

Close TTRequest
Deallocate TTRequest

