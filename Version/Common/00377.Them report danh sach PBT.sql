--Khi muon insert them 1 report vdu report "ucKeHoachBaoTriNamVH" thi ma hoa ra rui dem vao key
DECLARE @Report nvarchar(500)
set @Report = N'ήΊ͌ΆΠΔͪΆΊΔ͈ͤͬ'

IF NOT EXISTS (SELECT * FROM LIC_REPORT WHERE REPORT_NAME = @Report)
INSERT INTO LIC_REPORT (REPORT_NAME,TYPE_LIC) VALUES ( @Report,N'̦')
	
GO

IF NOT EXISTS (SELECT * FROM DS_REPORT WHERE REPORT_NAME = N'ucDanhSachPBT')
INSERT INTO DS_REPORT(REPORT_NAME,TEN_REPORT_VIET,TEN_REPORT_ANH, LOAI_REPORT,STT,NOTE,NAMES,[TYPE],REPORT_MAIL)
VALUES(N'ucDanhSachPBT', N'Danh sách phiếu bảo trì',N'List of work orders',3,3,N'','ucDanhSachPBT',2,1)

go
IF NOT EXISTS (SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = N'ucDanhSachPBT')
INSERT INTO NHOM_REPORT(REPORT_NAME,GROUP_ID,QUYEN)
VALUES(N'ucDanhSachPBT', 1,N'Access')

