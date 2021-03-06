IF NOT EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'MGetGiaTriThongSoGSTT')
   exec('CREATE FUNCTION  dbo.MGetGiaTriThongSoGSTT () RETURNS  nvarchar(50) as Begin return null end')
GO




--SELECT *,DBO.MGetGiaTriThongSoGSTT(MS_TS_GSTT) FROM THONG_SO_GSTT
ALTER function [dbo].[MGetGiaTriThongSoGSTT]
(
	@MS_TS_GSTT nvarchar(50)
)
returns nvarchar(4000)
as
begin
declare @sName nvarchar(4000)



SELECT     @sName = COALESCE(ISNULL(@sName,'') + 
	CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'') + 
	ISNULL(TEN_GIA_TRI,'')  
	FROM        GIA_TRI_TS_GSTT
	WHERE MS_TS_GSTT = @MS_TS_GSTT	
	ORDER BY ISNULL(TEN_GIA_TRI,'')  	

return @sName
end

