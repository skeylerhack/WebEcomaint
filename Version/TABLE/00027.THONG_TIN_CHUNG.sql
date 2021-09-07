

if not exists(select * from sys.columns 
            where Name = N'DOI_FONT' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD DOI_FONT BIT
END    

if not exists(select * from sys.columns 
            where Name = N'FONT_REPORT' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD FONT_REPORT NVARCHAR(255)
END    

