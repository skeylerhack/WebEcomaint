
ALTER procedure [dbo].[SP_Y_INSERT_DON_HANG_NHAP_VAT_TU_CHI_TIET]
     @MS_DH_NHAP_PT nvarchar(14),
     @MS_PT nvarchar(25),
     @MS_VI_TRI int,
     @SL_VT float,
     @ID float
as
begin
		if(@SL_VT is not null)
		begin
		  insert into IC_DON_HANG_NHAP_VAT_TU_CHI_TIET(MS_DH_NHAP_PT,MS_PT,MS_VI_TRI,SL_VT,ID)
		  values (@MS_DH_NHAP_PT,@MS_PT,@MS_VI_TRI,@SL_VT,@ID)
	  end
end
