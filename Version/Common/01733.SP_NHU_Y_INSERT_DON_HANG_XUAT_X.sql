
ALTER proc [dbo].[SP_NHU_Y_INSERT_DON_HANG_XUAT_X]
	@MS_DH_XUAT_PT nvarchar(14),
	@SO_PHIEU_XN nvarchar(20),
	@NGAY datetime,	
	@GIO DATETIME,
	@MS_KHO int,
	@MS_DANG_XUAT int,
	@NGUOI_NHAN nvarchar(20),
	@NGAY_CHUNG_TU datetime,
	@SO_CHUNG_TU nvarchar(20),
	@MS_PHIEU_BAO_TRI nvarchar(20),
	@GHI_CHU nvarchar(255),
	@LOCK bit,
	@LY_DO_XUAT NVARCHAR(255),
	@THU_KHO NVARCHAR(50),
	@MS_BP_CHIU_PHI int,
	@USERNAME NVARCHAR(50),
	@TEN_NGUOI_NHAP NVARCHAR(100),
	@DANG_XUAT NVARCHAR(100),
	@MS_KHO_DEN int,
	@MS_VI_TRI_DEN int
AS

IF @MS_DANG_XUAT <> 2
BEGIN
    SET @MS_KHO_DEN = NULL	
	SET @MS_VI_TRI_DEN = NULL	
END

INSERT INTO [dbo].[IC_DON_HANG_XUAT_X] 
           ([MS_DH_XUAT_PT]
           ,[SO_PHIEU_XN]
           ,[NGAY]
           ,[GIO]
           ,[MS_KHO]
           ,[MS_DANG_XUAT]
           ,[NGUOI_NHAN]
           ,[NGAY_CHUNG_TU]
           ,[SO_CHUNG_TU]
           ,[MS_PHIEU_BAO_TRI]
           ,[GHI_CHU]
           ,[LOCK]
			,[LY_DO_XUAT]
			,[THU_KHO]
			,[MS_BP_CHIU_PHI]
			,[USERNAME]
	)
     VALUES
           (@MS_DH_XUAT_PT,
			@SO_PHIEU_XN ,
			
			@NGAY ,
			@GIO ,
			@MS_KHO ,
			@MS_DANG_XUAT ,
			@NGUOI_NHAN ,
			@NGAY_CHUNG_TU ,
			@SO_CHUNG_TU ,
			@MS_PHIEU_BAO_TRI ,
			@GHI_CHU ,
			@LOCK,
			 @LY_DO_XUAT,
			@THU_KHO,
			@MS_BP_CHIU_PHI,
			@USERNAME)

IF @MS_DANG_XUAT = 2
BEGIN
    UPDATE [IC_DON_HANG_XUAT_X] SET MS_KHO_DEN = @MS_KHO_DEN, MS_VI_TRI_DEN = @MS_VI_TRI_DEN WHERE MS_DH_XUAT_PT = @MS_DH_XUAT_PT
END
