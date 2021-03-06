
	 
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetPhieuNhapTra')
   exec('CREATE FUNCTION  dbo.GetPhieuNhapTra () RETURNS  nvarchar(1000) as Begin return null end')
GO
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
		SELECT T.MS_DH_NHAP_PT  FROM IC_DON_HANG_NHAP T
INNER JOIN IC_DON_HANG_NHAP_VAT_TU T1 ON T1.MS_DH_NHAP_PT = T.MS_DH_NHAP_PT 
INNER JOIN IC_DON_HANG_NHAP_VAT_TU_CHI_TIET T2 ON T2.MS_DH_NHAP_PT = T1.MS_DH_NHAP_PT AND T1.MS_PT = T2.MS_PT AND T1.ID = T2.ID 
WHERE  T.MS_DHX  = @MS_DH_XUAT_PT AND T1.MS_DH_NHAP_PT_GOC  =@MS_DH_NHAP_PT
		
		) T

return @ms_dh_tra
end




