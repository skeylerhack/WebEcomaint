
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDeXuatChiTiet')
   EXEC('CREATE PROCEDURE spGetDeXuatChiTiet AS BEGIN SET NOCOUNT ON; END')
GO

alter proc spGetDeXuatChiTiet
	@msDX nvarchar(50)
as
begin 
	select row_number() over(order by MS_PT)  STT, TEN_PT, SL_DE_XUAT SL_DAT_HANG, DVT, DON_GIA, THUE_VAT, DON_GIA * THUE_VAT / 100 TIEN_THUE, THANH_TIEN from DE_XUAT_MUA_HANG_CHI_TIET where MS_DE_XUAT = @msDX
end


