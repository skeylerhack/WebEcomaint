
--SELECT dbo.GetGiaTriThongSo('10-05-CVM-024-00','01',196)

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'GetGiaTriThongSo')
   exec('CREATE FUNCTION  dbo.GetGiaTriThongSo () RETURNS  nvarchar(4000) as Begin return null end')
GO
alter function [dbo].[GetGiaTriThongSo]
(
	@MS_MAY NVARCHAR(50),
	@MS_BO_PHAN NVARCHAR(50),
	@MS_TS_GSTT NVARCHAR(50)
)
returns nvarchar(4000)
as 
begin

declare @TEN_MAY nvarchar(4000)
SELECT @TEN_MAY =COALESCE(@TEN_MAY + ' ', '') +
	CAST(T1.TEN_GT AS Nvarchar(4000))
	FROM 
		(SELECT DISTINCT ('<p>' + TEN_GT + ' [' + CONVERT(NVARCHAR(50), convert(decimal,GIA_TRI_DUOI)) + ' - ' +  CONVERT(NVARCHAR(50), convert(decimal, GIA_TRI_TREN)) + ']</p>') TEN_GT FROM THONG_SO_GSTT T
	INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT T1 ON T1.MS_TS_GSTT = T.MS_TS_GSTT 
	INNER JOIN CAU_TRUC_THIET_BI T2 ON T2.MS_MAY = T1.MS_MAY AND T2.MS_BO_PHAN = T1.MS_BO_PHAN 
	WHERE T.MS_TS_GSTT = @MS_TS_GSTT AND T2.MS_MAY = @MS_MAY AND T2.MS_BO_PHAN = @MS_BO_PHAN AND T.LOAI_TS = 0) T1
	ORDER BY T1.TEN_GT


	declare @JSON nvarchar(4000) = '['
	SELECT @JSON =COALESCE(@JSON + '', '') +
	CAST(T1.[JSON] AS Nvarchar(4000))
	FROM 
		(SELECT DISTINCT  '{"ID":"' + CONVERT(NVARCHAR(10), T1.MS_TT) + '","GiaTriDuoi":"' + CONVERT(NVARCHAR(50), convert(decimal,GIA_TRI_DUOI)) + '","GiaTriTren":"' + CONVERT(NVARCHAR(50), convert(decimal,GIA_TRI_TREN)) + '"},'     [JSON] FROM THONG_SO_GSTT T
	INNER JOIN CAU_TRUC_THIET_BI_TS_GSTT T1 ON T1.MS_TS_GSTT = T.MS_TS_GSTT 
	INNER JOIN CAU_TRUC_THIET_BI T2 ON T2.MS_MAY = T1.MS_MAY AND T2.MS_BO_PHAN = T1.MS_BO_PHAN 
	WHERE T.MS_TS_GSTT = @MS_TS_GSTT AND T2.MS_MAY = @MS_MAY AND T2.MS_BO_PHAN = @MS_BO_PHAN AND T.LOAI_TS = 0) T1
	ORDER BY T1.[JSON]
	
return @TEN_MAY + '!' + substring(@JSON, 1, (len(@JSON) - 1)) + ']'
end
