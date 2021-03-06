

ALTER procedure [dbo].[SP_Y_EDIT_DE_XUAT_MUA_HANG]
	 @MS_DE_XUAT nvarchar(50),
     @SO_DE_XUAT nvarchar(50),
     @PHONG_BAN nvarchar (256),
     @NGUOI_LAP nvarchar(256),
     @NGAY_LAP datetime,
     @NGUOI_SUA nvarchar(256),
     @NGAY_SUA datetime,
     @NGUOI_DE_XUAT nvarchar(256),
     @NGAY_DE_XUAT datetime,
     @NGUOI_NHAN nvarchar(256),
     @NGAY_NHAN datetime,
     @NGUOI_DUYET nvarchar(256),
     @NGAY_DUYET datetime,
     @NGUOI_GIAO nvarchar(256),
     @NGAY_GIAO datetime,
     @THEO_YEU_CAU bit,
     @THEO_KE_HOACH bit,
     @TRANG_THAI int,
     @TEN_TRANG_THAI nvarchar(256),
     @GHI_CHU nvarchar(512),
	 @MS_KHO INT,
	 @MS_LOAI_VT NVARCHAR(10),
	 @MS_TO INT,
     @TEN_TT nvarchar(250),
     @MS_TT numeric(18,2),
     @NGUOI_TN nvarchar(256)
as
IF @NGUOI_TN = '' 
	SET @NGUOI_TN = NULL
begin
      update dbo.DE_XUAT_MUA_HANG
      set SO_DE_XUAT= @SO_DE_XUAT,PHONG_BAN= @PHONG_BAN,NGUOI_LAP= @NGUOI_LAP,
      NGAY_LAP= @NGAY_LAP,NGUOI_SUA= @NGUOI_SUA,NGAY_SUA= @NGAY_SUA,NGUOI_DE_XUAT= @NGUOI_DE_XUAT,
      NGAY_DE_XUAT= @NGAY_DE_XUAT,NGUOI_NHAN= @NGUOI_NHAN,NGAY_NHAN= @NGAY_NHAN,NGUOI_DUYET= @NGUOI_DUYET,
      NGAY_DUYET= @NGAY_DUYET,NGUOI_GIAO= @NGUOI_GIAO,NGAY_GIAO= @NGAY_GIAO,THEO_YEU_CAU= @THEO_YEU_CAU,
      THEO_KE_HOACH= @THEO_KE_HOACH,TRANG_THAI= @TRANG_THAI,TEN_TRANG_THAI= @TEN_TRANG_THAI,GHI_CHU= @GHI_CHU,MS_TO = @MS_TO,
      NGUOI_TN = @NGUOI_TN
where MS_DE_XUAT= @MS_DE_XUAT
end
