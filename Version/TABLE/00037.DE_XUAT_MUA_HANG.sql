

if not exists(select * from sys.columns 
            where Name = N'KEY_DUYET' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG ADD KEY_DUYET NVARCHAR(500)
END    
