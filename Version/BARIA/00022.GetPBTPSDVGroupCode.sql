IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetPBTPSDVGroupCode')
   exec('CREATE FUNCTION  dbo.GetPBTPSDVGroupCode () RETURNS  nvarchar(4000) as Begin return null end')
GO


--SELECT dbo.GetPBTPSDVGroupCode(MS_YEU_CAU) AS MSPBT, * FROM PHAT_SINH_DICH_VU
ALTER function [dbo].[GetPBTPSDVGroupCode]
(
	@MSYC NVARCHAR(30),
	@MSGroupCode NVARCHAR(20)
)

RETURNS  nvarchar(4000)
as 

begin
declare @sName nvarchar(4000)

	SELECT @sName = COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'' )  + 
		ISNULL(MS_PHIEU_BAO_TRI ,'') 
	FROM PSDV_PHIEU_BT WHERE MS_YEU_CAU = @MSYC AND SER_GROUP_CODE = @MSGroupCode ORDER BY MS_PHIEU_BAO_TRI
	
return @sName

end

