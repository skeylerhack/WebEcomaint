if not exists(select * from sys.columns 
            where Name = N'GHI_CHU' and Object_ID = Object_ID(N'LOAI_MAY'))
begin
    ALTER TABLE LOAI_MAY ADD GHI_CHU NVARCHAR(250)
END    




if not exists(select * from sys.columns 
            where Name = N'GHI_CHU' and Object_ID = Object_ID(N'NHOM_MAY'))
begin
    ALTER TABLE NHOM_MAY ADD GHI_CHU NVARCHAR(250)
END    

