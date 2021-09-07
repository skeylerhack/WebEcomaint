
DECLARE @Report nvarchar(500)
DECLARE @Report1 nvarchar(500)
DECLARE @Ten nvarchar(500)
DECLARE @TenAnh nvarchar(500)


DECLARE @LoaiRP INT
SET @LoaiRP = 9
SET @Report1 = N'ucBaoCaoChiPhi'
set @Report = N'ήΊ͈Ά΢͊Ά΢͊ΔΖͤΔΖ'
SET @Ten = 'Phân tích nhanh CPBT trên form'
SET @TenAnh = 'Quick analyzing maintenance cost in form'

IF NOT EXISTS (SELECT * FROM DS_REPORT WHERE REPORT_NAME = @Report1)
INSERT INTO DS_REPORT(REPORT_NAME,TEN_REPORT_VIET,TEN_REPORT_ANH, LOAI_REPORT,STT,NOTE,NAMES,[TYPE],REPORT_MAIL)
VALUES(@Report1, @Ten,@TenAnh,@LoaiRP,
(SELECT ISNULL(MAX(STT),0) + 1 FROM DS_REPORT WHERE LOAI_REPORT = 8 AND	STT < 100)
,N'Cho xem chi phí bảo trì theo nhiều cấp trên giao diện form. Từ cấp trên có thể xem chi phí bảo trì chi tiết ở cấp thấp hơn và cuối cùng là chi phí trên từng Phiếu bảo trì. Thích hợp cho việc xem xét, phân tích tìm những đối tượng và nguyên nhân gây ra chi phí bảo trì cao.',@Report1,1,1)

--go
--UPDATE NHOM_REPORT SET	REPORT_NAME = 'ucBaoCaoChiPhi' WHERE REPORT_NAME = 'rptPhanTichChiPhi_DUYTAN'

