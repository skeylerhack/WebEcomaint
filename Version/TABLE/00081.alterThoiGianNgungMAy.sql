

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TRUONG_CA') and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY'))
BEGIN
		ALTER TABLE THOI_GIAN_NGUNG_MAY ADD TRUONG_CA NVARCHAR(250) NULL
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'CaID') and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY'))
BEGIN
		ALTER TABLE THOI_GIAN_NGUNG_MAY ADD CaID INT NULL
END
