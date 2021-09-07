if not exists(select * from sys.columns 
            where Name = N'MS_CN_GS' and Object_ID = Object_ID(N'KE_HOACH_TONG_THE'))
begin
    ALTER TABLE KE_HOACH_TONG_THE ADD MS_CN_GS NVARCHAR(9)
END   

