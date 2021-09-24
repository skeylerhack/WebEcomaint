CREATE  PROC VS_ST_LOCATIONS
(
	@ACTION nvarchar(250)='',
    @ID int = NULL,
	@LocationName nvarchar(250)=NULL,
	@Description nvarchar(250)=NULL,
	@TB [ST_LOCATIONS] READONLY
)
AS
BEGIN
	IF @ACTION='LIST'
	BEGIN
		SELECT 
		   [ID]
		  ,[LocationName]
		  ,[Description]
		FROM [dbo].[ST_LOCATIONS]
		ORDER BY [ID]
	END
	IF @ACTION='SAVE'
	BEGIN
		UPDATE T1 SET T1.[LocationName]=T2.[LocationName],T1.[Description]=T2.[Description]
		FROM [dbo].[ST_LOCATIONS] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		INSERT INTO [dbo].[ST_LOCATIONS]([LocationName],[Description])
		SELECT [LocationName],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT [ID] FROM [dbo].[ST_LOCATIONS])
		
		
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM [dbo].[ST_LOCATIONS] WHERE ID IN(SELECT ID FROM @TB)
	END
END