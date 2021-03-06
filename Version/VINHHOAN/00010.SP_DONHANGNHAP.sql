IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_DONHANGNHAP')
   exec('CREATE PROCEDURE [dbo].[SP_DONHANGNHAP] AS BEGIN SET NOCOUNT ON; END')
GO


ALTER  PROC  [dbo].[SP_DONHANGNHAP] 
@MS_DH_NHAP_PT NVARCHAR(50)
AS
SELECT     dbo.IC_KHO.TEN_KHO, dbo.IC_DON_HANG_NHAP.NGAY, dbo.IC_DON_HANG_NHAP.GIO, dbo.IC_DON_HANG_NHAP.BSXE, 									
                      dbo.IC_DON_HANG_NHAP.SO_CHUNG_TU,dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT									
FROM         dbo.IC_DON_HANG_NHAP INNER JOIN									
                      dbo.IC_KHO ON dbo.IC_DON_HANG_NHAP.MS_KHO = dbo.IC_KHO.MS_KHO             									
WHERE 		dbo.IC_DON_HANG_NHAP.MS_DH_NHAP_PT=	@MS_DH_NHAP_PT

SELECT     dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT, dbo.IC_PHU_TUNG.TEN_PT, dbo.DON_VI_TINH.TEN_1, 									
                      dbo.IC_DON_HANG_NHAP_VAT_TU.SO_LUONG_CTU, dbo.IC_DON_HANG_NHAP_VAT_TU.SL_THUC_NHAP, 									
                      dbo.IC_DON_HANG_NHAP_VAT_TU.DON_GIA, dbo.IC_DON_HANG_NHAP_VAT_TU.THANH_TIEN, dbo.IC_DON_HANG_NHAP.GHI_CHU									
FROM        dbo.IC_DON_HANG_NHAP inner join dbo.IC_DON_HANG_NHAP_VAT_TU on IC_DON_HANG_NHAP.MS_DH_NHAP_PT=IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT inner join 									
                      dbo.IC_PHU_TUNG ON dbo.IC_DON_HANG_NHAP_VAT_TU.MS_PT = dbo.IC_PHU_TUNG.MS_PT INNER JOIN									
                      dbo.DON_VI_TINH ON dbo.IC_PHU_TUNG.DVT = dbo.DON_VI_TINH.DVT	
WHERE 		dbo.IC_DON_HANG_NHAP_VAT_TU.MS_DH_NHAP_PT=	@MS_DH_NHAP_PT					

