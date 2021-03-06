

-----------------
ALTER PROCEDURE [dbo].[spInsertThoiGianNgungMayBoPhanTheoMay]
	
	@MS_MAY Nvarchar(30),
	@MS_LAN VARCHAR(50),	
	@STT int,
	@MS_BO_PHAN nvarchar(50),	
	@MS_PT nvarchar(50), 
	@DEL int

AS
	IF(@STT = -1)
	BEGIN

			INSERT INTO THOI_GIAN_NGUNG_MAY_PHU_TUNG( MS_MAY, MS_LAN, MS_BO_PHAN, MS_PT) VALUES
			( @MS_MAY, @MS_LAN,@MS_BO_PHAN, @MS_PT)
		
	END
	ELSE
	BEGIN		
			IF(@DEL = 1)
			BEGIN
				DELETE THOI_GIAN_NGUNG_MAY_PHU_TUNG WHERE STT = @STT
			END
			ELSE
			BEGIN
				UPDATE THOI_GIAN_NGUNG_MAY_PHU_TUNG SET MS_PT = @MS_PT, MS_BO_PHAN = @MS_BO_PHAN WHERE STT = @STT 		
			END
	END
