IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'H_QL_ADD_DON_HANG_XUAT_CS')
exec('CREATE PROCEDURE H_QL_ADD_DON_HANG_XUAT_CS AS BEGIN SET NOCOUNT ON; END')
GO
ALTER proc [dbo].[H_QL_ADD_DON_HANG_XUAT_CS]
	@MS_DH_XUAT_PT nvarchar(14),
	@SO_PHIEU_XN nvarchar(20),
	@GIO DATETIME,
	@NGAY datetime,
	@MS_KHO int,
	@MS_DANG_XUAT int,
	@NGUOI_NHAN nvarchar(20),
	@NGAY_CHUNG_TU datetime,
	@SO_CHUNG_TU nvarchar(255),
	@MS_PHIEU_BAO_TRI nvarchar(20),
	@GHI_CHU nvarchar(255),
	@LOCK bit,
	@LY_DO_XUAT NVARCHAR(255),
	@THU_KHO NVARCHAR(50),
	@MS_BP_CHIU_PHI int,
	@NGUOI_LAP nvarchar(255),
	@CAN_CU nvarchar(255),
	@THU_KHO_KY nvarchar(255),
	@KHO_CHINH int,
	@MS_VI_TRI int,
	@MS_MAY nvarchar(30),
	@MS_LY_DO_XUAT_KT nvarchar(30),
	@MS_KH_NHAN nvarchar(20)
AS
INSERT INTO [dbo].[IC_DON_HANG_XUAT]
           ([MS_DH_XUAT_PT],[SO_PHIEU_XN]
           ,[GIO],[NGAY],[MS_KHO]
           ,[MS_DANG_XUAT],[NGUOI_NHAN]
           ,[NGAY_CHUNG_TU],[SO_CHUNG_TU]
           ,[MS_PHIEU_BAO_TRI],[GHI_CHU]
           ,[LOCK],[LY_DO_XUAT],[THU_KHO]
           ,[MS_BP_CHIU_PHI]
           ,NGUOI_LAP,CAN_CU,THU_KHO_KY,MS_KHO_DEN, MS_MAY,MS_LY_DO_XUAT_KT,MS_KH_NHAN,MS_VI_TRI_DEN )
     VALUES
           (@MS_DH_XUAT_PT,@SO_PHIEU_XN ,
			@GIO ,@NGAY ,@MS_KHO ,
			@MS_DANG_XUAT,@NGUOI_NHAN ,
			@NGAY_CHUNG_TU ,@SO_CHUNG_TU ,
			@MS_PHIEU_BAO_TRI ,@GHI_CHU ,
			@LOCK,@LY_DO_XUAT,@THU_KHO,
			@MS_BP_CHIU_PHI,
			@NGUOI_LAP,@CAN_CU,@THU_KHO_KY,@KHO_CHINH, @MS_MAY,@MS_LY_DO_XUAT_KT,@MS_KH_NHAN,@MS_VI_TRI )

