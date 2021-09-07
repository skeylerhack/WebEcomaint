
if not exists(select * from sys.columns 
            where Name = N'SO_GIO_LUY_KE' and Object_ID = Object_ID(N'PHIEU_BAO_TRI'))
begin
    ALTER TABLE PHIEU_BAO_TRI ADD SO_GIO_LUY_KE float
END    
