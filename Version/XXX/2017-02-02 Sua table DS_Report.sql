Update DS_REPORT set TEN_REPORT_VIET = N'Biểu đồ hiệu suất sử dụng theo dây chuyền (Dung cho cty SX day chuyen, phai co ke hoach line)' where REPORT_NAME = 'rptBieuDohieuSuatLine'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'rptBieuDohieuSuatLine'

Update DS_REPORT set TEN_REPORT_VIET = N'Biểu đồ tính chỉ số khả năng sãn sàng theo dây chuyền (Cty SX day chuyen, phai co ke hoach line)' where REPORT_NAME = 'rptBieuDoKhaNangSanSangLine'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'rptBieuDoKhaNangSanSangLine'

Update DS_REPORT set TEN_REPORT_VIET = N'Kế hoạch hiệu chuẩn kiểm định năm (Bia Bac lieu - Co the chua dung, can KT truoc khi SD)' where REPORT_NAME = 'ucKeHoachKiemDinhNam'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucKeHoachKiemDinhNam'


Update DS_REPORT set TEN_REPORT_VIET = N'Báo cáo công tác luân chuyển vật tư phụ tùng (chỉ cty có nhiều cty con dùng)' where REPORT_NAME = 'ucLuanChuyenVatTu'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucLuanChuyenVatTu'


Update DS_REPORT set TEN_REPORT_VIET = N'Báo cáo phân tích FSN (Fast - Slow - Nonmoving) (Chỉ cty lớn dùng)' where REPORT_NAME = 'ucFastSlowNonMovingAnalysic'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucFastSlowNonMovingAnalysic'

Update DS_REPORT set TEN_REPORT_VIET = N'Báo cáo số lượng hàng tồn kho an toàn  (Chỉ cty lớn dùng)' where REPORT_NAME = 'ucSafetyStock'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucSafetyStock'


Update DS_REPORT set TEN_REPORT_VIET = N'Thống kê vật tư xuất theo thời gian nhập kho (Chỉ cty lớn dùng)' where REPORT_NAME = 'ucVTXuatTheoNhap'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucVTXuatTheoNhap'


Update DS_REPORT set TEN_REPORT_VIET = N'Danh sách phiếu nhập bị trễ hóa đơn(Chỉ cty lớn dùng)' where REPORT_NAME = 'ucDSPNTreHoaDon'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucDSPNTreHoaDon'

Update DS_REPORT set TEN_REPORT_VIET = N'Danh sách phiếu nhập bị trễ hóa đơn(Chỉ cty lớn dùng)' where REPORT_NAME = 'ucDSPNTreHoaDon'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucDSPNTreHoaDon'


Update DS_REPORT set TEN_REPORT_VIET = N'Báo cáo tồn kho theo phiếu nhập (Thay thế bằng chức năng tìm kiếm)' where REPORT_NAME = 'rptTON_KHO_THEO_PHIEU_NHAP'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'rptTON_KHO_THEO_PHIEU_NHAP'


Update DS_REPORT set TEN_REPORT_VIET = N'Báo cáo tồn kho dùng khi kiểm kê kho' where REPORT_NAME = 'rptKiemKeVT_PT'
Update DS_REPORT set TEN_REPORT_ANH = N'Inventory report used for physical counting' where REPORT_NAME = 'rptKiemKeVT_PT'

Update DS_REPORT set TEN_REPORT_VIET = N'DS phụ tùng không sử dụng để thay thế cho máy trên PBT' where REPORT_NAME = 'rptucVTKhongThayThe'
Update DS_REPORT set TEN_REPORT_ANH = N'List of spare parts not used for replacement in WO' where REPORT_NAME = 'rptucVTKhongThayThe'
Update DS_REPORT set NOTE = N'Danh sách vật tư KHÔNG được sử dụng trên Phiếu bảo trì, kể từ ngày (nhập trên form) cho đến ngày hiện tại trên các phiếu bảo trì với tất cả tình trạng (bao gồm cả Đang soạn và Đang thực hiện). Xuất dữ liệu ra form, sau đó, có thể lọc, sort rồi xuất ra Excel ' where REPORT_NAME = 'rptucVTKhongThayThe'

