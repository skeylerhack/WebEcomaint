CREATE  PROC VS_ST_SAFETY
(
	@ACTION nvarchar(250)='',
	@TB [ST_Safety] READONLY
)
AS
BEGIN
	IF @ACTION='LIST'
	BEGIN
		SELECT 
		   *
		FROM [dbo].[ST_Safety]
		ORDER BY [ID]
	END
	IF @ACTION='LIST_DEPARTMENT'
	BEGIN
		SELECT 
		   ID,Department,[Description]
		FROM [dbo].[ST_DEPARTMENT]
		ORDER BY [ID]
	END
	IF @ACTION='LIST_USER'
	BEGIN
		SELECT 
		   USERNAME [Username],[DESCRIPTION] [Description]
		FROM [dbo].[W_USERS]
		ORDER BY [KHOA]
	END
	IF @ACTION='SAVE'
	BEGIN
		UPDATE T1 
		SET 
			T1.[Staffname]=T2.[Staffname],
			T1.[Department]=T2.[Department],
			T1.[Position]=T2.[Position],
			T1.[Userlogin]=T2.[Userlogin],
			T1.[Description]=T2.[Description]
		FROM [dbo].[ST_Safety] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		INSERT INTO [dbo].[ST_Safety]([Staffname],[Department],[Position],[Userlogin],[Description])
		SELECT [Staffname],[Department],[Position],[Userlogin],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT [ID] FROM [dbo].[ST_Safety])
		
		
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM [dbo].[ST_Safety] WHERE ID IN(SELECT ID FROM @TB)
	END
END