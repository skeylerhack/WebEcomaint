
CREATE PROC [dbo].[VS_ST_INSPECTION1]
(
	@ACTION nvarchar(250)='',
	@TB ST_INSPECTION1 READONLY,
	@InspectionID INT=NULL,
	@FolderShare nvarchar(MAX)=NULL
)
AS
BEGIN
	IF @ACTION='LIST'
	BEGIN
		SELECT ID,InspectionID,PicName,PicPath,Before FROM [dbo].[ST_Inspection1] WHERE [InspectionID]=@InspectionID ORDER BY ID
	END
	IF @ACTION='SAVE'
	BEGIN

		UPDATE T1 SET T1.Before=T2.Before
		FROM [dbo].[ST_Inspection1] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		INSERT INTO [dbo].[ST_Inspection1]
           ([InspectionID]
           ,[PicName]
           ,[PicPath]
           ,[Before])
		SELECT ISNULL([InspectionID],-1),[PicName],@FolderShare,[Before] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT ID FROM [dbo].[ST_Inspection1])
	END
	IF @ACTION='DELETE_NULL'
	BEGIN
		DELETE [dbo].[ST_Inspection1] WHERE ISNULL([InspectionID],-1) = @InspectionID
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE [dbo].[ST_Inspection1] WHERE ID IN (SELECT ID FROM @TB)
	END
END