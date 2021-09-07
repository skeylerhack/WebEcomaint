
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCapNhapMaCongNhan')
   exec('CREATE PROCEDURE [dbo].[spCapNhapMaCongNhan] AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC spCapNhapMaCongNhan  '10006666', '100066'
ALTER PROC spCapNhapMaCongNhan
	@MaCu nvarchar (100), 
	@MaMoi nvarchar (100) 
AS

Declare @TABLE nvarchar (100),@COT nvarchar (100), @sql nvarchar (1000)

UPDATE CONG_NHAN SET MS_CONG_NHAN = @MaMoi WHERE MS_CONG_NHAN = @MaCu

--Tao bang tam chua du lieu
	SELECT DISTINCT sysobjects.NAME AS NAME_TB, syscolumns.NAME AS NAME_COT, CONVERT(BIT,0) CAP_NHAP INTO #BTMS_CONG_NHAN FROM sysobjects INNER JOIN syscolumns ON sysobjects.ID = syscolumns.ID 
	WHERE syscolumns.NAME LIKE 'MS_CONG_NHAN%'  and OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1  AND syscolumns.[type] = 39
	and ((sysobjects.NAME) NOT IN ('CONG_NHAN' ))  
--Chay vong lap

Declare @iTT int
set @iTT = 1
Declare  CurFor CURSOR FOR
	SELECT NAME_TB,NAME_COT FROM #BTMS_CONG_NHAN ORDER BY NAME_TB
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
	UPDATE #BTMS_CONG_NHAN SET CAP_NHAP = 1 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END TRY
BEGIN CATCH
	PRINT (@sql)     
	UPDATE #BTMS_CONG_NHAN SET CAP_NHAP = 0 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END CATCH

	
    FETCH NEXT FROM CurFor
    INTO  @TABLE,@COT
	set @iTT = @iTT +1
End

Close CurFor
Deallocate CurFor


UPDATE IC_DON_HANG_NHAP SET NGUOI_NHAP = @MaMoi WHERE NGUOI_NHAP = @MaCu
UPDATE IC_DON_HANG_XUAT SET NGUOI_NHAN = @MaMoi WHERE NGUOI_NHAN = @MaCu

