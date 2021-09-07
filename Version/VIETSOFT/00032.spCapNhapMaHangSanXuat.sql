
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'spCapNhapMaHangSanXuat')
   exec('CREATE PROCEDURE [dbo].[spCapNhapMaHangSanXuat] AS BEGIN SET NOCOUNT ON; END')
GO

-- EXEC spCapNhapMaHangSanXuat  '251', '112'
ALTER PROC spCapNhapMaHangSanXuat
	@MaCu int, 
	@MaMoi int 
AS

Declare @TABLE nvarchar (100),@COT nvarchar (100), @sql nvarchar (1000)
--Declare @MaCu nvarchar (100), @MaMoi nvarchar (100) 

--set @MaCu = 'BUE-BO-002TEST'
--set @MaMoi = 'BUE-BO-002'

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MAY_HANG_SAN_XUAT]') AND parent_object_id = OBJECT_ID(N'[dbo].[MAY]'))
	ALTER TABLE [dbo].[MAY] DROP CONSTRAINT [FK_MAY_HANG_SAN_XUAT]

IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_IC_PHU_TUNG_HANG_SAN_XUAT]') AND parent_object_id = OBJECT_ID(N'[dbo].[IC_PHU_TUNG]'))
	ALTER TABLE [dbo].[IC_PHU_TUNG] DROP CONSTRAINT [FK_IC_PHU_TUNG_HANG_SAN_XUAT]



Set IDENTITY_INSERT HANG_SAN_XUAT ON
	INSERT INTO HANG_SAN_XUAT (MS_HSX,TEN_HSX,DIA_CHI,WEBSITE)
	SELECT @MaMoi,TEN_HSX,DIA_CHI,WEBSITE FROM HANG_SAN_XUAT WHERE MS_HSX = @MaCu
	
	DELETE HANG_SAN_XUAT WHERE MS_HSX = @MaCu
Set IDENTITY_INSERT HANG_SAN_XUAT OFF
	
	
--Tao bang tam chua du lieu
	SELECT DISTINCT syscolumns.type ,sysobjects.NAME AS NAME_TB, syscolumns.NAME AS NAME_COT, CONVERT(BIT,0) CAP_NHAP  INTO  #BTMS_HSX 
	FROM sysobjects INNER JOIN syscolumns ON sysobjects.ID = syscolumns.ID 
	WHERE syscolumns.NAME LIKE 'MS_HSX%'  and OBJECTPROPERTY(sysobjects.id, N'IsUserTable') = 1 
	and ((sysobjects.NAME   ) NOT IN ('HANG_SAN_XUAT' ) )  
--Chay vong lap

Declare @iTT int
set @iTT = 1
Declare  MS_HSXinh CURSOR FOR
	SELECT NAME_TB,NAME_COT FROM #BTMS_HSX ORDER BY NAME_TB
Open MS_HSXinh
FETCH NEXT FROM MS_HSXinh
INTO @TABLE,@COT
While @@Fetch_Status = 0
Begin

BEGIN TRY
	set @sql = CONVERT(nvarchar(10),@iTT) +  '. UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ' +  CONVERT(NVARCHAR,@MaMoi) + ' WHERE [' + @COT + '] =	' +  CONVERT(NVARCHAR,@MaCu) 
	PRINT (@sql)
	set @sql = 'UPDATE [' +  @TABLE  + '] SET [' + @COT + '] = ' +  CONVERT(NVARCHAR,@MaMoi) + ' WHERE [' + @COT + '] =	' +  CONVERT(NVARCHAR,@MaCu)
	EXEC (@sql)
	UPDATE #BTMS_HSX SET CAP_NHAP = 1 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END TRY
BEGIN CATCH
	PRINT (@sql)     
	UPDATE #BTMS_HSX SET CAP_NHAP = 0 WHERE NAME_TB = @TABLE AND NAME_COT = @COT
END CATCH

	
    FETCH NEXT FROM MS_HSXinh
    INTO  @TABLE,@COT
	set @iTT = @iTT +1
End

Close MS_HSXinh
Deallocate MS_HSXinh







ALTER TABLE [dbo].[MAY]  WITH NOCHECK ADD  CONSTRAINT [FK_MAY_HANG_SAN_XUAT] FOREIGN KEY([MS_HSX])
REFERENCES [dbo].[HANG_SAN_XUAT] ([MS_HSX])
ON UPDATE CASCADE



ALTER TABLE [dbo].[IC_PHU_TUNG]  WITH NOCHECK ADD  CONSTRAINT [FK_IC_PHU_TUNG_HANG_SAN_XUAT] FOREIGN KEY([MS_HSX])
REFERENCES [dbo].[HANG_SAN_XUAT] ([MS_HSX])
ON UPDATE CASCADE



