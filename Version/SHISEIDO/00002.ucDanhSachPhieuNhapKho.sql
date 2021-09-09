﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'ucDanhSachPhieuNhapKho') UPDATE LANGUAGES SET VIETNAM=N'Phiếu nhập kho', ENGLISH=N'Receipt',CHINESE=N'Receipt', VIETNAM_OR=N'Phiếu nhập kho', ENGLISH_OR=N'Receipt' , CHINESE_OR=N'Receipt' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'ucDanhSachPhieuNhapKho' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'ucDanhSachPhieuNhapKho',N'Phiếu nhập kho',N'Receipt',N'Receipt',N'Phiếu nhập kho',N'Receipt',N'Receipt','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'tdBaoCaoNhapKho') UPDATE LANGUAGES SET VIETNAM=N'BÁO CÁO NHẬP KHO', ENGLISH=N'BÁO CÁO NHẬP KHO',CHINESE=N'BÁO CÁO NHẬP KHO', VIETNAM_OR=N'BÁO CÁO NHẬP KHO', ENGLISH_OR=N'BÁO CÁO NHẬP KHO' , CHINESE_OR=N'BÁO CÁO NHẬP KHO' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'tdBaoCaoNhapKho' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'tdBaoCaoNhapKho',N'BÁO CÁO NHẬP KHO',N'BÁO CÁO NHẬP KHO',N'BÁO CÁO NHẬP KHO',N'BÁO CÁO NHẬP KHO',N'BÁO CÁO NHẬP KHO',N'BÁO CÁO NHẬP KHO','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'MS_DH_NHAP_PT') UPDATE LANGUAGES SET VIETNAM=N'Đơn hàng nhập', ENGLISH=N'Receipt ID',CHINESE=N'Receipt ID', VIETNAM_OR=N'Đơn hàng nhập', ENGLISH_OR=N'Receipt ID' , CHINESE_OR=N'Receipt ID' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'MS_DH_NHAP_PT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'MS_DH_NHAP_PT',N'Đơn hàng nhập',N'Receipt ID',N'Receipt ID',N'Đơn hàng nhập',N'Receipt ID',N'Receipt ID','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'MS_PT') UPDATE LANGUAGES SET VIETNAM=N'Mã VT PT', ENGLISH=N'ITEM ID',CHINESE=N'ITEM ID', VIETNAM_OR=N'Mã VT PT', ENGLISH_OR=N'ITEM ID' , CHINESE_OR=N'ITEM ID' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'MS_PT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'MS_PT',N'Mã VT PT',N'ITEM ID',N'ITEM ID',N'Mã VT PT',N'ITEM ID',N'ITEM ID','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'TEN_PT') UPDATE LANGUAGES SET VIETNAM=N'Tên VTPT', ENGLISH=N'Spare part',CHINESE=N'Spare part', VIETNAM_OR=N'Tên VTPT', ENGLISH_OR=N'Spare part' , CHINESE_OR=N'Spare part' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'TEN_PT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'TEN_PT',N'Tên VTPT',N'Spare part',N'Spare part',N'Tên VTPT',N'Spare part',N'Spare part','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'TEN_LOAI_VT') UPDATE LANGUAGES SET VIETNAM=N'Loại VT PT', ENGLISH=N'Item type',CHINESE=N'Item type', VIETNAM_OR=N'Loại VT PT', ENGLISH_OR=N'Item type' , CHINESE_OR=N'Item type' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'TEN_LOAI_VT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'TEN_LOAI_VT',N'Loại VT PT',N'Item type',N'Item type',N'Loại VT PT',N'Item type',N'Item type','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'TEN_DVT') UPDATE LANGUAGES SET VIETNAM=N'Đơn vị tính', ENGLISH=N'Measure',CHINESE=N'Measure', VIETNAM_OR=N'Đơn vị tính', ENGLISH_OR=N'Measure' , CHINESE_OR=N'Measure' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'TEN_DVT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'TEN_DVT',N'Đơn vị tính',N'Measure',N'Measure',N'Đơn vị tính',N'Measure',N'Measure','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'SL_THUC_NHAP') UPDATE LANGUAGES SET VIETNAM=N'SL thực nhập', ENGLISH=N'Actual Qty',CHINESE=N'Actual Qty', VIETNAM_OR=N'SL thực nhập', ENGLISH_OR=N'Actual Qty' , CHINESE_OR=N'Actual Qty' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'SL_THUC_NHAP' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'SL_THUC_NHAP',N'SL thực nhập',N'Actual Qty',N'Actual Qty',N'SL thực nhập',N'Actual Qty',N'Actual Qty','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'MS_KH') UPDATE LANGUAGES SET VIETNAM=N'Mã NCC', ENGLISH=N'Vendor ID',CHINESE=N'Vendor ID', VIETNAM_OR=N'Mã NCC', ENGLISH_OR=N'Vendor ID' , CHINESE_OR=N'Vendor ID' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'MS_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'MS_KH',N'Mã NCC',N'Vendor ID',N'Vendor ID',N'Mã NCC',N'Vendor ID',N'Vendor ID','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'TEN_RUT_GON') UPDATE LANGUAGES SET VIETNAM=N'Nhà cung cấp', ENGLISH=N'Vendor',CHINESE=N'Vendor', VIETNAM_OR=N'Nhà cung cấp', ENGLISH_OR=N'Vendor' , CHINESE_OR=N'Vendor' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'TEN_RUT_GON' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'TEN_RUT_GON',N'Nhà cung cấp',N'Vendor',N'Vendor',N'Nhà cung cấp',N'Vendor',N'Vendor','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'MS_DDH') UPDATE LANGUAGES SET VIETNAM=N'Đơn hàng', ENGLISH=N'PO',CHINESE=N'PO', VIETNAM_OR=N'Đơn hàng', ENGLISH_OR=N'PO' , CHINESE_OR=N'PO' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'MS_DDH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'MS_DDH',N'Đơn hàng',N'PO',N'PO',N'Đơn hàng',N'PO',N'PO','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'SO_TO_KHAI') UPDATE LANGUAGES SET VIETNAM=N'Số tờ khai', ENGLISH=N'Số tờ khai',CHINESE=N'Số tờ khai', VIETNAM_OR=N'Số tờ khai', ENGLISH_OR=N'Số tờ khai' , CHINESE_OR=N'Số tờ khai' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'SO_TO_KHAI' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'SO_TO_KHAI',N'Số tờ khai',N'Số tờ khai',N'Số tờ khai',N'Số tờ khai',N'Số tờ khai',N'Số tờ khai','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'LE_PHI_HQ') UPDATE LANGUAGES SET VIETNAM=N'Lệ phí HQ', ENGLISH=N'Lệ phí HQ',CHINESE=N'Lệ phí HQ', VIETNAM_OR=N'Lệ phí HQ', ENGLISH_OR=N'Lệ phí HQ' , CHINESE_OR=N'Lệ phí HQ' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'LE_PHI_HQ' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'LE_PHI_HQ',N'Lệ phí HQ',N'Lệ phí HQ',N'Lệ phí HQ',N'Lệ phí HQ',N'Lệ phí HQ',N'Lệ phí HQ','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'XUAT_XU') UPDATE LANGUAGES SET VIETNAM=N'Mục đích sử dụng', ENGLISH=N'Mục đích sử dụng',CHINESE=N'Mục đích sử dụng', VIETNAM_OR=N'Mục đích sử dụng', ENGLISH_OR=N'Mục đích sử dụng' , CHINESE_OR=N'Mục đích sử dụng' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'XUAT_XU' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'XUAT_XU',N'Mục đích sử dụng',N'Mục đích sử dụng',N'Mục đích sử dụng',N'Mục đích sử dụng',N'Mục đích sử dụng',N'Mục đích sử dụng','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'GHI_CHU') UPDATE LANGUAGES SET VIETNAM=N'Ghi chú', ENGLISH=N'Note',CHINESE=N'Note', VIETNAM_OR=N'Ghi chú', ENGLISH_OR=N'Note' , CHINESE_OR=N'Note' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'GHI_CHU' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'GHI_CHU',N'Ghi chú',N'Note',N'Note',N'Ghi chú',N'Note',N'Note','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'STT') UPDATE LANGUAGES SET VIETNAM=N'STT', ENGLISH=N'No',CHINESE=N'No', VIETNAM_OR=N'STT', ENGLISH_OR=N'No' , CHINESE_OR=N'No' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'STT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'STT',N'STT',N'No',N'No',N'STT',N'No',N'No','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD =N'msgKhongCoDuLieuXuatExcel') UPDATE LANGUAGES SET VIETNAM=N'Không có dữ liệu xuất Excel', ENGLISH=N'No data to export to excel',CHINESE=N'No data to export to excel', VIETNAM_OR=N'Không có dữ liệu xuất Excel', ENGLISH_OR=N'No data to export to excel' , CHINESE_OR=N'No data to export to excel' WHERE FORM=N'ucDanhSachPhieuNhapKho' AND KEYWORD=N'msgKhongCoDuLieuXuatExcel' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucDanhSachPhieuNhapKho',N'msgKhongCoDuLieuXuatExcel',N'Không có dữ liệu xuất Excel',N'No data to export to excel',N'No data to export to excel',N'Không có dữ liệu xuất Excel',N'No data to export to excel',N'No data to export to excel','ECOMAIN')