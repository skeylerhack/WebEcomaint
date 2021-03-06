
ALTER procedure [dbo].[SP_Y_INSERT_DUYET_DE_XUAT_MUA_HANG]
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
      insert into dbo.DE_XUAT_MUA_HANG_DUYET(MS_DE_XUAT,NGUOI_DUYET,NGAY_DUYET,TT_DUYET,
		DON_VI,VAI_TRO,QUYET_DINH,NOI_DUNG,DUYET,BAT_BUOC)
      values (@MS_DE_XUAT,@NGUOI_DUYET,GETDATE(),@TT_DUYET,
		@DON_VI,@VAI_TRO,@QUYET_DINH,@NOI_DUNG,@DUYET,@BAT_BUOC)
end
