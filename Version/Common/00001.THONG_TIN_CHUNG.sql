

if not exists(select * from sys.columns 
            where Name = N'VER_HT' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD VER_HT FLOAT
END    

if not exists(select * from sys.columns 
            where Name = N'VER_KH' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD VER_KH FLOAT
END    


if not exists(select * from sys.columns 
            where Name = N'VER_TB' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD VER_TB FLOAT
END    
