IF EXISTS(select * from sys.columns 
            where Name IN (N'TRUONG_CA') and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY'))
BEGIN
		ALTER TABLE THOI_GIAN_NGUNG_MAY ALTER COLUMN TRUONG_CA NVARCHAR(250)
END