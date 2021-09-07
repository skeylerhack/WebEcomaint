--Khi muon insert them 1 report vdu report "ucGSTTDinhKy" thi ma hoa ra rui dem vao key
--rptDanhsach_NCC	Danh sách nhà cung cấp	List of suppliers	NULL	0	2	Chung	Liệt kê danh sách và thông tin của tất cả nhà cung cấp có trong hệ thống.	NULL	Thông tin khởi tạo	frmrptDanhsach_NCC	2	1
DECLARE @Report nvarchar(500)
DECLARE @Report1 nvarchar(500)
DECLARE @LoaiRP INT
SET @LoaiRP = 0
SET @Report1 = N'rptDanhsach_NCC'

set @Report = N'ΨΤά͌ΆΠΔΪΆΊΔ΂͊͊͠'


IF NOT EXISTS (SELECT * FROM LIC_REPORT WHERE REPORT_NAME = @Report)
INSERT INTO LIC_REPORT (REPORT_NAME,TYPE_LIC) VALUES ( @Report,N'̦')
	
	--SELECT * FROM dbo.DS_REPORT WHERE LOAI_REPORT = 0 AND STT<100

IF NOT EXISTS (SELECT * FROM DS_REPORT WHERE REPORT_NAME =  N'rptDanhsach_NCC')
INSERT INTO DS_REPORT(REPORT_NAME,TEN_REPORT_VIET,TEN_REPORT_ANH, LOAI_REPORT,STT,NOTE,NAMES,[TYPE],REPORT_MAIL)
VALUES(@Report1, N'Danh sách nhà cung cấp',N'List of suppliers',@LoaiRP,
(SELECT ISNULL(MAX(STT),0) + 1 FROM DS_REPORT WHERE LOAI_REPORT = @LoaiRP AND	STT < 100)
,N'Liệt kê danh sách và thông tin của tất cả nhà cung cấp có trong hệ thống.',@Report1,1,1)


IF NOT EXISTS (SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = @Report1)
INSERT INTO NHOM_REPORT(REPORT_NAME,GROUP_ID,QUYEN)
VALUES(@Report1, 1,N'Access')

