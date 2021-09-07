
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'FN' AND name = 'Get_MsYeuCau')
   exec('CREATE FUNCTION  dbo.Get_MsYeuCau () RETURNS  nvarchar(50) as Begin return null end')
GO

--SELECT dbo.Get_MsYeuCau(MS_PHIEU_BAO_TRI ) as aaa, * FROM PHIEU_BAO_TRI WHERE MS_PHIEU_BAO_TRI = 'WO-201511000043'

ALTER function [dbo].[Get_MsYeuCau]
(
	@MsPBT nvarchar(100)
)
returns nvarchar(1000)
as 
begin

	
DECLARE @NDUNGYC Nvarchar(1000)

SELECT @NDUNGYC = COALESCE(@NDUNGYC + ', ' + char(13) ,  '') +
CAST(YEU_CAU AS Nvarchar(1000))
FROM 
	(SELECT MS_YEU_CAU + ' - ' + NGUOI_YEU_CAU AS YEU_CAU 
		FROM dbo.YEU_CAU_NSD AS T1 INNER JOIN dbo.YEU_CAU_NSD_CHI_TIET AS T2 ON T1.STT = T2.STT
		WHERE MS_PBT=@MsPBT ) T1 
RETURN @NDUNGYC

end

