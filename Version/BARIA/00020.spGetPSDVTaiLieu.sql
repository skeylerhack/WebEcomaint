IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetPSDVTaiLieu')
   exec('CREATE PROCEDURE [dbo].[spGetPSDVTaiLieu] AS BEGIN SET NOCOUNT ON; END')
GO

--EXEC spGetPSDVTaiLieu '01/01/2015','01/01/2016', -1

ALTER PROC spGetPSDVTaiLieu
	@MsYeuCau NVARCHAR(20)
AS
	
	SELECT    TAI_LIEU_THAU, TL_SO,NOI_DUNG,GHI_CHU,DUONG_DAN, ID_PSDV_TL, MS_YEU_CAU, CONVERT(BIT,1) AS CU_MOI
	FROM         PSDV_TAI_LIEU AS T1 
	WHERE MS_YEU_CAU = @MsYeuCau
	ORDER BY TAI_LIEU_THAU, TL_SO
	
	