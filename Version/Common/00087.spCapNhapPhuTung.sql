
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCapNhapPhuTung')
   exec('CREATE PROCEDURE [dbo].[spCapNhapPhuTung] AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC spCapNhapPhuTung  '10-01-OCO-001', '10-01-OCO-001TEST'
ALTER PROC spCapNhapPhuTung
	@MaCu nvarchar (100), 
	@MaMoi nvarchar (100) 
AS
Declare @TABLE nvarchar (100),@COT nvarchar (100), @sql nvarchar (1000) 
--set @MaCu = 'BUE-BO-002TEST'
--set @MaMoi = 'BUE-BO-002'

UPDATE IC_PHU_TUNG SET MS_PT = @MaMoi WHERE MS_PT = @MaCu

--Tao bang tam chua du lieu
	SELECT DISTINCT sysobjects.NAME AS NAME_TB, syscolumns.NAME AS NAME_COT, CONVERT(BIT,0) CAP_NHAP INTO  #BTPTUNG FROM sysobjects INNER JOIN syscolumns ON sysobjects.ID = syscolumns.ID 
	WHERE syscolumns.NAME LIKE '%MS_PT%'  and OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1  AND syscolumns.prec >=25
	and ((sysobjects.NAME   ) NOT IN ('IC_PHU_TUNG' , 'VI_TRI_KHO_VAT_TU' ) ) 
--Chay vong lap

Declare @iTT int
set @iTT = 1
Declare  PhuTung CURSOR FOR
	SELECT NAME_TB,NAME_COT FROM #BTPTUNG ORDER BY NAME_TB
Open PhuTung
FETCH NEXT FROM PhuTung
INTO @TABLE,@COT
While @@Fetch_Status = 0
Begin

BEGIN TRY
	set @sql = CONVERT(nvarchar(10),@iTT) +  '. UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @MaMoi + ''' WHERE [' + @COT + '] =	''' +  @MaCu + ''''
	PRINT (@sql)
	set @sql = 'UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @MaMoi + ''' WHERE [' + @COT + '] =	''' +  @MaCu + ''''
	EXEC (@sql)
	UPDATE #BTPTUNG SET CAP_NHAP = 1 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END TRY
BEGIN CATCH
	PRINT (@sql)     
	UPDATE #BTPTUNG SET CAP_NHAP = 0 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END CATCH

	
    FETCH NEXT FROM PhuTung
    INTO  @TABLE,@COT
	set @iTT = @iTT +1
End

Close PhuTung
Deallocate PhuTung



DELETE FROM VI_TRI_KHO_VAT_TU WHERE MS_PT = @MaMoi
UPDATE [VI_TRI_KHO_VAT_TU] SET [MS_PT] = @MaMoi WHERE [MS_PT] = @MaCu


--SELECT * FROM #BTPTUNG