
IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmThongtinthietbi')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/10/bai-0401-thong-tin-va-cau-truc-thiet-bi.html'
WHERE FORM_NAME = 'frmThongtinthietbi'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmThongtinthietbi', null, N'http://vs-elearning.blogspot.com/2016/10/bai-0401-thong-tin-va-cau-truc-thiet-bi.html', N'Thông tin thiết bị')
END
IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmThoiGianNgungMayNEW')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/11/muc-42-thoi-gian-ngung-may.html'
WHERE FORM_NAME = 'frmThoiGianNgungMayNEW'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmThoiGianNgungMayNEW', null, N'http://vs-elearning.blogspot.com/2016/11/muc-42-thoi-gian-ngung-may.html', N'Thời gian ngừng máy')
END
IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmYeucaucuaNSD')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/11/muc-43-yeu-cau-nguoi-su-dung.html'
WHERE FORM_NAME = 'frmYeucaucuaNSD'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmYeucaucuaNSD', null, N'http://vs-elearning.blogspot.com/2016/11/muc-43-yeu-cau-nguoi-su-dung.html', N'Yêu cầu người sử dụng')
END

IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmPhieuBaoTri_NEW')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/11/bai-0602-phieu-bao-tri.html'
WHERE FORM_NAME = 'frmPhieuBaoTri_NEW'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmPhieuBaoTri_NEW', null, N'http://vs-elearning.blogspot.com/2016/11/bai-0602-phieu-bao-tri.html', N'Phiếu bảo trì')
END

IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmGiamsattinhtrang')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/10/bai-0605-giam-sat-tinh-trang-thiet-bi.html'
WHERE FORM_NAME = 'frmGiamsattinhtrang'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmGiamsattinhtrang', null, N'http://vs-elearning.blogspot.com/2016/10/bai-0605-giam-sat-tinh-trang-thiet-bi.html', N'Giám sát tình trạng')
END


IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmImportExcel')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/10/muc-15-import-du-lieu.html'
WHERE FORM_NAME = 'frmImportExcel'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmImportExcel', null, N'http://vs-elearning.blogspot.com/2016/10/muc-15-import-du-lieu.html', N'Import dữ liệu từ excel')
END


IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmDanhmucphutung_CS')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/10/bai-0708-huong-dan-danh-muc-vat-tu-phu_3.html'
WHERE FORM_NAME = 'frmDanhmucphutung_CS'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmDanhmucphutung_CS', null, N'http://vs-elearning.blogspot.com/2016/10/bai-0708-huong-dan-danh-muc-vat-tu-phu_3.html', N'Danh mục phụ tùng')
END


IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmDanhmuccongviec')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/10/bai-0203-danh-muc-cong-viec_3.html'
WHERE FORM_NAME = 'frmDanhmuccongviec'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmDanhmuccongviec', null, N'http://vs-elearning.blogspot.com/2016/10/bai-0203-danh-muc-cong-viec_3.html', N'Danh mục công việc')
END


IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmThongtinthietbi')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/10/bai-0401-thong-tin-va-cau-truc-thiet-bi.html'
WHERE FORM_NAME = 'frmThongtinthietbi'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmThongtinthietbi', null, N'http://vs-elearning.blogspot.com/2016/10/bai-0401-thong-tin-va-cau-truc-thiet-bi.html', N'Thông số thiết bị')
END


IF EXISTS (SELECT * FROM DS_FORM WHERE FORM_NAME = 'frmThongsoGSTT')
BEGIN
UPDATE DS_FORM 
SET LINK_VIDEO = N'http://vs-elearning.blogspot.com/2016/10/bai-0204-thong-so-giam-sat-tinh-trang_3.html'
WHERE FORM_NAME = 'frmThongsoGSTT'
END
ELSE
BEGIN
	INSERT INTO DS_FORM (DLL_NAME, FORM_NAME, LINK_BH, LINK_VIDEO, [DESCRIPTION]) VALUES ('CMMS', 'frmThongsoGSTT', null, N'http://vs-elearning.blogspot.com/2016/10/bai-0204-thong-so-giam-sat-tinh-trang_3.html', N'Thông số giám sát tình trạng')
END