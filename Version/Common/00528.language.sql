IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'ucBaoCaoYCNSD' AND KEYWORD =N'ucBaoCaoYCNSD') UPDATE LANGUAGES SET VIETNAM=N'Theo dõi yêu cầu bảo trì', ENGLISH=N'User request tracking', VIETNAM_OR=N'Theo dõi yêu cầu bảo trì', ENGLISH_OR=N'User request tracking' WHERE FORM=N'ucBaoCaoYCNSD' AND KEYWORD=N'ucBaoCaoYCNSD' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'ucBaoCaoYCNSD',N'ucBaoCaoYCNSD',N'Theo dõi yêu cầu bảo trì',N'User request tracking',N'Theo dõi yêu cầu bảo trì',N'User request tracking')



