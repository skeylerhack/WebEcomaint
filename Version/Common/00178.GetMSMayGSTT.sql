IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetMSMayGSTT')
   exec('CREATE FUNCTION  dbo.GetMSMayGSTT () RETURNS  nvarchar(4000) as Begin return null end')
GO
--SELECT dbo.GetMSMayGSTT(STT),dbo.GettenMayGSTT(STT, NGAY_KT,'ADMIN'), * FROM GIAM_SAT_TINH_TRANG
ALTER function [dbo].[GetMSMayGSTT]
(
	@STT INT
)
returns nvarchar(4000)
as 
begin

declare @MS_MAY nvarchar(4000)
SELECT @MS_MAY =COALESCE(@MS_MAY + ', ', '') +
	CAST(MS_MAY AS Nvarchar(4000))
	FROM 
		(SELECT DISTINCT T2.MS_MAY
FROM         dbo.GIAM_SAT_TINH_TRANG_TS AS T1 INNER JOIN
                      MAY AS T2 ON T1.MS_MAY = T2.MS_MAY
WHERE     (T1.STT = @STT )) T1 ORDER BY MS_MAY
return @MS_MAY
end




