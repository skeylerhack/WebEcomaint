IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'rptDeXuatMuaHangNew' AND KEYWORD =N'DPT_No') UPDATE LANGUAGES SET VIETNAM=N'DPT No', ENGLISH=N'DPT No', VIETNAM_OR=N'DPT No', ENGLISH_OR=N'DPT No' WHERE FORM=N'rptDeXuatMuaHangNew' AND KEYWORD=N'DPT_No' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'rptDeXuatMuaHangNew',N'DPT_No',N'DPT No',N'DPT No',N'DPT No',N'DPT No')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'rptDeXuatMuaHangNew' AND KEYWORD =N'Account_No') UPDATE LANGUAGES SET VIETNAM=N'Account No', ENGLISH=N'Account No', VIETNAM_OR=N'Account No', ENGLISH_OR=N'Account No' WHERE FORM=N'rptDeXuatMuaHangNew' AND KEYWORD=N'Account_No' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'rptDeXuatMuaHangNew',N'Account_No',N'Account No',N'Account No',N'Account No',N'Account No')
