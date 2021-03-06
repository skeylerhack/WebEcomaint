IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'SP_Y_EDIT_DE_XUAT_MUA_HANG_CHI_TIET_VECO')
   exec('CREATE PROCEDURE SP_Y_EDIT_DE_XUAT_MUA_HANG_CHI_TIET_VECO AS BEGIN SET NOCOUNT ON; END')
GO

ALTER procedure SP_Y_EDIT_DE_XUAT_MUA_HANG_CHI_TIET_VECO
	 @MS_DE_XUAT nvarchar(50),
     @MS_PT nvarchar(25),
     @MS_PT_CTY nvarchar(25),
     @TEN_PT nvarchar(256),
     @PART_NO nvarchar(256),
     @QUY_CACH nvarchar(256),
     @DVT nvarchar(256),
     @NHAN_HIEU nvarchar(256),
     @HANG_SX nvarchar(256),
     @CONG_DUNG nvarchar(256),
     @HAN_SU_DUNG nvarchar(256),
     @TON_KHO numeric(18,2),
     @TON_MIN numeric(18,2),
     @TON_MAX numeric(18,2),
     @DA_DAT_MUA numeric(18,2),
     @DA_DE_XUAT numeric(18,2),
     @SL_DE_XUAT numeric(18,2),
     @SL_DA_DUYET numeric(18,2),
     @DON_GIA numeric(18,2),
     @NGOAI_TE nvarchar(256),
     @TY_GIA numeric(18,6),
     @TY_GIA_USD numeric(18,6),
     @THANH_TIEN numeric(20,2),
	 @THANH_TIEN_VND numeric(20,2),
     @THANH_TIEN_USD numeric(20,2),
     @THUE_VAT FLOAT,
     @SO_HOA_DON nvarchar(50),
     @NHA_CUNG_CAP nvarchar(256),
     @NGAY_GIAO_HANG datetime,
     @NGAY_DE_XUAT_CUOI datetime,
     @NHA_CUNG_CAP_CUOI nvarchar(256),
     @DON_GIA_CUOI numeric(18,2),
     @NGOAI_TE_CUOI nvarchar(256),
     @GHI_CHU nvarchar(512),
     @SL_NH numeric(18,2),
     @TEN_TT nvarchar(250),
     @MS_TT numeric(18,2),
	 @TEN_MAY  nvarchar(50), 
	 @TEN_N_XUONG  nvarchar(250),
	 @LIFE_TIME FLOAT,
	 @BY_WHOM  nvarchar(50), 
	 @BUYING_NEW BIT,
	 @REPLACING_FOR BIT, 
	 @DUONG_DAN_TL nvarchar(500)
	 ,@SPARE BIT
	 ,@MAINTENANCE BIT
	 	  ,@TRANSFER_TO nvarchar(250)

as
begin
      update dbo.DE_XUAT_MUA_HANG_CHI_TIET
      set TEN_PT= @TEN_PT,PART_NO= @PART_NO,
      QUY_CACH= @QUY_CACH,DVT= @DVT,NHAN_HIEU= @NHAN_HIEU,HANG_SX= @HANG_SX,
      CONG_DUNG= @CONG_DUNG,HAN_SU_DUNG= @HAN_SU_DUNG,TON_KHO= @TON_KHO,TON_MIN= @TON_MIN,
      TON_MAX= @TON_MAX,DA_DAT_MUA= @DA_DAT_MUA,DA_DE_XUAT= @DA_DE_XUAT,SL_DE_XUAT= @SL_DE_XUAT,
      SL_DA_DUYET= @SL_DA_DUYET,DON_GIA= @DON_GIA,NGOAI_TE= @NGOAI_TE,TY_GIA= @TY_GIA,
      TY_GIA_USD= @TY_GIA_USD,THANH_TIEN= @THANH_TIEN,THANH_TIEN_VND = @THANH_TIEN_VND,THANH_TIEN_USD= @THANH_TIEN_USD,SO_HOA_DON= @SO_HOA_DON,
      NHA_CUNG_CAP= @NHA_CUNG_CAP,NGAY_GIAO_HANG= @NGAY_GIAO_HANG,NGAY_DE_XUAT_CUOI= @NGAY_DE_XUAT_CUOI,NHA_CUNG_CAP_CUOI= @NHA_CUNG_CAP_CUOI,
      DON_GIA_CUOI= @DON_GIA_CUOI,NGOAI_TE_CUOI= @NGOAI_TE_CUOI,GHI_CHU= @GHI_CHU,
      THUE_VAT = @THUE_VAT,
	   TEN_MAY=@TEN_MAY ,LIFE_TIME = @LIFE_TIME,BY_WHOM = @BY_WHOM,BUYING_NEW = @BUYING_NEW,REPLACING_FOR= @REPLACING_FOR,DUONG_DAN_TL=@DUONG_DAN_TL
	 ,SPARE=@SPARE ,MAINTENANCE= @MAINTENANCE, TRANSFER_TO =@TRANSFER_TO,
	 TEN_N_XUONG = 	 @TEN_N_XUONG 



	  where MS_DE_XUAT= @MS_DE_XUAT and MS_PT= @MS_PT
end

