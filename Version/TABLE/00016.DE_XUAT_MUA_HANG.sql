if not exists(select * from sys.columns 
            where Name = N'NGUOI_TN' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG ADD NGUOI_TN NVARCHAR(9)
END    




