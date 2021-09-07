--DROP PROCEDURE GetPhutungTheoMay GetBoPhanTheoMay
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetBoPhanTheoMay')   
exec('CREATE PROCEDURE GetBoPhanTheoMay AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[GetBoPhanTheoMay]
	@MS_MAY NVARCHAR(30) ='BLN-01-01',
	@STT INT =70
AS 
BEGIN
SELECT MS_BO_PHAN, MS_BO_PHAN_CHA, (MS_BO_PHAN + ': ' + TEN_BO_PHAN) AS TEN_BO_PHAN  FROM CAU_TRUC_THIET_BI WHERE MS_MAY = @MS_MAY
END	