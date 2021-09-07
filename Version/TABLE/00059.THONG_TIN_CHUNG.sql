if not exists(select * from sys.columns 
            where Name = N'NGAY_LIC' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD NGAY_LIC NVARCHAR(250)

	
END    
