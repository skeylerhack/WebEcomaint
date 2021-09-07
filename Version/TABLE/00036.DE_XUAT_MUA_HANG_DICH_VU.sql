
if not exists(select * from sys.columns where Name = N'DUONG_DAN_TL' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD DUONG_DAN_TL NVARCHAR(500)
END    
