
if not exists(select * from sys.columns 
            where Name = N'MS_PT_CT' and Object_ID = Object_ID(N'IC_DON_HANG_XUAT_VAT_TU'))
begin
    ALTER TABLE dbo.IC_DON_HANG_XUAT_VAT_TU ADD MS_PT_CT NVARCHAR(50)
END    
GO	

if not exists(select * from sys.columns 
            where Name = N'TEN_PT_CT' and Object_ID = Object_ID(N'IC_DON_HANG_XUAT_VAT_TU'))
begin
    ALTER TABLE dbo.IC_DON_HANG_XUAT_VAT_TU ADD TEN_PT_CT NVARCHAR(250)
END    
GO	    
