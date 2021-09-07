
--IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[fnNguoiDuyetYeuCau]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
--DROP FUNCTION [dbo].[fnNguoiDuyetYeuCau]
--GO
ALTER function [dbo].[GetPhieuNhapTra]
(
	@MS_DH_XUAT_PT nvarchar(50),
	@MS_DH_NHAP_PT nvarchar(50)
)
returns nvarchar(1000)
as 
begin
declare @ms_dh_tra nvarchar(1000)
	SELECT @ms_dh_tra =COALESCE(@ms_dh_tra + ', ', '') +
	CAST(T.MS_DH_NHAP_PT AS Nvarchar(1000))
	FROM 
		(
		SELECT DISTINCT T.MS_DH_NHAP_PT  FROM IC_DON_HANG_NHAP T
INNER JOIN IC_DON_HANG_NHAP_VAT_TU T1 ON T1.MS_DH_NHAP_PT = T.MS_DH_NHAP_PT 
INNER JOIN IC_DON_HANG_NHAP_VAT_TU_CHI_TIET T2 ON T2.MS_DH_NHAP_PT = T1.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT AND T1.ID = T2.ID 
WHERE  T.MS_DHX  = @MS_DH_XUAT_PT AND T1.MS_DH_NHAP_PT_GOC  =@MS_DH_NHAP_PT AND T.MS_DANG_NHAP = 6
		
		) T

return @ms_dh_tra
end
GO


