IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBranch' AND KEYWORD =N'bancomuonxoakhong') UPDATE LANGUAGES SET VIETNAM=N'Xóa tài liệu?', ENGLISH=N'Delete this document?', VIETNAM_OR=N'Xóa tài liệu?', ENGLISH_OR=N'Delete this document?' WHERE FORM=N'frmBranch' AND KEYWORD=N'bancomuonxoakhong' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBranch',N'bancomuonxoakhong',N'Xóa tài liệu?',N'Delete this document?',N'Xóa tài liệu?',N'Delete this document?')
