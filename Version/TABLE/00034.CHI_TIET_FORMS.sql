
IF NOT EXISTS (SELECT * FROM CHI_TIET_FORMS WHERE     (FORM_NAME = 'frmPhieuBaoTriBHNT'))
BEGIN
	INSERT INTO CHI_TIET_FORMS(FORM_NAME,TEN_FORMS_VIET,TEN_FORMS_ANH)
	VALUES ( 'frmPhieuBaoTriBHNT' ,N' 5.4.9  Nghiệm thu nhiều phiếu bảo trì',N' 5.4.9  Multi work order approval')
	
	
	SELECT * FROM NHOM_FORM WHERE FORM_NAME = 'frmPhieuBaoTriBHNT'
END	


IF NOT EXISTS (SELECT * FROM NHOM_FORM WHERE FORM_NAME = 'frmPhieuBaoTriBHNT')
BEGIN
	INSERT INTO NHOM_FORM(GROUP_ID,FORM_NAME,QUYEN)
	VALUES ( 1,'frmPhieuBaoTriBHNT' ,N'Full access')
END	