if not exists(select * from sys.columns 
            where Name = N'CO_KH' and Object_ID = Object_ID(N'KE_HOACH_THUC_HIEN'))
begin
    ALTER TABLE KE_HOACH_THUC_HIEN ADD CO_KH BIT
END    