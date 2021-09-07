IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_YEU_CAU_NSD_CHI_TIET_HINH_XOA')
exec('CREATE PROCEDURE SP_YEU_CAU_NSD_CHI_TIET_HINH_XOA AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[SP_YEU_CAU_NSD_CHI_TIET_HINH_XOA]
	@ID int = 12
AS
BEGIN
		DELETE dbo.YEU_CAU_NSD_CHI_TIET_HINH WHERE STT_HINH = @ID
END
