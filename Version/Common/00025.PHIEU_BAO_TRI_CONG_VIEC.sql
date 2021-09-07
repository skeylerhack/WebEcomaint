
if not exists(select * from sys.columns 
            where Name = N'THAO_TAC' and Object_ID = Object_ID(N'PHIEU_BAO_TRI_CONG_VIEC'))
begin
    ALTER TABLE PHIEU_BAO_TRI_CONG_VIEC ADD THAO_TAC NVARCHAR(2000)
END    

if not exists(select * from sys.columns 
            where Name = N'TIEU_CHUAN_KT' and Object_ID = Object_ID(N'PHIEU_BAO_TRI_CONG_VIEC'))
begin
    ALTER TABLE PHIEU_BAO_TRI_CONG_VIEC ADD TIEU_CHUAN_KT NVARCHAR(2000)
END    

if not exists(select * from sys.columns 
            where Name = N'PATH_HD' and Object_ID = Object_ID(N'PHIEU_BAO_TRI_CONG_VIEC'))
begin
    ALTER TABLE PHIEU_BAO_TRI_CONG_VIEC ADD PATH_HD NVARCHAR(250)
END    

if not exists(select * from sys.columns 
            where Name = N'SO_NGUOI' and Object_ID = Object_ID(N'PHIEU_BAO_TRI_CONG_VIEC'))
begin
    ALTER TABLE PHIEU_BAO_TRI_CONG_VIEC ADD SO_NGUOI INT
END    

if not exists(select * from sys.columns 
            where Name = N'YEU_CAU_NS' and Object_ID = Object_ID(N'PHIEU_BAO_TRI_CONG_VIEC'))
begin
    ALTER TABLE PHIEU_BAO_TRI_CONG_VIEC ADD YEU_CAU_NS NVARCHAR(1000)
END    

if not exists(select * from sys.columns 
            where Name = N'YEU_CAU_DUNG_CU' and Object_ID = Object_ID(N'PHIEU_BAO_TRI_CONG_VIEC'))
begin
    ALTER TABLE PHIEU_BAO_TRI_CONG_VIEC ADD YEU_CAU_DUNG_CU NVARCHAR(1000)
END    
