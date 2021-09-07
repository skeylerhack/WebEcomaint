IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetPBTTinhTrangTruocSau')
   exec('CREATE PROCEDURE [dbo].[GetPBTTinhTrangTruocSau] AS BEGIN SET NOCOUNT ON; END')
GO

--EXEC GetPBTTinhTrangTruocSau 'WO-201506000001'
ALTER PROC [dbo].[GetPBTTinhTrangTruocSau]
	@MSPBT nvarchar(20)
AS 

SELECT     ID, MS_PHIEU_BAO_TRI, THONG_SO_DO, THIET_BI_DO, TT_TRUOC_BT, TT_SAU_BT, MS_DV_DO, XAC_NHAN, GHI_CHU, USER_XN
FROM         dbo.PHIEU_BAO_TRI_TINH_TRANG
WHERE     (MS_PHIEU_BAO_TRI = @MSPBT)
ORDER BY THONG_SO_DO, THIET_BI_DO, TT_TRUOC_BT, TT_SAU_BT


