if not exists(select * from sys.columns 
            where Name = N'TRANSFER_DATA' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
    ALTER TABLE dbo.THONG_TIN_CHUNG ADD TRANSFER_DATA INT
END