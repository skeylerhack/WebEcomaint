﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD =N'TEN_DICH_VU') UPDATE LANGUAGES SET VIETNAM=N'Name', ENGLISH=N'Name', VIETNAM_OR=N'Name', ENGLISH_OR=N'Name' WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD=N'TEN_DICH_VU' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDeXuatMuaHang_New',N'TEN_DICH_VU',N'Name',N'Name',N'Name',N'Name')


IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD =N'MS_PT') UPDATE LANGUAGES SET VIETNAM=N'Mã phụ tùng', ENGLISH=N'Spare part ID', VIETNAM_OR=N'Mã phụ tùng', ENGLISH_OR=N'Spare part ID' WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD=N'MS_PT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDeXuatMuaHang_New',N'MS_PT',N'Mã phụ tùng',N'Spare part ID',N'Mã phụ tùng',N'Spare part ID')
