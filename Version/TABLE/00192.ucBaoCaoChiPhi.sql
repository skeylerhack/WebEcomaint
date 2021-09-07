



--Khi muon insert them 1 report vdu report "ucBaoCaoChiPhi" thi ma hoa ra rui dem vao key
--SELECT * FROM dbo.LOAI_REPORT
DECLARE @Report nvarchar(500)
DECLARE @Report1 nvarchar(500)
DECLARE @LoaiRP INT
SET @LoaiRP = 9
SET @Report1 = N'ucBaoCaoChiPhi'
set @Report = N'ήΊ͈Ά΢͊Ά΢͊ΔΖͤΔΖ'


IF NOT EXISTS (SELECT * FROM LIC_REPORT WHERE REPORT_NAME = @Report)
INSERT INTO LIC_REPORT (REPORT_NAME,TYPE_LIC) VALUES ( @Report,N'̦')
	
	--Lịch hiệu chuẩn và kiểm định theo năm

IF NOT EXISTS (SELECT * FROM DS_REPORT WHERE REPORT_NAME = @Report1)
INSERT INTO DS_REPORT(REPORT_NAME,TEN_REPORT_VIET,TEN_REPORT_ANH, LOAI_REPORT,STT,NOTE,NAMES,[TYPE],REPORT_MAIL)
VALUES(@Report1, N'Phân tích nhanh CPBT trên form',N'Quick analyzing maintenance cost in form',@LoaiRP,
(SELECT ISNULL(MAX(STT),0) + 1 FROM DS_REPORT WHERE LOAI_REPORT = @LoaiRP AND	STT < 100)
,N'Cho xem chi phí bảo trì theo nhiều cấp trên giao diện form. Từ cấp trên có thể xem chi phí bảo trì chi tiết ở cấp thấp hơn và cuối cùng là chi phí trên từng Phiếu bảo trì. Thích hợp cho việc xem xét, phân tích tìm những đối tượng và nguyên nhân gây ra chi phí bảo trì cao.',@Report1,2,1)


IF NOT EXISTS (SELECT * FROM NHOM_REPORT WHERE REPORT_NAME = @Report1)
INSERT INTO NHOM_REPORT(REPORT_NAME,GROUP_ID,QUYEN)
VALUES(@Report1, 1,N'Access')


UPDATE dbo.DS_REPORT SET STT = STT+ 100 WHERE REPORT_NAME IN ('rptPhanTichChiPhi' ,'rptPhanTichChiPhi_DUYTAN')