
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetPhuTungbtpn_baria')
   exec('CREATE FUNCTION  dbo.GetPhuTungbtpn_baria () RETURNS  nvarchar(50) as Begin return null end')
GO

alter function [dbo].[GetPhuTungbtpn_baria]
(
	@MS_MAY	NVARCHAR(100),
	@MS_LOAI_BT int,
	@MS_CV int,
	@MS_BO_PHAN NVARCHAR(100)
)
returns nvarchar(4000)
as
begin
declare @sName nvarchar(4000)

SELECT     @sName = COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'') + TEN_PT + 
' ( ' + convert(nvarchar(10),a.SO_LUONG) + dvt.TEN_1 + ')'

FROM MAY_LOAI_BTPN_CONG_VIEC_PHU_TUNG A INNER JOIN IC_PHU_TUNG B ON A.MS_PT = B.MS_PT 
inner join DON_VI_TINH dvt on b.DVT = dvt.DVT
WHERE a.MS_LOAI_BT =    @MS_LOAI_BT    AND A.MS_BO_PHAN = @MS_BO_PHAN AND A.MS_CV = @MS_CV AND A.MS_MAY = @MS_MAY

return @sName
end
