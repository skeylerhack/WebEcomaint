
if not exists(select * from sys.columns 
            where Name = N'FONT_FORM' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD FONT_FORM NVARCHAR(250) 
END    

GO
UPDATE THONG_TIN_CHUNG SET FONT_FORM = N'Tahoma' WHERE ISNULL(FONT_FORM,'') = ''

GO
if not exists(select * from sys.columns 
            where Name = N'FONT_SIZE' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD FONT_SIZE FLOAT 
END    

GO
UPDATE THONG_TIN_CHUNG SET FONT_SIZE = 8.25 WHERE ISNULL(FONT_SIZE,0) = 0