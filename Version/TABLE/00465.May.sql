if not exists(select * from sys.columns 
            where Name = N'HINH_ANH' and Object_ID = Object_ID(N'MAY'))
BEGIN
    ALTER TABLE dbo.MAY ADD HINH_ANH IMAGE
END