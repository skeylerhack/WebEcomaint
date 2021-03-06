IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetPhuTungKHTT_baria')
   exec('CREATE FUNCTION  dbo.GetPhuTungKHTT_baria () RETURNS  nvarchar(50) as Begin return null end')
GO


ALTER function [dbo].[GetPhuTungKHTT_baria]
(
	@HANG_MUC_ID int,
	@MS_CV int,
	@MS_BO_PHAN NVARCHAR(100)
)
returns nvarchar(4000)
as
begin
declare @sName nvarchar(4000)

SELECT     @sName = COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'') + TEN_PT + 
' ( ' + convert(nvarchar(10),a.SO_LUONG) + dvt.TEN_1 + ')'

FROM KE_HOACH_TONG_CONG_VIEC_PHU_TUNG A INNER JOIN IC_PHU_TUNG B ON A.MS_PT = B.MS_PT 
inner join DON_VI_TINH dvt on b.DVT = dvt.DVT
WHERE HANG_MUC_ID =    @HANG_MUC_ID    AND A.MS_BO_PHAN = @MS_BO_PHAN AND A.MS_CV = @MS_CV

                      


return @sName
end
