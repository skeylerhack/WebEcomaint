USE [CMMS_PILMICO]
GO

ALTER PROC [dbo].[spCreatePX]
	@DocNum NVARCHAR(25),
	@DocNumOld NVARCHAR(25),
	@WorkOrder NVARCHAR(100),
	@WarehouseID BIGINT,
	@MS_KHO_CMMS NVARCHAR(100),
	@MSNhap NVARCHAR(100),
	@MSXuat NVARCHAR(100),
	@NgayXuatNhap DATETIME,
	@MS_VI_TRI_CMMS INT,
	@Type NVARCHAR(10)
AS

BEGIN TRY
    BEGIN TRANSACTION
-- Tao nguoi nhan
	DECLARE @NguoiNhanCMMS NVARCHAR(30)
	SET @NguoiNhanCMMS = 'SYSN'	

	DECLARE @MS_DANG_XUAT INT = 1
	IF @TYPE = '2' SET @MS_DANG_XUAT = 3
--------------------------------------------------------------
---- Tao Phieu xuat
-- INSERT vao IC_DON_HANG_XUAT
	INSERT INTO IC_DON_HANG_XUAT (
			MS_DH_XUAT_PT, SO_PHIEU_XN, GIO, NGAY,
			MS_KHO, MS_DANG_XUAT, NGAY_CHUNG_TU, MS_PHIEU_BAO_TRI, GHI_CHU, 
			LOCK, SO_CHUNG_TU,NGUOI_NHAN,MS_DHX_SYNC,NGUOI_LAP,THU_KHO)
	SELECT @MSXuat AS MS_DH_XUAT_PT , @DocNum AS SO_PHIEU_XN , @NgayXuatNhap AS GIO ,  @NgayXuatNhap AS NGAY ,
			@MS_KHO_CMMS AS MS_KHO , @MS_DANG_XUAT AS MS_DANG_XUAT, @NgayXuatNhap AS NGAY_CHUNG_TU , 
			CASE @TYPE WHEN '1' THEN @WorkOrder ELSE NULL END AS MS_PHIEU_BAO_TRI , 
			CASE @TYPE WHEN '1' THEN N'Phiếu xuất tự động' ELSE N'Phiếu xuất tự động từ nhập trả' END AS GHI_CHU ,
			CONVERT(BIT,1) AS LOCK , 
			CASE @TYPE WHEN '1' THEN @DocNum ELSE @DocNumOld END AS SO_CHUNG_TU , @NguoiNhanCMMS AS NGUOI_NHAN, @DocNum ,@NguoiNhanCMMS AS NGUOI_LAP,N'Admin' AS THU_KHO

-- INSERT vao IC_DON_HANG_XUAT_VAT_TU
	INSERT INTO IC_DON_HANG_XUAT_VAT_TU (MS_DH_XUAT_PT, MS_PT, SO_LUONG_CTU, SO_LUONG_THUC_XUAT)
	SELECT DISTINCT @MSXuat AS MS_DH_XUAT_PT,ItemID AS MS_PT, Quantity AS SO_LUONG_CTU ,Quantity AS SO_LUONG_THUC_XUAT
	FROM PilmicoIntegration.DBO.InventoryTransaction 
	WHERE (DocNum = @DocNum) AND (WorkOrder = @WorkOrder) AND (WarehouseID = @WarehouseID) AND (ISNULL([Completed],0) = 1) AND ([Type] = @TYPE) AND (DocNumOld = @DocNumOld OR @DocNumOld = '-1')
-- INSERT vao IC_DON_HANG_XUAT_VAT_TU_CHI_TIET
	INSERT INTO IC_DON_HANG_XUAT_VAT_TU_CHI_TIET (MS_DH_XUAT_PT, MS_PT, STT, 
			MS_DH_NHAP_PT, MS_VI_TRI, SL_VT, ID_XUAT)
	SELECT DISTINCT @MSXuat AS MS_DH_XUAT_PT , ItemID AS MS_PT , ROW_NUMBER() OVER (ORDER BY ItemID)  AS STT,
			@MSNhap AS MS_DH_NHAP_PT , @MS_VI_TRI_CMMS AS MS_VI_TRI , Quantity AS SL_VT , ID AS ID_XUAT 
	FROM PilmicoIntegration.DBO.InventoryTransaction 
	WHERE (DocNum = @DocNum) AND (WorkOrder = @WorkOrder) AND (WarehouseID = @WarehouseID) AND (ISNULL([Completed],0) = 1) AND ([Type] = @TYPE) AND (DocNumOld = @DocNumOld OR @DocNumOld = '-1')





COMMIT TRANSACTION
END TRY
BEGIN CATCH
    
    ROLLBACK TRANSACTION
END CATCH
