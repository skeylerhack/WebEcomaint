IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'CapNhapPhieuXuatPBTChiTiet')
   exec('CREATE PROCEDURE CapNhapPhieuXuatPBTChiTiet AS BEGIN SET NOCOUNT ON; END')
GO
--EXEC CapNhapPhieuXuatPBTChiTiet
ALTER PROC [dbo].[CapNhapPhieuXuatPBTChiTiet]
	@PBT nvarchar(50)
AS
begin
	declare @sName nvarchar(4000)
	SET @sName = ''
	SELECT @sName = COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'' )  + 
		ISNULL(MS_DH_XUAT_PT ,'')  
	FROM IC_DON_HANG_XUAT B WHERE MS_PHIEU_BAO_TRI = @PBT 

	UPDATE PHIEU_BAO_TRI SET DHX = @sName WHERE MS_PHIEU_BAO_TRI = @PBT
End


