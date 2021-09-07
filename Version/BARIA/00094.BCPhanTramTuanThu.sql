--Khi muon insert them 1 report vdu report "ucKeHoachBaoTriNamVH" thi ma hoa ra rui dem vao key
DECLARE @Report nvarchar(500)
set @Report = N'ήΊ͈͊ͤΔΆΠͬΨΆΞͬήΆΠͬΔή͈͚ͬ͌'

IF NOT EXISTS (SELECT * FROM LIC_REPORT WHERE REPORT_NAME = @Report)
INSERT INTO LIC_REPORT (REPORT_NAME,TYPE_LIC) VALUES ( @Report,N'̦')
	
GO
DECLARE @Reports nvarchar(500)
set @Reports = 'ucBCPhanTramTuanThuBTDK'

IF NOT EXISTS (SELECT * FROM DS_REPORT WHERE REPORT_NAME =@Reports)
INSERT INTO DS_REPORT(REPORT_NAME,TEN_REPORT_VIET,TEN_REPORT_ANH, LOAI_REPORT,STT,NOTE,NAMES,[TYPE],REPORT_MAIL)
VALUES(@Reports, N'% tuân thủ lịch bảo trì định kỳ',N'Comply to Periodic Maintenance schedule',3,99,N'',@Reports,2,1)

go
DECLARE @Reports nvarchar(500)
set @Reports = 'ucBCPhanTramTuanThuBTDK'
IF NOT EXISTS (SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = @Reports)
INSERT INTO NHOM_REPORT(REPORT_NAME,GROUP_ID,QUYEN)
VALUES(@Reports, 1,N'Access')



go

DECLARE @Report nvarchar(500)
set @Report = N'ήΊ͈͊ͤΔΆΠͬΨΆΞͬήΆΠͬΔή͒ͪͬͬ'

IF NOT EXISTS (SELECT * FROM LIC_REPORT WHERE REPORT_NAME = @Report)
INSERT INTO LIC_REPORT (REPORT_NAME,TYPE_LIC) VALUES ( @Report,N'̦')
	
GO
DECLARE @Reports nvarchar(500)
set @Reports = 'ucBCPhanTramTuanThuGSTT'

IF NOT EXISTS (SELECT * FROM DS_REPORT WHERE REPORT_NAME = @Reports)
INSERT INTO DS_REPORT(REPORT_NAME,TEN_REPORT_VIET,TEN_REPORT_ANH, LOAI_REPORT,STT,NOTE,NAMES,[TYPE],REPORT_MAIL)
VALUES(@Reports, N'% tuân thủ lịch giám sát tình trạng',N'Comply to Condition Monitoring schedule',8,55,N'',@Reports,2,1)

go
DECLARE @Reports nvarchar(500)
set @Reports = 'ucBCPhanTramTuanThuGSTT'
IF NOT EXISTS (SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = @Reports)
INSERT INTO NHOM_REPORT(REPORT_NAME,GROUP_ID,QUYEN)
VALUES(@Reports, 1,N'Access')




