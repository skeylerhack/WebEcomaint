if not exists(select * from sys.columns 
            where Name = N'CHI_PHI' and Object_ID = Object_ID(N'IC_DON_HANG_XUAT_VAT_TU'))
begin
    ALTER TABLE dbo.IC_DON_HANG_XUAT_VAT_TU ADD CHI_PHI FLOAT;
END    
GO	



