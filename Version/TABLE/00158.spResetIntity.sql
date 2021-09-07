IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spResetIntity')
   exec('CREATE PROCEDURE spResetIntity AS BEGIN SET NOCOUNT ON; END')
GO



ALTER PROC spResetIntity
	@tableName nvarchar(100) = 'DIEU_DO',
	@colName nvarchar(100) = 'ID_DD'
AS


DECLARE @last_value bigint 
DECLARE @lastValUsed bigint
DECLARE @sql nvarchar(max)




SET @last_value = CONVERT(bigint, (SELECT last_value FROM sys.identity_columns WHERE OBJECT_NAME(OBJECT_ID) = @tableName));
IF @last_value IS NULL
    BEGIN
        DBCC CHECKIDENT (@tableName, RESEED, 1);
    END
ELSE
    BEGIN
		DECLARE @MAXID TABLE (ID BIGINT)
		INSERT @MAXID
		EXEC ('SELECT ISNULL(MAX(' + @colName + '),0) FROM ' + @tableName )

		SET @lastValUsed = (SELECT ISNULL(MAX(ID),0) FROM @MAXID);
        DBCC CHECKIDENT (@tableName, RESEED, @lastValUsed);
    END
