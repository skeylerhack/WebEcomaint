if not exists(select * from sys.columns 
            where Name = N'LY_DO' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD LY_DO NVARCHAR(255)
END    


if not exists(select * from sys.columns 
	where Name = N'NGAY_DX' and Object_ID = Object_ID(N'DE_XUAT_MUA_HANG_DICH_VU'))
begin
    ALTER TABLE DE_XUAT_MUA_HANG_DICH_VU ADD NGAY_DX DATETIME
END    

