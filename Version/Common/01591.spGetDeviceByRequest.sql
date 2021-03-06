


IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spGetDeviceByRequest')
   
exec('CREATE PROCEDURE spGetDeviceByRequest AS BEGIN SET NOCOUNT ON; END')

GO


ALTER PROC [dbo].[spGetDeviceByRequest]
(
	@username NVARCHAR(50),
	@workSiteID NVARCHAR(50),
	@requestDetailID INT
)
as

DECLARE @date DATETIME
SET @date = GETDATE()

SELECT @date = NGAY FROM YEU_CAU_NSD WHERE STT = @requestDetailID



SELECT A.MS_MAY ID,A.TEN_MAY [Name] FROM dbo.MGetMayUserNgay(@date,@username,@workSiteID,-1,-1,-1,'-1','-1',0)  A 
UNION 
SELECT T1.MS_MAY,T2.TEN_MAY FROM YEU_CAU_NSD_CHI_TIET T1 INNER JOIN MAY T2 ON T1.MS_MAY = T2.MS_MAY WHERE STT = @requestDetailID
ORDER BY MS_MAY
