if not exists(select * from sys.columns 
            where Name = N'SNGUOI' and Object_ID = Object_ID(N'KE_HOACH_TONG_CONG_VIEC'))
begin
    ALTER TABLE KE_HOACH_TONG_CONG_VIEC ADD SNGUOI INT
END    

GO
if not exists(select * from sys.columns 
            where Name = N'YCAU_NS' and Object_ID = Object_ID(N'KE_HOACH_TONG_CONG_VIEC'))
begin
    ALTER TABLE KE_HOACH_TONG_CONG_VIEC ADD YCAU_NS NVARCHAR(1000)
END    

GO
if not exists(select * from sys.columns 
            where Name = N'YCAU_DC' and Object_ID = Object_ID(N'KE_HOACH_TONG_CONG_VIEC'))
begin
    ALTER TABLE KE_HOACH_TONG_CONG_VIEC ADD YCAU_DC NVARCHAR(1000)
END    




