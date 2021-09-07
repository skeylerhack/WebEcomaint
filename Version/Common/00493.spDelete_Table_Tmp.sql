
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spDelete_Table_Tmp')
   exec('CREATE PROCEDURE spDelete_Table_Tmp AS BEGIN SET NOCOUNT ON; END')
 Go
ALTER PROC [dbo].[spDelete_Table_Tmp]
	 @tableNameTmp as nvarchar(50),
	 @userName as nvarchar(50)
AS

BEGIN
		DECLARE @exec as nvarchar(max)
		DECLARE @name VARCHAR(50) 

		DECLARE db_cursor CURSOR FOR  
		SELECT TABLE_NAME from information_schema.tables where TABLE_TYPE = 'BASE TABLE'
		and lower(LEFT(TABLE_NAME,LEN(@tableNameTmp))) = lower(@tableNameTmp) AND Lower(RIGHT(TABLE_NAME, LEN(@userName))) = Lower(@userName)
		ORDER BY TABLE_NAME
		OPEN db_cursor   
		FETCH NEXT FROM db_cursor INTO @name   

		WHILE @@FETCH_STATUS = 0   
		BEGIN   
			   set @exec  = 'drop table [' + @name + ']'
			   exec (@exec) 
			   set @exec = ''
			   FETCH NEXT FROM db_cursor INTO @name   
		END   

		CLOSE db_cursor   
		DEALLOCATE db_cursor
END






