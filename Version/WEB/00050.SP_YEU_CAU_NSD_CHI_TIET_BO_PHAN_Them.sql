IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_YEU_CAU_NSD_CHI_TIET_BO_PHAN_Them')
   
exec('CREATE PROCEDURE SP_YEU_CAU_NSD_CHI_TIET_BO_PHAN_Them AS BEGIN SET NOCOUNT ON; END')

GO
-- =============================================
-- Author:		huong
-- Create date: 31-01-2019
-- Description:	thên phụ tùng vào yêu cầu người sử dụng phụ tùng
-- =============================================
ALTER PROCEDURE [dbo].SP_YEU_CAU_NSD_CHI_TIET_BO_PHAN_Them
	@DanhSachPhuTung [DanhSachPhuTung] READONLY
AS
BEGIN
	INSERT INTO dbo.YEU_CAU_NSD_CHI_TIET_BO_PHAN
	        ( STT ,
	          MS_MAY ,
	          STT_VAN_DE ,
	          MS_BO_PHAN ,
	          MS_PT ,
	          MS_VI_TRI_PT
	        )
 SELECT STT,MS_MAY,STT_VAN_DE,MS_BO_PHAN,MS_PT,MS_VI_TRI_PT FROM @DanhSachPhuTung
END
