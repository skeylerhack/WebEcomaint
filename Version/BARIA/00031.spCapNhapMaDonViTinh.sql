
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCapNhapMaDonViTinh')
   exec('CREATE PROCEDURE [dbo].[spCapNhapMaDonViTinh] AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC spCapNhapMaDonViTinh  '10-01-OCO-001', '10-01-OCO-001TEST'
ALTER PROC spCapNhapMaDonViTinh
	@DVTCu nvarchar (100), 
	@DVT nvarchar (100) 
AS

Declare @TABLE nvarchar (100),@COT nvarchar (100), @sql nvarchar (1000)
--Declare @DVTCu nvarchar (100), @DVT nvarchar (100) 

--set @DVTCu = 'BUE-BO-002TEST'
--set @DVT = 'BUE-BO-002'

UPDATE DON_VI_TINH SET  DVT = @DVT WHERE DVT = @DVTCu

--Tao bang tam chua du lieu
	SELECT DISTINCT sysobjects.NAME AS NAME_TB, syscolumns.NAME AS NAME_COT, CONVERT(BIT,0) CAP_NHAP INTO  #BTDVT  FROM sysobjects INNER JOIN syscolumns ON sysobjects.ID = syscolumns.ID 
	WHERE syscolumns.NAME LIKE 'DVT%'  and OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1  AND  syscolumns.type = 39
	and ((sysobjects.NAME   ) NOT IN ('DON_VI_TINH' ) ) 
--Chay vong lap

Declare @iTT int
set @iTT = 1
Declare  DVTinh CURSOR FOR
	SELECT NAME_TB,NAME_COT FROM #BTDVT ORDER BY NAME_TB
Open DVTinh
FETCH NEXT FROM DVTinh
INTO @TABLE,@COT
While @@Fetch_Status = 0
Begin

BEGIN TRY
	set @sql = CONVERT(nvarchar(10),@iTT) +  '. UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @DVT + ''' WHERE [' + @COT + '] =	''' +  @DVTCu + ''''
	PRINT (@sql)
	set @sql = 'UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @DVT + ''' WHERE [' + @COT + '] =	''' +  @DVTCu + ''''
	EXEC (@sql)
	UPDATE #BTDVT SET CAP_NHAP = 1 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END TRY
BEGIN CATCH
	PRINT (@sql)     
	UPDATE #BTDVT SET CAP_NHAP = 0 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END CATCH

	
    FETCH NEXT FROM DVTinh
    INTO  @TABLE,@COT
	set @iTT = @iTT +1
End

Close DVTinh
Deallocate DVTinh
