IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'DUYET_YC') and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
		ALTER TABLE THONG_TIN_CHUNG ADD DUYET_YC BIT DEFAULT 0
END


