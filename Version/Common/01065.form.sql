
DELETE NHOM_MENU WHERE MENU_ID IN ('mnuCountingUnit','mnuDonvitinhRT', 'mnuMeasuringUnit')
DELETE MENU WHERE MENU_ID IN ('mnuCountingUnit','mnuDonvitinhRT')
INSERT INTO NHOM_MENU (GROUP_ID, MENU_ID) 
SELECT GROUP_ID, 'mnuMeasuringUnit' FROM NHOM

UPDATE NHOM_FORM SET QUYEN = 'Read only' WHERE FORM_NAME IN ('frmDonvitinh', 'frmDonvitinhRuntime')
UPDATE NHOM_FORM SET QUYEN = 'Full access' WHERE FORM_NAME IN ('frmDonvido')

UPDATE MENU SET MENU_TEXT = N'2.13. Đơn vị', MENU_ENGLISH = N'2.13. Unit' WHERE MENU_ID = 'mnuMeasuringUnit'
UPDATE MENU SET MENU_TEXT = N'2.14. Ngày nghỉ lễ', MENU_ENGLISH = N'2.14. Holiday List' WHERE MENU_ID = 'mnuNgaynghile'
UPDATE MENU SET MENU_TEXT = N'2.15.1. Class hư hỏng', MENU_ENGLISH = N'2.15.1. Failure Class' WHERE MENU_ID = 'mnuClass'
UPDATE MENU SET MENU_TEXT = N'2.15.2. Hư hỏng', MENU_ENGLISH = N'2.15.2. Problem' WHERE MENU_ID = 'mnuProblem'
UPDATE MENU SET MENU_TEXT = N'2.15.3. Nguyên nhân hư hỏng', MENU_ENGLISH = N'2.15.3. Breakdown Cause' WHERE MENU_ID = 'mnuCause'
UPDATE MENU SET MENU_TEXT = N'2.16. Danh mục quận huyện', MENU_ENGLISH = N'2.16. District List' WHERE MENU_ID = 'mnuDanhmuctinhquan'
UPDATE MENU SET MENU_TEXT = N'2.17. Danh mục đường', MENU_ENGLISH = N'2.17.Street List' WHERE MENU_ID = 'mnuDanhmucduong'
UPDATE MENU SET MENU_TEXT = N'2.18. Danh mục kho', MENU_ENGLISH = N'2.18. List of Warehouses' WHERE MENU_ID = 'mnuDanhmuckho'
UPDATE MENU SET MENU_TEXT = N'2.19. Quy trình duyệt tài liệu', MENU_ENGLISH = N'2.19. Document Approval Procedure' WHERE MENU_ID = 'mnuDuyetTaiLieu'
UPDATE MENU SET MENU_TEXT = N'2.15. Phân tích hư hỏng', MENU_ENGLISH = N'2.15. Failure Analysis' WHERE MENU_ID = 'mnuDachmuchechuyengia'



















