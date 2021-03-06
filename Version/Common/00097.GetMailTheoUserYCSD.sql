IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetMailTheoUserYCSD')
   exec('CREATE FUNCTION  dbo.GetMailTheoUserYCSD () RETURNS  nvarchar(50) as Begin return null end')
GO
-- EXEC GetMailTheoUserYCSD 17
ALTER function [dbo].[GetMailTheoUserYCSD]
(
	@STT INT
)
returns nvarchar(1000)
as 
begin

declare @sName nvarchar(4000)
SET @sName = ''
SELECT @sName =  COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'') + USER_MAIL
FROM 
(SELECT A.* FROM USERS A INNER JOIN USER_CHUC_NANG B ON A.USERNAME = B.USERNAME WHERE STT = 13) T1 INNER JOIN 
(SELECT MS_TO FROM YEU_CAU_NSD A INNER JOIN USERS B ON A.USER_LAP = B.USERNAME WHERE A.STT = @STT)  T2 
ON T1.MS_TO = T2.MS_TO
WHERE ISNULL(USER_MAIL,'') <> ''


RETURN @sName

END