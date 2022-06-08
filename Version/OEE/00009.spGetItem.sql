
ALTER PROCEDURE [dbo].[spGetItem]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll INT=2,
	@MS_MAY NVARCHAR(30) ='BTA-04-02'
AS 
---- @CoAll = 1 có all 
---- @CoAll = 0  
---- @CoAll = 2 lấy theo máy item
BEGIN
IF @CoAll = 1
BEGIN
SELECT * FROM (SELECT ID,ItemName  FROM dbo.Item
UNION
SELECT -1,N'< ALL >') A
ORDER BY A.ItemName
END
ELSE
IF	@CoAll = 0
BEGIN
SELECT ID,ItemCode,ItemName  FROM dbo.Item
ORDER BY ItemName
END	
ELSE
BEGIN
------------lấy theo máy Item theo msMay
SELECT ID,A.ItemCode,ItemName  FROM dbo.Item A
INNER JOIN dbo.ItemMay B ON B.ItemID = A.ID
WHERE B.MS_MAY = @MS_MAY
ORDER BY ItemName
END

END	


