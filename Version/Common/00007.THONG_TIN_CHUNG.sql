
if not exists(select * from sys.columns 
            where Name = N'TTBT' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD TTBT BIT 
END    
