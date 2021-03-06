CREATE PROC [dbo].[VS_ST_BSSMSAUDIT]
(
	@ACTION nvarchar(250)='',
	@TB ST_BSSMSAudit READONLY
)
AS
BEGIN
	IF @ACTION='LIST_INCHARGE'
	BEGIN
		SELECT [ID],[Staffname],[Description] FROM	[dbo].[ST_Safety] ORDER BY ID
	END
	IF @ACTION='LIST'
	BEGIN
		SELECT 
		   [ID],[AuditContent],[InCharge],[DeadLine],[Status],[Description]
		FROM [dbo].[ST_BSSMSAUDIT]
		ORDER BY [ID]
	END
	IF @ACTION='SAVE'
	BEGIN
		UPDATE T1 
		SET 
		T1.[AuditContent]=T2.[AuditContent],
		T1.[Description]=T2.[Description],
		T1.[InCharge]=T2.[InCharge],
		T1.[Status]=T2.[Status]
		FROM [dbo].[ST_BSSMSAUDIT] T1 INNER JOIN @TB T2 ON T1.ID=T2.ID

		INSERT INTO [dbo].[ST_BSSMSAUDIT]([AuditContent],[InCharge],[DeadLine],[Status],[Description])
		SELECT [AuditContent],[InCharge],[DeadLine],[Status],[Description] FROM @TB WHERE ISNULL(ID,-1) NOT IN(SELECT [ID] FROM [dbo].[ST_BSSMSAUDIT])
		
		
	END
	IF @ACTION='DELETE'
	BEGIN
		DELETE FROM [dbo].[ST_BSSMSAUDIT] WHERE ID IN(SELECT ID FROM @TB)
	END
END