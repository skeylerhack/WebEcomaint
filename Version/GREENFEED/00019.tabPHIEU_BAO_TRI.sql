IF not exists(select * from sys.columns 
            where Name = N'BAN_GIAO' and Object_ID = Object_ID(N'PHIEU_BAO_TRI'))
begin
    ALTER TABLE PHIEU_BAO_TRI ADD BAN_GIAO BIT;
END 

GO	
IF not exists(select * from sys.columns 
            where Name = N'USERNAME_BG' and Object_ID = Object_ID(N'PHIEU_BAO_TRI'))
begin
    ALTER TABLE PHIEU_BAO_TRI ADD USERNAME_BG NVARCHAR(50);
END   

IF not exists(select * from sys.columns 
    where Name = N'NGAY_BG' and Object_ID = Object_ID(N'PHIEU_BAO_TRI'))
begin
    ALTER TABLE PHIEU_BAO_TRI ADD NGAY_BG DATETIME;
END   


