IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'VS_LEADERSHIPDETAILS')
   exec('CREATE PROCEDURE VS_LEADERSHIPDETAILS AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROCEDURE [dbo].[VS_LEADERSHIPDETAILS]
	@ACTION NVARCHAR(250) = NULL,
	@USER_NAME NVARCHAR(30) = N'',
	@DateCreate DATETIME = NULL,
	@sBT NVARCHAR(250) = N''
AS
BEGIN
	IF @ACTION='GET_MAX_DATECREATE'
	BEGIN
		SELECT MAX(DateCreate) FROM LeadershipDetails WHERE UserName = @USER_NAME
	END

	IF @ACTION='GET_DATA'
	BEGIN
		SELECT ROW_NUMBER() OVER(ORDER BY IDLeadership) AS STT, ISNULL(LSD.IDLeadership, LS.ID) AS IDLeadership, LS.Content, LSD.UserName, ISNULL(LSD.DateCreate, GETDATE()) AS DateCreate, ISNULL(LSD.Yes,0) AS Yes, ISNULL(LSD.No, 0 ) AS No, ISNULL(LSD.NA, 0 ) AS NA FROM dbo.Leadership LS
		LEFT JOIN dbo.LeadershipDetails LSD ON LSD.IDLeadership = LS.ID AND LSD.UserName  = @USER_NAME AND CONVERT(DATE,LSD.DateCreate) = CONVERT(DATE,@DateCreate)
		WHERE LS.Active = 1
	END

	IF @ACTION='LIST_USER'
	BEGIN
		--USER ADMIN KHÔNG CÓ TRONG [dbo].[ST_Safety]
		IF NOT EXISTS (SELECT * FROM [dbo].[ST_Safety] WHERE Userlogin = @USER_NAME) 
		BEGIN
			SELECT TOP 1 U.USERNAME AS Userlogin, ISNULL(S.Staffname, U.USERNAME) AS Staffname, 0 STT
			FROM dbo.USERS U
			LEFT JOIN  [dbo].[ST_Safety] S ON U.USERNAME = S.Userlogin
			WHERE USERNAME = @USER_NAME
			UNION
			SELECT Userlogin, Staffname, 1 STT FROM [dbo].[ST_Safety]
			WHERE Userlogin <> @USER_NAME
			ORDER BY STT, Staffname
		END
		ELSE
		BEGIN
			SELECT TOP 1 Userlogin, Staffname, 1 STT FROM [dbo].[ST_Safety]
			WHERE Userlogin = @USER_NAME
			UNION
			SELECT Userlogin, Staffname, 1 STT FROM [dbo].[ST_Safety]
			WHERE Userlogin <> @USER_NAME
			ORDER BY STT, Staffname
		END
		
	END

	IF @ACTION='UPDATE'
	BEGIN
		CREATE TABLE #LeadershipDetails(
		IDLeadership INT,
		UserName NVARCHAR(30),
		DateCreate DATETIME,
		Yes BIT,
		No BIT,
		NA BIT)

	DECLARE @sSQL NVARCHAR(1000)
	SET @sSQL = 'INSERT INTO #LeadershipDetails(IDLeadership, UserName, DateCreate, Yes, No, NA) SELECT IDLeadership, UserName, DateCreate, Yes, No, NA FROM ' + @sBT
	EXEC(@sSQL)
	EXEC ('DROP TABLE ' + @sBT)

	--DELETE UNUSED ROW
	DELETE FROM dbo.LeadershipDetails WHERE IDLeadership  NOT IN (SELECT IDLeadership FROM #LeadershipDetails) AND UserName = @USER_NAME  

	--UPDATE ROW
	UPDATE LSD
	SET LSD.DateCreate = #LSD.DateCreate,
		LSD.Yes = #LSD.Yes,
		LSD.No = #LSD.No,
		LSD.NA = #LSD.NA
	FROM dbo.LeadershipDetails LSD
	INNER JOIN #LeadershipDetails #LSD ON LSD.IDLeadership = #LSD.IDLeadership  AND LSD.UserName = #LSD.UserName  

	--INSERT NEW ROW
	INSERT INTO dbo.LeadershipDetails (IDLeadership, UserName, DateCreate, Yes, No, NA)
	SELECT  IDLeadership, @USER_NAME, @DateCreate, Yes, No, NA
	FROM #LeadershipDetails 
	WHERE ISNULL(UserName,'') = ''
	END
	
END
