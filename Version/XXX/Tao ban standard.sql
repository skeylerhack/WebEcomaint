--Xoa tao ban standard 

delete from NHOM_MENU where MENU_ID in ('mnuItemLanguageEN','mnuLanguage','mnuSettingup', 'mnuFormsetting','mnuReportmailsetting','mnuReportmailsetting',
  'mnuBoPhanChiuPhiRule','mnuNgaynghile','mnuDachmuchechuyengia','mnuClass','mnuProblem', 'mnuCause',  'mnuChonMay', 'mnuYeucauNSD','mnuYeucauNSD_Nhap',
  'mnuYeucauNSD_DSX', 'mnuYeucauNSD_DBT','mnuLichTau','mnuPhatSinhDichVu', 'mnuDuyetTaiLieu','mnuSetMin_Max', 
  'mnuPhieuNhapXac','mnuPhieuXuatXac','mnuTimvattudexuat','mnuDeXuatMuaHang')
  
  delete from MENU where MENU_ID in ('mnuItemLanguageEN','mnuLanguage','mnuSettingup', 'mnuFormsetting','mnuReportmailsetting','mnuReportmailsetting',
  'mnuBoPhanChiuPhiRule','mnuNgaynghile','mnuDachmuchechuyengia','mnuClass','mnuProblem', 'mnuCause',  'mnuChonMay', 'mnuYeucauNSD','mnuYeucauNSD_Nhap',
  'mnuYeucauNSD_DSX', 'mnuYeucauNSD_DBT','mnuLichTau','mnuPhatSinhDichVu', 'mnuDuyetTaiLieu','mnuSetMin_Max', 
  'mnuPhieuNhapXac','mnuPhieuXuatXac','mnuTimvattudexuat','mnuDeXuatMuaHang')
  
  delete from NHOM_REPORT where REPORT_NAME in (SELECT  REPORT_NAME FROM  dbo.DS_REPORT WHERE     (STT > 99))
  delete from DS_REPORT where STT > 99
  delete NHOM_REPORT where REPORT_NAME in ('frmDeXuatMuaHang_New','frmDonDatHang_New', 'rptDeXuatMuaHang','rptDonDatHang')
  delete from DS_Report where REPORT_NAME in ('frmDeXuatMuaHang_New','frmDonDatHang_New', 'rptDeXuatMuaHang','rptDonDatHang') 
  
  
--- Xoa menu khong can dung (cho tat ca phien ban)

delete from NHOM_MENU where MENU_ID in ('mnuDanhmuctinhquan', 'mnuDanhmucduong')  
delete MENU where MENU_ID in ('mnuDanhmuctinhquan', 'mnuDanhmucduong')


select * from MENU order by MENU_TEXT