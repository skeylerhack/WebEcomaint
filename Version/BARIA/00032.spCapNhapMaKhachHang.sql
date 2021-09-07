
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCapNhapMaKhachHang')
   exec('CREATE PROCEDURE [dbo].[spCapNhapMaKhachHang] AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC spCapNhapMaKhachHang  '01', '01TEST'
ALTER PROC spCapNhapMaKhachHang
	@MaCu nvarchar (100), 
	@MaMoi nvarchar (100) 
AS

Declare @TABLE nvarchar (100),@COT nvarchar (100), @sql nvarchar (1000)
--Declare @MaCu nvarchar (100), @MaMoi nvarchar (100) 

--set @MaCu = 'BUE-BO-002TEST'
--set @MaMoi = 'BUE-BO-002'

UPDATE KHACH_HANG SET   MS_KH = @MaMoi WHERE MS_KH = @MaCu

--Tao bang tam chua du lieu
	SELECT DISTINCT sysobjects.NAME AS NAME_TB, syscolumns.NAME AS NAME_COT, CONVERT(BIT,0) CAP_NHAP INTO #BTMS_KH FROM sysobjects INNER JOIN syscolumns ON sysobjects.ID = syscolumns.ID 
	WHERE syscolumns.NAME LIKE 'MS_KH%'  and OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1  AND syscolumns.[type] = 39
	and ((sysobjects.NAME   ) NOT IN ('KHACH_HANG' ,'IC_KHO' ) )  AND syscolumns.NAME <> 'MS_KHO'
--Chay vong lap

Declare @iTT int
set @iTT = 1
Declare  MS_KHinh CURSOR FOR
	SELECT NAME_TB,NAME_COT FROM #BTMS_KH ORDER BY NAME_TB
Open MS_KHinh
FETCH NEXT FROM MS_KHinh
INTO @TABLE,@COT
While @@Fetch_Status = 0
Begin

BEGIN TRY
	set @sql = CONVERT(nvarchar(10),@iTT) +  '. UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @MaMoi + ''' WHERE [' + @COT + '] =	''' +  @MaCu + ''''
	PRINT (@sql)
	set @sql = 'UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ''' +  @MaMoi + ''' WHERE [' + @COT + '] =	''' +  @MaCu + ''''
	EXEC (@sql)
	UPDATE #BTMS_KH SET CAP_NHAP = 1 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END TRY
BEGIN CATCH
	PRINT (@sql)     
	UPDATE #BTMS_KH SET CAP_NHAP = 0 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END CATCH

	
    FETCH NEXT FROM MS_KHinh
    INTO  @TABLE,@COT
	set @iTT = @iTT +1
End

Close MS_KHinh
Deallocate MS_KHinh

UPDATE IC_DON_HANG_NHAP SET NGUOI_NHAP = @MaMoi WHERE NGUOI_NHAP = @MaCu
UPDATE IC_DON_HANG_XUAT SET NGUOI_NHAN = @MaMoi WHERE NGUOI_NHAN = @MaCu
