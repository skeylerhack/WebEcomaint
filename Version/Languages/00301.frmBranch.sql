﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'bancomuonxoakhong') UPDATE LANGUAGES SET VIETNAM=N'Bạn có muốn xóa email không!', ENGLISH=N'Do you want delete this data!', VIETNAM_OR=N'Bạn có muốn xóa email không!', ENGLISH_OR=N'Do you want delete this data!' WHERE FORM=N'frmBranch' AND KEYWORD=N'bancomuonxoakhong' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'bancomuonxoakhong',N'Bạn có muốn xóa email không!',N'Do you want delete this data!',N'Bạn có muốn xóa email không!',N'Do you want delete this data!')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'btnGhiTL') UPDATE LANGUAGES SET VIETNAM=N'&Lưu', ENGLISH=N'&Save', VIETNAM_OR=N'&Lưu', ENGLISH_OR=N'&Save' WHERE FORM=N'frmBranch' AND KEYWORD=N'btnGhiTL' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'btnGhiTL',N'&Lưu',N'&Save',N'&Lưu',N'&Save')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'btnKhongGhiTL') UPDATE LANGUAGES SET VIETNAM=N'&Không lưu', ENGLISH=N'&Cancel', VIETNAM_OR=N'&Không lưu', ENGLISH_OR=N'&Cancel' WHERE FORM=N'frmBranch' AND KEYWORD=N'btnKhongGhiTL' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'btnKhongGhiTL',N'&Không lưu',N'&Cancel',N'&Không lưu',N'&Cancel')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'btnOpenTL') UPDATE LANGUAGES SET VIETNAM=N'Xem tài liệu', ENGLISH=N'View Document', VIETNAM_OR=N'Xem tài liệu', ENGLISH_OR=N'View Document' WHERE FORM=N'frmBranch' AND KEYWORD=N'btnOpenTL' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'btnOpenTL',N'Xem tài liệu',N'View Document',N'Xem tài liệu',N'View Document')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'btnThemNX') UPDATE LANGUAGES SET VIETNAM=N'Thêm', ENGLISH=N'Add', VIETNAM_OR=N'Thêm', ENGLISH_OR=N'Add' WHERE FORM=N'frmBranch' AND KEYWORD=N'btnThemNX' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'btnThemNX',N'Thêm',N'Add',N'Thêm',N'Add')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'btnThemSuaTL') UPDATE LANGUAGES SET VIETNAM=N'Thêm/sửa', ENGLISH=N'Add/Edit', VIETNAM_OR=N'Thêm/sửa', ENGLISH_OR=N'Add/Edit' WHERE FORM=N'frmBranch' AND KEYWORD=N'btnThemSuaTL' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'btnThemSuaTL',N'Thêm/sửa',N'Add/Edit',N'Thêm/sửa',N'Add/Edit')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'btnThoatTL') UPDATE LANGUAGES SET VIETNAM=N'Thoát', ENGLISH=N'Exit', VIETNAM_OR=N'Thoát', ENGLISH_OR=N'Exit' WHERE FORM=N'frmBranch' AND KEYWORD=N'btnThoatTL' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'btnThoatTL',N'Thoát',N'Exit',N'Thoát',N'Exit')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'dathaydoiduongdan') UPDATE LANGUAGES SET VIETNAM=N'Đường dẫn đã thay đổi', ENGLISH=N'The path has changed', VIETNAM_OR=N'Đường dẫn đã thay đổi', ENGLISH_OR=N'The path has changed' WHERE FORM=N'frmBranch' AND KEYWORD=N'dathaydoiduongdan' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'dathaydoiduongdan',N'Đường dẫn đã thay đổi',N'The path has changed',N'Đường dẫn đã thay đổi',N'The path has changed')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDuyetSanXuat' AND KEYWORD =N'msgVuiLongNhapYKien') UPDATE LANGUAGES SET VIETNAM=N'Vui lòng nhập ý kiến người duyệt', ENGLISH=N'Please input notes', VIETNAM_OR=N'Vui lòng nhập ý kiến người duyệt', ENGLISH_OR=N'Please input notes' WHERE FORM=N'frmDuyetSanXuat' AND KEYWORD=N'msgVuiLongNhapYKien' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDuyetSanXuat',N'msgVuiLongNhapYKien',N'Vui lòng nhập ý kiến người duyệt',N'Please input notes',N'Vui lòng nhập ý kiến người duyệt',N'Please input notes')
