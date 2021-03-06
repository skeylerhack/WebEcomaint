
IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Y_EDIT_DE_XUAT_MUA_HANG_DICH_VU_VECO')
   exec('CREATE PROCEDURE SP_Y_EDIT_DE_XUAT_MUA_HANG_DICH_VU_VECO AS BEGIN SET NOCOUNT ON; END')
GO
ALTER procedure SP_Y_EDIT_DE_XUAT_MUA_HANG_DICH_VU_VECO
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
     @LY_DO nvarchar(255),
     @DUONG_DAN_TL nvarchar(500),
	  @NHA_CUNG_CAP NVARCHAR(250),
	 @NGAY_GIAO DATETIME,
	 @TEN_N_XUONG NVARCHAR(250),
	  @TEN_MAY  nvarchar(50), 
	 @LIFE_TIME FLOAT,
	 @BUYING_NEW BIT,
	 @REPLACING_FOR BIT
	 ,@SPARE BIT
	 ,@MAINTENANCE BIT,
	  @BY_WHOM  nvarchar(50)
	  ,@TRANSFER_TO nvarchar(250)
as
begin
      update dbo.DE_XUAT_MUA_HANG_DICH_VU
      set TEN_DICH_VU= @TEN_DICH_VU,DVT= @DVT,SL_DE_XUAT= @SL_DE_XUAT,DON_GIA= @DON_GIA,NGOAI_TE= @NGOAI_TE,TY_GIA= @TY_GIA,
		TY_GIA_USD= @TY_GIA_USD,THANH_TIEN= @THANH_TIEN,THANH_TIEN_VND= @THANH_TIEN_VND,THANH_TIEN_USD= @THANH_TIEN_USD,
		GHI_CHU= @GHI_CHU, LY_DO = @LY_DO, NGAY_DX = @NGAY_DX, DUONG_DAN_TL = @DUONG_DAN_TL,
		TEN_MAY =@TEN_MAY, LIFE_TIME =@LIFE_TIME, BUYING_NEW=@BUYING_NEW, REPLACING_FOR=@REPLACING_FOR, SPARE=@SPARE, MAINTENANCE=@MAINTENANCE, BY_WHOM=@BY_WHOM, TRANSFER_TO=@TRANSFER_TO
		 ,NHA_CUNG_CAP = @NHA_CUNG_CAP,
	 NGAY_GIAO_HANG = @NGAY_GIAO,
	 TEN_N_XUONG = @TEN_N_XUONG

	  where MS_DE_XUAT= @MS_DE_XUAT and MS_DICH_VU= @MS_DICH_VU


end
