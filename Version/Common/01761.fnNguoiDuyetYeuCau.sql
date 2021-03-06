
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnNguoiDuyetYeuCau]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [dbo].[fnNguoiDuyetYeuCau]
GO
CREATE FUNCTION [dbo].[fnNguoiDuyetYeuCau]
(
		@STT INT = NULL
)
RETURNS NVARCHAR(200)
AS
BEGIN
		DECLARE @NGUOI_DUYET NVARCHAR(200) = NULL
		IF(SELECT COUNT(*) FROM dbo.YEU_CAU_NSD_CHI_TIET WHERE STT = @STT AND USERNAME_DSX IS NOT NULL) > 0 
		BEGIN
			-- nếu có tên user trong th
			IF (SELECT MS_CONG_NHAN FROM dbo.USERS WHERE USERNAME = (SELECT DISTINCT USERNAME_DSX FROM dbo.YEU_CAU_NSD_CHI_TIET WHERE STT = @STT AND USERNAME_DSX IS NOT NULL)) IS NULL
			-- nếu có công nhân thì lấy tên công nhân
			BEGIN
			SET @NGUOI_DUYET = (SELECT FULL_NAME FROM dbo.USERS WHERE USERNAME = (SELECT DISTINCT USERNAME_DSX FROM dbo.YEU_CAU_NSD_CHI_TIET WHERE STT = @STT AND USERNAME_DSX IS NOT NULL))
			END
            
			ELSE
			BEGIN
				SET @NGUOI_DUYET = (SELECT HO +' '+ TEN FROM dbo.CONG_NHAN WHERE MS_CONG_NHAN = (SELECT MS_CONG_NHAN FROM dbo.USERS WHERE USERNAME = (SELECT DISTINCT USERNAME_DSX FROM dbo.YEU_CAU_NSD_CHI_TIET WHERE STT = @STT AND USERNAME_DSX IS NOT NULL)))
			END	
		END 
		ELSE
        BEGIN
        	SET @NGUOI_DUYET = ''
        END
		RETURN @NGUOI_DUYET
END

