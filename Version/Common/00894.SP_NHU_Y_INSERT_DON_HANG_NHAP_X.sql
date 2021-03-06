
ALTER procedure [dbo].[SP_NHU_Y_INSERT_DON_HANG_NHAP_X]
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
     @DIEM2 int
as
begin
      insert into IC_DON_HANG_NHAP_X(MS_DH_NHAP_PT,SO_PHIEU_XN,GIO,NGAY,
      MS_KHO,MS_DANG_NHAP,NGUOI_NHAP,NGAY_CHUNG_TU,
      SO_CHUNG_TU,DIEM,DANH_GIA,GHI_CHU,
      LOCK,DA_HET,THU_KHO,
      MS_DDH,SO_DE_XUAT,NGUOI_GIAO,BSXE,
      DIEM1,DIEM2)
      values (@MS_DH_NHAP_PT,@SO_PHIEU_XN,@GIO,@NGAY,
      @MS_KHO,@MS_DANG_NHAP,@NGUOI_NHAP,@NGAY_CHUNG_TU,
      @SO_CHUNG_TU,@DIEM,@DANH_GIA,@GHI_CHU,
      @LOCK,@DA_HET,@THU_KHO,
      @MS_DDH,@SO_DE_XUAT,@NGUOI_GIAO,@BSXE,
      @DIEM1,@DIEM2)
end
