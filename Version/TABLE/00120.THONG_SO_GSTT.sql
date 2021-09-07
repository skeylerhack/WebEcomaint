IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'CACH_THUC_HIEN') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD  CACH_THUC_HIEN NVARCHAR(2000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'THOI_GIAN') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD THOI_GIAN FLOAT
END

