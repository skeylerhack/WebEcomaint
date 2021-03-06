IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spEditGiayPhep')
exec('CREATE PROCEDURE spEditGiayPhep AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spEditGiayPhep]
	@MS_GP NVARCHAR(20),
	@MS_LOAI_GP BIGINT,
	@MS_N_XUONG [nvarchar](50),
	@DS_PHIEU_BAO_TRI [nvarchar](500),
	@DUYET BIT,
	@NGUOI_LAP NVARCHAR(9),
	@NGAY_LAP DATETIME,
	@GHI_CHU NVARCHAR(500),
	@FLag BIT
AS 
BEGIN
IF @FLag = 1
BEGIN
-- them giấy phép
INSERT INTO dbo.GIAY_PHEP ( MS_GP, MS_LOAI_GP, MS_N_XUONG, DS_PHIEU_BAO_TRI,
                             DUYET, NGUOI_LAP, NGAY_LAP,GHI_CHU)
VALUES  (@MS_GP, -- MS_GP - nchar(20)
          @MS_LOAI_GP, -- MS_LOAI_GP - bigint
          @MS_N_XUONG, -- MS_N_XUONG - nvarchar(50)
          @DS_PHIEU_BAO_TRI, -- DS_PHIEU_BAO_TRI - nvarchar(500)
          0, -- DUYET - bit
          @NGUOI_LAP, -- NGUOI_LAP - nvarchar(9)
          @NGAY_LAP, -- NGAY_LAP - datetime
		  @GHI_CHU
          )
END
ELSE
BEGIN
-- sua giấy phép
IF @DUYET = 0
BEGIN
UPDATE dbo.GIAY_PHEP
SET MS_LOAI_GP = @MS_LOAI_GP,
MS_N_XUONG =@MS_N_XUONG,
DS_PHIEU_BAO_TRI =@DS_PHIEU_BAO_TRI,
GHI_CHU =@GHI_CHU,
DUYET = 0,
NGAY_LAP = @NGAY_LAP,
NGUOI_DUYET = NULL,
NGAY_DUYET = NULL
WHERE MS_GP =@MS_GP
END
ELSE
BEGIN
UPDATE dbo.GIAY_PHEP
SET 
DUYET = 1,
NGUOI_DUYET = @NGUOI_LAP,
NGAY_DUYET = @NGAY_LAP
WHERE MS_GP =@MS_GP
END	
END	
SELECT @MS_GP

END	
