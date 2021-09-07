if not exists(select * from sys.columns 
            where Name = N'SSL_MAIL' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD SSL_MAIL BIT 
END    
ELSE
PRINT 'TON TAI'

