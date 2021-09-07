
------------CAN_CU
if not exists(select * from sys.columns 
            where Name = N'CAN_CU' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP_X'))
begin
    ALTER TABLE IC_DON_HANG_NHAP_X ADD CAN_CU NVARCHAR(255);
END    
GO	
------------THU_KHO_KY
if not exists(select * from sys.columns
            where Name = N'THU_KHO_KY' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP_X'))
begin
    ALTER TABLE IC_DON_HANG_NHAP_X ADD THU_KHO_KY NVARCHAR(100);
END    
GO	

------------NGUOI_LAP
if not exists(select * from sys.columns 
            where Name = N'NGUOI_LAP' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP_X'))
begin
    ALTER TABLE IC_DON_HANG_NHAP_X ADD NGUOI_LAP NVARCHAR(250);
END    
GO	
------------MS_DHX
if not exists(select * from sys.columns 
            where Name = N'MS_DHX' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP_X'))
begin
    ALTER TABLE IC_DON_HANG_NHAP_X ADD MS_DHX NVARCHAR(14);
END    
GO	

------------NGAY_TD
if not exists(select * from sys.columns 
            where Name = N'NGAY_TD' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP_X'))
begin
    ALTER TABLE IC_DON_HANG_NHAP_X ADD NGAY_TD DATETIME;
END    
GO	
------------MS_DH_XUAT_PT
if not exists(select * from sys.columns 
            where Name = N'MS_DH_XUAT_PT' and Object_ID = Object_ID(N'IC_DON_HANG_NHAP_X'))
begin
    ALTER TABLE IC_DON_HANG_NHAP_X ADD MS_DH_XUAT_PT NVARCHAR(14);
END    
GO	

