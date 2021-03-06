IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetTenMayGSTT')
   exec('CREATE FUNCTION  dbo.GetTenMayGSTT () RETURNS  nvarchar(4000) as Begin return null end')
GO
--SELECT dbo.GetTenMayGSTT(STT), * FROM GIAM_SAT_TINH_TRANG
ALTER function [dbo].[GetTenMayGSTT]
(
	@STT INT
)
returns nvarchar(4000)
as 
begin

declare @TEN_MAY nvarchar(4000)
SELECT @TEN_MAY =COALESCE(@TEN_MAY + ', ', '') +
	CAST(TEN_MAY AS Nvarchar(4000))
	FROM 
		(SELECT DISTINCT T2.TEN_MAY
FROM         dbo.GIAM_SAT_TINH_TRANG_TS AS T1 INNER JOIN
                      may AS T2 ON T1.MS_MAY = T2.MS_MAY
WHERE     (T1.STT = @STT )) T1 ORDER BY TEN_MAY
return @TEN_MAY
end




