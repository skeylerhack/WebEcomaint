
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCapNhapMaLoaiMay')
   exec('CREATE PROCEDURE [dbo].[spCapNhapMaLoaiMay] AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC spCapNhapMaLoaiMay  '01', '01TEST'
ALTER PROC spCapNhapMaLoaiMay
	@MaCu nvarchar (100), 
	@MaMoi nvarchar (100) 
AS

Declare @TABLE nvarchar (100),@COT nvarchar (100), @sql nvarchar (1000)

UPDATE LOAI_MAY SET MS_LOAI_MAY = @MaMoi WHERE MS_LOAI_MAY = @MaCu

--Tao bang tam chua du lieu
	SELECT DISTINCT sysobjects.NAME AS NAME_TB, syscolumns.NAME AS NAME_COT, CONVERT(BIT,0) CAP_NHAP INTO #BTMS_LOAI_MAY FROM sysobjects INNER JOIN syscolumns ON sysobjects.ID = syscolumns.ID 
	WHERE syscolumns.NAME LIKE 'MS_LOAI_MAY%'  and OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1  AND syscolumns.[type] = 39
	and ((sysobjects.NAME) NOT IN ('LOAI_MAY' ) )  
--Chay vong lap

Declare @iTT int
set @iTT = 1
Declare  CurFor CURSOR FOR
	SELECT NAME_TB,NAME_COT FROM #BTMS_LOAI_MAY ORDER BY NAME_TB
Open CurFor
FETCH NEXT FROM CurFor
INTO @TABLE,@COT
While @@Fetch_Status = 0
Begin

BEGIN TRY
	set @sql = CONVERT(nvarchar(10),@iTT) +  '. UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @MaMoi + ''' WHERE [' + @COT + '] =	''' +  @MaCu + ''''
	PRINT (@sql)
	set @sql = 'UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @MaMoi + ''' WHERE [' + @COT + '] =	''' +  @MaCu + ''''
	EXEC (@sql)
	UPDATE #BTMS_LOAI_MAY SET CAP_NHAP = 1 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END TRY
BEGIN CATCH
	PRINT (@sql)     
	UPDATE #BTMS_LOAI_MAY SET CAP_NHAP = 0 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END CATCH

	
    FETCH NEXT FROM CurFor
    INTO  @TABLE,@COT
	set @iTT = @iTT +1
End

Close CurFor
Deallocate CurFor

