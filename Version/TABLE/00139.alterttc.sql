
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'VER_WEB') and Object_ID = Object_ID(N'thong_tin_chung'))
BEGIN
		ALTER TABLE thong_tin_chung ADD  VER_WEB int
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'REF_NO') and Object_ID = Object_ID(N'YEU_CAU_NSD'))
BEGIN
		ALTER TABLE YEU_CAU_NSD ADD  REF_NO NVARCHAR(300)
END
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'REF_ID') and Object_ID = Object_ID(N'YEU_CAU_NSD'))
BEGIN
		ALTER TABLE YEU_CAU_NSD ADD  REF_ID INT
END

IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'REF_NO') and Object_ID = Object_ID(N'YEU_CAU_NSD_CHI_TIET'))
BEGIN
		ALTER TABLE YEU_CAU_NSD_CHI_TIET ADD  REF_NO NVARCHAR(300)
END
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'REF_ID') and Object_ID = Object_ID(N'YEU_CAU_NSD_CHI_TIET'))
BEGIN
		ALTER TABLE YEU_CAU_NSD_CHI_TIET ADD  REF_ID INT
END
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'REF_TYPE') and Object_ID = Object_ID(N'YEU_CAU_NSD_CHI_TIET'))
BEGIN
		ALTER TABLE YEU_CAU_NSD_CHI_TIET ADD  REF_TYPE NVARCHAR(300)
END
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'DETAIL_TYPE') and Object_ID = Object_ID(N'YEU_CAU_NSD_CHI_TIET'))
BEGIN
		ALTER TABLE YEU_CAU_NSD_CHI_TIET ADD  DETAIL_TYPE NVARCHAR(300)
END
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'LINE_ID') and Object_ID = Object_ID(N'YEU_CAU_NSD_CHI_TIET'))
BEGIN
		ALTER TABLE YEU_CAU_NSD_CHI_TIET ADD  LINE_ID INT
END