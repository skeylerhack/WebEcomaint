
if not exists(select * from sys.columns 
            where Name = N'SYN_INFO' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD SYN_INFO NVARCHAR(255)
END    

if not exists(select * from sys.columns 
            where Name = N'SYN_DATA' and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
begin
    ALTER TABLE THONG_TIN_CHUNG ADD SYN_DATA BIT
END    

if not exists(select * from sys.columns 
            where Name = N'MS_DHX_SYNC' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP'))
begin
    ALTER TABLE IC_DON_HANG_NHAP ADD MS_DHX_SYNC NVARCHAR (14)
END    


if not exists(select * from sys.columns 
            where Name = N'MS_DHX_SYNC' and Object_ID = Object_ID(N'IC_DON_HANG_XUAT'))
begin
    ALTER TABLE IC_DON_HANG_XUAT ADD MS_DHX_SYNC NVARCHAR (14)
END    

