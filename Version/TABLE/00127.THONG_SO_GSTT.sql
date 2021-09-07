

--THONG_SO_GSTT
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'CACH_THUC_HIEN') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD  CACH_THUC_HIEN NVARCHAR(2000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TIEU_CHUAN_KT') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD  TIEU_CHUAN_KT NVARCHAR(2000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'YEU_CAU_NS') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD  YEU_CAU_NS NVARCHAR(1000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'YEU_CAU_DUNG_CU') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD  YEU_CAU_DUNG_CU NVARCHAR(1000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'THOI_GIAN') and Object_ID = Object_ID(N'THONG_SO_GSTT'))
BEGIN
		ALTER TABLE THONG_SO_GSTT ADD  THOI_GIAN FLOAT
END


--CAU_TRUC_THIET_BI_TS_GSTT
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'THOI_GIAN') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_TS_GSTT'))
BEGIN
		ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT ADD  THOI_GIAN FLOAT
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'CACH_THUC_HIEN') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_TS_GSTT'))
BEGIN
		ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT ADD  CACH_THUC_HIEN NVARCHAR(2000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TIEU_CHUAN_KT') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_TS_GSTT'))
BEGIN
		ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT ADD  TIEU_CHUAN_KT NVARCHAR(2000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'YEU_CAU_NS') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_TS_GSTT'))
BEGIN
		ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT ADD  YEU_CAU_NS NVARCHAR(1000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'YEU_CAU_DUNG_CU') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_TS_GSTT'))
BEGIN
		ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT ADD  YEU_CAU_DUNG_CU NVARCHAR(1000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'PATH_HD') and Object_ID = Object_ID(N'CAU_TRUC_THIET_BI_TS_GSTT'))
BEGIN
		ALTER TABLE CAU_TRUC_THIET_BI_TS_GSTT ADD  PATH_HD NVARCHAR(500)
END



--GIAM_SAT_TINH_TRANG_TS
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'THOI_GIAN') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD  THOI_GIAN FLOAT
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'CACH_THUC_HIEN') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD  CACH_THUC_HIEN NVARCHAR(2000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TIEU_CHUAN_KT') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD  TIEU_CHUAN_KT NVARCHAR(2000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'YEU_CAU_NS') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD  YEU_CAU_NS NVARCHAR(1000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'YEU_CAU_DUNG_CU') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD  YEU_CAU_DUNG_CU NVARCHAR(1000)
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'PATH_HD') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD  PATH_HD NVARCHAR(500)
END
