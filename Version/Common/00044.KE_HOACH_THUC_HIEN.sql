

if not exists(select * from sys.columns 
            where Name = N'TU_GIO' and Object_ID = Object_ID(N'KE_HOACH_THUC_HIEN'))
begin
    ALTER TABLE KE_HOACH_THUC_HIEN ADD TU_GIO DATETIME
END 

if not exists(select * from sys.columns 
            where Name = N'DEN_GIO' and Object_ID = Object_ID(N'KE_HOACH_THUC_HIEN'))
begin
    ALTER TABLE KE_HOACH_THUC_HIEN ADD DEN_GIO DATETIME
END    

if not exists(select * from sys.columns 
            where Name = N'SPHUT' and Object_ID = Object_ID(N'KE_HOACH_THUC_HIEN'))
begin
    ALTER TABLE KE_HOACH_THUC_HIEN ADD SPHUT FLOAT
END    
