IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'rptDeXuatMuaHangNew' AND KEYWORD =N'TMP4') UPDATE LANGUAGES SET VIETNAM=N'M� SAP', ENGLISH=N'ID SAP',CHINESE=N'ID SAP', VIETNAM_OR=N'M� SAP', ENGLISH_OR=N'ID SAP' , CHINESE_OR=N'ID SAP' WHERE FORM=N'rptDeXuatMuaHangNew' AND KEYWORD=N'TMP4' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'rptDeXuatMuaHangNew',N'TMP4',N'M� SAP',N'ID SAP',N'ID SAP',N'M� SAP',N'ID SAP',N'ID SAP','ECOMAIN')