﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuLapPhieuBaoTri') UPDATE LANGUAGES SET VIETNAM=N'Lập phiếu bảo trì', ENGLISH=N'Add work order',CHINESE=N'Add work order', VIETNAM_OR=N'Lập phiếu bảo trì', ENGLISH_OR=N'Add work order' , CHINESE_OR=N'Add work order' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuLapPhieuBaoTri' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmMain',N'mnuLapPhieuBaoTri',N'Lập phiếu bảo trì',N'Add work order',N'Add work order',N'Lập phiếu bảo trì',N'Add work order',N'Add work order','ECOMAIN')


IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmReminder_new' AND KEYWORD =N'BtnHuy') UPDATE LANGUAGES SET VIETNAM=N'Chưa giải quyết', ENGLISH=N'Chưa giải quyết',CHINESE=N'Chưa giải quyết', VIETNAM_OR=N'Chưa giải quyết', ENGLISH_OR=N'Chưa giải quyết' , CHINESE_OR=N'Chưa giải quyết' WHERE FORM=N'frmReminder_new' AND KEYWORD=N'BtnHuy' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmReminder_new',N'BtnHuy',N'Chưa giải quyết',N'Chưa giải quyết',N'Chưa giải quyết',N'Chưa giải quyết',N'Chưa giải quyết',N'Chưa giải quyết','ECOMAIN')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD =N'MsgQuyenKT22') UPDATE LANGUAGES SET VIETNAM=N'Bạn vui lòng chọn máy!', ENGLISH=N'Please select a maintenance type!',CHINESE=N'Please select a maintenance type!', VIETNAM_OR=N'Bạn vui lòng chọn máy!', ENGLISH_OR=N'Please select a maintenance type!' , CHINESE_OR=N'Please select a maintenance type!' WHERE FORM=N'frmKehoachtongthe_odd' AND KEYWORD=N'MsgQuyenKT22' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmKehoachtongthe_odd',N'MsgQuyenKT22',N'Bạn vui lòng chọn máy!',N'Please select a maintenance type!',N'Please select a maintenance type!',N'Bạn vui lòng chọn máy!',N'Please select a maintenance type!',N'Please select a maintenance type!','ECOMAIN')


IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'rptTINH_TRANG_THIET_BI' AND KEYWORD =N'TIEU_DE') UPDATE LANGUAGES SET VIETNAM=N'GIÁM SÁT TÌNH TRẠNG ĐẾN HẠN KIỂM TRA', ENGLISH=N'CONDITION MONITORING  PARAMETER TO BE CHECKED',CHINESE=N'CONDITION MONITORING  PARAMETER TO BE CHECKED', VIETNAM_OR=N'GIÁM SÁT TÌNH TRẠNG ĐẾN HẠN KIỂM TRA', ENGLISH_OR=N'CONDITION MONITORING  PARAMETER TO BE CHECKED' , CHINESE_OR=N'CONDITION MONITORING  PARAMETER TO BE CHECKED' WHERE FORM=N'rptTINH_TRANG_THIET_BI' AND KEYWORD=N'TIEU_DE' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'rptTINH_TRANG_THIET_BI',N'TIEU_DE',N'GIÁM SÁT TÌNH TRẠNG ĐẾN HẠN KIỂM TRA',N'CONDITION MONITORING  PARAMETER TO BE CHECKED',N'CONDITION MONITORING  PARAMETER TO BE CHECKED',N'GIÁM SÁT TÌNH TRẠNG ĐẾN HẠN KIỂM TRA',N'CONDITION MONITORING  PARAMETER TO BE CHECKED',N'CONDITION MONITORING  PARAMETER TO BE CHECKED','ECOMAIN')



