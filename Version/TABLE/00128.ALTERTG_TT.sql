
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TG_TT') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS_DT'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG_TS_DT ADD  TG_TT float NULL
END


IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'TG_TT') and Object_ID = Object_ID(N'GIAM_SAT_TINH_TRANG_TS'))
BEGIN
		ALTER TABLE GIAM_SAT_TINH_TRANG_TS ADD  TG_TT float NULL
END












