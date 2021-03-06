IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetMayYeuCauSuDung')
   exec('CREATE FUNCTION  dbo.GetMayYeuCauSuDung () RETURNS  nvarchar(1000) as Begin return null end')
GO
--select dbo.GetMayYeuCauSuDung( 'PX-1704-0004', 'PN-1704-0009')

ALTER function [dbo].[GetMayYeuCauSuDung]
(
	@STT BIGINT,
	@NNgu INT,
	@LOAI INT
)
returns nvarchar(1000)
as 
begin
declare @TenMay nvarchar(1000)


	SELECT @TenMay =COALESCE(@TenMay + ', ', '') +
	CAST(T.TEN_MAY AS Nvarchar(1000))
	FROM 
		(

			SELECT STT, 
				CASE @LOAI WHEN 1 THEN
					CASE @NNgu WHEN 1 THEN T2.TEN_MAY WHEN 2 THEN ISNULL(NULLIF(T2.TEN_MAY_ANH,''),T2.TEN_MAY) ELSE ISNULL(NULLIF(T2.TEN_MAY_HOA,''),T2.TEN_MAY) END 
				ELSE T1.MS_MAY END
				AS TEN_MAY  FROM YEU_CAU_NSD_CHI_TIET T1 INNER JOIN MAY T2 ON T1.MS_MAY = T2.MS_MAY WHERE STT = @STT
		
		) T

return @TenMay
end




