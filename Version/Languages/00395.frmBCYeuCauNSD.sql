﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucTinhTrangThietbi' AND KEYWORD =N'chkYCSD') UPDATE LANGUAGES SET VIETNAM=N'Có YC sửa chữa', ENGLISH=N'Work request',CHINESE=N'Work request', VIETNAM_OR=N'Có YC sửa chữa', ENGLISH_OR=N'Work request' , CHINESE_OR=N'Work request' WHERE FORM=N'ucTinhTrangThietbi' AND KEYWORD=N'chkYCSD' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucTinhTrangThietbi',N'chkYCSD',N'Có YC sửa chữa',N'Work request',N'Work request',N'Có YC sửa chữa',N'Work request',N'Work request','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucTinhTrangThietbi' AND KEYWORD =N'chkKHTT') UPDATE LANGUAGES SET VIETNAM=N'Có trong KHTT', ENGLISH=N'Master plan',CHINESE=N'Master plan', VIETNAM_OR=N'Có trong KHTT', ENGLISH_OR=N'Master plan' , CHINESE_OR=N'Master plan' WHERE FORM=N'ucTinhTrangThietbi' AND KEYWORD=N'chkKHTT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucTinhTrangThietbi',N'chkKHTT',N'Có trong KHTT',N'Master plan',N'Master plan',N'Có trong KHTT',N'Master plan',N'Master plan','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucTinhTrangThietbi' AND KEYWORD =N'chkBaoTri') UPDATE LANGUAGES SET VIETNAM=N'Đang soạn PBT', ENGLISH=N'Work order',CHINESE=N'Work order', VIETNAM_OR=N'Đang soạn PBT', ENGLISH_OR=N'Work order' , CHINESE_OR=N'Work order' WHERE FORM=N'ucTinhTrangThietbi' AND KEYWORD=N'chkBaoTri' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucTinhTrangThietbi',N'chkBaoTri',N'Đang soạn PBT',N'Work order',N'Work order',N'Đang soạn PBT',N'Work order',N'Work order','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucTinhTrangThietbi' AND KEYWORD =N'chkDangBaoTri') UPDATE LANGUAGES SET VIETNAM=N'Đang bảo trì', ENGLISH=N'In maintenance',CHINESE=N'In maintenance', VIETNAM_OR=N'Đang bảo trì', ENGLISH_OR=N'In maintenance' , CHINESE_OR=N'In maintenance' WHERE FORM=N'ucTinhTrangThietbi' AND KEYWORD=N'chkDangBaoTri' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'ucTinhTrangThietbi',N'chkDangBaoTri',N'Đang bảo trì',N'In maintenance',N'In maintenance',N'Đang bảo trì',N'In maintenance',N'In maintenance','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBCYeuCauNSD' AND KEYWORD =N'NGAY') UPDATE LANGUAGES SET VIETNAM=N'Ngày yêu cầu', ENGLISH=N'Request date',CHINESE=N'Request date', VIETNAM_OR=N'Ngày yêu cầu', ENGLISH_OR=N'Request date' , CHINESE_OR=N'Request date' WHERE FORM=N'frmBCYeuCauNSD' AND KEYWORD=N'NGAY' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmBCYeuCauNSD',N'NGAY',N'Ngày yêu cầu',N'Request date',N'Request date',N'Ngày yêu cầu',N'Request date',N'Request date','ECOMAIN')
