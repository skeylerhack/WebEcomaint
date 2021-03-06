
ALTER procedure [dbo].[SP_NHU_Y_EDIT_DON_HANG_NHAP_X]
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
      update IC_DON_HANG_NHAP_X
      set SO_PHIEU_XN= @SO_PHIEU_XN,GIO= @GIO,NGAY= @NGAY,
      MS_KHO= @MS_KHO,MS_DANG_NHAP= @MS_DANG_NHAP,NGUOI_NHAP= @NGUOI_NHAP,NGAY_CHUNG_TU= @NGAY_CHUNG_TU,
      SO_CHUNG_TU= @SO_CHUNG_TU,DIEM= @DIEM,DANH_GIA= @DANH_GIA,GHI_CHU= @GHI_CHU,
      LOCK= @LOCK,DA_HET= @DA_HET,THU_KHO= @THU_KHO,
      MS_DDH= @MS_DDH,SO_DE_XUAT= @SO_DE_XUAT,NGUOI_GIAO= @NGUOI_GIAO,BSXE= @BSXE,
      DIEM1= @DIEM1,DIEM2= @DIEM2
	  where MS_DH_NHAP_PT = @MS_DH_NHAP_PT
end
