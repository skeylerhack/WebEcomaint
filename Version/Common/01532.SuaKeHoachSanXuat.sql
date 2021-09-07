IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SuaKeHoachSanXuat')
exec('CREATE PROCEDURE SuaKeHoachSanXuat AS BEGIN SET NOCOUNT ON; END')

GO
ALTER PROCEDURE SuaKeHoachSanXuat
	@ID INT =3,
	@TuNgay DATE = '12/01/2018',
	@GiaTri FLOAT = 455,
	@GhiChu NVARCHAR(MAX) ='test'
AS 
BEGIN
UPDATE dbo.KHSX_NGAY
SET	NGAY =@TuNgay,
GIO_KH = @GiaTri,
GHI_CHU = @GhiChu
WHERE ID =@ID
END