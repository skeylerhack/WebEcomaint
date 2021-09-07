
IF NOT EXISTS( SELECT * FROM dbo.CHUC_NANG WHERE STT = 114) 
BEGIN
	INSERT INTO dbo.CHUC_NANG(STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH, TEN_CHUC_NANG_HOA, MT_CN)
	VALUES(114,	N'Cấu trúc Thiết bị - New', N'Cấu trúc Thiết bị - New',	N'Cấu trúc Thiết bị - New',	N'Cấu trúc Thiết bị - New'	)

	INSERT INTO dbo.USER_CHUC_NANG(USERNAME, STT)	VALUES(N'admin',114)	
END


IF NOT EXISTS( SELECT * FROM dbo.CHUC_NANG WHERE STT = 115)
BEGIN
	INSERT INTO dbo.CHUC_NANG(STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH, TEN_CHUC_NANG_HOA, MT_CN)    
	VALUES(115,N'Import Cấu trúc TB - Công việc bảo trì New',N'Import Cấu trúc TB - Công việc bảo trì New',	N'Import Cấu trúc TB - Công việc bảo trì New',	N'Import Cấu trúc TB - Công việc bảo trì New')	
	INSERT INTO dbo.USER_CHUC_NANG(USERNAME, STT)	VALUES(N'admin',115)	
END

IF NOT EXISTS( SELECT * FROM dbo.CHUC_NANG WHERE STT = 116)
BEGIN
	INSERT INTO dbo.CHUC_NANG(STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH, TEN_CHUC_NANG_HOA, MT_CN)    
	VALUES(116,	'Import Cấu trúc TB - Phụ tùng New',N'Import Cấu trúc TB - Phụ tùng New',N'Import Cấu trúc TB - Phụ tùng New',N'Import Cấu trúc TB - Phụ tùng New')

	INSERT INTO dbo.USER_CHUC_NANG(USERNAME, STT)	VALUES(N'admin',116)	
END

IF NOT EXISTS( SELECT * FROM dbo.CHUC_NANG WHERE STT = 117)
BEGIN
	INSERT INTO dbo.CHUC_NANG(STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH, TEN_CHUC_NANG_HOA, MT_CN)    
	VALUES(117,	N'Duyệt nhập yêu cầu',N'Duyệt nhập yêu cầu',N'Duyệt nhập yêu cầu',N'Duyệt nhập yêu cầu (menu 4-3-1)')
	INSERT INTO dbo.USER_CHUC_NANG(USERNAME, STT)	VALUES(N'admin',117)	
END

IF NOT EXISTS( SELECT * FROM dbo.CHUC_NANG WHERE STT = 118)
BEGIN
	INSERT INTO dbo.CHUC_NANG(STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH, TEN_CHUC_NANG_HOA, MT_CN)    
	VALUES(118,N'Lock/Unlock Đề xuất mua hàng',N'Lock/Unlock Đề xuất mua hàng',N'Lock/Unlock Đề xuất mua hàng',N'Lock/Unlock Đề xuất mua hàng')  

	INSERT INTO dbo.USER_CHUC_NANG(USERNAME, STT)	VALUES(N'admin',118)	
END

