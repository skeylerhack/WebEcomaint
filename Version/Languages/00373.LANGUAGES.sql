UPDATE CHUC_NANG SET TEN_CHUC_NANG = N'Import thời gian chạy máy', MT_CN= N'Import thời gian chạy máy' WHERE STT = 24

UPDATE CHI_TIET_FORMS  SET TEN_FORMS_VIET =  N'4.3.3. Tiếp nhận yêu cầu người sử dụng', TEN_FORMS_ANH=	N'4.3.3 User Request Receipt' WHERE FORM_NAME = 'frmYeuCauBT' 


IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDanhmucphutung_CS' AND KEYWORD =N'chkActive') UPDATE LANGUAGES SET VIETNAM=N'Hiệu lực', ENGLISH=N'Active',CHINESE=N'Active', VIETNAM_OR=N'Hiệu lực', ENGLISH_OR=N'Active' , CHINESE_OR=N'Active' WHERE FORM=N'frmDanhmucphutung_CS' AND KEYWORD=N'chkActive' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmDanhmucphutung_CS',N'chkActive',N'Hiệu lực',N'Active',N'Active',N'Hiệu lực',N'Active',N'Active','ECOMAIN')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmTinhHinhTonKho' AND KEYWORD =N'optDeactivate') UPDATE LANGUAGES SET VIETNAM=N'Inactive', ENGLISH=N'Inactive',CHINESE=N'Inactive', VIETNAM_OR=N'Inactive', ENGLISH_OR=N'Inactive' , CHINESE_OR=N'Inactive' WHERE FORM=N'frmTinhHinhTonKho' AND KEYWORD=N'optDeactivate' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmTinhHinhTonKho',N'optDeactivate',N'Inactive',N'Inactive',N'Inactive',N'Inactive',N'Inactive',N'Inactive','ECOMAIN')
