if not exists(select * from sys.columns 
            where Name = N'ID_DIFF' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
    ALTER TABLE dbo.THONG_TIN_CHUNG ADD ID_DIFF NVARCHAR(500)
END   

