

if not exists(select * from sys.columns 
            where Name = N'THOI_GIAN_DU_KIEN' and Object_ID = Object_ID(N'KE_HOACH_TONG_CONG_VIEC'))
begin
    ALTER TABLE KE_HOACH_TONG_CONG_VIEC ADD THOI_GIAN_DU_KIEN float
END    

