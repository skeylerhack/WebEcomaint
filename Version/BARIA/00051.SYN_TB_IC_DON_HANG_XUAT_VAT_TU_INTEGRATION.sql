

if not exists(select * from sys.columns 
            where Name = N'NAV Entry No' and Object_ID = Object_ID(N'SYN_TB_IC_DON_HANG_XUAT_VAT_TU_INTEGRATION'))
begin
    ALTER TABLE SYN_TB_IC_DON_HANG_XUAT_VAT_TU_INTEGRATION ADD [NAV Entry No] INT
END    

if not exists(select * from sys.columns 
            where Name = N'NAV Entry No' and Object_ID = Object_ID(N'SYN_TB_IC_DON_HANG_XUAT_VAT_TU_CMMS'))
begin
    ALTER TABLE SYN_TB_IC_DON_HANG_XUAT_VAT_TU_CMMS ADD [NAV Entry No] INT
END    