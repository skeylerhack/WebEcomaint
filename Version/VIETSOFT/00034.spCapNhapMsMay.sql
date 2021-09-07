
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCapNhapMsMay')
   exec('CREATE PROCEDURE [dbo].[spCapNhapMsMay] AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC spCapNhapMsMay  '10-01-OCO', '10-01-OCOTEST'
ALTER PROC spCapNhapMsMay
	@MaCu nvarchar (100), 
	@MaMoi nvarchar (100) 
AS
Declare @TABLE nvarchar (100),@COT nvarchar (100), @sql nvarchar (1000) 
--set @MaCu = 'BUE-BO-002TEST'
--set @MaMoi = 'BUE-BO-002'

UPDATE MAY SET MS_MAY = @MaMoi WHERE MS_MAY = @MaCu

--Tao bang tam chua du lieu
	SELECT DISTINCT T1.NAME AS NAME_TB, T2.NAME AS NAME_COT, CONVERT(BIT,0) CAP_NHAP INTO  #BTam 
	FROM sysobjects T1 INNER JOIN syscolumns T2 ON T1.ID = T2.ID 
	WHERE T2.NAME LIKE '%MS_MAY%'  and OBJECTPROPERTY(T1.id, N'IsUserTable') = 1  
	and (T1.NAME NOT IN ('MAY')) 
--Chay vong lap

Declare @iTT int
set @iTT = 1
Declare  CursorFor CURSOR FOR
	SELECT NAME_TB,NAME_COT FROM #BTam ORDER BY NAME_TB
Open CursorFor
FETCH NEXT FROM CursorFor
INTO @TABLE,@COT
While @@Fetch_Status = 0
Begin

BEGIN TRY
	set @sql = CONVERT(nvarchar(10),@iTT) +  '. UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @MaMoi + ''' WHERE [' + @COT + '] =	''' +  @MaCu + ''''
	PRINT (@sql)
	set @sql = 'UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @MaMoi + ''' WHERE [' + @COT + '] =	''' +  @MaCu + ''''
	EXEC (@sql)
	UPDATE #BTam SET CAP_NHAP = 1 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END TRY
BEGIN CATCH
	PRINT (@sql)     
	UPDATE #BTam SET CAP_NHAP = 0 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END CATCH

	
    FETCH NEXT FROM CursorFor
    INTO  @TABLE,@COT
	set @iTT = @iTT +1
End

Close CursorFor
Deallocate CursorFor




--SELECT * FROM #BTam