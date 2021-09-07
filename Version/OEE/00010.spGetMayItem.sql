
ALTER PROCEDURE [dbo].[spGetMayItem]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@Item INT =1
---- @Item = 0 theo item
---- @Item = 1 theo pro details
AS 
BEGIN
IF @Item = 0
BEGIN
SELECT DISTINCT A.MS_MAY,A.TEN_MAY FROM dbo.MGetMayUserNgay(GETDATE(),@username,-1,-1,-1,-1,'-1','-1', @NNgu) A 	INNER JOIN dbo.ItemMay ON ItemMay.MS_MAY = A.MS_MAY ORDER BY A.TEN_MAY
END

IF @Item = 1
BEGIN
SELECT DISTINCT A.MS_MAY,A.TEN_MAY FROM dbo.MGetMayUserNgay(GETDATE(),@username,-1,-1,-1,-1,'-1','-1', @NNgu) A 	INNER JOIN dbo.PrODetails ON PrODetails.MS_MAY = A.MS_MAY ORDER BY A.TEN_MAY
END



END	



