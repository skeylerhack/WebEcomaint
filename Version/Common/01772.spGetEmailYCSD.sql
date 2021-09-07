
alter PROC [dbo].[spGetEmailYCSD]
	@iSTT BIGINT = 1366,
	@sNXCha NVARCHAR(MAX) = 'NM1-001',
	@MsLoaiGoiMail NVARCHAR(2) = '1',
	@sUName NVARCHAR(100) = 'pro5',
	@sMailThem NVARCHAR(MAX) = ''
AS	
--@MsLoaiGoiMail
--1	Khi nhập yêu cầu bảo trì
--2	Khi duyệt yêu cầu bảo trì
--3	Khi tiếp nhận yêu cầu bảo trì

IF @MsLoaiGoiMail = '2'
BEGIN
SET @sNXCha = (SELECT MS_N_XUONG FROM dbo.YEU_CAU_NSD WHERE STT = @iSTT)
END
DECLARE @sMail NVARCHAR(2000)
SET @sMail = ''
--lay all mail cua use ycsd, user lap user DSX, user DBT lay lun ca mail goi them
SELECT   @sMail = COALESCE(ISNULL(@sMail,'') + CASE LEN(@sMail) WHEN 0 THEN '' ELSE '; ' END , '') + ISNULL(MAIL_NSD,'')  
FROM     (  
SELECT        
ISNULL(T3.USER_MAIL,'') + CASE ISNULL(T3.USER_MAIL,'') WHEN '' THEN '' ELSE '; ' END  + 
ISNULL(T1.EMAIL_NSD,'') + CASE ISNULL(T1.EMAIL_NSD,'') WHEN '' THEN '' ELSE '; ' END  + 

ISNULL(T5.USER_MAIL,'') + CASE ISNULL(T5.USER_MAIL,'') WHEN '' THEN '' ELSE '; ' END  + 
ISNULL(T2.EMAIL_DSX,'') + CASE ISNULL(T2.EMAIL_DSX,'') WHEN '' THEN '' ELSE '; ' END  + 

ISNULL(T4.USER_MAIL,'') + CASE ISNULL(T4.USER_MAIL,'') WHEN '' THEN '' ELSE '; ' END  + 
ISNULL(T2.EMAIL_DBT,'') + CASE ISNULL(T2.EMAIL_DBT,'') WHEN '' THEN '' ELSE '; ' END  AS MAIL_NSD

FROM            dbo.USERS AS T4 RIGHT OUTER JOIN
    dbo.YEU_CAU_NSD_CHI_TIET AS T2 ON T4.USERNAME = T2.USERNAME_DBT LEFT OUTER JOIN
    dbo.USERS AS T5 ON T2.USERNAME_DSX = T5.USERNAME RIGHT OUTER JOIN
    dbo.YEU_CAU_NSD AS T1 LEFT OUTER JOIN
    dbo.USERS AS T3 ON T1.USER_LAP = T3.USERNAME ON T2.STT = T1.STT
WHERE        (T1.STT = @iSTT)
) A
 
--truong hop goi mail là tao moi yeu cau su dung thi fai lay them use cung to phong ban
IF CONVERT(INT,@MsLoaiGoiMail) =1 
BEGIN
--Lấy mail theo to phong ban nguoi yeu cau
	DECLARE @sMailYC NVARCHAR(MAX) = ''
    SELECT @sMailYC = dbo.GetMailTheoUserYCSD (@iSTT)
	SET @sMail = @sMail + ISNULL(@sMailYC,'') + CASE ISNULL(@sMailYC,'') WHEN '' THEN '' ELSE '; ' END
END
--SELECT @sMailThem AS MT

IF LEN(RTRIM(LTRIM(@sMail))) > 0 
BEGIN
	IF LEN(RTRIM(LTRIM(@sMailThem))) = 0 
		SET @sMailThem = SUBSTRING(@sMail,1,LEN(@sMail)-1)
	ELSE
		SET @sMailThem = @sMailThem + ';' + SUBSTRING(@sMail,1,LEN(@sMail)-1)
END
--SELECT @sMailThem AS MTX

DECLARE @YCSD_EMAIL TABLE (
	[EMAIL] [nvarchar](MAX)  NULL
)  
--REPLACE(ISNULL(RTRIM(LTRIM(EMAIL)),''''), CHAR(13) + CHAR(10), '')
DECLARE @sSql NVARCHAR(MAX) = '  SELECT ISNULL(RTRIM(LTRIM(EMAIL)),'''') AS EMAIL  FROM dbo.NHA_XUONG_EMAIL WHERE  (MS_LOAI_EMAIL = ' +  + char(39)  + @MsLoaiGoiMail + char(39) + ') AND (MS_N_XUONG = ' + char(39)  + @sNXCha + char(39) + ') '
SELECT @sNXCha = DBO.MGetNXUongCha(@sNXCha)
--SELECT POS,[VALUE] FROM dbo.MGetSplit(@sNX,';')
Declare @Pos INT, @VALUE nvarchar (1000)
Declare  TTNhap CURSOR FOR
	SELECT * FROM dbo.MGetSplit(@sNXCha,';')
Open TTNhap
FETCH NEXT FROM TTNhap
INTO @Pos,@VALUE
While @@Fetch_Status = 0
BEGIN
	SET @sSql = @sSql  + 	' UNION SELECT ISNULL(RTRIM(LTRIM(EMAIL)),'''') AS EMAIL  FROM dbo.NHA_XUONG_EMAIL WHERE (MS_LOAI_EMAIL = ' +  + char(39)  + @MsLoaiGoiMail + char(39) + ') AND MS_N_XUONG = ' + char(39)  + @VALUE + char(39)  
    FETCH NEXT FROM TTNhap
    INTO  @Pos,@VALUE

End

Close TTNhap
Deallocate TTNhap
INSERT INTO @YCSD_EMAIL
exec (@sSql)
INSERT INTO @YCSD_EMAIL
SELECT ISNULL(USER_MAIL,'') FROM dbo.USERS WHERE USERNAME = @sUName
UNION	

SELECT @sMailThem
declare @sName nvarchar(max)

	SELECT @sName =COALESCE(ISNULL(@sName,'') + CASE LEN(ISNULL(@sName,'')) WHEN 0 THEN '' ELSE ';' END  ,'' )  + EMAIL
	FROM
	(
		SELECT DISTINCT REPLACE(RTRIM(LTRIM(EMAIL)), CHAR(13) + CHAR(10), '') AS EMAIL FROM @YCSD_EMAIL
	) T1


SELECT DISTINCT [VALUE] INTO #TMP FROM dbo.MGetSplit(@sName,';')
declare @sName1 nvarchar(max)
	SELECT @sName1 =COALESCE(ISNULL(@sName1,'') + CASE LEN(ISNULL(@sName1,'')) WHEN 0 THEN '' ELSE ';' END  ,'' )  + [VALUE]
	FROM
	(
		SELECT DISTINCT REPLACE(LTRIM(RTRIM([VALUE])), CHAR(13) + CHAR(10), '')  AS [VALUE] FROM #TMP
	) T1

	SELECT @sName1 AS EMAIL_YCSD




	