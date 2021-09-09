﻿
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmDiChuyenVatTu' AND KEYWORD =N'BtnRemoveAl') UPDATE LANGUAGES SET VIETNAM=N'<<', ENGLISH=N'<<', VIETNAM_OR=N'<<', ENGLISH_OR=N'<<' WHERE FORM=N'FrmDiChuyenVatTu' AND KEYWORD=N'BtnRemoveAl' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'FrmDiChuyenVatTu',N'BtnRemoveAl',N'<<',N'<<',N'<<',N'<<')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmDiChuyenVatTu' AND KEYWORD =N'btnMoveAl') UPDATE LANGUAGES SET VIETNAM=N'>>', ENGLISH=N'>>', VIETNAM_OR=N'>>', ENGLISH_OR=N'>>' WHERE FORM=N'FrmDiChuyenVatTu' AND KEYWORD=N'btnMoveAl' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'FrmDiChuyenVatTu',N'btnMoveAl',N'>>',N'>>',N'>>',N'>>')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmDiChuyenVatTu' AND KEYWORD =N'btnMove') UPDATE LANGUAGES SET VIETNAM=N'>', ENGLISH=N'>', VIETNAM_OR=N'>', ENGLISH_OR=N'>' WHERE FORM=N'FrmDiChuyenVatTu' AND KEYWORD=N'btnMove' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'FrmDiChuyenVatTu',N'btnMove',N'>',N'>',N'>',N'>')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmDiChuyenVatTu' AND KEYWORD =N'SL_VT') UPDATE LANGUAGES SET VIETNAM=N'Số lượng tồn', ENGLISH=N'Inventory Qty', VIETNAM_OR=N'Số lượng tồn', ENGLISH_OR=N'Inventory Qty' WHERE FORM=N'FrmDiChuyenVatTu' AND KEYWORD=N'SL_VT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'FrmDiChuyenVatTu',N'SL_VT',N'Số lượng tồn',N'Inventory Qty',N'Số lượng tồn',N'Inventory Qty')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'rptKIEM_KE_VAT_TU' AND KEYWORD =N'SL_TON_TT') UPDATE LANGUAGES SET VIETNAM=N'SL kiểm kê', ENGLISH=N'Inventory Qty', VIETNAM_OR=N'SL kiểm kê', ENGLISH_OR=N'Inventory Qty' WHERE FORM=N'rptKIEM_KE_VAT_TU' AND KEYWORD=N'SL_TON_TT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'rptKIEM_KE_VAT_TU',N'SL_TON_TT',N'SL kiểm kê',N'Inventory Qty',N'SL kiểm kê',N'Inventory Qty')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmKiemKeKho' AND KEYWORD =N'lblSearch') UPDATE LANGUAGES SET VIETNAM=N'Tìm kiếm', ENGLISH=N'Search', VIETNAM_OR=N'Tìm kiếm', ENGLISH_OR=N'Search' WHERE FORM=N'FrmKiemKeKho' AND KEYWORD=N'lblSearch' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'FrmKiemKeKho',N'lblSearch',N'Tìm kiếm',N'Search',N'Tìm kiếm',N'Search')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmPhieuXuatKhoVatTu_CS' AND KEYWORD =N'DANG_XUAT_NULL') UPDATE LANGUAGES SET VIETNAM=N'Chọn dạng xuất', ENGLISH=N'Choose Issue type', VIETNAM_OR=N'Chọn dạng xuất', ENGLISH_OR=N'Choose Issue type' WHERE FORM=N'FrmPhieuXuatKhoVatTu_CS' AND KEYWORD=N'DANG_XUAT_NULL' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'FrmPhieuXuatKhoVatTu_CS',N'DANG_XUAT_NULL',N'Chọn dạng xuất',N'Choose Issue type',N'Chọn dạng xuất',N'Choose Issue type')