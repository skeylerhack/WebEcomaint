
DECLARE @Report nvarchar(500)
set @Report = N'ήΊ͈͊ͬΔ΢Ζ͒ΖΆΠ͊Ͱ͠ΔΆΠͰΖΎΠ'

IF NOT EXISTS (SELECT * FROM LIC_REPORT WHERE REPORT_NAME = @Report)
INSERT INTO LIC_REPORT (REPORT_NAME,TYPE_LIC) VALUES ( @Report,N'̦')
	
GO

IF NOT EXISTS (SELECT * FROM DS_REPORT WHERE REPORT_NAME = N'ucBCThoiGianCVNhanVien')
INSERT INTO DS_REPORT(REPORT_NAME,TEN_REPORT_VIET,TEN_REPORT_ANH, LOAI_REPORT,STT,NOTE,NAMES,[TYPE],REPORT_MAIL)
VALUES(N'ucBCThoiGianCVNhanVien', N'Tổng hợp công nhân viên',N'Total hours worked by employees',7,1, N'Total hours worked by employees','ucBCThoiGianCVNhanVien',1,1)

go
IF NOT EXISTS (SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = N'ucBCThoiGianCVNhanVien')
INSERT INTO NHOM_REPORT(REPORT_NAME,GROUP_ID,QUYEN)
VALUES(N'ucBCThoiGianCVNhanVien', 1,N'Access')


