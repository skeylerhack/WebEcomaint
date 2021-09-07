if not exists(select * from sys.columns 
           where Name = N'CN_UPDATE' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
   ALTER TABLE THONG_TIN_CHUNG ADD CN_UPDATE BIT DEFAULT 0
END    
GO
UPDATE THONG_TIN_CHUNG SET CN_UPDATE = 0 WHERE CN_UPDATE IS NULL

