IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spInsertThoiGianNgungMayBoPhanTheoMay')
   exec('CREATE PROCEDURE spInsertThoiGianNgungMayBoPhanTheoMay AS BEGIN SET NOCOUNT ON; END')
GO
-----------------
ALTER PROCEDURE [dbo].[spInsertThoiGianNgungMayBoPhanTheoMay]
	
	@MS_MAY Nvarchar(30),
	@NGAY DATETIME,
	@TU_GIO DATETIME,
	@DEN_NGAY DATETIME,
	@DEN_GIO DATETIME,
	@STT int,
	@MS_BO_PHAN nvarchar(50),	
	@MS_PT nvarchar(50), 
	@DEL int

AS
	--IF(@STT = -1)
	--BEGIN

	--		INSERT INTO THOI_GIAN_NGUNG_MAY_PHU_TUNG( MS_MAY, NGAY, TU_GIO, DEN_NGAY, DEN_GIO, MS_BO_PHAN, MS_PT) VALUES
	--		( @MS_MAY, @NGAY, @TU_GIO, @DEN_NGAY,@DEN_GIO,@MS_BO_PHAN, @MS_PT)
		
	--END
	--ELSE
	--BEGIN		
	--		IF(@DEL = 1)
	--		BEGIN
	--			DELETE THOI_GIAN_NGUNG_MAY_PHU_TUNG WHERE STT = @STT
	--		END
	--		ELSE
	--		BEGIN
	--			UPDATE THOI_GIAN_NGUNG_MAY_PHU_TUNG SET MS_PT = @MS_PT WHERE STT = @STT 		
	--		END
	--END
