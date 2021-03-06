
IF NOT EXISTS (SELECT * FROM   sys.columns WHERE  object_id = OBJECT_ID(N'THONG_TIN_CHUNG') AND name = 'TTCT')
begin
    ALTER TABLE THONG_TIN_CHUNG ADD TTCT BIT NULL
end 
GO
UPDATE THONG_TIN_CHUNG 
SET TTCT = CASE [PRIVATE] WHEN 'BARIA' THEN 1 ELSE 0 END
go
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmPhieuBaoTri_New' AND KEYWORD =N'MsgNhapNoteTTPBTCT') UPDATE LANGUAGES SET VIETNAM=N'Nhập ghi chú (có thể để trống)', ENGLISH=N'Please enter note! (may be empty)', VIETNAM_OR=N'Nhập ghi chú (có thể để trống)', ENGLISH_OR=N'Please enter note! (may be empty)' WHERE FORM=N'FrmPhieuBaoTri_New' AND KEYWORD=N'MsgNhapNoteTTPBTCT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'FrmPhieuBaoTri_New',N'MsgNhapNoteTTPBTCT',N'Nhập ghi chú (có thể để trống)',N'Please enter note! (may be empty)',N'Nhập ghi chú (có thể để trống)',N'Please enter note! (may be empty)')
