
ALTER PROCEDURE [dbo].[spGetItemByPro]
	@PrOID BIGINT =-1,
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0
AS 
BEGIN
SELECT A.ID, ISNULL(A.OtherName,CASE @NNgu WHEN 0 THEN A.ItemName WHEN 1 THEN ISNULL(NULLIF(A.ItemNameA,''),A.ItemName) ELSE ISNULL(NULLIF(A.ItemNameH,''),A.ItemName) END) AS ItemName FROM dbo.Item A
INNER JOIN dbo.PrODetails B ON A.ID = B.ItemID 
WHERE B.PrOID = @PrOID OR @PrOID = -1
END	



