
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type in (N'FN', N'IF', N'TF', N'FS', N'FT') AND name = 'GetLoaiBaoTriTheoMay')
   exec('CREATE FUNCTION  dbo.GetLoaiBaoTriTheoMay () RETURNS  nvarchar(max) as Begin return null end')
GO


--SELECT dbo.GetLoaiBaoTriTheoMay(MS_MAY,0) as asdasas FROM may



ALTER FUNCTION [dbo].[GetLoaiBaoTriTheoMay]
(
	@MsMay nvarchar(100),
	@NNgu INT
)
returns nvarchar(max)
as
begin
declare @sName nvarchar(max)


	SELECT @sName =COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE '; ' END  ,'' )  + TEN_LOAI_BT
	FROM
	(
		SELECT DISTINCT T2.TEN_LOAI_BT FROM dbo.MAY_LOAI_BTPN T1 INNER JOIN dbo.LOAI_BAO_TRI T2 ON	T2.MS_LOAI_BT = T1.MS_LOAI_BT WHERE MS_MAY = @MsMay
	) T1
              
return @sName
end

