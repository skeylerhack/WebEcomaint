if not exists(select * from sys.columns 
            where Name = N'MS_NGUOI_THUC_HIEN' and Object_ID = Object_ID(N'MAY_LOAI_BTPN'))
begin
    ALTER TABLE MAY_LOAI_BTPN ADD MS_NGUOI_THUC_HIEN NVARCHAR(255) NULL;
END    
