﻿
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmCapNhatNhanSu' AND KEYWORD =N'frmCapNhatNhanSu') UPDATE LANGUAGES SET VIETNAM=N'Sau chép ngày giờ', ENGLISH=N'Sau chép ngày giờ',CHINESE=N'Sau chép ngày giờ', VIETNAM_OR=N'Sau chép ngày giờ', ENGLISH_OR=N'Sau chép ngày giờ' , CHINESE_OR=N'Sau chép ngày giờ' WHERE FORM=N'frmCapNhatNhanSu' AND KEYWORD=N'frmCapNhatNhanSu' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmCapNhatNhanSu',N'frmCapNhatNhanSu',N'Sau chép ngày giờ',N'Sau chép ngày giờ',N'Sau chép ngày giờ',N'Sau chép ngày giờ',N'Sau chép ngày giờ',N'Sau chép ngày giờ','ECOMAIN')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmCapNhatNhanSu' AND KEYWORD =N'msgChuaChonDuLieuCanCopy') UPDATE LANGUAGES SET VIETNAM=N'Bạn chưa chọn dữ liệu để sao chép', ENGLISH=N'Bạn chưa chọn dữ liệu để sao chép',CHINESE=N'Bạn chưa chọn dữ liệu để sao chép', VIETNAM_OR=N'Bạn chưa chọn dữ liệu để sao chép', ENGLISH_OR=N'Bạn chưa chọn dữ liệu để sao chép' , CHINESE_OR=N'Bạn chưa chọn dữ liệu để sao chép' WHERE FORM=N'frmCapNhatNhanSu' AND KEYWORD=N'msgChuaChonDuLieuCanCopy' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmCapNhatNhanSu',N'msgChuaChonDuLieuCanCopy',N'Bạn chưa chọn dữ liệu để sao chép',N'Bạn chưa chọn dữ liệu để sao chép',N'Bạn chưa chọn dữ liệu để sao chép',N'Bạn chưa chọn dữ liệu để sao chép',N'Bạn chưa chọn dữ liệu để sao chép',N'Bạn chưa chọn dữ liệu để sao chép','ECOMAIN')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmPhieuBaoTri_New' AND KEYWORD =N'btnCopyNS') UPDATE LANGUAGES SET VIETNAM=N'Copy nhân sự', ENGLISH=N'Copy nhân sự',CHINESE=N'Copy nhân sự', VIETNAM_OR=N'Copy nhân sự', ENGLISH_OR=N'Copy nhân sự' , CHINESE_OR=N'Copy nhân sự' WHERE FORM=N'FrmPhieuBaoTri_New' AND KEYWORD=N'btnCopyNS' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'FrmPhieuBaoTri_New',N'btnCopyNS',N'Copy nhân sự',N'Copy nhân sự',N'Copy nhân sự',N'Copy nhân sự',N'Copy nhân sự',N'Copy nhân sự','ECOMAIN')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmPhieuBaoTri_New' AND KEYWORD =N'optKhongTheoCongViec') UPDATE LANGUAGES SET VIETNAM=N'Nhập nhân sự không theo công việc', ENGLISH=N'Nhập nhân sự không theo công việc',CHINESE=N'Nhập nhân sự không theo công việc', VIETNAM_OR=N'Nhập nhân sự không theo công việc', ENGLISH_OR=N'Nhập nhân sự không theo công việc' , CHINESE_OR=N'Nhập nhân sự không theo công việc' WHERE FORM=N'FrmPhieuBaoTri_New' AND KEYWORD=N'optKhongTheoCongViec' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'FrmPhieuBaoTri_New',N'optKhongTheoCongViec',N'Nhập nhân sự không theo công việc',N'Nhập nhân sự không theo công việc',N'Nhập nhân sự không theo công việc',N'Nhập nhân sự không theo công việc',N'Nhập nhân sự không theo công việc',N'Nhập nhân sự không theo công việc','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'FrmPhieuBaoTri_New' AND KEYWORD =N'optTheoCongViec') UPDATE LANGUAGES SET VIETNAM=N'Nhập nhân sự  theo công việc', ENGLISH=N'Nhập nhân sự  theo công việc',CHINESE=N'Nhập nhân sự  theo công việc', VIETNAM_OR=N'Nhập nhân sự  theo công việc', ENGLISH_OR=N'Nhập nhân sự  theo công việc' , CHINESE_OR=N'Nhập nhân sự  theo công việc' WHERE FORM=N'FrmPhieuBaoTri_New' AND KEYWORD=N'optTheoCongViec' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'FrmPhieuBaoTri_New',N'optTheoCongViec',N'Nhập nhân sự  theo công việc',N'Nhập nhân sự  theo công việc',N'Nhập nhân sự  theo công việc',N'Nhập nhân sự  theo công việc',N'Nhập nhân sự  theo công việc',N'Nhập nhân sự  theo công việc','ECOMAIN')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmPhieuBaoTri_NEW' AND KEYWORD =N'SO_GIO_PB_PHUT') UPDATE LANGUAGES SET VIETNAM=N'Số giờ PB (Phút)', ENGLISH=N'Số giờ PB (Phút)',CHINESE=N'Số giờ PB (Phút)', VIETNAM_OR=N'Số giờ PB (Phút)', ENGLISH_OR=N'Số giờ PB (Phút)' , CHINESE_OR=N'Số giờ PB (Phút)' WHERE FORM=N'frmPhieuBaoTri_NEW' AND KEYWORD=N'SO_GIO_PB_PHUT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmPhieuBaoTri_NEW',N'SO_GIO_PB_PHUT',N'Số giờ PB (Phút)',N'Số giờ PB (Phút)',N'Số giờ PB (Phút)',N'Số giờ PB (Phút)',N'Số giờ PB (Phút)',N'Số giờ PB (Phút)','ECOMAIN')




IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'frmChonVTRequestPBT') UPDATE LANGUAGES SET VIETNAM=N'Chọn vật tư', ENGLISH=N'Choose item',CHINESE=N'Choose item', VIETNAM_OR=N'Chọn vật tư', ENGLISH_OR=N'Choose item' , CHINESE_OR=N'Choose item' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'frmChonVTRequestPBT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'frmChonVTRequestPBT',N'Chọn vật tư',N'Choose item',N'Choose item',N'Chọn vật tư',N'Choose item',N'Choose item','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgBanCoChacRequest') UPDATE LANGUAGES SET VIETNAM=N'Bạn có chắc thực hiện !', ENGLISH=N'Are you sure !',CHINESE=N'Are you sure !', VIETNAM_OR=N'Bạn có chắc thực hiện !', ENGLISH_OR=N'Are you sure !' , CHINESE_OR=N'Are you sure !' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgBanCoChacRequest' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgBanCoChacRequest',N'Bạn có chắc thực hiện !',N'Are you sure !',N'Are you sure !',N'Bạn có chắc thực hiện !',N'Are you sure !',N'Are you sure !','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgBanDaNhapSLRequestNenKhongTheNhapSLReturn') UPDATE LANGUAGES SET VIETNAM=N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !', ENGLISH=N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !',CHINESE=N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !', VIETNAM_OR=N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !', ENGLISH_OR=N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !' , CHINESE_OR=N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgBanDaNhapSLRequestNenKhongTheNhapSLReturn' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgBanDaNhapSLRequestNenKhongTheNhapSLReturn',N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !',N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !',N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !',N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !',N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !',N'Bạn đã nhập số lượng request nên không thể nhập số lượng return !','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgBanDaNhapSLReturnNenKhongTheNhapSLRequest') UPDATE LANGUAGES SET VIETNAM=N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !', ENGLISH=N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !',CHINESE=N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !', VIETNAM_OR=N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !', ENGLISH_OR=N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !' , CHINESE_OR=N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgBanDaNhapSLReturnNenKhongTheNhapSLRequest' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgBanDaNhapSLReturnNenKhongTheNhapSLRequest',N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !',N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !',N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !',N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !',N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !',N'Bạn đã nhập số lượng return nên không thể nhập số lượng request !','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgRequestKhongThanhCong') UPDATE LANGUAGES SET VIETNAM=N'Cập nhật không thành công!', ENGLISH=N'Update is unsuccessful !',CHINESE=N'Update is unsuccessful !', VIETNAM_OR=N'Cập nhật không thành công!', ENGLISH_OR=N'Update is unsuccessful !' , CHINESE_OR=N'Update is unsuccessful !' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgRequestKhongThanhCong' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgRequestKhongThanhCong',N'Cập nhật không thành công!',N'Update is unsuccessful !',N'Update is unsuccessful !',N'Cập nhật không thành công!',N'Update is unsuccessful !',N'Update is unsuccessful !','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgRequestThanhCong') UPDATE LANGUAGES SET VIETNAM=N'Cập nhật thành công!', ENGLISH=N'Update is successful !',CHINESE=N'Update is successful !', VIETNAM_OR=N'Cập nhật thành công!', ENGLISH_OR=N'Update is successful !' , CHINESE_OR=N'Update is successful !' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgRequestThanhCong' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgRequestThanhCong',N'Cập nhật thành công!',N'Update is successful !',N'Update is successful !',N'Cập nhật thành công!',N'Update is successful !',N'Update is successful !','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgSLRequestLonHonSLDaPhanBo') UPDATE LANGUAGES SET VIETNAM=N'Số lượng request lớn hơn số lượng đã phân bổ.', ENGLISH=N'Số lượng request lớn hơn số lượng đã phân bổ.',CHINESE=N'Số lượng request lớn hơn số lượng đã phân bổ.', VIETNAM_OR=N'Số lượng request lớn hơn số lượng đã phân bổ.', ENGLISH_OR=N'Số lượng request lớn hơn số lượng đã phân bổ.' , CHINESE_OR=N'Số lượng request lớn hơn số lượng đã phân bổ.' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgSLRequestLonHonSLDaPhanBo' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgSLRequestLonHonSLDaPhanBo',N'Số lượng request lớn hơn số lượng đã phân bổ.',N'Số lượng request lớn hơn số lượng đã phân bổ.',N'Số lượng request lớn hơn số lượng đã phân bổ.',N'Số lượng request lớn hơn số lượng đã phân bổ.',N'Số lượng request lớn hơn số lượng đã phân bổ.',N'Số lượng request lớn hơn số lượng đã phân bổ.','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgSLRequestLonHonSLKH') UPDATE LANGUAGES SET VIETNAM=N'Số lượng request lớn hơn số lượng kế hoạch.', ENGLISH=N'Số lượng request lớn hơn số lượng kế hoạch.',CHINESE=N'Số lượng request lớn hơn số lượng kế hoạch.', VIETNAM_OR=N'Số lượng request lớn hơn số lượng kế hoạch.', ENGLISH_OR=N'Số lượng request lớn hơn số lượng kế hoạch.' , CHINESE_OR=N'Số lượng request lớn hơn số lượng kế hoạch.' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgSLRequestLonHonSLKH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgSLRequestLonHonSLKH',N'Số lượng request lớn hơn số lượng kế hoạch.',N'Số lượng request lớn hơn số lượng kế hoạch.',N'Số lượng request lớn hơn số lượng kế hoạch.',N'Số lượng request lớn hơn số lượng kế hoạch.',N'Số lượng request lớn hơn số lượng kế hoạch.',N'Số lượng request lớn hơn số lượng kế hoạch.','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgSLRequestLonHonSLTon') UPDATE LANGUAGES SET VIETNAM=N'Số lượng request lớn hơn số lượng tồn.', ENGLISH=N'Số lượng request lớn hơn số lượng tồn.',CHINESE=N'Số lượng request lớn hơn số lượng tồn.', VIETNAM_OR=N'Số lượng request lớn hơn số lượng tồn.', ENGLISH_OR=N'Số lượng request lớn hơn số lượng tồn.' , CHINESE_OR=N'Số lượng request lớn hơn số lượng tồn.' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgSLRequestLonHonSLTon' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgSLRequestLonHonSLTon',N'Số lượng request lớn hơn số lượng tồn.',N'Số lượng request lớn hơn số lượng tồn.',N'Số lượng request lớn hơn số lượng tồn.',N'Số lượng request lớn hơn số lượng tồn.',N'Số lượng request lớn hơn số lượng tồn.',N'Số lượng request lớn hơn số lượng tồn.','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgSLRetuenLonHonSLDaPhanBo') UPDATE LANGUAGES SET VIETNAM=N'Số lượng return lớn hơn số lượng đã phân bổ.', ENGLISH=N'Số lượng return lớn hơn số lượng đã phân bổ.',CHINESE=N'Số lượng return lớn hơn số lượng đã phân bổ.', VIETNAM_OR=N'Số lượng return lớn hơn số lượng đã phân bổ.', ENGLISH_OR=N'Số lượng return lớn hơn số lượng đã phân bổ.' , CHINESE_OR=N'Số lượng return lớn hơn số lượng đã phân bổ.' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgSLRetuenLonHonSLDaPhanBo' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgSLRetuenLonHonSLDaPhanBo',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'msgSLReturnLonHonSLDaPhanBo') UPDATE LANGUAGES SET VIETNAM=N'Số lượng return lớn hơn số lượng đã phân bổ.', ENGLISH=N'Số lượng return lớn hơn số lượng đã phân bổ.',CHINESE=N'Số lượng return lớn hơn số lượng đã phân bổ.', VIETNAM_OR=N'Số lượng return lớn hơn số lượng đã phân bổ.', ENGLISH_OR=N'Số lượng return lớn hơn số lượng đã phân bổ.' , CHINESE_OR=N'Số lượng return lớn hơn số lượng đã phân bổ.' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'msgSLReturnLonHonSLDaPhanBo' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'msgSLReturnLonHonSLDaPhanBo',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.',N'Số lượng return lớn hơn số lượng đã phân bổ.','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'SL_DA_REQUEST') UPDATE LANGUAGES SET VIETNAM=N'SL đã Request', ENGLISH=N'SL đã Request',CHINESE=N'SL đã Request', VIETNAM_OR=N'SL đã Request', ENGLISH_OR=N'SL đã Request' , CHINESE_OR=N'SL đã Request' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'SL_DA_REQUEST' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'SL_DA_REQUEST',N'SL đã Request',N'SL đã Request',N'SL đã Request',N'SL đã Request',N'SL đã Request',N'SL đã Request','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'SL_REQUEST') UPDATE LANGUAGES SET VIETNAM=N'SL Request', ENGLISH=N'SL Request',CHINESE=N'SL Request', VIETNAM_OR=N'SL Request', ENGLISH_OR=N'SL Request' , CHINESE_OR=N'SL Request' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'SL_REQUEST' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'SL_REQUEST',N'SL Request',N'SL Request',N'SL Request',N'SL Request',N'SL Request',N'SL Request','ECOMAIN')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD =N'SL_RETURN') UPDATE LANGUAGES SET VIETNAM=N'SL Return', ENGLISH=N'SL Return',CHINESE=N'SL Return', VIETNAM_OR=N'SL Return', ENGLISH_OR=N'SL Return' , CHINESE_OR=N'SL Return' WHERE FORM=N'frmChonVTRequestPBT' AND KEYWORD=N'SL_RETURN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,CHINESE,VIETNAM_OR,ENGLISH_OR,CHINESE_OR,MS_MODULE)  VALUES(N'frmChonVTRequestPBT',N'SL_RETURN',N'SL Return',N'SL Return',N'SL Return',N'SL Return',N'SL Return',N'SL Return','ECOMAIN')
