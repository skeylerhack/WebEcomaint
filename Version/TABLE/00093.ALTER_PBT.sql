IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'STT_CA') and Object_ID = Object_ID(N'PHIEU_BAO_TRI'))
BEGIN
		ALTER TABLE PHIEU_BAO_TRI ADD STT_CA INT 
END