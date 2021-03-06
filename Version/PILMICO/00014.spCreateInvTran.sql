USE [PilmicoIntegration]
GO


ALTER PROC [dbo].[spCreateInvTran]
	@Type NVARCHAR(10) = 1 --  1 nhap + xuat    - 2 nhap tra
AS
BEGIN TRY
    BEGIN TRAN Tr1

DECLARE @DocNum NVARCHAR(25) 
DECLARE @DocNumOld NVARCHAR(25) 
DECLARE @WorkOrder NVARCHAR(100)
DECLARE @WarehouseID BIGINT
DECLARE @MS_KHO_CMMS NVARCHAR(100)
DECLARE @Currency NVARCHAR(100)



CREATE TABLE #tmpPN
(
   MS_Nhap nvarchar(50)
)

CREATE TABLE #tmpPX
(
   MS_Xuat nvarchar(50)
)
DECLARE @MSNhap NVARCHAR(100)
DECLARE @MSXuat NVARCHAR(100)
DECLARE @NgayXuatNhap DATETIME
-- Tao nguoi nhan
DECLARE @NguoiNhanCMMS NVARCHAR(30)
	
--IF NOT EXISTS (SELECT * FROM CMMS_PILMICO.dbo.KHACH_HANG_CONG_NHAN_XUAT WHERE NGUOI_NHAP = 'SYSN' )
--BEGIN
--	IF NOT EXISTS (SELECT * FROM CMMS_PILMICO.dbo.CONG_NHAN WHERE MS_CONG_NHAN = 'SYSN')
--		INSERT INTO CMMS_PILMICO.dbo.CONG_NHAN (MS_CONG_NHAN , HO , TEN,MS_TO) VALUES ('SYSN', 'Synchronize','', (SELECT TOP 1 MS_TO1 FROM CMMS_PILMICO.dbo.[TO] ORDER BY MS_TO ))
--END

SET @NguoiNhanCMMS = 'SYSN'	

DECLARE KHOLIST CURSOR FOR 
	SELECT DISTINCT DocNum,WorkOrder,WarehouseID,MS_KHO,ISNULL(Currency,'VND') AS Currency,
		CASE WHEN @Type = 1 THEN CONVERT(NVARCHAR(25),'-1') ELSE DocNumOld END AS DocNumOld
	FROM PilmicoIntegration.DBO.InventoryTransaction T1 INNER JOIN CMMS_PILMICO.dbo.IC_KHO T2 ON CONVERT(NVARCHAR,T1.WarehouseID) = T2.MS_KHO_INT 
	WHERE ISNULL([Completed],0) = 1 AND [Type] = @Type AND ISNULL(CompletedCMMS,0) = 0
OPEN KHOLIST

FETCH NEXT FROM KHOLIST 
INTO @DocNum,@WorkOrder,@WarehouseID,@MS_KHO_CMMS,@Currency,@DocNumOld
WHILE @@FETCH_STATUS = 0
BEGIN

-- Tao So Phieu Nhap
	SELECT @NgayXuatNhap = MAX(TransactionTime)   FROM PilmicoIntegration.DBO.InventoryTransaction WHERE DocNum = @DocNum AND WorkOrder = @WorkOrder AND WarehouseID = @WarehouseID AND ISNULL([Completed],0) = 1 AND [Type] = @Type

	INSERT INTO #tmpPN
	EXEC CMMS_PILMICO.dbo.sp_get_id 'PN',@NgayXuatNhap 
	select @MSNhap = MS_Nhap  from #tmpPN
-- TIM VI TRI KHO
	DECLARE @MS_VI_TRI_CMMS INT 
	IF NOT EXISTS (SELECT MS_VI_TRI FROM CMMS_PILMICO.dbo.VI_TRI_KHO WHERE MS_KHO  = @MS_KHO_CMMS AND TEN_VI_TRI = N'Vị trí mặc định khi sync')
	BEGIN
		INSERT INTO CMMS_PILMICO.dbo.VI_TRI_KHO(MS_KHO, TEN_VI_TRI,GHI_CHU)
		VALUES (@MS_KHO_CMMS , N'Vị trí mặc định khi sync' , N'Vị trí mặc định khi sync' )
	END		

	SELECT TOP 1 @MS_VI_TRI_CMMS = MS_VI_TRI FROM CMMS_PILMICO.dbo.VI_TRI_KHO  WHERE MS_KHO  = @MS_KHO_CMMS AND TEN_VI_TRI = N'Vị trí mặc định khi sync' 
 --Tao Phieu Nhap  -- NHAP MOI TYPE = 1 -- NHAP TRA TYPE = 2
	EXEC CMMS_PILMICO.dbo.spCreatePN	@DocNum ,@DocNumOld,@WorkOrder,@WarehouseID,@MS_KHO_CMMS,@MSNhap,@NgayXuatNhap,@MS_VI_TRI_CMMS,@Currency, @Type 

-- Tao So Phieu Xuat
	INSERT INTO #tmpPX
	EXEC CMMS_PILMICO.dbo.sp_get_id 'PX',@NgayXuatNhap 
	select @MSXuat = MS_Xuat  from #tmpPX

-- Tao Phieu Xuat
	EXEC CMMS_PILMICO.dbo.spCreatePX	@DocNum ,@DocNumOld,	@WorkOrder ,	@WarehouseID ,	@MS_KHO_CMMS ,	@MSNhap ,@MSXuat,	@NgayXuatNhap , @MS_VI_TRI_CMMS,@Type

	UPDATE CMMS_PILMICO.dbo.VI_TRI_KHO_VAT_TU SET SL_VT = 0 WHERE MS_DH_NHAP_PT = @MSNhap

	UPDATE PilmicoIntegration.DBO.InventoryTransaction SET CompletedCMMS = 1,CompletionTimeCMMS = GETDATE() 
		FROM PilmicoIntegration.DBO.InventoryTransaction 
		WHERE (DocNum = @DocNum) AND (WorkOrder = @WorkOrder) AND (WarehouseID = @WarehouseID) AND (ISNULL([Completed],0) = 1) AND ([Type] = @TYPE) AND (DocNumOld = @DocNumOld OR @DocNumOld = '-1')

	DELETE #tmpPX
	DELETE #tmpPN

    FETCH NEXT FROM KHOLIST
    INTO  @DocNum,@WorkOrder,@WarehouseID,@MS_KHO_CMMS,@Currency,@DocNumOld

End


Close KHOLIST
Deallocate KHOLIST



COMMIT TRAN Tr1
END TRY
BEGIN CATCH
    
    ROLLBACK TRAN Tr1
END CATCH
