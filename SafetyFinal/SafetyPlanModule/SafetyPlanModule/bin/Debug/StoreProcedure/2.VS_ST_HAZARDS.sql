CREATE  PROC VS_ST_HAZARDS
(
	@ACTION nvarchar(250)='',
    @ID int = NULL,
	@Hazard nvarchar(250)=NULL,
	@Description nvarchar(250)=NULL,
	@TB [ST_Hazards] READONLY
)
AS
BEGIN
	IF @ACTION='LIST'
	BEGIN
		SELECT 
		   [ID]
		  ,[Hazard]
		  ,[Description]
		FROM [dbo].[ST_Hazards]
		ORDER BY [ID]
	END
	IF @ACTION='SAVE'
	BEGIN
		UPDATE T1 SET T1.[Hazard]=T2.[Hazard],T1.[Description]=T2.[Description]
		FROM [dbo].[ST_Hazards] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		INSERT INTO [dbo].[ST_Hazards]([Hazard],[Description])
		SELECT [Hazard],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT [ID] FROM [dbo].[ST_Hazards])
		
		
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM [dbo].[ST_Hazards] WHERE ID IN(SELECT ID FROM @TB)
	END
END