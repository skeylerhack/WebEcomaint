
--sp_add_IC_DON_HANG_NHAP
ALTER procedure [dbo].[SP_Y_INSERT_DON_HANG_NHAP]
     @MS_DH_NHAP_PT nvarchar(14),
     @SO_PHIEU_XN nvarchar(20),
     @GIO datetime,
     @NGAY datetime,
     @MS_KHO int,
	 @TEN_KHO NVARCHAR(255),
     @MS_DANG_NHAP int,
     @NGUOI_NHAP nvarchar(255),
     @NGAY_CHUNG_TU datetime,
     @SO_CHUNG_TU nvarchar(20),
     @DIEM int,
     @DANH_GIA nvarchar(50),
     @GHI_CHU nvarchar(255),
     @LOCK bit,
     @STT int,
     @DA_HET bit,
     @THU_KHO nvarchar(50),
     @MS_DDH nvarchar(30),
     @SO_DE_XUAT nvarchar(50),
     @NGUOI_GIAO nvarchar(100),
     @BSXE nvarchar(100),
     @DIEM1 int,
     @DIEM2 int,
     @LY_DO nvarchar(255),
	 @CAN_CU nvarchar(255),
	 @THU_KHO_KY nvarchar(255),
	 @NGUOI_LAP nvarchar(255),
	 @MS_DHX nvarchar(14) ,
	 @CP_NHAP_KHAU FLOAT,
	 @CP_KHAC FLOAT,
	 @MS_LY_DO_NHAP_KT nvarchar(255),
	 @MS_DON_HANG nvarchar(14)
as
begin
	DECLARE @NgayCT DATETIME
	IF ISNULL(@SO_CHUNG_TU,'') = '' 
		SET @NgayCT = NULL
	ELSE
		SET @NgayCT = GETDATE()
	IF(@MS_DANG_NHAP = 6 OR @MS_DANG_NHAP = 10)
		SET @MS_DHX = @MS_DON_HANG
	ELSE IF @MS_DANG_NHAP = 3
		SET @MS_DDH = @MS_DON_HANG
		
	insert into IC_DON_HANG_NHAP(MS_DH_NHAP_PT,SO_PHIEU_XN,GIO,NGAY,
		MS_KHO,MS_DANG_NHAP,NGUOI_NHAP,NGAY_CHUNG_TU,
		SO_CHUNG_TU,DIEM,DANH_GIA,GHI_CHU,
		LOCK,DA_HET,THU_KHO,
		MS_DDH,SO_DE_XUAT,NGUOI_GIAO,BSXE,
		DIEM1,DIEM2,LY_DO,CAN_CU,THU_KHO_KY,NGUOI_LAP,MS_DHX, NGAY_TD , MS_LY_DO_NHAP_KT, CP_NHAP_KHAU,CP_KHAC )
	values (@MS_DH_NHAP_PT,@SO_PHIEU_XN,@GIO,@NGAY,
		@MS_KHO,@MS_DANG_NHAP,@NGUOI_NHAP,@NGAY_CHUNG_TU,
		@SO_CHUNG_TU,@DIEM,@DANH_GIA,@GHI_CHU,
		@LOCK,@DA_HET,@THU_KHO,
		@MS_DDH,@SO_DE_XUAT,@NGUOI_GIAO,@BSXE,
		@DIEM1,@DIEM2,@LY_DO,@CAN_CU,@THU_KHO_KY,@NGUOI_LAP,@MS_DHX,@NgayCT, @MS_LY_DO_NHAP_KT, @CP_NHAP_KHAU,@CP_KHAC)
end







