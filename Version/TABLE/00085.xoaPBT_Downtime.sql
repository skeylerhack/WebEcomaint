IF  EXISTS (select * from sys.columns 
            where Name IN ( N'MS_PHIEU_BAO_TRI') and Object_ID = Object_ID(N'THOI_GIAN_NGUNG_MAY'))
BEGIN
		ALTER TABLE THOI_GIAN_NGUNG_MAY DROP COLUMN MS_PHIEU_BAO_TRI
END