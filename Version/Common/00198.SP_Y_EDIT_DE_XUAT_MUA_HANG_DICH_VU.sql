
ALTER procedure [dbo].[SP_Y_EDIT_DE_XUAT_MUA_HANG_DICH_VU]
	 @MS_DE_XUAT nvarchar(50),
     @MS_DICH_VU nvarchar(50),
     @TEN_DICH_VU nvarchar(256),
     @DVT nvarchar(256),
     @SL_DE_XUAT numeric(18,2),
     @DON_GIA numeric(18,2),
     @NGOAI_TE nvarchar(256),
     @TY_GIA numeric(18,6),
     @TY_GIA_USD numeric(18,6),
     @THANH_TIEN numeric(20,2),
	 @THANH_TIEN_VND numeric(20,2),
     @THANH_TIEN_USD numeric(20,2),
     @GHI_CHU nvarchar(512),
     @NGAY_DX datetime,
     @LY_DO nvarchar(255)
as
begin
      update dbo.DE_XUAT_MUA_HANG_DICH_VU
      set TEN_DICH_VU= @TEN_DICH_VU,DVT= @DVT,SL_DE_XUAT= @SL_DE_XUAT,DON_GIA= @DON_GIA,NGOAI_TE= @NGOAI_TE,TY_GIA= @TY_GIA,
		TY_GIA_USD= @TY_GIA_USD,THANH_TIEN= @THANH_TIEN,THANH_TIEN_VND= @THANH_TIEN_VND,THANH_TIEN_USD= @THANH_TIEN_USD,
		GHI_CHU= @GHI_CHU, LY_DO = @LY_DO, NGAY_DX = @NGAY_DX
	  where MS_DE_XUAT= @MS_DE_XUAT and MS_DICH_VU= @MS_DICH_VU
end
