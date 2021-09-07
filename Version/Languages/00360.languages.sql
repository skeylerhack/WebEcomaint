IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD =N'TONG_THOI_GIAN') UPDATE LANGUAGES SET VIETNAM=N'Tổng số phút KH', ENGLISH=N'Total hours plan', VIETNAM_OR=N'Tổng số phút KH', ENGLISH_OR=N'Total hours plan' WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD=N'TONG_THOI_GIAN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmKehoachtongthe_odd',N'TONG_THOI_GIAN',N'Tổng số phút KH',N'Total hours plan',N'Tổng số phút KH',N'Total hours plan')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD =N'THOI_GIAN_DU_KIEN') UPDATE LANGUAGES SET VIETNAM=N'Số phút KH', ENGLISH=N'Plan time', VIETNAM_OR=N'Số phút KH', ENGLISH_OR=N'Plan time' WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD=N'THOI_GIAN_DU_KIEN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmKehoachtongthe_odd',N'THOI_GIAN_DU_KIEN',N'Số phút KH',N'Plan time',N'Số phút KH',N'Plan time')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuNhapKho_New' AND KEYWORD =N'TONG_CP') UPDATE LANGUAGES SET VIETNAM=N'Tổng phí (VNĐ)', ENGLISH=N'Total fee (VND)', VIETNAM_OR=N'Tổng phí (VNĐ)', ENGLISH_OR=N'Total fee (VND)' WHERE FORM=N'frmPhieuNhapKho_New' AND KEYWORD=N'TONG_CP' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuNhapKho_New',N'TONG_CP',N'Tổng phí (VNĐ)',N'Total fee (VND)',N'Tổng phí (VNĐ)',N'Total fee (VND)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuNhapKho_New' AND KEYWORD =N'TT_TAX') UPDATE LANGUAGES SET VIETNAM=N'Tiền thuế (VNĐ)', ENGLISH=N'TAT amount (VND)', VIETNAM_OR=N'Tiền thuế (VNĐ)', ENGLISH_OR=N'TAT amount (VND)' WHERE FORM=N'frmPhieuNhapKho_New' AND KEYWORD=N'TT_TAX' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuNhapKho_New',N'TT_TAX',N'Tiền thuế (VNĐ)',N'TAT amount (VND)',N'Tiền thuế (VNĐ)',N'TAT amount (VND)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD =N'msgCoTren2MayHayNgayKiemTra') UPDATE LANGUAGES SET VIETNAM=N'Bạn chỉ có thể chọn 1 máy và 1 ngày giám sát để khai báo việc xử lý ', ENGLISH=N'Can only choose one equipment and one CM date for processing', VIETNAM_OR=N'Bạn chỉ có thể chọn 1 máy và 1 ngày giám sát để khai báo việc xử lý ', ENGLISH_OR=N'Can only choose one equipment and one CM date for processing' WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD=N'msgCoTren2MayHayNgayKiemTra' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmKehoachtongthe_odd',N'msgCoTren2MayHayNgayKiemTra',N'Bạn chỉ có thể chọn 1 máy và 1 ngày giám sát để khai báo việc xử lý ',N'Can only choose one equipment and one CM date for processing',N'Bạn chỉ có thể chọn 1 máy và 1 ngày giám sát để khai báo việc xử lý ',N'Can only choose one equipment and one CM date for processing')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonThucHienGSTT' AND KEYWORD =N'frmChonThucHienGSTT') UPDATE LANGUAGES SET VIETNAM=N'Xác nhận việc xử lý các thông số GSTT không đạt', ENGLISH=N'Confirm processing failed CM parameters?', VIETNAM_OR=N'Xác nhận việc xử lý các thông số GSTT không đạt', ENGLISH_OR=N'Confirm processing failed CM parameters?' WHERE FORM=N'frmChonThucHienGSTT' AND KEYWORD=N'frmChonThucHienGSTT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmChonThucHienGSTT',N'frmChonThucHienGSTT',N'Xác nhận việc xử lý các thông số GSTT không đạt',N'Confirm processing failed CM parameters?',N'Xác nhận việc xử lý các thông số GSTT không đạt',N'Confirm processing failed CM parameters?')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD =N'MS_CONG_NHAN') UPDATE LANGUAGES SET VIETNAM=N'Người xác nhận', ENGLISH=N'Confirmer', VIETNAM_OR=N'Người xác nhận', ENGLISH_OR=N'Confirmer' WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD=N'MS_CONG_NHAN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmKehoachtongthe_odd',N'MS_CONG_NHAN',N'Người xác nhận',N'Confirmer',N'Người xác nhận',N'Confirmer')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD =N'TG_XU_LY') UPDATE LANGUAGES SET VIETNAM=N'Ngày xử lý', ENGLISH=N'Resolve time', VIETNAM_OR=N'Ngày xử lý', ENGLISH_OR=N'Resolve time' WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD=N'TG_XU_LY' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmKehoachtongthe_odd',N'TG_XU_LY',N'Ngày xử lý',N'Resolve time',N'Ngày xử lý',N'Resolve time')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucBieuDoTGNMayTheoNXThang' AND KEYWORD =N'TieuDeNNThang') UPDATE LANGUAGES SET VIETNAM=N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY THEO THÁNG', ENGLISH=N'DOWNTIME CHART FOR MONTHS', VIETNAM_OR=N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY THEO THÁNG', ENGLISH_OR=N'DOWNTIME CHART FOR MONTHS' WHERE FORM=N'ucBieuDoTGNMayTheoNXThang' AND KEYWORD=N'TieuDeNNThang' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'ucBieuDoTGNMayTheoNXThang',N'TieuDeNNThang',N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY THEO THÁNG',N'DOWNTIME CHART FOR MONTHS',N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY THEO THÁNG',N'DOWNTIME CHART FOR MONTHS')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucBieuDoTGNMayTheoMay' AND KEYWORD =N'TDTGNM') UPDATE LANGUAGES SET VIETNAM=N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY', ENGLISH=N'DOWNTIME CHART', VIETNAM_OR=N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY', ENGLISH_OR=N'DOWNTIME CHART' WHERE FORM=N'ucBieuDoTGNMayTheoMay' AND KEYWORD=N'TDTGNM' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'ucBieuDoTGNMayTheoMay',N'TDTGNM',N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY',N'DOWNTIME CHART',N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY',N'DOWNTIME CHART')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucBieuDoTGNMayTheoMay' AND KEYWORD =N'TieuDeTGNM') UPDATE LANGUAGES SET VIETNAM=N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY', ENGLISH=N'DOWNTIME CHART', VIETNAM_OR=N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY', ENGLISH_OR=N'DOWNTIME CHART' WHERE FORM=N'ucBieuDoTGNMayTheoMay' AND KEYWORD=N'TieuDeTGNM' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'ucBieuDoTGNMayTheoMay',N'TieuDeTGNM',N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY',N'DOWNTIME CHART',N'BIỂU ĐỒ THỜI GIAN NGỪNG MÁY',N'DOWNTIME CHART')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD =N'ChuyenTuBTPN') UPDATE LANGUAGES SET VIETNAM=N'Chuyển từ BTPN ', ENGLISH=N'From PM', VIETNAM_OR=N'Chuyển từ BTPN ', ENGLISH_OR=N'From PM' WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD=N'ChuyenTuBTPN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmKehoachtongthe_odd',N'ChuyenTuBTPN',N'Chuyển từ BTPN ',N'From PM',N'Chuyển từ BTPN ',N'From PM')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucBCHieuChuanKiemDinh' AND KEYWORD =N'bcKeHoach') UPDATE LANGUAGES SET VIETNAM=N'Kế hoạch', ENGLISH=N'Plan', VIETNAM_OR=N'Kế hoạch', ENGLISH_OR=N'Plan' WHERE FORM=N'ucBCHieuChuanKiemDinh' AND KEYWORD=N'bcKeHoach' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'ucBCHieuChuanKiemDinh',N'bcKeHoach',N'Kế hoạch',N'Plan',N'Kế hoạch',N'Plan')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDanhmucto' AND KEYWORD =N'MA_TO') UPDATE LANGUAGES SET VIETNAM=N'Mã viết tắt', ENGLISH=N'Mã viết tắt', VIETNAM_OR=N'Mã viết tắt', ENGLISH_OR=N'Mã viết tắt' WHERE FORM=N'frmDanhmucto' AND KEYWORD=N'MA_TO' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDanhmucto',N'MA_TO',N'Mã viết tắt',N'Mã viết tắt',N'Mã viết tắt',N'Mã viết tắt')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDonDatHang' AND KEYWORD =N'msgSoDonHangTonTai') UPDATE LANGUAGES SET VIETNAM=N'Số đơn hàng tồn tại', ENGLISH=N'PO No', VIETNAM_OR=N'Số đơn hàng tồn tại', ENGLISH_OR=N'PO No' WHERE FORM=N'frmDonDatHang' AND KEYWORD=N'msgSoDonHangTonTai' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDonDatHang',N'msgSoDonHangTonTai',N'Số đơn hàng tồn tại',N'PO No',N'Số đơn hàng tồn tại',N'PO No')
