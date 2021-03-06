IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDownTimeType')
   
exec('CREATE PROCEDURE spGetDownTimeType AS BEGIN SET NOCOUNT ON; END')

GO

ALTER PROCEDURE [dbo].[spGetDownTimeType]
	@Username NVARCHAR(100) ='admin',
	@NNgu INT =0,
	@CoAll BIT=1
AS 
BEGIN
IF @CoAll = 1
BEGIN
SELECT * FROM (SELECT ID, CASE @NNgu WHEN 0 THEN DownTimeTypeName WHEN 1 THEN ISNULL(DownTimeTypeNameA,DownTimeTypeName) WHEN 2 THEN	 ISNULL(DownTimeTypeNameH,DownTimeTypeName) END AS DownTimeTypeName  FROM dbo.DownTimeType
UNION
SELECT -1,N'< ALL >') A
ORDER BY A.ID
END
ELSE
BEGIN
SELECT ID, CASE @NNgu WHEN 0 THEN DownTimeTypeName WHEN 1 THEN ISNULL(DownTimeTypeNameA,DownTimeTypeName) WHEN 2 THEN	 ISNULL(DownTimeTypeNameH,DownTimeTypeName) END AS DownTimeTypeName  FROM dbo.DownTimeType
ORDER BY ID
END	
END	


