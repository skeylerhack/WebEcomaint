﻿IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'msgChuyenGioKHQuaTTAll') UPDATE LANGUAGES SET VIETNAM=N'Chuyển tất cả giờ KH đang chọn qua TT ?', ENGLISH=N'Change all planned time into actual time?', VIETNAM_OR=N'Chuyển tất cả giờ KH đang chọn qua TT ?', ENGLISH_OR=N'Change all planned time into actual time?' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'msgChuyenGioKHQuaTTAll' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'msgChuyenGioKHQuaTTAll',N'Chuyển tất cả giờ KH đang chọn qua TT ?',N'Change all planned time into actual time?',N'Chuyển tất cả giờ KH đang chọn qua TT ?',N'Change all planned time into actual time?')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'msgChuyenGioTTQuaKHAll') UPDATE LANGUAGES SET VIETNAM=N'Chuyển tất cả giờ TT đang chọn qua KH ?', ENGLISH=N'Change all actual time into planned time?', VIETNAM_OR=N'Chuyển tất cả giờ TT đang chọn qua KH ?', ENGLISH_OR=N'Change all actual time into planned time?' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'msgChuyenGioTTQuaKHAll' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'msgChuyenGioTTQuaKHAll',N'Chuyển tất cả giờ TT đang chọn qua KH ?',N'Change all actual time into planned time?',N'Chuyển tất cả giờ TT đang chọn qua KH ?',N'Change all actual time into planned time?')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuChuyenGioKHQuaTTDangChon') UPDATE LANGUAGES SET VIETNAM=N'Chuyển giờ KH qua TT cho nhân viên đang chọn', ENGLISH=N'Change planned time to actual time for selected employee', VIETNAM_OR=N'Chuyển giờ KH qua TT cho nhân viên đang chọn', ENGLISH_OR=N'Change planned time to actual time for selected employee' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuChuyenGioKHQuaTTDangChon' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuChuyenGioKHQuaTTDangChon',N'Chuyển giờ KH qua TT cho nhân viên đang chọn',N'Change planned time to actual time for selected employee',N'Chuyển giờ KH qua TT cho nhân viên đang chọn',N'Change planned time to actual time for selected employee')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuChuyenGioKHQuaTTAll') UPDATE LANGUAGES SET VIETNAM=N'Chuyển giờ KH đang chọn qua TT cho tất cả nhân viên', ENGLISH=N'Change planned time to actual time for all employees', VIETNAM_OR=N'Chuyển giờ KH đang chọn qua TT cho tất cả nhân viên', ENGLISH_OR=N'Change planned time to actual time for all employees' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuChuyenGioKHQuaTTAll' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuChuyenGioKHQuaTTAll',N'Chuyển giờ KH đang chọn qua TT cho tất cả nhân viên',N'Change planned time to actual time for all employees',N'Chuyển giờ KH đang chọn qua TT cho tất cả nhân viên',N'Change planned time to actual time for all employees')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuChuyenGioTTQuaKHDangChon') UPDATE LANGUAGES SET VIETNAM=N'Chuyển giờ TT qua KH cho nhân viên đang chọn', ENGLISH=N'Change actual time to planned time for selected employee', VIETNAM_OR=N'Chuyển giờ TT qua KH cho nhân viên đang chọn', ENGLISH_OR=N'Change actual time to planned time for selected employee' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuChuyenGioTTQuaKHDangChon' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuChuyenGioTTQuaKHDangChon',N'Chuyển giờ TT qua KH cho nhân viên đang chọn',N'Change actual time to planned time for selected employee',N'Chuyển giờ TT qua KH cho nhân viên đang chọn',N'Change actual time to planned time for selected employee')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuChuyenGioTTQuaKHAll') UPDATE LANGUAGES SET VIETNAM=N'Chuyển giờ TT đang chọn qua KH cho tất cả nhân viên', ENGLISH=N'Change actual time to planned time for all employees', VIETNAM_OR=N'Chuyển giờ TT đang chọn qua KH cho tất cả nhân viên', ENGLISH_OR=N'Change actual time to planned time for all employees' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuChuyenGioTTQuaKHAll' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuChuyenGioTTQuaKHAll',N'Chuyển giờ TT đang chọn qua KH cho tất cả nhân viên',N'Change actual time to planned time for all employees',N'Chuyển giờ TT đang chọn qua KH cho tất cả nhân viên',N'Change actual time to planned time for all employees')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'optKH') UPDATE LANGUAGES SET VIETNAM=N'Kế hoạch', ENGLISH=N'Plan', VIETNAM_OR=N'Kế hoạch', ENGLISH_OR=N'Plan' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'optKH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'optKH',N'Kế hoạch',N'Plan',N'Kế hoạch',N'Plan')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'optThucTe') UPDATE LANGUAGES SET VIETNAM=N'Thực tế', ENGLISH=N'Actual', VIETNAM_OR=N'Thực tế', ENGLISH_OR=N'Actual' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'optThucTe' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'optThucTe',N'Thực tế',N'Actual',N'Thực tế',N'Actual')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'NGAY_KH') UPDATE LANGUAGES SET VIETNAM=N'Ngày KH', ENGLISH=N'Plan day', VIETNAM_OR=N'Ngày KH', ENGLISH_OR=N'Plan day' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'NGAY_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'NGAY_KH',N'Ngày KH',N'Plan day',N'Ngày KH',N'Plan day')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'TU_GIO_KH') UPDATE LANGUAGES SET VIETNAM=N'Từ giờ KH', ENGLISH=N'Plan hours', VIETNAM_OR=N'Từ giờ KH', ENGLISH_OR=N'Plan hours' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'TU_GIO_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'TU_GIO_KH',N'Từ giờ KH',N'Plan hours',N'Từ giờ KH',N'Plan hours')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'DEN_GIO_KH') UPDATE LANGUAGES SET VIETNAM=N'Đến giờ KH', ENGLISH=N'Plan to hours', VIETNAM_OR=N'Đến giờ KH', ENGLISH_OR=N'Plan to hours' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'DEN_GIO_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'DEN_GIO_KH',N'Đến giờ KH',N'Plan to hours',N'Đến giờ KH',N'Plan to hours')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'DEN_NGAY_KH') UPDATE LANGUAGES SET VIETNAM=N'Đến ngày KH', ENGLISH=N'Plan to day', VIETNAM_OR=N'Đến ngày KH', ENGLISH_OR=N'Plan to day' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'DEN_NGAY_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'DEN_NGAY_KH',N'Đến ngày KH',N'Plan to day',N'Đến ngày KH',N'Plan to day')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'SO_GIO_KH') UPDATE LANGUAGES SET VIETNAM=N'Số giờ KH', ENGLISH=N'Plan Total hours', VIETNAM_OR=N'Số giờ KH', ENGLISH_OR=N'Plan Total hours' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'SO_GIO_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'SO_GIO_KH',N'Số giờ KH',N'Plan Total hours',N'Số giờ KH',N'Plan Total hours')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'KhongCoDuLieu') UPDATE LANGUAGES SET VIETNAM=N'Không có dữ liệu', ENGLISH=N'No data', VIETNAM_OR=N'Không có dữ liệu', ENGLISH_OR=N'No data' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'KhongCoDuLieu' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'KhongCoDuLieu',N'Không có dữ liệu',N'No data',N'Không có dữ liệu',N'No data')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'tabCuaSoBT') UPDATE LANGUAGES SET VIETNAM=N'Cửa sổ bảo trì', ENGLISH=N'Window maintenance', VIETNAM_OR=N'Cửa sổ bảo trì', ENGLISH_OR=N'Window maintenance' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'tabCuaSoBT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'tabCuaSoBT',N'Cửa sổ bảo trì',N'Window maintenance',N'Cửa sổ bảo trì',N'Window maintenance')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'TONG_GIO_KH') UPDATE LANGUAGES SET VIETNAM=N'Số giờ KH', ENGLISH=N'Plan total hours', VIETNAM_OR=N'Số giờ KH', ENGLISH_OR=N'Plan total hours' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'TONG_GIO_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'TONG_GIO_KH',N'Số giờ KH',N'Plan total hours',N'Số giờ KH',N'Plan total hours')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD =N'SO_PHUT_KH') UPDATE LANGUAGES SET VIETNAM=N'Số phút KH', ENGLISH=N'Plan minutes', VIETNAM_OR=N'Số phút KH', ENGLISH_OR=N'Plan minutes' WHERE FORM=N'frmPhieuBaoTri_New' AND KEYWORD=N'SO_PHUT_KH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmPhieuBaoTri_New',N'SO_PHUT_KH',N'Số phút KH',N'Plan minutes',N'Số phút KH',N'Plan minutes')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuThemTatCaThoiGian') UPDATE LANGUAGES SET VIETNAM=N'Thêm thời gian cho tất cả nhân sự', ENGLISH=N'Add time for all employees', VIETNAM_OR=N'Thêm thời gian cho tất cả nhân sự', ENGLISH_OR=N'Add time for all employees' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuThemTatCaThoiGian' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuThemTatCaThoiGian',N'Thêm thời gian cho tất cả nhân sự',N'Add time for all employees',N'Thêm thời gian cho tất cả nhân sự',N'Add time for all employees')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuBoTatCaThoiGian') UPDATE LANGUAGES SET VIETNAM=N'Bỏ thời gian của tất cả nhân sự', ENGLISH=N'Undo time for all employees', VIETNAM_OR=N'Bỏ thời gian của tất cả nhân sự', ENGLISH_OR=N'Undo time for all employees' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuBoTatCaThoiGian' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuBoTatCaThoiGian',N'Bỏ thời gian của tất cả nhân sự',N'Undo time for all employees',N'Bỏ thời gian của tất cả nhân sự',N'Undo time for all employees')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuThemDongDangChon') UPDATE LANGUAGES SET VIETNAM=N'Thêm thời gian cho nhân sự đang chọn', ENGLISH=N'Add time for selected employee', VIETNAM_OR=N'Thêm thời gian cho nhân sự đang chọn', ENGLISH_OR=N'Add time for selected employee' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuThemDongDangChon' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuThemDongDangChon',N'Thêm thời gian cho nhân sự đang chọn',N'Add time for selected employee',N'Thêm thời gian cho nhân sự đang chọn',N'Add time for selected employee')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuBoDongDangChon') UPDATE LANGUAGES SET VIETNAM=N'Bỏ thời gian của nhân sự đang chọn', ENGLISH=N'Undo time for selected employee', VIETNAM_OR=N'Bỏ thời gian của nhân sự đang chọn', ENGLISH_OR=N'Undo time for selected employee' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuBoDongDangChon' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuBoDongDangChon',N'Bỏ thời gian của nhân sự đang chọn',N'Undo time for selected employee',N'Bỏ thời gian của nhân sự đang chọn',N'Undo time for selected employee')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuSaoChep') UPDATE LANGUAGES SET VIETNAM=N'Sao chép ngày giờ cho các nhân viên của CV này', ENGLISH=N'Copy time for involved personnels', VIETNAM_OR=N'Sao chép ngày giờ cho các nhân viên của CV này', ENGLISH_OR=N'Copy time for involved personnels' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuSaoChep' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmMain',N'mnuSaoChep',N'Sao chép ngày giờ cho các nhân viên của CV này',N'Copy time for involved personnels',N'Sao chép ngày giờ cho các nhân viên của CV này',N'Copy time for involved personnels')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuHyperLinkmnuPBT') UPDATE LANGUAGES SET VIETNAM=N'Link đến phiếu bảo trì', ENGLISH=N'Link to work order',CHINESE=N'Link to work order', VIETNAM_OR=N'Link đến phiếu bảo trì', ENGLISH_OR=N'Link to work order' , CHINESE_OR=N'Link to work order' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuHyperLinkmnuPBT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmMain',N'mnuHyperLinkmnuPBT',N'Link đến phiếu bảo trì',N'Link to work order',N'Link to work order',N'Link đến phiếu bảo trì',N'Link to work order',N'Link to work order','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuHyperLinkNewPhieuBaoTri') UPDATE LANGUAGES SET VIETNAM=N'Lập phiếu bảo trì', ENGLISH=N'Add work order',CHINESE=N'Add work order', VIETNAM_OR=N'Lập phiếu bảo trì', ENGLISH_OR=N'Add work order' , CHINESE_OR=N'Add work order' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuHyperLinkNewPhieuBaoTri' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmMain',N'mnuHyperLinkNewPhieuBaoTri',N'Lập phiếu bảo trì',N'Add work order',N'Add work order',N'Lập phiếu bảo trì',N'Add work order',N'Add work order','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmMain' AND KEYWORD =N'mnuHyperLinkLapPhieuBaoTri') UPDATE LANGUAGES SET VIETNAM=N'Lập phiếu bảo trì', ENGLISH=N'Add work order',CHINESE=N'Add work order', VIETNAM_OR=N'Lập phiếu bảo trì', ENGLISH_OR=N'Add work order' , CHINESE_OR=N'Add work order' WHERE FORM=N'frmMain' AND KEYWORD=N'mnuHyperLinkLapPhieuBaoTri' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmMain',N'mnuHyperLinkLapPhieuBaoTri',N'Lập phiếu bảo trì',N'Add work order',N'Add work order',N'Lập phiếu bảo trì',N'Add work order',N'Add work order','ECOMAIN')
