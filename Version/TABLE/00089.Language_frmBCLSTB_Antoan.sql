﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBCLSTB_Antoan' AND KEYWORD =N'STT_SERVICE') UPDATE LANGUAGES SET VIETNAM=N'Thuê ngoài', ENGLISH=N'Outsourcing', VIETNAM_OR=N'Thuê ngoài', ENGLISH_OR=N'Outsourcing' WHERE FORM=N'frmBCLSTB_Antoan' AND KEYWORD=N'STT_SERVICE' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBCLSTB_Antoan',N'STT_SERVICE',N'Thuê ngoài',N'Outsourcing',N'Thuê ngoài',N'Outsourcing')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBCLSTB_Antoan' AND KEYWORD =N'TIEU_DE') UPDATE LANGUAGES SET VIETNAM=N'LỊCH SỬ BẢO TRÌ CHO CÁC THIẾT BỊ AN TOÀN ', ENGLISH=N'MAINTENANCE HISTORY FOR SAFE EQUIPMENT', VIETNAM_OR=N'LỊCH SỬ BẢO TRÌ CHO CÁC THIẾT BỊ AN TOÀN ', ENGLISH_OR=N'MAINTENANCE HISTORY FOR SAFE EQUIPMENT' WHERE FORM=N'frmBCLSTB_Antoan' AND KEYWORD=N'TIEU_DE' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBCLSTB_Antoan',N'TIEU_DE',N'LỊCH SỬ BẢO TRÌ CHO CÁC THIẾT BỊ AN TOÀN ',N'MAINTENANCE HISTORY FOR SAFE EQUIPMENT',N'LỊCH SỬ BẢO TRÌ CHO CÁC THIẾT BỊ AN TOÀN ',N'MAINTENANCE HISTORY FOR SAFE EQUIPMENT')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmBCLSTB_Antoan' AND KEYWORD =N'THIET_BI') UPDATE LANGUAGES SET VIETNAM=N'Thiết bị', ENGLISH=N'Equipment', VIETNAM_OR=N'Thiết bị', ENGLISH_OR=N'Equipment' WHERE FORM=N'frmBCLSTB_Antoan' AND KEYWORD=N'THIET_BI' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmBCLSTB_Antoan',N'THIET_BI',N'Thiết bị',N'Equipment',N'Thiết bị',N'Equipment')
