
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetRequestInfomation')
   exec('CREATE PROCEDURE GetRequestInfomation AS BEGIN SET NOCOUNT ON; END')
GO

ALTER procedure [dbo].[GetRequestInfomation] 
	@ID as integer,
	@username NVARCHAR(50)
AS

DECLARE @NgayHT DATETIME
SET @NgayHT = GETDATE()
SELECT A.* INTO #MAY_TMP FROM dbo.MGetMayUserNgay(@NgayHT,@USERNAME,'-1',-1,-1,-1,'-1','-1',0)  A
SET FMTONLY OFF

SELECT     A.MS_MAY DeviceID, A.MS_MAY AS DeviceName,MS_LOAI_YEU_CAU_BT TypeOfMaintenanceRequestID, A.MO_TA_TINH_TRANG [Description], CONVERT(INT,ISNULL(A.MS_NGUYEN_NHAN,-1)) AS CauseID, 
			A.YEU_CAU Request, A.NGAY_XAY_RA DateOccurred, A.GIO_XAY_RA HourOccurred, MS_UU_TIEN PriorityID, A.STT ID, A.STT_VAN_DE UserRequestDetailID, A.MS_MAY AS OldDeviceID, A.STT_VAN_DE AS OldUserRequestDetailID,
			CONVERT(BIT,ISNULL(THUC_HIEN_DSX,0)) AS  IsExecuteApproveRequested
FROM         dbo.YEU_CAU_NSD_CHI_TIET AS A  INNER JOIN #MAY_TMP B ON A.MS_MAY = B.MS_MAY 
WHERE STT=@ID
ORDER BY A.MS_MAY

 