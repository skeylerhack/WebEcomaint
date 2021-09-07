IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetViTriTreeListAll')
exec('CREATE PROCEDURE GetViTriTreeListAll AS BEGIN SET NOCOUNT ON; END')
GO
ALTER proc [dbo].[GetViTriTreeListAll]
	@UserName nvarchar(50) ='admin',
	@NNgu INT = 0
AS
BEGIN
SELECT  RTRIM(CAST(MS_VI_TRI AS CHAR(10))) AS MS_VI_TRI,TEN_VI_TRI, RTRIM('@'+ CAST(MS_KHO AS CHAR(10))) AS 'MS_CHA' , MS_KHO AS STT FROM dbo.VI_TRI_KHO
union
SELECT RTRIM('@'+ CAST(MS_KHO AS CHAR(10))),TEN_KHO,NULL, MS_KHO AS STT FROM dbo.IC_KHO
union
SELECT '-99',NULL,NULL, -99 AS STT FROM dbo.IC_KHO
ORDER BY STT
END