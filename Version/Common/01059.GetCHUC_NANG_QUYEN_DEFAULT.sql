

IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetCHUC_NANG_QUYEN_DEFAULT')
   exec('CREATE PROCEDURE GetCHUC_NANG_QUYEN_DEFAULT AS BEGIN SET NOCOUNT ON; END')
 Go
--EXEC GetCHUC_NANG_QUYEN_DEFAULT
ALTER procedure [dbo].[GetCHUC_NANG_QUYEN_DEFAULT]
 AS

	SELECT DISTINCT    dbo.CHUC_NANG.STT, dbo.CHUC_NANG.TEN_CHUC_NANG, MT_CN,CONVERT(BIT,0) AS CHON, CONVERT(BIT,'False') IS_UPDATE,  NULL USERNAME
	FROM         dbo.CHUC_NANG LEFT OUTER JOIN
                      dbo.USER_CHUC_NANG ON dbo.CHUC_NANG.STT = dbo.USER_CHUC_NANG.STT 
	ORDER BY dbo.CHUC_NANG.STT
