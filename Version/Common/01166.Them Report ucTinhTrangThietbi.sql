
DECLARE @Report nvarchar(500)
set @Report = N'ήΊͬΖΠΔͬΨΆΠΒͬΔΖΎάΈΖ'

IF NOT EXISTS (SELECT * FROM LIC_REPORT WHERE REPORT_NAME = @Report)
INSERT INTO LIC_REPORT (REPORT_NAME,TYPE_LIC) VALUES ( @Report,N'̦')
	
GO

IF NOT EXISTS (SELECT * FROM DS_REPORT WHERE REPORT_NAME = N'ucTinhTrangThietbi')
INSERT INTO DS_REPORT(REPORT_NAME,TEN_REPORT_VIET,TEN_REPORT_ANH, LOAI_REPORT,STT,NOTE,NAMES,[TYPE],REPORT_MAIL)
VALUES(N'ucTinhTrangThietbi', N'Danh sách thiết bị theo tình trạng máy',N'List of equipment by status',1,21, N'Danh sách thiết bị theo tình trạng máy','ucTinhTrangThietbi',2,1)

go
IF NOT EXISTS (SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = N'ucTinhTrangThietbi')
INSERT INTO NHOM_REPORT(REPORT_NAME,GROUP_ID,QUYEN)
VALUES(N'ucTinhTrangThietbi', 1,N'Access')
