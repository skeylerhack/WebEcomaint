CREATE  PROC VS_ST_CONTACTOBJECTS
(
	@ACTION nvarchar(250)='',
    @ID int = NULL,
	@ContactObject nvarchar(250)=NULL,
	@Description nvarchar(250)=NULL,
	@TB [ST_CONTACTOBJECTS] READONLY
)
AS
BEGIN
	IF @ACTION='LIST'
	BEGIN
		SELECT 
		   [ID]
		  ,[ContactObject]
		  ,[Description]
		FROM [dbo].[ST_CONTACTOBJECTS]
		ORDER BY [ID]
	END
	IF @ACTION='SAVE'
	BEGIN
		UPDATE T1 SET T1.[ContactObject]=T2.[ContactObject],T1.[Description]=T2.[Description]
		FROM [dbo].[ST_CONTACTOBJECTS] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		INSERT INTO [dbo].[ST_CONTACTOBJECTS]([ContactObject],[Description])
		SELECT [ContactObject],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT [ID] FROM [dbo].[ST_CONTACTOBJECTS])
		
		
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM [dbo].[ST_CONTACTOBJECTS] WHERE ID IN(SELECT ID FROM @TB)
	END
END