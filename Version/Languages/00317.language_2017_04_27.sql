﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuHyperLinkAddCV') UPDATE LANGUAGES SET VIETNAM=N'Thêm công việc', ENGLISH=N'Add work', VIETNAM_OR=N'Thêm công việc', ENGLISH_OR=N'Add work' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuHyperLinkAddCV' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuHyperLinkAddCV',N'Thêm công việc',N'Add work',N'Thêm công việc',N'Add work')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThemCongViec' AND KEYWORD =N'frmThemCongViec') UPDATE LANGUAGES SET VIETNAM=N'Thêm công việc', ENGLISH=N'Add work', VIETNAM_OR=N'Thêm công việc', ENGLISH_OR=N'Add work' WHERE FORM=N'frmThemCongViec' AND KEYWORD=N'frmThemCongViec' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThemCongViec',N'frmThemCongViec',N'Thêm công việc',N'Add work',N'Thêm công việc',N'Add work')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThemCongViec' AND KEYWORD =N'lblMoTaCV') UPDATE LANGUAGES SET VIETNAM=N'Mô tả CV', ENGLISH=N'Work Desc.', VIETNAM_OR=N'Mô tả CV', ENGLISH_OR=N'Work Desc.' WHERE FORM=N'frmThemCongViec' AND KEYWORD=N'lblMoTaCV' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThemCongViec',N'lblMoTaCV',N'Mô tả CV',N'Work Desc.',N'Mô tả CV',N'Work Desc.')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThemCongViec' AND KEYWORD =N'lblLCViec') UPDATE LANGUAGES SET VIETNAM=N'Loại công việc', ENGLISH=N'Work type', VIETNAM_OR=N'Loại công việc', ENGLISH_OR=N'Work type' WHERE FORM=N'frmThemCongViec' AND KEYWORD=N'lblLCViec' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThemCongViec',N'lblLCViec',N'Loại công việc',N'Work type',N'Loại công việc',N'Work type')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThemCongViec' AND KEYWORD =N'lblTGianChuan') UPDATE LANGUAGES SET VIETNAM=N'Thời gian chuẩn', ENGLISH=N'Standard time', VIETNAM_OR=N'Thời gian chuẩn', ENGLISH_OR=N'Standard time' WHERE FORM=N'frmThemCongViec' AND KEYWORD=N'lblTGianChuan' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThemCongViec',N'lblTGianChuan',N'Thời gian chuẩn',N'Standard time',N'Thời gian chuẩn',N'Standard time')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBophanchiuphi' AND KEYWORD =N'msgMaSoBPCPDaTonTai') UPDATE LANGUAGES SET VIETNAM=N'Mã BPCP đã tồn tại!', ENGLISH=N'Cost center ID already exists!', VIETNAM_OR=N'Mã BPCP đã tồn tại!', ENGLISH_OR=N'Cost center ID already exists!' WHERE FORM=N'frmBophanchiuphi' AND KEYWORD=N'msgMaSoBPCPDaTonTai' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBophanchiuphi',N'msgMaSoBPCPDaTonTai',N'Mã BPCP đã tồn tại!',N'Cost center ID already exists!',N'Mã BPCP đã tồn tại!',N'Cost center ID already exists!')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuNhapKho_New' AND KEYWORD =N'MsgDONGIAGOCNULL') UPDATE LANGUAGES SET VIETNAM=N'Đơn giá gốc không được để trống!', ENGLISH=N'Unit price cannot be empty!', VIETNAM_OR=N'Đơn giá gốc không được để trống!', ENGLISH_OR=N'Unit price cannot be empty!' WHERE FORM=N'frmPhieuNhapKho_New' AND KEYWORD=N'MsgDONGIAGOCNULL' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuNhapKho_New',N'MsgDONGIAGOCNULL',N'Đơn giá gốc không được để trống!',N'Unit price cannot be empty!',N'Đơn giá gốc không được để trống!',N'Unit price cannot be empty!')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThongtinthietbi' AND KEYWORD =N'Msg_edit_giatri') UPDATE LANGUAGES SET VIETNAM=N'Vui lòng sửa giá trị!', ENGLISH=N'Please edit value!', VIETNAM_OR=N'Vui lòng sửa giá trị!', ENGLISH_OR=N'Please edit value!' WHERE FORM=N'frmThongtinthietbi' AND KEYWORD=N'Msg_edit_giatri' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThongtinthietbi',N'Msg_edit_giatri',N'Vui lòng sửa giá trị!',N'Please edit value!',N'Vui lòng sửa giá trị!',N'Please edit value!')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmTaiLieu' AND KEYWORD =N'msgPhaiChonTo') UPDATE LANGUAGES SET VIETNAM=N'Vui lòng chọn tổ!', ENGLISH=N'Please select department!', VIETNAM_OR=N'Vui lòng chọn tổ!', ENGLISH_OR=N'Please select department!' WHERE FORM=N'frmTaiLieu' AND KEYWORD=N'msgPhaiChonTo' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmTaiLieu',N'msgPhaiChonTo',N'Vui lòng chọn tổ!',N'Please select department!',N'Vui lòng chọn tổ!',N'Please select department!')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmTaiLieu' AND KEYWORD =N'msgPhaiChonQT') UPDATE LANGUAGES SET VIETNAM=N'Vui lòng chọn quy trình!', ENGLISH=N'Please select procedure!', VIETNAM_OR=N'Vui lòng chọn quy trình!', ENGLISH_OR=N'Please select procedure!' WHERE FORM=N'frmTaiLieu' AND KEYWORD=N'msgPhaiChonQT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmTaiLieu',N'msgPhaiChonQT',N'Vui lòng chọn quy trình!',N'Please select procedure!',N'Vui lòng chọn quy trình!',N'Please select procedure!')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmTaiLieu' AND KEYWORD =N'msgUserdatontai') UPDATE LANGUAGES SET VIETNAM=N'User đã tồn tại!', ENGLISH=N'User already exists!', VIETNAM_OR=N'User đã tồn tại!', ENGLISH_OR=N'User already exists!' WHERE FORM=N'frmTaiLieu' AND KEYWORD=N'msgUserdatontai' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmTaiLieu',N'msgUserdatontai',N'User đã tồn tại!',N'User already exists!',N'User đã tồn tại!',N'User already exists!')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmTaiLieu' AND KEYWORD =N'msgMacDinhKhongDuocChonTo') UPDATE LANGUAGES SET VIETNAM=N'Mặc định không được chọn Tổ', ENGLISH=N'Cannot choose Department when choosing default', VIETNAM_OR=N'Mặc định không được chọn Tổ', ENGLISH_OR=N'Cannot choose Department when choosing default' WHERE FORM=N'frmTaiLieu' AND KEYWORD=N'msgMacDinhKhongDuocChonTo' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmTaiLieu',N'msgMacDinhKhongDuocChonTo',N'Mặc định không được chọn Tổ',N'Cannot choose Department when choosing default',N'Mặc định không được chọn Tổ',N'Cannot choose Department when choosing default')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD =N'frmDeXuatMuaHang_New') UPDATE LANGUAGES SET VIETNAM=N'Đề xuất mua hàng', ENGLISH=N'Purchase Request', VIETNAM_OR=N'Đề xuất mua hàng', ENGLISH_OR=N'Purchase Request' WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD=N'frmDeXuatMuaHang_New' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDeXuatMuaHang_New',N'frmDeXuatMuaHang_New',N'Đề xuất mua hàng',N'Purchase Request',N'Đề xuất mua hàng',N'Purchase Request')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuHyperLinkmnuGSTTCNhap') UPDATE LANGUAGES SET VIETNAM=N'Cách giải quyết', ENGLISH=N'Solution', VIETNAM_OR=N'Cách giải quyết', ENGLISH_OR=N'Method to solve' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuHyperLinkmnuGSTTCNhap' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuHyperLinkmnuGSTTCNhap',N'Cách giải quyết',N'Solution',N'Cách giải quyết ',N'Solution')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonThucHienGSTT' AND KEYWORD =N'lblCachThucHien') UPDATE LANGUAGES SET VIETNAM=N'Cách giải quyết', ENGLISH=N'Solution', VIETNAM_OR=N'Cách giải quyết', ENGLISH_OR=N'Solution' WHERE FORM=N'frmChonThucHienGSTT' AND KEYWORD=N'lblCachThucHien' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmChonThucHienGSTT',N'lblCachThucHien',N'Solution',N'Method to solve',N'Cách giải quyết ',N'Solution')


IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmThemCongViec' AND KEYWORD =N'msgChuaNhapThoigianChuanCoMuonTiepTuc') UPDATE LANGUAGES SET VIETNAM=N'Chưa nhập thời gian chuẩn. Bạn có muốn tiếp tục?', ENGLISH=N'Standard time is empty. Do you want to continue? ', VIETNAM_OR=N'Chưa nhập thời gian chuẩn. Bạn có muốn tiếp tục?', ENGLISH_OR=N'Standard time is empty. Do you want to continue? ' WHERE FORM=N'frmThemCongViec' AND KEYWORD=N'msgChuaNhapThoigianChuanCoMuonTiepTuc' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmThemCongViec',N'msgChuaNhapThoigianChuanCoMuonTiepTuc',N'Chưa nhập thời gian chuẩn. Bạn có muốn tiếp tục?',N'Standard time is empty. Do you want to continue? ',N'Chưa nhập thời gian chuẩn. Bạn có muốn tiếp tục?',N'Standard time is empty. Do you want to continue? ')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmChonCongViecBoPhan' AND KEYWORD =N'KhongCoLoaiMay') UPDATE LANGUAGES SET VIETNAM=N'Không có loại máy', ENGLISH=N'No eq. type', VIETNAM_OR=N'Không có loại máy', ENGLISH_OR=N'No eq. type' WHERE FORM=N'FrmChonCongViecBoPhan' AND KEYWORD=N'KhongCoLoaiMay' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'FrmChonCongViecBoPhan',N'KhongCoLoaiMay',N'Không có loại máy',N'No eq. type',N'Không có loại máy',N'No eq. type')