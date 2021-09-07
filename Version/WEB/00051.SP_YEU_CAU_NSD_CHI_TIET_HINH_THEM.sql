-- =============================================
-- Author:		huong
-- Create date: 27/06/2019
-- Description:	Thêm hình
-- =============================================
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_YEU_CAU_NSD_CHI_TIET_HINH_THEM')
exec('CREATE PROCEDURE SP_YEU_CAU_NSD_CHI_TIET_HINH_THEM AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].SP_YEU_CAU_NSD_CHI_TIET_HINH_THEM
	@STT INT,
	@MS_MAY NVARCHAR(30),
	@STT_VAN_DE INT,
	@DUONG_DAN NVARCHAR(255)
AS
BEGIN
INSERT INTO dbo.YEU_CAU_NSD_CHI_TIET_HINH
        ( STT ,
          MS_MAY ,
          STT_VAN_DE ,
          DUONG_DAN ,
          GHI_CHU
        )
VALUES  ( @STT , -- STT - int
          @MS_MAY , -- MS_MAY - nvarchar(30)
          @STT_VAN_DE , -- STT_VAN_DE - int
          @DUONG_DAN , -- DUONG_DAN - nvarchar(255)
          NULL  -- GHI_CHU - nvarchar(100)
        )
END


