
ALTER procedure [dbo].[SP_Y_EDIT_DUYET_DE_XUAT_MUA_HANG]
	 @MS_DE_XUAT nvarchar(50),
     @NGUOI_DUYET nvarchar(256),
     @MS_CN nvarchar(256),
     @NGAY_DUYET datetime,
     @TT_DUYET int,
     @DON_VI nvarchar(256),
     @VAI_TRO nvarchar(256),
     @QUYET_DINH bit,
     @NOI_DUNG nvarchar(512),
     @DUYET bit,
     @BAT_BUOC bit
as
begin
      update dbo.DE_XUAT_MUA_HANG_DUYET
      set NGAY_DUYET= @NGAY_DUYET,TT_DUYET= @TT_DUYET,
      DON_VI= @DON_VI,VAI_TRO= @VAI_TRO,QUYET_DINH= @QUYET_DINH,NOI_DUNG= @NOI_DUNG,
      DUYET= @DUYET, BAT_BUOC = @BAT_BUOC
	  where MS_DE_XUAT= @MS_DE_XUAT and NGUOI_DUYET= @NGUOI_DUYET
end
