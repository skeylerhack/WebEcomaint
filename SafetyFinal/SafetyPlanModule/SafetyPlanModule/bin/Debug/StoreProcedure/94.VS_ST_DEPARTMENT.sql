CREATE PROC VS_ST_DEPARTMENT
(
	@ACTION NVARCHAR(200),
	@TB ST_DEPARTMENT READONLY
)
AS
BEGIN
	IF @ACTION='LIST'
	BEGIN
		SELECT * FROM [dbo].[ST_Department] ORDER BY ID
	END
	IF @ACTION='SAVE'
	BEGIN
		UPDATE T1 SET T1.[Department]=T2.[Department],T1.[Description]=T2.[Description]
		FROM [dbo].[ST_Department] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		INSERT INTO [dbo].[ST_Department]([Department],[Description])
		SELECT [Department],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT [ID] FROM [dbo].[ST_Department])
		
		
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM [dbo].[ST_Department] WHERE ID IN(SELECT ID FROM @TB)
	END
END