CREATE  PROC VS_ST_TASKS
(
	@ACTION nvarchar(250)='',
    @ID int = NULL,
	@Task nvarchar(250)=NULL,
	@Description nvarchar(250)=NULL,
	@TB [ST_TASKS] READONLY
)
AS
BEGIN
	IF @ACTION='LIST'
	BEGIN
		SELECT 
		   [ID]
		  ,[Task]
		  ,[Description]
		FROM [dbo].[ST_TASKS]
		ORDER BY [ID]
	END
	IF @ACTION='SAVE'
	BEGIN
		UPDATE T1 SET T1.[Task]=T2.[Task],T1.[Description]=T2.[Description]
		FROM [dbo].[ST_TASKS] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		INSERT INTO [dbo].[ST_TASKS]([Task],[Description])
		SELECT [Task],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT [ID] FROM [dbo].[ST_TASKS])
		
		
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM [dbo].[ST_TASKS] WHERE ID IN(SELECT ID FROM @TB)
	END
END