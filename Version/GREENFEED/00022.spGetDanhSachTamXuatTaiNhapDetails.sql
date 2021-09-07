IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDanhSachTamXuatTaiNhapDetails')
exec('CREATE PROCEDURE spGetDanhSachTamXuatTaiNhapDetails AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetDanhSachTamXuatTaiNhapDetails]
    @ID BIGINT
AS
BEGIN
    SELECT  ID,ID_TNX, MS_TAI_SAN, TEN_TAI_SAN, DVT, SL_XUAT, LY_DO_XUAT,
            NGAY_XUAT, SL_NHAP, LY_DO_NHAP, NGAY_NHAP
    FROM    dbo.PHIEU_TAM_XUAT_TAI_NHAP_CHI_TIET
    WHERE   ID_TNX =@ID
	ORDER BY MS_TAI_SAN
	END	
           
