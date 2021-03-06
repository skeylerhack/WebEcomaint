IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'LOAI_CN') and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
		ALTER TABLE THONG_TIN_CHUNG ADD LOAI_CN INT
		ALTER TABLE THONG_TIN_CHUNG ADD DEFAULT 0 FOR LOAI_CN
END		
GO
IF NOT EXISTS(select * from sys.columns 
            where Name IN ( N'LINK1') and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
		ALTER TABLE THONG_TIN_CHUNG ADD LINK1 NVARCHAR(MAX)
		ALTER TABLE THONG_TIN_CHUNG ADD DEFAULT N'.' FOR LINK1
END		
GO
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'LINK2') and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
		ALTER TABLE THONG_TIN_CHUNG ADD LINK2 NVARCHAR(MAX)
		ALTER TABLE THONG_TIN_CHUNG ADD DEFAULT N'.' FOR LINK2
END		
GO
IF NOT EXISTS(select * from sys.columns 
            where Name IN (N'LINK3') and Object_ID = Object_ID(N'THONG_TIN_CHUNG'))
BEGIN
		ALTER TABLE THONG_TIN_CHUNG ADD LINK3 NVARCHAR(MAX)
		ALTER TABLE THONG_TIN_CHUNG ADD DEFAULT N'.' FOR LINK3
END		

GO
	UPDATE THONG_TIN_CHUNG SET LOAI_CN = 0 WHERE LOAI_CN IS  NULL
	UPDATE THONG_TIN_CHUNG SET LINK1 = N'.' WHERE LINK1 IS  NULL
	UPDATE THONG_TIN_CHUNG SET LINK2 = N'.' WHERE LINK2 IS  NULL
	UPDATE THONG_TIN_CHUNG SET LINK3 = N'.' WHERE LINK3 IS  NULL
	