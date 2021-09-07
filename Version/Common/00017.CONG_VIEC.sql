
if not exists(select * from sys.columns 
            where Name = N'SO_NGUOI' and Object_ID = Object_ID(N'CONG_VIEC'))
begin
    ALTER TABLE CONG_VIEC ADD SO_NGUOI INT
END  
GO
if not exists(select * from sys.columns 
            where Name = N'YEU_CAU_NS' and Object_ID = Object_ID(N'CONG_VIEC'))
begin
    ALTER TABLE CONG_VIEC ADD YEU_CAU_NS NVARCHAR(1000)
END    
GO
if not exists(select * from sys.columns 
            where Name = N'YEU_CAU_DUNG_CU' and Object_ID = Object_ID(N'CONG_VIEC'))
begin
    ALTER TABLE CONG_VIEC ADD YEU_CAU_DUNG_CU NVARCHAR(1000)
END    

