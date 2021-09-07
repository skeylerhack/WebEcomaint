if not exists(select * from sys.columns 
            where Name = N'TEN_N_XUONG' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_CHI_TIET'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_CHI_TIET ADD TEN_N_XUONG nvarchar(500)
END 