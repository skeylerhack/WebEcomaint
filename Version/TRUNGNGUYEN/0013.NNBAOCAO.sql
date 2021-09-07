--Theo dõi tiến độ hiệu chuẩn và kiểm định theo năm 
UPDATE  dbo.DS_REPORT
SET TEN_REPORT_VIET =N'Theo dõi tiến độ hiệu chuẩn và kiểm định theo năm'
WHERE TEN_REPORT_VIET =N'Lịch hiệu chuẩn và kiểm định theo năm'

--Theo dõi tiến độ giám sát tình trạng theo năm
UPDATE dbo.DS_REPORT
SET TEN_REPORT_VIET =N'Theo dõi tiến độ giám sát tình trạng theo năm'
WHERE TEN_REPORT_VIET =N'Lịch giám sát tình trạng theo năm'

--Chưa nhập -> Chưa mua, Nhập chưa đủ -> Mua chưa đủ, Đã nhập đủ -> Hoàn thành.
UPDATE dbo.TRANG_THAI_DX SET TEN_TT = N'Chưa mua' WHERE MS_TT = 0
UPDATE dbo.TRANG_THAI_DX SET TEN_TT = N'Mua chưa đủ' WHERE MS_TT = 1
UPDATE dbo.TRANG_THAI_DX SET TEN_TT = N'Hoàn thành' WHERE MS_TT = 2