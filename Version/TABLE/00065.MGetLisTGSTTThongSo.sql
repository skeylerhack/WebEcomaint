

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'MGetLisTGSTTThongSo')
   exec('CREATE FUNCTION  dbo.MGetLisTGSTTThongSo () RETURNS  nvarchar(50) as Begin return null end')
GO
--SELECT dbo.MGetListGSTTThongSo(STT,A.MS_MAY,MS_TS_GSTT,MS_BO_PHAN,MS_TT) FROM GIAM_SAT_TINH_TRANG_TS A

ALTER function [dbo].[MGetListGSTTThongSo]
(
	@STT int,
	@MS_MAY nvarchar(30),
	@MS_TS_GSTT nvarchar(10),
	@MS_BO_PHAN nvarchar(50),
	@MS_TT int 
)
returns nvarchar(4000)
as
begin
declare @sName nvarchar(4000)



SELECT     @sName = COALESCE(ISNULL(@sName,'') + 
CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'') + ISNULL(B.TEN_GIA_TRI,'')
FROM         dbo.GIAM_SAT_TINH_TRANG_TS_DT AS A INNER JOIN
                      dbo.GIA_TRI_TS_GSTT AS B ON A.STT_GT = B.STT AND A.MS_TS_GSTT = B.MS_TS_GSTT
WHERE     (A.STT = @STT) AND (A.MS_MAY = @MS_MAY) AND (A.MS_TS_GSTT = @MS_TS_GSTT) 
AND (A.MS_BO_PHAN = @MS_BO_PHAN) AND (A.MS_TT = @MS_TT)


return @sName
end

