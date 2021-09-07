IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'SO_GIO_LUY_KE') and Object_ID = Object_ID(N'THOI_GIAN_CHAY_MAY'))
BEGIN
		ALTER TABLE THOI_GIAN_CHAY_MAY ADD  SO_GIO_LUY_KE float
END
