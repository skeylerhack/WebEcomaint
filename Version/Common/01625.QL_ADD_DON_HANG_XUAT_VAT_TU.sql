
ALTER proc [dbo].[QL_ADD_DON_HANG_XUAT_VAT_TU]
	@MS_DH_XUAT_PT nvarchar(14),
	@MS_PT nvarchar(25),
	@SO_LUONG_CTU float,
	@SO_LUONG_THUC_XUAT float,
	@GHI_CHU nvarchar(256),
	@TG_PB INT,
	@CHI_PHI FLOAT
AS
INSERT INTO [dbo].[IC_DON_HANG_XUAT_VAT_TU]
           ([MS_DH_XUAT_PT]
           ,[MS_PT]
           ,[SO_LUONG_CTU]
           ,[SO_LUONG_THUC_XUAT]
           ,[GHI_CHU]
           ,TG_PB,CHI_PHI)
     VALUES
           (@MS_DH_XUAT_PT ,
			@MS_PT ,
			@SO_LUONG_CTU ,
			@SO_LUONG_THUC_XUAT,
			@GHI_CHU,
			@TG_PB,
			@CHI_PHI
			)
