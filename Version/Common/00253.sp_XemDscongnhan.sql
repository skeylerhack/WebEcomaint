ALTER procedure [dbo].[sp_XemDscongnhan]		
AS
BEGIN
	SELECT MS_CONG_NHAN, HO + ' ' + TEN AS HOTEN
	FROM dbo.CONG_NHAN
	WHERE dbo.CONG_NHAN.BO_VIEC <> 1
	ORDER BY TEN
END
