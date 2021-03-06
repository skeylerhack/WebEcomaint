
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetTenGT_TSGSTT')
   exec('CREATE FUNCTION  dbo.GetTenGT_TSGSTT () RETURNS  nvarchar(4000) as Begin return null end')
GO
ALTER function [dbo].[GetTenGT_TSGSTT]
(
	@MS_MAY NVARCHAR(20), 
	@STT INT
)
returns nvarchar(4000)
as
begin

declare @sName nvarchar(4000)

SELECT    @sName = COALESCE(ISNULL(@sName,'') + 
		CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE ', ' END  ,'') + 
		ISNULL(TEN_GIA_TRI,'')
		FROM 	 GIAM_SAT_TINH_TRANG T INNER JOIN 
			GIAM_SAT_TINH_TRANG_TS_DT T1
				ON T.STT = T1.STT INNER JOIN THONG_SO_GSTT T2 ON T2.MS_TS_GSTT = T1.MS_TS_GSTT
				INNER JOIN GIA_TRI_TS_GSTT T3 ON T2.MS_TS_GSTT = T3.MS_TS_GSTT AND T1.STT_GT = T3.STT
				WHERE T1.MS_MAY = @MS_MAY AND LOAI_TS = 1 and T.STT = @STT

		
return @sName
end
