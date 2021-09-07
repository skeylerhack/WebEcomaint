
if not exists(select * from sys.columns 
            where Name = N'DUYET' and Object_ID = Object_ID(N'YEU_CAU_NSD'))
begin
    ALTER TABLE dbo.YEU_CAU_NSD ADD DUYET BIT  DEFAULT (0)
END    
GO	
if not exists(select * from sys.columns 
            where Name = N'DUYET_TAO_YC' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE dbo.THONG_TIN_CHUNG ADD DUYET_TAO_YC BIT  DEFAULT (0)
END    

GO	
if not exists(select * from sys.columns 
            where Name = N'TIME_END' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE dbo.THONG_TIN_CHUNG ADD TIME_END INT  DEFAULT (0)

END    
GO	
UPDATE THONG_TIN_CHUNG SET TIME_END = 30

GO


