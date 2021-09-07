
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'GetUserRequest')
   exec('CREATE PROCEDURE GetUserRequest AS BEGIN SET NOCOUNT ON; END')
GO


ALTER procedure GetUserRequest
	@requestedBy NVARCHAR(50),
	@fromDate NVARCHAR(10),
	@toDate  NVARCHAR(10),
	@username NVARCHAR(50), 
	@lang int
AS
DECLARE @TU_NGAY DATETIME
DECLARE @DEN_NGAY DATETIME
IF  @fromDate='  /  /' 
	SET @TU_NGAY=NULL
ELSE
	SET @TU_NGAY=CONVERT(DATETIME, @fromDate)
IF  @toDate='  /  /' 
	SET @DEN_NGAY=NULL
ELSE
	SET @DEN_NGAY=CONVERT(DATETIME, @toDate)
	
IF @requestedBy = ''
	SET @requestedBy = '-1'
IF @username = ''
	SET @username = '-1'
	
SELECT DISTINCT MS_N_XUONG INTO  #NX_TMP FROM dbo.MashjGetNXUser(@username, '-1')
	

SELECT DISTINCT A.STT ID, A.MS_YEU_CAU UserRequestID, A.SO_YEU_CAU RequestNO, A.NGAY DateCreated, A.GIO_YEU_CAU HourCreated, A.NGUOI_YEU_CAU RequestedBy, A.USER_COMMENT UserComment, A.NGAY_HOAN_THANH DateCompleted, A.DA_KIEM_TRA IsChecked,
A.USERNAME Username, A.REVIEWER_COMMENT ReviewComment, A.USER_LAP CreatedBy, A.EMAIL_NSD Email, A.MS_N_XUONG WorkSiteID, CASE @lang WHEN 0 THEN B.Ten_N_XUONG 
WHEN 1 THEN TEN_N_XUONG_A ELSE TEN_N_XUONG_H END AS WorkSiteName ,CONVERT( BIT, ISNULL((SELECT TOP 1 ISNULL(THUC_HIEN_DSX,0) 
FROM YEU_CAU_NSD_CHI_TIET X WHERE THUC_HIEN_DSX = 1 AND A.STT = X.STT),0)) AS IsExecuteApproveRequested
FROM         dbo.YEU_CAU_NSD AS A INNER JOIN
                      dbo.NHA_XUONG AS B ON A.MS_N_XUONG = B.MS_N_XUONG INNER JOIN 
                      #NX_TMP AS NX ON A.MS_N_XUONG = NX.MS_N_XUONG
WHERE     (A.NGAY BETWEEN ISNULL(@TU_NGAY, '20000101') AND ISNULL(@DEN_NGAY, '20990101')) AND (A.NGUOI_YEU_CAU = @requestedBy) OR
                      (A.NGAY BETWEEN ISNULL(@TU_NGAY, '20000101') AND ISNULL(@DEN_NGAY, '20990101')) AND (@requestedBy = '-1')
ORDER BY A.STT DESC
