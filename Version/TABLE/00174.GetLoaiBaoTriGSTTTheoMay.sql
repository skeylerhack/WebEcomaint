




IF NOT EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'GetLoaiBaoTriGSTTTheoMay')
   exec('CREATE FUNCTION  dbo.GetLoaiBaoTriGSTTTheoMay () RETURNS  nvarchar(max) as Begin return null end')
GO


--SELECT dbo.GetLoaiBaoTriGSTTTheoMay(MS_MAY,0) as asdasas FROM may



ALTER FUNCTION [dbo].[GetLoaiBaoTriGSTTTheoMay]
(
	@MsMay nvarchar(100),
	@NNgu INT
)
returns nvarchar(max)
as
begin
declare @sName nvarchar(max)


	SELECT @sName =COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'' )  + TEN_DV_TG
	FROM
	(
		
			
			SELECT DISTINCT T1.MS_MAY,CONVERT(NVARCHAR(10), T1.CHU_KY_DO) + ' ' + 		
			CASE @NNgu WHEN 0 THEN T2.TEN_DV_TG  
			WHEN 1 THEN ISNULL(NULLIF(T2.TEN_DV_TG_ANH ,''),T2.TEN_DV_TG )
			ELSE ISNULL(NULLIF(T2.TEN_DV_TG_HOA,''),T2.TEN_DV_TG ) END  AS TEN_DV_TG
			FROM dbo.CAU_TRUC_THIET_BI_TS_GSTT T1 INNER JOIN dbo.DON_VI_THOI_GIAN T2 ON T2.MS_DV_TG = T1.MS_DV_TG
			WHERE T1.MS_MAY = @MsMay
	) T1
              
return @sName
end

