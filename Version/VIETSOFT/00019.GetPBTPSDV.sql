
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetPBTPSDV')
   exec('CREATE FUNCTION  dbo.GetPBTPSDV () RETURNS  nvarchar(4000) as Begin return null end')
GO

--SELECT dbo.GetPBTPSDV(MS_YEU_CAU) AS MSPBT, * FROM PHAT_SINH_DICH_VU
ALTER function [dbo].[GetPBTPSDV]
(
	@MSYC NVARCHAR(30)
)

RETURNS  nvarchar(4000)
as 

begin
declare @sName nvarchar(4000)

	SELECT @sName = COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'' )  + 
		ISNULL(MS_PHIEU_BAO_TRI ,'') 
	FROM PSDV_PHIEU_BT WHERE MS_YEU_CAU = @MSYC ORDER BY MS_PHIEU_BAO_TRI
	
return @sName

end

GO


