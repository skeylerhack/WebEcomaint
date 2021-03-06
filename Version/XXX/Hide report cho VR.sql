
-- Báo cáo Biểu mẫu ghi nhận kết quả thực hiện bảo trì theo tuần
Update DS_REPORT set STT = 150 where REPORT_NAME = 'ucKeHoachTuan'

-- Báo cáo Lịch bảo trì định kỳ năm chi tiết theo từng công việc

Update DS_REPORT set STT = 150 where REPORT_NAME = 'UCKeHoachBT_Nam'

---Lịch bảo trì định kỳ theo năm in theo máy

Update DS_REPORT set STT = 150 where REPORT_NAME = 'ucKHBDThietBi'

--- Báo cáo Lịch bảo trì định kỳ trong tuần

Update DS_REPORT set STT = 150 where REPORT_NAME = 'rptKeHoachBaoTriTrongTuan'

-- Sua ten bao cao Lich bao tri dinh ky thang 

Update DS_REPORT set  TEN_REPORT_VIET = N'Lịch bảo trì định kỳ' where REPORT_NAME = 'ucMaintainMonth'


--Sửa ngôn ngữ cho báo cáo kho 


Update dbo.DS_REPORT set NOTE = N'Dự toán vật tư chi tiết theo đơn vị, phòng ban. Dữ liệu được lấy từ các đề xuất mua hàng của từng phòng ban trong khoảng thời gian được chọn' where REPORT_NAME =N'ucDeXuatVatTu'
Update dbo.DS_REPORT set TEN_REPORT_VIET = N'Danh sách vật tư phụ tùng đã xuất kho' where REPORT_NAME =N'rptVAT_TU_XUAT_KHO'
Update dbo.DS_REPORT set TEN_REPORT_ANH = N'List of items issued by warehouse' where REPORT_NAME =N'rptVAT_TU_XUAT_KHO'

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'rptVAT_TU_XUAT_KHO' AND KEYWORD =N' TEN_REPORT') UPDATE LANGUAGES SET VIETNAM=N'DANH SÁCH VẬT TƯ PHỤ TÙNG ĐÃ XUẤT KHO', ENGLISH=N'ISSUED MATERIAL AND SPARE PART REPORT', VIETNAM_OR=N'DANH SÁCH VẬT TƯ PHỤ TÙNG ĐÃ XUẤT KHO', ENGLISH_OR=N'ISSUED MATERIAL AND SPARE PART REPORT' WHERE FORM=N'rptVAT_TU_XUAT_KHO' AND KEYWORD=N' TEN_REPORT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'rptVAT_TU_XUAT_KHO',N' TEN_REPORT',N'DANH SÁCH VẬT TƯ PHỤ TÙNG ĐÃ XUẤT KHO',N'ISSUED MATERIAL AND SPARE PART REPORT',N'DANH SÁCH VẬT TƯ PHỤ TÙNG ĐÃ XUẤT KHO',N'ISSUED MATERIAL AND SPARE PART REPORT')

Update dbo.DS_REPORT set TEN_REPORT_VIET = N'Báo cáo nhập xuất tồn vật tư phụ tùng theo kho' where REPORT_NAME =N'ListStockReport'
Update dbo.DS_REPORT set TEN_REPORT_ANH = N'Inventory transaction report by warehouse' where REPORT_NAME =N'ListStockReport'


IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDeXuatVatTu' AND KEYWORD =N'TieuDe') UPDATE LANGUAGES SET VIETNAM=N'ĐỀ XUẤT MUA VẬT TƯ', ENGLISH=N'MATERIAL PURCHASE REQUEST', VIETNAM_OR=N'ĐỀ XUẤT MUA VẬT TƯ', ENGLISH_OR=N'MATERIAL PURCHASE REQUEST' WHERE FORM=N'ucDeXuatVatTu' AND KEYWORD=N'TieuDe' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'ucDeXuatVatTu',N'TieuDe',N'ĐỀ XUẤT MUA VẬT TƯ',N'MATERIAL PURCHASE REQUEST',N'ĐỀ XUẤT MUA VẬT TƯ',N'MATERIAL PURCHASE REQUEST')

Update dbo.DS_REPORT set TEN_REPORT_VIET = N'Dự toán vật tư chi tiết (Đề xuất mua vật tư)' where REPORT_NAME =N'ucDeXuatVatTu'
Update dbo.DS_REPORT set TEN_REPORT_ANH = N'Consumption plan by department (Purchase request' where REPORT_NAME =N'ucDeXuatVatTu'

Update dbo.DS_REPORT set NOTE = N'Báo cáo nhập xuất tồn lọc theo loại VTPT bao gồm các thông tin:Số lượng và giá trị đầu kỳ, số lượng và giá trị nhập trong kỳ, số lượng và giá trị xuất trong kỳ (phân theo từng bộ phận chịu phí), số lượng và giá trị còn lại cuối kỳ. Báo cáo dạng Excel' where REPORT_NAME =N'ucBangKeXNTKhoChinh'



