IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_YEU_CAU_NSD_XOA')
exec('CREATE PROCEDURE SP_YEU_CAU_NSD_XOA AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[SP_YEU_CAU_NSD_XOA]
	@ID int = 67
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @res_code INT = 0
	BEGIN
		DELETE dbo.YEU_CAU_NSD_CHI_TIET_HINH WHERE STT = @ID
		DELETE dbo.YEU_CAU_NSD_CHI_TIET_BO_PHAN WHERE STT = @ID
		DELETE dbo.YEU_CAU_NSD_CHI_TIET WHERE STT = @ID
		DELETE dbo.YEU_CAU_NSD WHERE STT = @ID
		SET @res_code = 1
	END
	SELECT  @res_code ResponseCode
END