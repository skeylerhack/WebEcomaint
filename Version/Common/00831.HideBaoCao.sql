update MENU 
set MENU_PARENT = 'mnuMasterData'
where MENU_ID in ('mnuDuyetTaiLieu', 'mnuDanhmuckho')

update MENU 
set MENU_TEXT = N' 2.22. Quy trình duyệt tài liệu',
MENU_ENGLISH = N' 2.22. Document Approval Procedure',
MENU_INDEX = 30, MENU_LINE = 0
where MENU_ID = 'mnuDuyetTaiLieu'

update MENU 
set MENU_TEXT = N' 2.21. Danh mục kho',
MENU_ENGLISH = N' 2.21. List of Warehouses',
MENU_INDEX = 29, MENU_LINE = 1
where MENU_ID = 'mnuDanhmuckho'

update MENU SET MENU_LINE = 1
where MENU_ID = 'mnuPhieuNhapXac'

update MENU 
set AN_HIEN = 0
where MENU_ID = 'mnuSetMin_Max'

UPDATE DS_REPORT SET STT = 15 where REPORT_NAME = 'rptKiemKeVT_PT'
UPDATE DS_REPORT SET STT = ISNULL(STT,0) + 101 where REPORT_NAME = 'ucLuanChuyenVatTu'
UPDATE DS_REPORT SET STT = 103 where REPORT_NAME = 'ucFastSlowNonMovingAnalysic'
UPDATE DS_REPORT SET STT = 104 where REPORT_NAME = 'ucSafetyStock'
