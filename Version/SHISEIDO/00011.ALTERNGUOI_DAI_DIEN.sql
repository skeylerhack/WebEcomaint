IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'SO_TAI_KHOAN') and Object_ID = Object_ID(N'NGUOI_DAI_DIEN'))
BEGIN
		ALTER TABLE NGUOI_DAI_DIEN ADD SO_TAI_KHOAN NVARCHAR(MAX)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TEN_NH') and Object_ID = Object_ID(N'NGUOI_DAI_DIEN'))
BEGIN
		ALTER TABLE NGUOI_DAI_DIEN ADD TEN_NH NVARCHAR(MAX)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'NGUOI_HUONG') and Object_ID = Object_ID(N'NGUOI_DAI_DIEN'))
BEGIN
		ALTER TABLE NGUOI_DAI_DIEN ADD NGUOI_HUONG BIT
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'SWIFT_CODE') and Object_ID = Object_ID(N'NGUOI_DAI_DIEN'))
BEGIN
		ALTER TABLE NGUOI_DAI_DIEN ADD SWIFT_CODE NVARCHAR(MAX)
END