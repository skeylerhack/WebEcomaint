

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetMS_YEU_CAU')
   exec('CREATE FUNCTION  dbo.GetMS_YEU_CAU () RETURNS INT as Begin return null end')
GO
--SELECT  dbo.GetMS_YEU_CAU('WO-201612000267')
alter function [dbo].[GetMS_YEU_CAU]
(
	@MS_PBT NVARCHAR(20)
)
returns nvarchar(MAX)
as 
begin

declare @MS_YEU_CAU nvarchar(MAX)
SELECT @MS_YEU_CAU =COALESCE(@MS_YEU_CAU + ', ', '') +
	CAST(T.MS_YEU_CAU AS Nvarchar(MAX))
	FROM 
		(SELECT DISTINCT MS_YEU_CAU
FROM        YEU_CAU_NSD AS T1 inner JOIN
                      YEU_CAU_NSD_CHI_TIET AS T2 ON T1.STT = T2.STT
WHERE     (T2.MS_PBT = @MS_PBT )) T

return @MS_YEU_CAU
end

