IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetRequestInfomation')
   
exec('CREATE PROCEDURE GetRequestInfomation AS BEGIN SET NOCOUNT ON; END')

GO

ALTER procedure [dbo].[GetRequestInfomation] 
	@ID as INTEGER = 72,
	@username NVARCHAR(50) ='Admin'
AS
DECLARE @NgayHT DATETIME
SET @NgayHT = GETDATE()
SELECT A.* INTO #MAY_TMP FROM dbo.MGetMayUserNgay(@NgayHT,@USERNAME,'-1',-1,-1,-1,'-1','-1',0)  A
SET FMTONLY OFF
SELECT     A.MS_MAY DeviceID, B.TEN_MAY DeviceName,D.TEN_LOAI_YEU_CAU_BT,A.MS_LOAI_YEU_CAU_BT TypeOfMaintenanceRequestID, A.MO_TA_TINH_TRANG [Description], CONVERT(INT,ISNULL(A.MS_NGUYEN_NHAN,-1)) AS CauseID, E.TEN_NGUYEN_NHAN,
			A.YEU_CAU Request, A.NGAY_XAY_RA DateOccurred, A.GIO_XAY_RA HourOccurred, A.MS_UU_TIEN PriorityID,C.TEN_UU_TIEN, A.STT ID, A.STT_VAN_DE UserRequestDetailID, A.MS_MAY AS OldDeviceID, A.STT_VAN_DE AS OldUserRequestDetailID,
			CONVERT(BIT,ISNULL(THUC_HIEN_DSX,0)) AS  IsExecuteApproveRequested
FROM         dbo.YEU_CAU_NSD_CHI_TIET AS A  INNER JOIN #MAY_TMP B ON A.MS_MAY = B.MS_MAY 
INNER JOIN dbo.MUC_UU_TIEN C ON C.MS_UU_TIEN = A.MS_UU_TIEN  
INNER JOIN dbo.LOAI_YEU_CAU_BAO_TRI D ON D.MS_LOAI_YEU_CAU_BT = A.MS_LOAI_YEU_CAU_BT
INNER JOIN dbo.NGUYEN_NHAN_DUNG_MAY E ON E.MS_NGUYEN_NHAN = A.MS_NGUYEN_NHAN
WHERE STT=@ID
ORDER BY A.MS_MAY



 