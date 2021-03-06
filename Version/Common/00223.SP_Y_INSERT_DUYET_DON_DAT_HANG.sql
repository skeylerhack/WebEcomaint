
ALTER procedure [dbo].[SP_Y_INSERT_DUYET_DON_DAT_HANG]
	 @MS_DON_DAT_HANG nvarchar(50),
     @NGUOI_DUYET nvarchar(256),
     @NGAY_DUYET datetime,
     @TT_DUYET int,
     @DON_VI nvarchar(256),
     @VAI_TRO nvarchar(256),
     @QUYET_DINH bit,
     @NOI_DUNG nvarchar(512),
     @DUYET bit,
	 @BAT_BUOC BIT
as
begin
      insert into dbo.DON_DAT_HANG_DUYET(MS_DON_DAT_HANG,NGUOI_DUYET,NGAY_DUYET,TT_DUYET,DON_VI,VAI_TRO,QUYET_DINH,NOI_DUNG,DUYET,BAT_BUOC)
      values (@MS_DON_DAT_HANG,@NGUOI_DUYET,GETDATE(),@TT_DUYET,@DON_VI,@VAI_TRO,@QUYET_DINH,@NOI_DUNG,@DUYET,@BAT_BUOC)
end
