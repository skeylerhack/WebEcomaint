IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'NGAY_BTDK_GOC') and Object_ID = Object_ID(N'KE_HOACH_TONG_THE'))
BEGIN
		ALTER TABLE KE_HOACH_TONG_THE ADD  NGAY_BTDK_GOC DATETIME
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'NGAY_BTDK_GOC') and Object_ID = Object_ID(N'PHIEU_BAO_TRI'))
BEGIN
		ALTER TABLE PHIEU_BAO_TRI ADD NGAY_BTDK_GOC DATETIME
END



