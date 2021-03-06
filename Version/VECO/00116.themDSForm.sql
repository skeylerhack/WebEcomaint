
IF NOT EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmNgayNghiTheoNhaXuong')
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, [DESCRIPTION]) SELECT 'CMMS', 'frmNgayNghiTheoNhaXuong', N'Cài đặt ngày nghỉ theo nhà xưởng'
END

IF NOT EXISTS (SELECT * FROM LIC_FORM WHERE FORM_NAME = N'ΐΨΞ͠ΒΆζ͠ΒΔΖͬΔΎ΢͠ΔΆʹή΢ΠΒ')
BEGIN
	INSERT INTO LIC_FORM (TYPE_LIC, FORM_NAME) SELECT N'̦', N'ΐΨΞ͠ΒΆζ͠ΒΔΖͬΔΎ΢͠ΔΆʹή΢ΠΒ'
END
IF NOT EXISTS (SELECT * FROM CHI_TIET_FORMS WHERE FORM_NAME = 'frmNgayNghiTheoNhaXuong')
BEGIN
	INSERT INTO CHI_TIET_FORMS (FORM_NAME, TEN_FORMS_VIET, TEN_FORMS_ANH) SELECT 'frmNgayNghiTheoNhaXuong', N'Ngày nghỉ theo nhà xưởng', N'Ngày nghỉ theo nhà xưởng'
END

IF NOT EXISTS (SELECT * FROM NHOM_FORM WHERE GROUP_ID = 1 AND FORM_NAME = 'frmNgayNghiTheoNhaXuong')
BEGIN
	INSERT INTO NHOM_FORM (GROUP_ID, FORM_NAME, QUYEN) SELECT 1, 'frmNgayNghiTheoNhaXuong', 'Full access'
END




IF NOT EXISTS (SELECT * FROM MENU WHERE MENU_ID = 'mnuNgayNghiTheoNhaXuong')
BEGIN
	INSERT INTO MENU (MENU_ID, MENU_TEXT, MENU_ENGLISH, MENU_PARENT, MENU_LINE, MENU_INDEX,CLASS_NAME, FUNCTION_NAME, AN_HIEN) 
	SELECT 'mnuNgayNghiTheoNhaXuong', N'Ngày nghỉ theo nhà xưởng', 'Ngày nghỉ theo nhà xưởng', N'mnuMasterData',0,28, 'frmMain', 'ShowNgayNhaXuong', 1
END

IF NOT EXISTS (SELECT * FROM LIC_MENU WHERE MENU_ID = N'ΞΠή͠ΒΆζ͠ΒΔΖͬΔΎ΢͠ΔΆʹή΢ΠΒ')
BEGIN
	INSERT INTO LIC_MENU (TYPE_LIC, MENU_ID) SELECT N'̦̦',N'ΞΠή͠ΒΆζ͠ΒΔΖͬΔΎ΢͠ΔΆʹή΢ΠΒ'
END
IF NOT EXISTS (SELECT * FROM NHOM_MENU WHERE MENU_ID = 'mnuNgayNghiTheoNhaXuong')
BEGIN
	INSERT INTO NHOM_MENU (GROUP_ID, MENU_ID) SELECT 1, 'mnuNgayNghiTheoNhaXuong'
END