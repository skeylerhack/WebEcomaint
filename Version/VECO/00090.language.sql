IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'rptDeXuatMuaHangNew' AND KEYWORD =N'IMAGE') UPDATE LANGUAGES SET VIETNAM=N'Hình ảnh', ENGLISH=N'Image', VIETNAM_OR=N'Hình ảnh', ENGLISH_OR=N'Image' WHERE FORM=N'rptDeXuatMuaHangNew' AND KEYWORD=N'IMAGE' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'rptDeXuatMuaHangNew',N'IMAGE',N'Hình ảnh',N'Image',N'Hình ảnh',N'Image')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD =N'IMAGE') UPDATE LANGUAGES SET VIETNAM=N'Hình Ảnh', ENGLISH=N'Image', VIETNAM_OR=N'Hình Ảnh', ENGLISH_OR=N'Image' WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD=N'IMAGE' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDeXuatMuaHang_New',N'IMAGE',N'Hình Ảnh',N'Image',N'Hình Ảnh',N'Image')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD =N'sbcTieuDeDXDV') UPDATE LANGUAGES SET VIETNAM=N'VINA ECO BOARD CO., LTD.', ENGLISH=N'VINA ECO BOARD CO., LTD.', VIETNAM_OR=N'VINA ECO BOARD CO., LTD.', ENGLISH_OR=N'VINA ECO BOARD CO., LTD.' WHERE FORM=N'frmDeXuatMuaHang_New' AND KEYWORD=N'sbcTieuDeDXDV' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDeXuatMuaHang_New',N'sbcTieuDeDXDV',N'VINA ECO BOARD CO., LTD.',N'VINA ECO BOARD CO., LTD.',N'VINA ECO BOARD CO., LTD.',N'VINA ECO BOARD CO., LTD.')
