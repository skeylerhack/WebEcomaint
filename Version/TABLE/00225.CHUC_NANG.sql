--N'Duyệt nhập yêu cầu'
IF (SELECT COUNT(*) FROM	 CHUC_NANG WHERE STT = 117 ) = 0
BEGIN
INSERT INTO dbo.CHUC_NANG ( STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH,
                             TEN_CHUC_NANG_HOA, MT_CN )
VALUES  ( 117,N'Duyệt nhập yêu cầu',N'Duyệt nhập yêu cầu',N'Duyệt nhập yêu cầu',N'Duyệt nhập yêu cầu (menu 4-3-1)')

INSERT INTO dbo.USER_CHUC_NANG ( USERNAME, STT ) VALUES  ( N'Admin',117) 
END	
GO	
--N'Import Cấu trúc Thiết bị - New'
DECLARE @stt INT = 114
DECLARE @tcn NVARCHAR(50) = N'Import Cấu trúc Thiết bị - New'

IF (SELECT COUNT(*) FROM	 CHUC_NANG WHERE STT = @stt ) = 0
BEGIN
INSERT INTO dbo.CHUC_NANG ( STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH,
                             TEN_CHUC_NANG_HOA, MT_CN )
VALUES  ( @stt,@tcn,@tcn,@tcn,@tcn)

INSERT INTO dbo.USER_CHUC_NANG ( USERNAME, STT ) VALUES  ( N'Admin',@stt) 
END	
GO	
--N'Import Cấu trúc TB - Công việc bảo trì New
DECLARE @stt INT = 115
DECLARE @tcn NVARCHAR(50) = N'Import Cấu trúc TB - Công việc bảo trì New'

IF (SELECT COUNT(*) FROM	 CHUC_NANG WHERE STT = @stt ) = 0
BEGIN
INSERT INTO dbo.CHUC_NANG ( STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH,
                             TEN_CHUC_NANG_HOA, MT_CN )
VALUES  ( @stt,@tcn,@tcn,@tcn,@tcn)

INSERT INTO dbo.USER_CHUC_NANG ( USERNAME, STT ) VALUES  ( N'Admin',@stt) 
END	
GO	
--N'Import Cấu trúc TB - Phụ tùng New
DECLARE @stt INT = 116
DECLARE @tcn NVARCHAR(50) = N'Import Cấu trúc TB - Phụ tùng New'

IF (SELECT COUNT(*) FROM	 CHUC_NANG WHERE STT = @stt ) = 0
BEGIN
INSERT INTO dbo.CHUC_NANG ( STT, TEN_CHUC_NANG, TEN_CHUC_NANG_ANH,
                             TEN_CHUC_NANG_HOA, MT_CN )
VALUES  ( @stt,@tcn,@tcn,@tcn,@tcn)

INSERT INTO dbo.USER_CHUC_NANG ( USERNAME, STT ) VALUES  ( N'Admin',@stt) 
END	