Update DS_REPORT set TEN_REPORT_ANH = N'List of issued items' where REPORT_NAME = 'rptVAT_TU_XUAT_KHO'
Update DS_REPORT set NOTE = N'Thống kê số lượng các vật tư phụ tùng xuất kho trong khoảng thời gian được chọn với các giá trị: Mã vật tư, tên vật tư, số lượng, đơn giá, thành tiền và nhiều thông tin khác. Báo cáo Excel' where REPORT_NAME = 'rptVAT_TU_XUAT_KHO'

Update DS_REPORT set TEN_REPORT_VIET = N'Danh sách vật tư không xuất kho' where REPORT_NAME = 'rptucVTKhongXuatKho'

Update DS_REPORT set TEN_REPORT_VIET = N'DS các công việc bảo trì trong khoảg thời gian (KHTT, PBT, CV VP)' where REPORT_NAME = 'ucKeHoachCongViecBaoTri'

Update DS_REPORT set TEN_REPORT_VIET = N'Dự toán vật tư chi tiết' where REPORT_NAME = 'ucDeXuatVatTu'
Update DS_REPORT set TEN_REPORT_ANH = N'Consumption plan by department' where REPORT_NAME = 'ucDeXuatVatTu'
Update DS_REPORT set NOTE = N'Danh sách chi tiết các vật tư phụ tùng do từng phòng ban yêu cầu (Lấy từ Đề xuất mua hàng) bao gồm SL tồn kho, SL đề xuất, SL được duyệt theo đơn vị, phòng ban trong khoảng thời gian được chọn' where REPORT_NAME = 'ucDeXuatVatTu'


Update DS_REPORT set TEN_REPORT_VIET = N'Dự toán kinh phí mua vật tư cho nhà máy' where REPORT_NAME = 'ucDuToanTheoDonVi'
Update DS_REPORT set TEN_REPORT_ANH = N'Planned budget for material purchase by factory' where REPORT_NAME = 'ucDuToanTheoDonVi'
Update DS_REPORT set NOTE = N'Dự toán kinh phí mua vật tư cho toàn Nhà máy theo loại vật tư. Bao gồm chi phí dự toán cho từng phòng ban (Lấy từ Đề xuất mua hàng). Chỉ bao gồm kinh phí chứ không có số lượng' where REPORT_NAME = 'ucDuToanTheoDonVi'


--- Chuyển loại báo cáo 

Update DS_REPORT set LOAI_REPORT = 3 where REPORT_NAME = 'frmBCLSTB_Antoan'
Update DS_REPORT set LOAI_REPORT = 3 where REPORT_NAME = 'rptucVTKhongThayThe'

Update DS_REPORT set LOAI_REPORT = 93 where REPORT_NAME = 'rptThongKeThoiGianNgungMay'




-- Sắp xếp lại thứ tự các báo cáo 
-- Module Bao tri 

Update DS_REPORT set STT = 1 where REPORT_NAME = 'ucBaoCaoPhieuCongViec'
Update DS_REPORT set STT = 2 where REPORT_NAME = 'ucKeHoachCongViecBaoTri'
Update DS_REPORT set STT = 3 where REPORT_NAME = 'ucKeHoachBTTuan'
Update DS_REPORT set STT = 4 where REPORT_NAME = 'ucDanhSachPBT'
Update DS_REPORT set STT = 5 where REPORT_NAME = 'ucMaintainMonth'
Update DS_REPORT set STT = 6 where REPORT_NAME = 'UCKeHoachBT_Thang'
Update DS_REPORT set STT = 7 where REPORT_NAME = 'ucDSBaoTri'
Update DS_REPORT set STT = 8 where REPORT_NAME = 'ucBaoCaoCongViecBaoTri'
Update DS_REPORT set STT = 9 where REPORT_NAME = 'rptDANH_SACH_VAT_TU_DE_BAO_TRI_TB'
Update DS_REPORT set STT = 10 where REPORT_NAME = 'ucDanhSachVTPT'
Update DS_REPORT set STT = 11 where REPORT_NAME = 'rptucVTKhongThayThe'
Update DS_REPORT set STT = 12 where REPORT_NAME = 'frmBCLSTB_Antoan'
Update DS_REPORT set STT = 13 where REPORT_NAME = 'rptDANH_SACH_PHIEU_BAO_TRI_THEO_NGAY_CUOI'
Update DS_REPORT set STT = 14 where REPORT_NAME = 'rptDANH_GIA_DICH_VU_KH'

