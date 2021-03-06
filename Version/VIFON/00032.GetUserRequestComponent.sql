
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetUserRequestComponent')
   exec('CREATE PROCEDURE GetUserRequestComponent AS BEGIN SET NOCOUNT ON; END')
GO

ALTER procedure [dbo].[GetUserRequestComponent] 
	@ID INT,
	@deviceID	NVARCHAR(30),
	@requestDetailID 	INT
AS
	SELECT T.STT UserRequestID, T.MS_MAY DeviceID,T.STT_VAN_DE UserRequestDetailID,T.STT_BO_PHAN ID, T.MS_BO_PHAN ComponentID, T1.TEN_BO_PHAN ComponentName, T.MS_PT SparePartID, T2.TEN_PT SparePartName, T.MS_VI_TRI_PT LocationID, CONVERT(INT, 0) AS Del  FROM YEU_CAU_NSD_CHI_TIET_BO_PHAN T
	INNER JOIN CAU_TRUC_THIET_BI T1 ON T1.MS_BO_PHAN = T.MS_BO_PHAN AND T.MS_MAY = T1.MS_MAY 
	LEFT JOIN IC_PHU_TUNG T2 ON T.MS_PT = T2.MS_PT 
	WHERE	(T.STT=@ID)
	AND (T.MS_MAY = @deviceID OR @deviceID = '-1' )
	AND (T.STT_VAN_DE = @requestDetailID OR @requestDetailID = -1 )
	ORDER BY ISNULL(T1.STT, 999)


