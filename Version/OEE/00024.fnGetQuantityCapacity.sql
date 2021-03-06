--SELECT [dbo].[fnGetQuantityCapacity](8,20)

CREATE FUNCTION [dbo].[fnGetQuantityCapacity]
    (
      @ItemID BIGINT = 8 ,
      @Input DECIMAL(18, 2) = 20
    )
RETURNS DECIMAL(18, 4)
AS
BEGIN

DECLARE @QuaBase DECIMAL(18, 4) = 20;
DECLARE @Resulst DECIMAL(18, 4) = 20

        SET @QuaBase = (SELECT CONVERT(DECIMAL(18, 4), ( @Input
                                                          * BasedUOMQuantity )
                                / UOMQuantity)
                         FROM   UOMConversionGroupDetails
                         WHERE  ID = ( SELECT   UOM
                                       FROM     dbo.Item
                                       WHERE    ID = @ItemID
                                     )
                       )

IF(SELECT B.CapacityUOM FROM dbo.Item A
INNER JOIN dbo.UOMConversionGroupDetails B ON A.UOM = B.ID
 WHERE A.ID =@ItemID)= 0 
  --      SET @BASEUOM = ( SELECT UOMID
  --                       FROM   UOMConversionGroupDetails
  --                       WHERE  ID = ( SELECT   UOM
  --                                     FROM     dbo.Item
  --                                     WHERE    ID = @ItemID
  --                                   )
  --                     )
		--        SET @BaseConvert = (SELECT CONVERT(NVARCHAR(20),@QuaBase) +' ' + UOMNote FROM dbo.UOM WHERE BasedUOM = 1)
      BEGIN
       SET @Resulst =   (SELECT  CONVERT(NVARCHAR(50), CONVERT(DECIMAL(18, 4), @QuaBase
                    / A.BasedUOMQuantity))  ConvertQuantity
            FROM    dbo.UOMConversionGroupDetails A
                    INNER JOIN dbo.UOMConversionGroup B ON B.ID = A.UOMConversionGroupID
            WHERE   UOMConversionGroupID = ( SELECT UOMConverionGroupID
                                             FROM   dbo.Item
                                             WHERE  ID = @ItemID
                                           )
                    AND A.CapacityUOM = 1)
END 
ELSE
BEGIN
SET @Resulst =@QuaBase
END
RETURN @Resulst
END