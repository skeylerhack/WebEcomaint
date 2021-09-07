
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDonHangChiTiet')
   EXEC('CREATE PROCEDURE spGetDonHangChiTiet AS BEGIN SET NOCOUNT ON; END')
GO

alter proc spGetDonHangChiTiet
	@msDH nvarchar(50)
as
begin 
	select row_number() over(order by MS_PT)  STT, TEN_PT, SL_DAT_HANG, DVT, DON_GIA, THUE_VAT, DON_GIA * THUE_VAT / 100 TIEN_THUE, THANH_TIEN from DON_DAT_HANG_CHI_TIET where MS_DON_DAT_HANG = @msDH
end
