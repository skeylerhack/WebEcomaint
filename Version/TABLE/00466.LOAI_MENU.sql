if not exists(select * from sys.columns 
            where Name = N'LOAI_MENU' and Object_ID = Object_ID(N'MENU'))
BEGIN
    ALTER TABLE dbo.MENU ADD LOAI_MENU BIGINT
END