
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetUserRequestDocument')
   exec('CREATE PROCEDURE GetUserRequestDocument AS BEGIN SET NOCOUNT ON; END')
GO

--EXEC GetUserRequestDocument 24 , '-1',-1

ALTER procedure GetUserRequestDocument 
	@ID INT,
	@deviceID NVARCHAR(30),
	@requestDetailID INT
AS 
	SELECT STT UserRequestID, MS_MAY DeviceID,STT_VAN_DE UserRequestDetailID,STT_HINH ID,DUONG_DAN [Path], GHI_CHU Note,DUONG_DAN as [Image]   FROM YEU_CAU_NSD_CHI_TIET_HINH
	WHERE	(STT=@ID)
	AND (MS_MAY = @deviceID OR @deviceID = '-1' )
	AND (STT_VAN_DE = @requestDetailID OR @requestDetailID = -1 )
