IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TEN_MAY') UPDATE LANGUAGES SET VIETNAM=N'Tên thiết bị', ENGLISH=N'Equipment',CHINESE=N'Equipment', VIETNAM_OR=N'Tên thiết bị', ENGLISH_OR=N'Equipment' , CHINESE_OR=N'Equipment' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TEN_MAY' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TEN_MAY',N'Tên thiết bị',N'Equipment',N'Equipment',N'Tên thiết bị',N'Equipment',N'Equipment','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'MS_BP') UPDATE LANGUAGES SET VIETNAM=N'Mã bộ phận', ENGLISH=N'Component ID',CHINESE=N'Component ID', VIETNAM_OR=N'Mã bộ phận', ENGLISH_OR=N'Component ID' , CHINESE_OR=N'Component ID' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'MS_BP' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'MS_BP',N'Mã bộ phận',N'Component ID',N'Component ID',N'Mã bộ phận',N'Component ID',N'Component ID','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TEN_BP') UPDATE LANGUAGES SET VIETNAM=N'Tên bộ phận', ENGLISH=N'Component',CHINESE=N'Component', VIETNAM_OR=N'Tên bộ phận', ENGLISH_OR=N'Component' , CHINESE_OR=N'Component' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TEN_BP' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TEN_BP',N'Tên bộ phận',N'Component',N'Component',N'Tên bộ phận',N'Component',N'Component','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'MS_TS') UPDATE LANGUAGES SET VIETNAM=N'MS thông số', ENGLISH=N'Parameter ID',CHINESE=N'Parameter ID', VIETNAM_OR=N'MS thông số', ENGLISH_OR=N'Parameter ID' , CHINESE_OR=N'Parameter ID' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'MS_TS' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'MS_TS',N'MS thông số',N'Parameter ID',N'Parameter ID',N'MS thông số',N'Parameter ID',N'Parameter ID','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TEN_TS') UPDATE LANGUAGES SET VIETNAM=N'Thông số', ENGLISH=N'Parameter',CHINESE=N'Parameter', VIETNAM_OR=N'Thông số', ENGLISH_OR=N'Parameter' , CHINESE_OR=N'Parameter' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TEN_TS' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TEN_TS',N'Thông số',N'Parameter',N'Parameter',N'Thông số',N'Parameter',N'Parameter','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'GIA_TRI') UPDATE LANGUAGES SET VIETNAM=N'Giá trị', ENGLISH=N'Value',CHINESE=N'Value', VIETNAM_OR=N'Giá trị', ENGLISH_OR=N'Value' , CHINESE_OR=N'Value' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'GIA_TRI' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'GIA_TRI',N'Giá trị',N'Value',N'Value',N'Giá trị',N'Value',N'Value','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'DVD') UPDATE LANGUAGES SET VIETNAM=N'Đơn vị đo', ENGLISH=N'UoM ',CHINESE=N'UoM ', VIETNAM_OR=N'Đơn vị đo', ENGLISH_OR=N'UoM ' , CHINESE_OR=N'UoM ' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'DVD' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'DVD',N'Đơn vị đo',N'UoM ',N'UoM ',N'Đơn vị đo',N'UoM ',N'UoM ','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'SO_PHIEU') UPDATE LANGUAGES SET VIETNAM=N'Số phiếu', ENGLISH=N'Số phiếu',CHINESE=N'Số phiếu', VIETNAM_OR=N'Số phiếu', ENGLISH_OR=N'Số phiếu' , CHINESE_OR=N'Số phiếu' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'SO_PHIEU' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'SO_PHIEU',N'Số phiếu',N'Số phiếu',N'Số phiếu',N'Số phiếu',N'Số phiếu',N'Số phiếu','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'lblNhanvienkiemtra') UPDATE LANGUAGES SET VIETNAM=N'Nhân viên kiểm tra', ENGLISH=N'Inspector',CHINESE=N'Inspector', VIETNAM_OR=N'Nhân viên kiểm tra', ENGLISH_OR=N'Inspector' , CHINESE_OR=N'Inspector' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'lblNhanvienkiemtra' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'lblNhanvienkiemtra',N'Nhân viên kiểm tra',N'Inspector',N'Inspector',N'Nhân viên kiểm tra',N'Inspector',N'Inspector','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'NHAN_XET') UPDATE LANGUAGES SET VIETNAM=N'Nhận xét', ENGLISH=N'Comment',CHINESE=N'Comment', VIETNAM_OR=N'Nhận xét', ENGLISH_OR=N'Comment' , CHINESE_OR=N'Comment' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'NHAN_XET' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'NHAN_XET',N'Nhận xét',N'Comment',N'Comment',N'Nhận xét',N'Comment',N'Comment','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'tabThongSo') UPDATE LANGUAGES SET VIETNAM=N'Thông số', ENGLISH=N'Parameter',CHINESE=N'Parameter', VIETNAM_OR=N'Thông số', ENGLISH_OR=N'Parameter' , CHINESE_OR=N'Parameter' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'tabThongSo' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'tabThongSo',N'Thông số',N'Parameter',N'Parameter',N'Thông số',N'Parameter',N'Parameter','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TEN_BO_PHAN') UPDATE LANGUAGES SET VIETNAM=N'Tên bộ phận', ENGLISH=N'Component',CHINESE=N'Component', VIETNAM_OR=N'Tên bộ phận', ENGLISH_OR=N'Component' , CHINESE_OR=N'Component' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TEN_BO_PHAN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TEN_BO_PHAN',N'Tên bộ phận',N'Component',N'Component',N'Tên bộ phận',N'Component',N'Component','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TG_TT') UPDATE LANGUAGES SET VIETNAM=N'TG TT', ENGLISH=N'Actual time ',CHINESE=N'Actual time ', VIETNAM_OR=N'TG TT', ENGLISH_OR=N'Actual time ' , CHINESE_OR=N'Actual time ' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TG_TT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TG_TT',N'TG TT',N'Actual time ',N'Actual time ',N'TG TT',N'Actual time ',N'Actual time ','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TG_KH') UPDATE LANGUAGES SET VIETNAM=N'TG KH', ENGLISH=N'Plan time',CHINESE=N'Plan time', VIETNAM_OR=N'TG KH', ENGLISH_OR=N'Plan time' , CHINESE_OR=N'Plan time' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TG_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TG_KH',N'TG KH',N'Plan time',N'Plan time',N'TG KH',N'Plan time',N'Plan time','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TEN_BO_PHAN') UPDATE LANGUAGES SET VIETNAM=N'Tên bộ phận', ENGLISH=N'Component',CHINESE=N'Component', VIETNAM_OR=N'Tên bộ phận', ENGLISH_OR=N'Component' , CHINESE_OR=N'Component' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TEN_BO_PHAN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TEN_BO_PHAN',N'Tên bộ phận',N'Component',N'Component',N'Tên bộ phận',N'Component',N'Component','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TEN_DV_DO') UPDATE LANGUAGES SET VIETNAM=N'Đơn vị đo', ENGLISH=N'UoM ',CHINESE=N'UoM ', VIETNAM_OR=N'Đơn vị đo', ENGLISH_OR=N'UoM ' , CHINESE_OR=N'UoM ' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TEN_DV_DO' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TEN_DV_DO',N'Đơn vị đo',N'UoM ',N'UoM ',N'Đơn vị đo',N'UoM ',N'UoM ','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TG_KH') UPDATE LANGUAGES SET VIETNAM=N'TG KH', ENGLISH=N'Plan time',CHINESE=N'Plan time', VIETNAM_OR=N'TG KH', ENGLISH_OR=N'Plan time' , CHINESE_OR=N'Plan time' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TG_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TG_KH',N'TG KH',N'Plan time',N'Plan time',N'TG KH',N'Plan time',N'Plan time','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'TG_TT') UPDATE LANGUAGES SET VIETNAM=N'TG TT', ENGLISH=N'Actual time ',CHINESE=N'Actual time ', VIETNAM_OR=N'TG TT', ENGLISH_OR=N'Actual time ' , CHINESE_OR=N'Actual time ' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'TG_TT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'TG_TT',N'TG TT',N'Actual time ',N'Actual time ',N'TG TT',N'Actual time ',N'Actual time ','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'GIA_TRI_DUOI') UPDATE LANGUAGES SET VIETNAM=N'Giá trị dưới', ENGLISH=N'L. Value',CHINESE=N'L. Value', VIETNAM_OR=N'Giá trị dưới', ENGLISH_OR=N'L. Value' , CHINESE_OR=N'L. Value' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'GIA_TRI_DUOI' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'GIA_TRI_DUOI',N'Giá trị dưới',N'L. Value',N'L. Value',N'Giá trị dưới',N'L. Value',N'L. Value','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'GIA_TRI_TREN') UPDATE LANGUAGES SET VIETNAM=N'Giá trị trên', ENGLISH=N'U. Value',CHINESE=N'U. Value', VIETNAM_OR=N'Giá trị trên', ENGLISH_OR=N'U. Value' , CHINESE_OR=N'U. Value' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'GIA_TRI_TREN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'GIA_TRI_TREN',N'Giá trị trên',N'U. Value',N'U. Value',N'Giá trị trên',N'U. Value',N'U. Value','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'tabThongSoDT') UPDATE LANGUAGES SET VIETNAM=N'Định tính', ENGLISH=N'CM par',CHINESE=N'CM par', VIETNAM_OR=N'Định tính', ENGLISH_OR=N'CM par' , CHINESE_OR=N'CM par' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'tabThongSoDT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'tabThongSoDT',N'Định tính',N'CM par',N'CM par',N'Định tính',N'CM par',N'CM par','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'tabThongSoDL') UPDATE LANGUAGES SET VIETNAM=N'Định lượng', ENGLISH=N'QCM par',CHINESE=N'QCM par', VIETNAM_OR=N'Định lượng', ENGLISH_OR=N'QCM par' , CHINESE_OR=N'QCM par' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'tabThongSoDL' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'tabThongSoDL',N'Định lượng',N'QCM par',N'QCM par',N'Định lượng',N'QCM par',N'QCM par','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'optDat') UPDATE LANGUAGES SET VIETNAM=N'Đạt', ENGLISH=N'Ok',CHINESE=N'Ok', VIETNAM_OR=N'Đạt', ENGLISH_OR=N'Ok' , CHINESE_OR=N'Ok' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'optDat' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'optDat',N'Đạt',N'Ok',N'Ok',N'Đạt',N'Ok',N'Ok','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'optKhongDat') UPDATE LANGUAGES SET VIETNAM=N'Không đạt', ENGLISH=N'Bad',CHINESE=N'Bad', VIETNAM_OR=N'Không đạt', ENGLISH_OR=N'Bad' , CHINESE_OR=N'Bad' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'optKhongDat' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'optKhongDat',N'Không đạt',N'Bad',N'Bad',N'Không đạt',N'Bad',N'Bad','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'MornitoringWeb' AND KEYWORD =N'labLoaiCV') UPDATE LANGUAGES SET VIETNAM=N'Loại công việc', ENGLISH=N'Type of works',CHINESE=N'Type of works', VIETNAM_OR=N'Loại công việc', ENGLISH_OR=N'Type of works' , CHINESE_OR=N'Type of works' WHERE FORM=N'MornitoringWeb' AND KEYWORD=N'labLoaiCV' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'MornitoringWeb',N'labLoaiCV',N'Loại công việc',N'Type of works',N'Type of works',N'Loại công việc',N'Type of works',N'Type of works','ECOMAIN')
