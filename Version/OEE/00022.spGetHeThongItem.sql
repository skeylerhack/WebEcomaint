

ALTER PROCEDURE spGetHeThongItem
	@UserName NVARCHAR(50) ='admin',
	@lang INT =0 
AS
BEGIN

	SELECT A.* INTO #MAY FROM dbo.MGetMayUserNgay(GETDATE(),@username,'-1',-1,-1,'-1','-1','-1', @lang) A 	

	SELECT DISTINCT B.MS_HE_THONG,TEN_HE_THONG FROM dbo.ItemMay A
	INNER JOIN  #MAY B ON B.MS_MAY = A.MS_MAY
END
