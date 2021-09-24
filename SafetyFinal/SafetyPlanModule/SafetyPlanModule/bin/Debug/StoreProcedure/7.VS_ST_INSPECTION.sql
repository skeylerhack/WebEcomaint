CREATE PROC VS_ST_INSPECTION
(
	@ACTION nvarchar(250)='',
	@TB ST_INSPECTION READONLY,
	@FolderShare nvarchar(MAX)=NULL
)
AS
BEGIN
	IF @ACTION='LIST_INCHARGE'
	BEGIN
		SELECT [ID],[Staffname],[Description] FROM	[dbo].[ST_Safety] ORDER BY ID
	END
	IF @ACTION='LIST_LOCATION'
	BEGIN
		SELECT [ID],[LocationName],[Description] FROM	[dbo].[ST_Locations] ORDER BY ID
	END
	IF @ACTION='LIST'
	BEGIN
		SELECT 
		   T1.[ID],
		   T1.[DocNum],
		   T1.[LocationID],
		   T1.[Situation],
		   T1.[Action],
		   T1.[InCharge],
		   T1.[Deadline],
		   T1.[Status],
		   T1.[PicBeforeDefault],
		   T1.[PicAfterDefault],
		   T2.PicPath [PathPicBeforeDefault],
		   T3.PicPath [PathPicAfterDefault],
		   T2.PicName [NamePicBeforeDefault],
		   T3.PicName [NamePicAfterDefault],
		   T1.[ID] InspectionID
		FROM [dbo].[ST_INSPECTION] T1 LEFT JOIN [dbo].[ST_INSPECTION1] T2 ON T1.ID=T2.InspectionID AND T1.PicBeforeDefault=T2.ID
			LEFT JOIN [dbo].[ST_INSPECTION1] T3 ON T1.ID=T3.InspectionID AND T1.PicAfterDefault=T3.ID
		ORDER BY T1.[ID]

		DELETE [dbo].[ST_Inspection1] WHERE InspectionID NOT IN (SELECT ID FROM [dbo].[ST_Inspection])
	END
	IF @ACTION='SAVE'
	BEGIN
		UPDATE T1 
		SET 
			T1.[DocNum]=T2.[DocNum],
			T1.[LocationID]=T2.[LocationID],
			T1.[Situation]=T2.[Situation],
			T1.[Action]=T2.[Action],
			T1.[InCharge]=T2.[InCharge],
			T1.[Deadline]=T2.[Deadline],
			T1.[Status]=T2.[Status],
			T1.[PicBeforeDefault]=T2.[PicBeforeDefault],
			T1.[PicAfterDefault]=T2.[PicAfterDefault]
		FROM [dbo].[ST_INSPECTION] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID
		
		INSERT INTO [dbo].[ST_Inspection]
        (	[DocNum]
           ,[LocationID]
           ,[Situation]
           ,[Action]
           ,[InCharge]
           ,[Deadline]
           ,[Status]
           ,[PicBeforeDefault]
           ,[PicAfterDefault]
		   ,VT
         )
		SELECT [DocNum],[LocationID],[Situation],[Action] ,[InCharge],[Deadline],[Status],[PicBeforeDefault],[PicAfterDefault],InspectionID FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT ID FROM [dbo].[ST_Inspection])
		
		UPDATE T2 SET T2.InspectionID=T1.ID
		FROM [dbo].[ST_Inspection] T1 INNER JOIN [dbo].[ST_Inspection1] T2 ON T1.PicBeforeDefault=T2.ID
		WHERE ISNULL(T2.InspectionID,-1)<0

		UPDATE T2 SET T2.InspectionID=T1.ID
		FROM [dbo].[ST_Inspection] T1 INNER JOIN [dbo].[ST_Inspection1] T2 ON T1.PicAfterDefault=T2.ID
		WHERE ISNULL(T2.InspectionID,-1)<0

		UPDATE T2 SET T2.InspectionID=T1.ID
		FROM [dbo].[ST_Inspection] T1 INNER JOIN [dbo].[ST_Inspection1] T2 ON T1.VT=T2.InspectionID
		WHERE ISNULL(T2.InspectionID,-1)<0

		UPDATE T2 SET T2.InspectionID=T1.ID
		FROM [dbo].[ST_Inspection] T1 INNER JOIN [dbo].[ST_Inspection1] T2 ON T1.VT=T2.InspectionID
		WHERE ISNULL(T2.InspectionID,-1)<0
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM [dbo].[ST_INSPECTION] WHERE ID IN(SELECT ID FROM @TB)
		DELETE FROM [dbo].[ST_INSPECTION1] WHERE [InspectionID] IN(SELECT ID FROM @TB)
	END
END