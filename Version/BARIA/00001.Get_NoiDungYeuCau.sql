IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'Get_NoiDungYeuCau')
   exec('CREATE FUNCTION  dbo.Get_NoiDungYeuCau () RETURNS  nvarchar(50) as Begin return null end')
GO
--SELECT dbo.Get_NoiDungYeuCau(MS_PHIEU_BAO_TRI ), * FROM PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = 'WO-201409000004'	

ALTER function [dbo].[Get_NoiDungYeuCau]
(
	@MsPBT nvarchar(100)
)
returns nvarchar(1000)
as 
begin
DECLARE @NDUNGYC Nvarchar(1000)

SELECT @NDUNGYC =COALESCE(@NDUNGYC + ', ', '') +
CAST(YEU_CAU AS Nvarchar(1000))
FROM 
	(SELECT YEU_CAU FROM YEU_CAU_NSD_CHI_TIET WHERE MS_PBT=@MsPBT) T1
RETURN @NDUNGYC

end

