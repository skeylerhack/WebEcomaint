if not exists(select * from sys.columns 
            where Name = N'MS_VI_TRI_DEN' and Object_ID = Object_ID(N'IC_DON_HANG_XUAT'))
begin
    ALTER TABLE dbo.IC_DON_HANG_XUAT ADD MS_VI_TRI_DEN INT;
END    
GO	

if not exists(select * from sys.columns 
            where Name = N'MS_VI_TRI' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP'))
begin
    ALTER TABLE dbo.IC_DON_HANG_NHAP ADD MS_VI_TRI INT;
END    
GO	

if not exists(select * from sys.columns 
            where Name = N'MS_VI_TRI' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP_X'))
begin
    ALTER TABLE dbo.IC_DON_HANG_NHAP_X ADD MS_VI_TRI INT;
END    
GO	

if not exists(select * from sys.columns 
            where Name = N'ID' and Object_ID = Object_ID(N'VI_TRI_KHO_VAT_TU_X'))
begin
    ALTER TABLE dbo.VI_TRI_KHO_VAT_TU_X ADD ID FLOAT;
END    
GO	




