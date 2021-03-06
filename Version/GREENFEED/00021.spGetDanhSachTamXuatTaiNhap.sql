IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDanhSachTamXuatTaiNhap')
exec('CREATE PROCEDURE spGetDanhSachTamXuatTaiNhap AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[spGetDanhSachTamXuatTaiNhap]
    @TNgay DATETIME = '01/01/2020' ,
    @DNgay DATETIME = '01/01/2021'
AS
BEGIN

    SELECT  A.ID, A.MS_TX_TN, A.NGUOI_DE_NGHI, A.MS_NHAN_VIEN, A.TEN_BO_PHAN,
            A.CNMD,A.NGUOI_MANG_RA, A.NOI_NHAN, A.PHUONG_TIEN_VC, A.TG_MANG_VE, A.NGUOI_LAP,
            A.NGAY_LAP, A.NGUOI_DUYET, A.NGAY_DUYET,A.GHI_CHU
    FROM    dbo.PHIEU_TAM_XUAT_TAI_NHAP A
    WHERE   A.NGAY_LAP BETWEEN @TNgay AND @DNgay
	ORDER BY A.MS_TX_TN,A.NGAY_LAP
	END	
           
