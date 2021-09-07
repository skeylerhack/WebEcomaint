if not exists(select * from sys.columns 
            where Name = N'USERNAME' and Object_ID = Object_ID(N'THOI_GIAN_CHAY_MAY'))
begin
    ALTER TABLE THOI_GIAN_CHAY_MAY ADD USERNAME NVARCHAR(50)
END    