-- Module Quan ly kho 

Update DS_REPORT set STT = 1 where REPORT_NAME = 'rptDanhSachPhieuNhap'
Update DS_REPORT set STT = 2 where REPORT_NAME = 'rptDanhSachPhieuXuatKho'
Update DS_REPORT set STT = 4 where REPORT_NAME = 'ucVatTuDeXuatChuaNhapKho'
Update DS_REPORT set STT = 5 where REPORT_NAME = 'rptTheKho'
Update DS_REPORT set STT = 10 where REPORT_NAME = 'ListStockReport'
Update DS_REPORT set STT = 15 where REPORT_NAME = 'rptKiemKeVT_PT'
Update DS_REPORT set STT = 16 where REPORT_NAME = 'rptPhanTichGiaTriTonKho'
Update DS_REPORT set STT = 17 where REPORT_NAME = 'ucDeXuatVatTu'
Update DS_REPORT set STT = 18 where REPORT_NAME = 'ucDuToanTheoDonVi'
Update DS_REPORT set STT = 20 where REPORT_NAME = 'rptucVTKhongXuatKho'
Update DS_REPORT set STT = 19 where REPORT_NAME = 'rptVAT_TU_XUAT_KHO'
Update DS_REPORT set STT = 25 where REPORT_NAME = 'rptPHU_TUNG_DUOC_CUNG_CAP_BOI_CTY'
Update DS_REPORT set STT = 26 where REPORT_NAME = 'rptCTY_DA_CUNG_CAP_VAT_TU'
Update DS_REPORT set STT = 27 where REPORT_NAME = 'rptDANH_GIA_NCC'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'rptTON_KHO_THEO_PHIEU_NHAP'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucDSPNTreHoaDon'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucFastSlowNonMovingAnalysic'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucLuanChuyenVatTu'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucSafetyStock'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucVTXuatTheoNhap'

-- Hieu chuan va kiem dinh 

Update DS_REPORT set STT = 1 where REPORT_NAME = 'ucBaoCaoHieuChuanKiemDinh'
Update DS_REPORT set STT = 2 where REPORT_NAME = 'ucHCKD'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'ucKeHoachKiemDinhNam'

-- Chi phí bảo trì 


Update DS_REPORT set STT = 2 where REPORT_NAME = 'ucBieuDoChiPhiTheoNX'
Update DS_REPORT set STT = 3 where REPORT_NAME = 'ucBieuDoChiPhiTheoNXThang'
Update DS_REPORT set STT = 4 where REPORT_NAME = 'ucBieuDoChiPhiTheoTB'
Update DS_REPORT set STT = 5 where REPORT_NAME = 'ucBieuDoChiPhiTheoThang'
Update DS_REPORT set STT = 7 where REPORT_NAME = 'rptCHI_PHI_BAO_TRI_THEO_BPCP'
Update DS_REPORT set STT = 6 where REPORT_NAME = 'rptPhanTichChiPhi_DUYTAN'

-- Thời gian ngừng máy 
Update DS_REPORT set STT = 1 where REPORT_NAME = 'ucBieuDoTGNMayTheoNX'
Update DS_REPORT set STT = 2 where REPORT_NAME = 'ucBieuDoTGNMayTheoNXThang'
Update DS_REPORT set STT = 3 where REPORT_NAME = 'ucBieuDoTGNMayTheoMay'
Update DS_REPORT set STT = 4 where REPORT_NAME = 'ucBieuDoTGNMayTheoThang'
Update DS_REPORT set STT = 5 where REPORT_NAME = 'ucMTTRMTBF'
Update DS_REPORT set STT = 6 where REPORT_NAME = 'rptHieuSuatSuDungMay'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'rptTHOI_GIAN_NGUNG_MAY_THEO_NGUYEN_NHAN'
Update DS_REPORT set STT = 8 where REPORT_NAME = 'ucBCTHThoiGianNgungMay'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'rptThongKeThoiGianNgungMay'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'rptBieuDohieuSuatLine'
Update DS_REPORT set STT = 101 where REPORT_NAME = 'rptBieuDoKhaNangSanSangLine'




	








