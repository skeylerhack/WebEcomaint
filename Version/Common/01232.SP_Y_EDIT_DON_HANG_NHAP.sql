
ALTER procedure [dbo].[SP_Y_EDIT_DON_HANG_NHAP]
     @MS_DH_NHAP_PT nvarchar(14),
     @SO_PHIEU_XN nvarchar(20),
     @GIO datetime,
     @NGAY datetime,
     @MS_KHO int,
     @TEN_KHO NVARCHAR(255),
     @MS_DANG_NHAP int,
     @NGUOI_NHAP nvarchar(255),
     @NGAY_CHUNG_TU datetime,
     @SO_CHUNG_TU nvarchar(255),
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
	 @MS_DHX nvarchar(14),
	 @CP_NHAP_KHAU FLOAT,
	 @CP_KHAC FLOAT  ,
	 @MS_LY_DO_NHAP_KT nvarchar(255),
	 @MS_DON_HANG nvarchar(14)
as
begin
	DECLARE @NgayCT DATETIME
	DECLARE @SoCTCu nvarchar(255)
	
	SELECT @SoCTCu = SO_CHUNG_TU FROM IC_DON_HANG_NHAP WHERE MS_DH_NHAP_PT = @MS_DH_NHAP_PT
	IF @SoCTCu <> @SO_CHUNG_TU
		SET @NgayCT = GETDATE() 
	ELSE
		SELECT @NgayCT = NGAY_TD FROM IC_DON_HANG_NHAP WHERE MS_DH_NHAP_PT = @MS_DH_NHAP_PT
		
		
	
	update IC_DON_HANG_NHAP
	set SO_PHIEU_XN= @SO_PHIEU_XN,GIO= @GIO,NGAY= @NGAY,
	MS_KHO= @MS_KHO,MS_DANG_NHAP= @MS_DANG_NHAP,NGUOI_NHAP= @NGUOI_NHAP,NGAY_CHUNG_TU= @NGAY_CHUNG_TU,
	SO_CHUNG_TU= @SO_CHUNG_TU,DIEM= @DIEM,DANH_GIA= @DANH_GIA,GHI_CHU= @GHI_CHU,
	LOCK= @LOCK,DA_HET= @DA_HET,THU_KHO= @THU_KHO,
	MS_DDH= @MS_DDH,SO_DE_XUAT= @SO_DE_XUAT,NGUOI_GIAO= @NGUOI_GIAO,BSXE= @BSXE,DIEM1= @DIEM1,DIEM2= @DIEM2,
	LY_DO=@LY_DO,CAN_CU=@CAN_CU,THU_KHO_KY=@THU_KHO_KY,NGUOI_LAP=@NGUOI_LAP,MS_DHX = @MS_DHX ,
	NGAY_TD = @NgayCT , CP_NHAP_KHAU = @CP_NHAP_KHAU , CP_KHAC = @CP_KHAC, MS_LY_DO_NHAP_KT =  @MS_LY_DO_NHAP_KT
	where MS_DH_NHAP_PT = @MS_DH_NHAP_PT
end



