
ALTER PROC [dbo].[spPBTTinhTrangChiTiet]
	@MS_PHIEU_BAO_TRI nvarchar(50),
	@MS_TT_CT int,
	@GHI_CHU	nvarchar(500),
	@USERNAME nvarchar(50),
	@THOI_GIAN datetime
AS 
DECLARE @STT INT
SET @STT = 0 
SELECT @STT = ISNULL(STT,0) + 1 FROM PHIEU_BAO_TRI_TINH_TRANG_CHI_TIET WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI
IF @STT = 0 
	SET @STT = 1

UPDATE PHIEU_BAO_TRI 
SET MS_TT_CT = @MS_TT_CT 
WHERE MS_PHIEU_BAO_TRI = @MS_PHIEU_BAO_TRI 

IF NOT EXISTS (SELECT * FROM PHIEU_BAO_TRI_TINH_TRANG_CHI_TIET WHERE [MS_PHIEU_BAO_TRI] = @MS_PHIEU_BAO_TRI AND [THOI_GIAN] = @THOI_GIAN)
BEGIN
	INSERT INTO [PHIEU_BAO_TRI_TINH_TRANG_CHI_TIET] ([MS_PHIEU_BAO_TRI],[STT],[MS_TT_CT],[GHI_CHU],[USERNAME],[THOI_GIAN])
	VALUES (@MS_PHIEU_BAO_TRI,@STT,@MS_TT_CT,@GHI_CHU,@USERNAME,@THOI_GIAN)
END
SELECT @STT
