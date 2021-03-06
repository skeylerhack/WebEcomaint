ALTER PROC  [dbo].[VS_LEADERSHIP]
(
	@USER_NAME NVARCHAR(30) = NULL,
	@ACTION NVARCHAR(250) = NULL,
	@sBT NVARCHAR(Max)= NULL,
	@ID INT = NULL,
	@Content NVARCHAR(MAX)= NULL,
	@Active BIT = NULL,
	@NNgu INT = NULL,
	@ID_TYPE BIGINT =NULL
)
AS
BEGIN
	IF @ACTION='GET_DATA'
	BEGIN
		SELECT ID,ID_TYPE,Content,Active FROM dbo.Leadership WHERE ID_TYPE =@ID_TYPE
		ORDER BY Content
	END

	IF @ACTION='GET_TYPE'
	BEGIN
		SELECT ID_TYPE,MA_SO, CASE @NNgu WHEN 0 THEN NAME_VN ELSE ISNULL(NAME_EL,NAME_VN) END AS NAME_TYPE FROM dbo.LeadershipType WHERE ACTIVE = 1 
	END

	IF @ACTION='ADD'
	BEGIN
		IF @ID = -1
		BEGIN
			-- THEM MOI THI ACTIVE = 1	
			INSERT INTO dbo.Leadership (Content, Active, UserCreate, DateCreate, UserEdits, DateEdits,ID_TYPE) VALUES (@Content, 1, @USER_NAME , GETDATE(), @USER_NAME, GETDATE(),@ID_TYPE)
			SELECT SCOPE_IDENTITY()
		END
	END

	IF @ACTION='UPDATE'
	BEGIN
		UPDATE dbo.Leadership 
		SET	ID_TYPE =@ID_TYPE,
			Content =@Content,
			UserEdits =@USER_NAME,
			DateEdits = GETDATE(),
			Active =@Active
			WHERE ID = @ID
			SELECT @ID
	END

	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM dbo.Leadership WHERE ID = @ID
	END
END






