IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'VS_LEADERSHIP')
   exec('CREATE PROCEDURE VS_LEADERSHIP AS BEGIN SET NOCOUNT ON; END')
GO
ALTER PROC  [dbo].[VS_LEADERSHIP]
(
	@USER_NAME NVARCHAR(30) = N'',
	@ACTION NVARCHAR(250) = N'',
	@sBT NVARCHAR(Max) = N'',
	@ID INT = NULL,
	@Content NVARCHAR(MAX) = N'',
	@Active BIT = NULL
)
AS
BEGIN
	IF @ACTION='GET_DATA'
	BEGIN
		SELECT ID, Content, Active FROM dbo.Leadership ORDER BY ID
	END

	IF @ACTION='ADD'
	BEGIN
		IF @ID = -1
		BEGIN
			-- THEM MOI THI ACTIVE = 1	
			INSERT INTO dbo.Leadership (Content, Active, UserCreate, DateCreate, UserEdits, DateEdits) VALUES (@Content, 1, @USER_NAME , GETDATE(), @USER_NAME, GETDATE())
		END
	END

	IF @ACTION='UPDATE'
	BEGIN
		Create Table #Leadership(
		ID INT,
		CONTENT NVARCHAR(MAX),
		ACTIVE BIT)

		DECLARE @SQL_#Leadership NVARCHAR(MAX)
		SET @SQL_#Leadership = 'INSERT INTO #Leadership (ID, CONTENT, ACTIVE) SELECT ID, CONTENT, ACTIVE FROM ' + @sBT
		EXEC(@SQL_#Leadership)
		SET @SQL_#Leadership = 'DROP TABLE ' + @sBT
		EXEC(@SQL_#Leadership)

		UPDATE L
		SET L.Content = #L.Content,
		L.Active = #L.Active,
		L.UserEdits = @USER_NAME,
		L.DateEdits = GETDATE()
		FROM dbo.Leadership L
		INNER JOIN #Leadership #L ON L.ID = #L.ID
	END

	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM dbo.LeadershipDetails WHERE IDLeadership = @ID
		DELETE FROM dbo.Leadership WHERE ID = @ID
	END
END






