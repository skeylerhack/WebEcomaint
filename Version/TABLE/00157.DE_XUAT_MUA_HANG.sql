if not exists(select * from sys.columns 
            where Name = N'MS_NCC' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG ADD MS_NCC NVARCHAR(250)
END    
