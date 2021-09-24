CREATE PROC VS_ST_RiskRegister
(
	@ACTION NVARCHAR(200)='',
	@TB ST_RiskRegister READONLY
)
AS
BEGIN
	IF @ACTION='LIST_LOCATION'
	BEGIN
		SELECT ID,[LocationName],[Description] FROM [dbo].[ST_Locations] ORDER BY ID
	END
	IF @ACTION='LIST_HAZARDS'
	BEGIN
		SELECT ID,[Hazard],[Description] FROM [dbo].[ST_Hazards] ORDER BY ID
	END
	IF @ACTION='LIST_TASKS'
	BEGIN
		SELECT ID,[Task],[Description] FROM [dbo].[ST_Tasks] ORDER BY ID
	END
	IF @ACTION='LIST_CONTACTOBJECTS'
	BEGIN
		SELECT ID,[ContactObject],[Description] FROM [dbo].[ST_ContactObjects] ORDER BY ID
	END
	IF @ACTION='LIST'
	BEGIN
		SELECT [ID],[LocationID],[HazardID],[TaskID],[ContackObjectID],[Picture],[IncidentOrAcident],[Picture] [PicPath] FROM [dbo].[ST_RiskRegister] ORDER BY ID
	END
	IF @ACTION='SAVE'
	BEGIN
		
		UPDATE T1
		SET T1.[LocationID] = T2.[LocationID]
			,T1.[HazardID] = T2.[HazardID]
			,T1.[TaskID] = T2.[TaskID]
			,T1.[ContackObjectID] = T2.[ContackObjectID]
			,T1.[Picture] = T2.[Picture]
			,T1.[IncidentOrAcident] = T2.[IncidentOrAcident]
		FROM [dbo].[ST_RiskRegister] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		
		INSERT INTO [dbo].[ST_RiskRegister]
           ([LocationID]
           ,[HazardID]
           ,[TaskID]
           ,[ContackObjectID]
           ,[Picture]
           ,[IncidentOrAcident])
		SELECT [LocationID],[HazardID],[TaskID],[ContackObjectID],[Picture],[IncidentOrAcident] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT ID FROM [dbo].[ST_RiskRegister])
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE [dbo].[ST_RiskRegister] WHERE ID IN(SELECT ID FROM @TB)
	END
END