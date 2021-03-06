IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDonDatHang_New' AND KEYWORD =N'btnInPR') UPDATE LANGUAGES SET VIETNAM=N'In đề xuất ', ENGLISH=N'Print PR', VIETNAM_OR=N'In đề xuất ', ENGLISH_OR=N'Print PR' WHERE FORM=N'frmDonDatHang_New' AND KEYWORD=N'btnInPR' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDonDatHang_New',N'btnInPR',N'In đề xuất ',N'Print PR',N'In đề xuất ',N'Print PR')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmNhacungcap' AND KEYWORD =N'NGUOI_HUONG') UPDATE LANGUAGES SET VIETNAM=N'Mặc định', ENGLISH=N'Default', VIETNAM_OR=N'Mặc định', ENGLISH_OR=N'Default' WHERE FORM=N'frmNhacungcap' AND KEYWORD=N'NGUOI_HUONG' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmNhacungcap',N'NGUOI_HUONG',N'Mặc định',N'Default',N'Mặc định',N'Default')

IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmNhacungcap' AND KEYWORD =N'NGUOI_HUONG') UPDATE LANGUAGES SET VIETNAM=N'Người hưởng', ENGLISH=N'Người hưởng', VIETNAM_OR=N'Người hưởng', ENGLISH_OR=N'Người hưởng' WHERE FORM=N'frmNhacungcap' AND KEYWORD=N'NGUOI_HUONG' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmNhacungcap',N'NGUOI_HUONG',N'Người hưởng',N'Người hưởng',N'Người hưởng',N'Người hưởng')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmNhacungcap' AND KEYWORD =N'SO_TAI_KHOAN') UPDATE LANGUAGES SET VIETNAM=N'Số tài khoản', ENGLISH=N'Bank ID', VIETNAM_OR=N'Số tài khoản', ENGLISH_OR=N'Bank ID' WHERE FORM=N'frmNhacungcap' AND KEYWORD=N'SO_TAI_KHOAN' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmNhacungcap',N'SO_TAI_KHOAN',N'Số tài khoản',N'Bank ID',N'Số tài khoản',N'Bank ID')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmNhacungcap' AND KEYWORD =N'TEN_NH') UPDATE LANGUAGES SET VIETNAM=N'Tên ngân hàng', ENGLISH=N'Bank name', VIETNAM_OR=N'Tên ngân hàng', ENGLISH_OR=N'Bank name' WHERE FORM=N'frmNhacungcap' AND KEYWORD=N'TEN_NH' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmNhacungcap',N'TEN_NH',N'Tên ngân hàng',N'Bank name',N'Tên ngân hàng',N'Bank name')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmNhacungcap' AND KEYWORD =N'SWIFT_CODE') UPDATE LANGUAGES SET VIETNAM=N'Swift code', ENGLISH=N'Swift code', VIETNAM_OR=N'Swift code', ENGLISH_OR=N'Swift code' WHERE FORM=N'frmNhacungcap' AND KEYWORD=N'SWIFT_CODE' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmNhacungcap',N'SWIFT_CODE',N'Swift code',N'Swift code',N'Swift code',N'Swift code')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'InternaleMemorandum') UPDATE LANGUAGES SET VIETNAM=N'INTERNAL MEMORANDUM', ENGLISH=N'INTERNAL MEMORANDUM', VIETNAM_OR=N'INTERNAL MEMORANDUM', ENGLISH_OR=N'INTERNAL MEMORANDUM' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'InternaleMemorandum' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'InternaleMemorandum',N'INTERNAL MEMORANDUM',N'INTERNAL MEMORANDUM',N'INTERNAL MEMORANDUM',N'INTERNAL MEMORANDUM')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'sheetPurchaseOrder') UPDATE LANGUAGES SET VIETNAM=N'PO', ENGLISH=N'PO', VIETNAM_OR=N'PO', ENGLISH_OR=N'PO' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'sheetPurchaseOrder' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'sheetPurchaseOrder',N'PO',N'PO',N'PO',N'PO')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'TenCongTyEng') UPDATE LANGUAGES SET VIETNAM=N'SHISEIDO VIETNAM INC', ENGLISH=N'SHISEIDO VIETNAM INC', VIETNAM_OR=N'SHISEIDO VIETNAM INC', ENGLISH_OR=N'SHISEIDO VIETNAM INC' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'TenCongTyEng' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'TenCongTyEng',N'SHISEIDO VIETNAM INC',N'SHISEIDO VIETNAM INC',N'SHISEIDO VIETNAM INC',N'SHISEIDO VIETNAM INC')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'TenCongTyViet') UPDATE LANGUAGES SET VIETNAM=N'Công ty TNHH Shiseido Việt Nam', ENGLISH=N'Công ty TNHH Shiseido Việt Nam', VIETNAM_OR=N'Công ty TNHH Shiseido Việt Nam', ENGLISH_OR=N'Công ty TNHH Shiseido Việt Nam' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'TenCongTyViet' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'TenCongTyViet',N'Công ty TNHH Shiseido Việt Nam',N'Công ty TNHH Shiseido Việt Nam',N'Công ty TNHH Shiseido Việt Nam',N'Công ty TNHH Shiseido Việt Nam')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'PurchaseRequestTitleEng') UPDATE LANGUAGES SET VIETNAM=N'PURCHASE REQUEST', ENGLISH=N'PURCHASE REQUEST', VIETNAM_OR=N'PURCHASE REQUEST', ENGLISH_OR=N'PURCHASE REQUEST' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'PurchaseRequestTitleEng' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'PurchaseRequestTitleEng',N'PURCHASE REQUEST',N'PURCHASE REQUEST',N'PURCHASE REQUEST',N'PURCHASE REQUEST')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'PurchaseRequestTitleViet') UPDATE LANGUAGES SET VIETNAM=N'(Phiếu đề nghị mua hàng)', ENGLISH=N'(Phiếu đề nghị mua hàng)', VIETNAM_OR=N'(Phiếu đề nghị mua hàng)', ENGLISH_OR=N'(Phiếu đề nghị mua hàng)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'PurchaseRequestTitleViet' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'PurchaseRequestTitleViet',N'(Phiếu đề nghị mua hàng)',N'(Phiếu đề nghị mua hàng)',N'(Phiếu đề nghị mua hàng)',N'(Phiếu đề nghị mua hàng)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'No.') UPDATE LANGUAGES SET VIETNAM=N'No:', ENGLISH=N'No:', VIETNAM_OR=N'No:', ENGLISH_OR=N'No:' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'No.' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'No.',N'No:',N'No:',N'No:',N'No:')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Date') UPDATE LANGUAGES SET VIETNAM=N'Date:', ENGLISH=N'Date:', VIETNAM_OR=N'Date:', ENGLISH_OR=N'Date:' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Date' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Date',N'Date:',N'Date:',N'Date:',N'Date:')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'EmployeeRequest') UPDATE LANGUAGES SET VIETNAM=N'Employee request:
(Người đề nghị) ', ENGLISH=N'Employee request:
(Người đề nghị) ', VIETNAM_OR=N'Employee request:
(Người đề nghị) ', ENGLISH_OR=N'Employee request:
(Người đề nghị) ' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'EmployeeRequest' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'EmployeeRequest',N'Employee request:
(Người đề nghị) ',N'Employee request:
(Người đề nghị) ',N'Employee request:
(Người đề nghị) ',N'Employee request:
(Người đề nghị) ')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'ProjectsWork') UPDATE LANGUAGES SET VIETNAM=N'Projects/ work 
(dự án/công việc):', ENGLISH=N'Projects/ work 
(dự án/công việc):', VIETNAM_OR=N'Projects/ work 
(dự án/công việc):', ENGLISH_OR=N'Projects/ work 
(dự án/công việc):' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'ProjectsWork' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'ProjectsWork',N'Projects/ work 
(dự án/công việc):',N'Projects/ work 
(dự án/công việc):',N'Projects/ work 
(dự án/công việc):',N'Projects/ work 
(dự án/công việc):')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Purpose') UPDATE LANGUAGES SET VIETNAM=N'Purpose (mục đích):', ENGLISH=N'Purpose (mục đích):', VIETNAM_OR=N'Purpose (mục đích):', ENGLISH_OR=N'Purpose (mục đích):' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Purpose' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Purpose',N'Purpose (mục đích):',N'Purpose (mục đích):',N'Purpose (mục đích):',N'Purpose (mục đích):')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Seller') UPDATE LANGUAGES SET VIETNAM=N'Seller: 
(Nhà cung cấp)   ', ENGLISH=N'Seller: 
(Nhà cung cấp)   ', VIETNAM_OR=N'Seller: 
(Nhà cung cấp)   ', ENGLISH_OR=N'Seller: 
(Nhà cung cấp)   ' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Seller' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Seller',N'Seller: 
(Nhà cung cấp)   ',N'Seller: 
(Nhà cung cấp)   ',N'Seller: 
(Nhà cung cấp)   ',N'Seller: 
(Nhà cung cấp)   ')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'DeliveryTerms') UPDATE LANGUAGES SET VIETNAM=N'Delivery Terms 
(điều kiện giao hàng)', ENGLISH=N'Delivery Terms 
(điều kiện giao hàng)', VIETNAM_OR=N'Delivery Terms 
(điều kiện giao hàng)', ENGLISH_OR=N'Delivery Terms 
(điều kiện giao hàng)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'DeliveryTerms' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'DeliveryTerms',N'Delivery Terms 
(điều kiện giao hàng)',N'Delivery Terms 
(điều kiện giao hàng)',N'Delivery Terms 
(điều kiện giao hàng)',N'Delivery Terms 
(điều kiện giao hàng)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Dept') UPDATE LANGUAGES SET VIETNAM=N'Dept:
(Phòng ban)', ENGLISH=N'Dept:
(Phòng ban)', VIETNAM_OR=N'Dept:
(Phòng ban)', ENGLISH_OR=N'Dept:
(Phòng ban)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Dept' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Dept',N'Dept:
(Phòng ban)',N'Dept:
(Phòng ban)',N'Dept:
(Phòng ban)',N'Dept:
(Phòng ban)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'STT') UPDATE LANGUAGES SET VIETNAM=N'No
(STT)', ENGLISH=N'No
(STT)', VIETNAM_OR=N'No
(STT)', ENGLISH_OR=N'No
(STT)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'STT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'STT',N'No
(STT)',N'No
(STT)',N'No
(STT)',N'No
(STT)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Address') UPDATE LANGUAGES SET VIETNAM=N'Address:
(Địa chỉ)', ENGLISH=N'Address:
(Địa chỉ)', VIETNAM_OR=N'Address:
(Địa chỉ)', ENGLISH_OR=N'Address:
(Địa chỉ)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Address' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Address',N'Address:
(Địa chỉ)',N'Address:
(Địa chỉ)',N'Address:
(Địa chỉ)',N'Address:
(Địa chỉ)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'TimeToDelivery') UPDATE LANGUAGES SET VIETNAM=N'Time to delivery 
(thời gian giao hàng)', ENGLISH=N'Time to delivery 
(thời gian giao hàng)', VIETNAM_OR=N'Time to delivery 
(thời gian giao hàng)', ENGLISH_OR=N'Time to delivery 
(thời gian giao hàng)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'TimeToDelivery' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'TimeToDelivery',N'Time to delivery 
(thời gian giao hàng)',N'Time to delivery 
(thời gian giao hàng)',N'Time to delivery 
(thời gian giao hàng)',N'Time to delivery 
(thời gian giao hàng)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'OthersVendor') UPDATE LANGUAGES SET VIETNAM=N'Other vendors considered', ENGLISH=N'Other vendors considered', VIETNAM_OR=N'Other vendors considered', ENGLISH_OR=N'Other vendors considered' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'OthersVendor' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'OthersVendor',N'Other vendors considered',N'Other vendors considered',N'Other vendors considered',N'Other vendors considered')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Yes') UPDATE LANGUAGES SET VIETNAM=N'YES', ENGLISH=N'YES', VIETNAM_OR=N'YES', ENGLISH_OR=N'YES' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Yes' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Yes',N'YES',N'YES',N'YES',N'YES')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'No') UPDATE LANGUAGES SET VIETNAM=N'NO', ENGLISH=N'NO', VIETNAM_OR=N'NO', ENGLISH_OR=N'NO' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'No' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'No',N'NO',N'NO',N'NO',N'NO')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Vendor1') UPDATE LANGUAGES SET VIETNAM=N'Vendor 1', ENGLISH=N'Vendor 1', VIETNAM_OR=N'Vendor 1', ENGLISH_OR=N'Vendor 1' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Vendor1' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Vendor1',N'Vendor 1',N'Vendor 1',N'Vendor 1',N'Vendor 1')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Vendor2') UPDATE LANGUAGES SET VIETNAM=N'Vendor 2', ENGLISH=N'Vendor 2', VIETNAM_OR=N'Vendor 2', ENGLISH_OR=N'Vendor 2' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Vendor2' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Vendor2',N'Vendor 2',N'Vendor 2',N'Vendor 2',N'Vendor 2')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Vendor3') UPDATE LANGUAGES SET VIETNAM=N'Vendor 3', ENGLISH=N'Vendor 3', VIETNAM_OR=N'Vendor 3', ENGLISH_OR=N'Vendor 3' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Vendor3' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Vendor3',N'Vendor 3',N'Vendor 3',N'Vendor 3',N'Vendor 3')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Item') UPDATE LANGUAGES SET VIETNAM=N'Item
(Mặt hàng)', ENGLISH=N'Item
(Mặt hàng)', VIETNAM_OR=N'Item
(Mặt hàng)', ENGLISH_OR=N'Item
(Mặt hàng)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Item' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Item',N'Item
(Mặt hàng)',N'Item
(Mặt hàng)',N'Item
(Mặt hàng)',N'Item
(Mặt hàng)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Quantity') UPDATE LANGUAGES SET VIETNAM=N'Quantity
(Số lượng)', ENGLISH=N'Quantity
(Số lượng)', VIETNAM_OR=N'Quantity
(Số lượng)', ENGLISH_OR=N'Quantity
(Số lượng)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Quantity' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Quantity',N'Quantity
(Số lượng)',N'Quantity
(Số lượng)',N'Quantity
(Số lượng)',N'Quantity
(Số lượng)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Unit') UPDATE LANGUAGES SET VIETNAM=N'Unit
(Đơn vị)', ENGLISH=N'Unit
(Đơn vị)', VIETNAM_OR=N'Unit
(Đơn vị)', ENGLISH_OR=N'Unit
(Đơn vị)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Unit' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Unit',N'Unit
(Đơn vị)',N'Unit
(Đơn vị)',N'Unit
(Đơn vị)',N'Unit
(Đơn vị)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Estimates') UPDATE LANGUAGES SET VIETNAM=N'Estimates UP
(Giá dự tính)', ENGLISH=N'Estimates UP
(Giá dự tính)', VIETNAM_OR=N'Estimates UP
(Giá dự tính)', ENGLISH_OR=N'Estimates UP
(Giá dự tính)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Estimates' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Estimates',N'Estimates UP
(Giá dự tính)',N'Estimates UP
(Giá dự tính)',N'Estimates UP
(Giá dự tính)',N'Estimates UP
(Giá dự tính)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'VAT') UPDATE LANGUAGES SET VIETNAM=N'VAT %', ENGLISH=N'VAT %', VIETNAM_OR=N'VAT %', ENGLISH_OR=N'VAT %' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'VAT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'VAT',N'VAT %',N'VAT %',N'VAT %',N'VAT %')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'VATValue') UPDATE LANGUAGES SET VIETNAM=N'VAT Value
(giá trị VAT)', ENGLISH=N'VAT Value
(giá trị VAT)', VIETNAM_OR=N'VAT Value
(giá trị VAT)', ENGLISH_OR=N'VAT Value
(giá trị VAT)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'VATValue' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'VATValue',N'VAT Value
(giá trị VAT)',N'VAT Value
(giá trị VAT)',N'VAT Value
(giá trị VAT)',N'VAT Value
(giá trị VAT)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'AmountIn') UPDATE LANGUAGES SET VIETNAM=N'Amount In ', ENGLISH=N'Amount In ', VIETNAM_OR=N'Amount In ', ENGLISH_OR=N'Amount In ' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'AmountIn' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'AmountIn',N'Amount In ',N'Amount In ',N'Amount In ',N'Amount In ')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Total') UPDATE LANGUAGES SET VIETNAM=N'Total (Tổng cộng):', ENGLISH=N'Total (Tổng cộng):', VIETNAM_OR=N'Total (Tổng cộng):', ENGLISH_OR=N'Total (Tổng cộng):' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Total' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Total',N'Total (Tổng cộng):',N'Total (Tổng cộng):',N'Total (Tổng cộng):',N'Total (Tổng cộng):')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'VATGTGT') UPDATE LANGUAGES SET VIETNAM=N'Thuế GTGT (VAT)', ENGLISH=N'Thuế GTGT (VAT)', VIETNAM_OR=N'Thuế GTGT (VAT)', ENGLISH_OR=N'Thuế GTGT (VAT)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'VATGTGT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'VATGTGT',N'Thuế GTGT (VAT)',N'Thuế GTGT (VAT)',N'Thuế GTGT (VAT)',N'Thuế GTGT (VAT)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'TotalInclude') UPDATE LANGUAGES SET VIETNAM=N'Total (Tổng cộng giá sau thuế):', ENGLISH=N'Total (Tổng cộng giá sau thuế):', VIETNAM_OR=N'Total (Tổng cộng giá sau thuế):', ENGLISH_OR=N'Total (Tổng cộng giá sau thuế):' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'TotalInclude' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'TotalInclude',N'Total (Tổng cộng giá sau thuế):',N'Total (Tổng cộng giá sau thuế):',N'Total (Tổng cộng giá sau thuế):',N'Total (Tổng cộng giá sau thuế):')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'PriceIncludingVAT') UPDATE LANGUAGES SET VIETNAM=N'Price including VAT (Giá gồm thuế GTGT): 0%', ENGLISH=N'Price including VAT (Giá gồm thuế GTGT): 0%', VIETNAM_OR=N'Price including VAT (Giá gồm thuế GTGT): 0%', ENGLISH_OR=N'Price including VAT (Giá gồm thuế GTGT): 0%' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'PriceIncludingVAT' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'PriceIncludingVAT',N'Price including VAT (Giá gồm thuế GTGT): 0%',N'Price including VAT (Giá gồm thuế GTGT): 0%',N'Price including VAT (Giá gồm thuế GTGT): 0%',N'Price including VAT (Giá gồm thuế GTGT): 0%')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'PriceIncludingCharge') UPDATE LANGUAGES SET VIETNAM=N'Price including charge of customs declaration (Giá bao gồm phí khai hải quan)', ENGLISH=N'Price including charge of customs declaration (Giá bao gồm phí khai hải quan)', VIETNAM_OR=N'Price including charge of customs declaration (Giá bao gồm phí khai hải quan)', ENGLISH_OR=N'Price including charge of customs declaration (Giá bao gồm phí khai hải quan)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'PriceIncludingCharge' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'PriceIncludingCharge',N'Price including charge of customs declaration (Giá bao gồm phí khai hải quan)',N'Price including charge of customs declaration (Giá bao gồm phí khai hải quan)',N'Price including charge of customs declaration (Giá bao gồm phí khai hải quan)',N'Price including charge of customs declaration (Giá bao gồm phí khai hải quan)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'RequestedDept') UPDATE LANGUAGES SET VIETNAM=N'Requested Dept', ENGLISH=N'Requested Dept', VIETNAM_OR=N'Requested Dept', ENGLISH_OR=N'Requested Dept' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'RequestedDept' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'RequestedDept',N'Requested Dept',N'Requested Dept',N'Requested Dept',N'Requested Dept')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'CheckedDept ') UPDATE LANGUAGES SET VIETNAM=N'Checked Dept', ENGLISH=N'Checked Dept', VIETNAM_OR=N'Checked Dept', ENGLISH_OR=N'Checked Dept' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'CheckedDept ' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'CheckedDept ',N'Checked Dept',N'Checked Dept',N'Checked Dept',N'Checked Dept')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Approved') UPDATE LANGUAGES SET VIETNAM=N'Approved', ENGLISH=N'Approved', VIETNAM_OR=N'Approved', ENGLISH_OR=N'Approved' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Approved' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Approved',N'Approved',N'Approved',N'Approved',N'Approved')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'RequestedBy') UPDATE LANGUAGES SET VIETNAM=N'Requested by,', ENGLISH=N'Requested by,', VIETNAM_OR=N'Requested by,', ENGLISH_OR=N'Requested by,' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'RequestedBy' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'RequestedBy',N'Requested by,',N'Requested by,',N'Requested by,',N'Requested by,')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'CheckedBy') UPDATE LANGUAGES SET VIETNAM=N'Checked by,', ENGLISH=N'Checked by,', VIETNAM_OR=N'Checked by,', ENGLISH_OR=N'Checked by,' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'CheckedBy' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'CheckedBy',N'Checked by,',N'Checked by,',N'Checked by,',N'Checked by,')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'NameSign') UPDATE LANGUAGES SET VIETNAM=N'Name & sign,', ENGLISH=N'Name & sign,', VIETNAM_OR=N'Name & sign,', ENGLISH_OR=N'Name & sign,' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'NameSign' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'NameSign',N'Name & sign,',N'Name & sign,',N'Name & sign,',N'Name & sign,')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'PDManager') UPDATE LANGUAGES SET VIETNAM=N'(PD S manager)', ENGLISH=N'(PD S manager)', VIETNAM_OR=N'(PD S manager)', ENGLISH_OR=N'(PD S manager)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'PDManager' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'PDManager',N'(PD S manager)',N'(PD S manager)',N'(PD S manager)',N'(PD S manager)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'NameSign1') UPDATE LANGUAGES SET VIETNAM=N'KEIGO OKAHARA', ENGLISH=N'KEIGO OKAHARA', VIETNAM_OR=N'KEIGO OKAHARA', ENGLISH_OR=N'KEIGO OKAHARA' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'NameSign1' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'NameSign1',N'KEIGO OKAHARA',N'KEIGO OKAHARA',N'KEIGO OKAHARA',N'KEIGO OKAHARA')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'FAManager') UPDATE LANGUAGES SET VIETNAM=N'(FA S manager)', ENGLISH=N'(FA S manager)', VIETNAM_OR=N'(FA S manager)', ENGLISH_OR=N'(FA S manager)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'FAManager' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'FAManager',N'(FA S manager)',N'(FA S manager)',N'(FA S manager)',N'(FA S manager)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'NameSign3') UPDATE LANGUAGES SET VIETNAM=N'KENICHI SAITO', ENGLISH=N'KENICHI SAITO', VIETNAM_OR=N'KENICHI SAITO', ENGLISH_OR=N'KENICHI SAITO' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'NameSign3' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'NameSign3',N'KENICHI SAITO',N'KENICHI SAITO',N'KENICHI SAITO',N'KENICHI SAITO')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'NameSign2') UPDATE LANGUAGES SET VIETNAM=N'TOMOHIKO NONAKA', ENGLISH=N'TOMOHIKO NONAKA', VIETNAM_OR=N'TOMOHIKO NONAKA', ENGLISH_OR=N'TOMOHIKO NONAKA' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'NameSign2' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'NameSign2',N'TOMOHIKO NONAKA',N'TOMOHIKO NONAKA',N'TOMOHIKO NONAKA',N'TOMOHIKO NONAKA')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'Director') UPDATE LANGUAGES SET VIETNAM=N'(General Director)', ENGLISH=N'(General Director)', VIETNAM_OR=N'(General Director)', ENGLISH_OR=N'(General Director)' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'Director' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'Director',N'(General Director)',N'(General Director)',N'(General Director)',N'(General Director)')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'NotesEng') UPDATE LANGUAGES SET VIETNAM=N'Notes: This Purchase Request is for internal use only, not be Purchase Order to above supplier', ENGLISH=N'Notes: This Purchase Request is for internal use only, not be Purchase Order to above supplier', VIETNAM_OR=N'Notes: This Purchase Request is for internal use only, not be Purchase Order to above supplier', ENGLISH_OR=N'Notes: This Purchase Request is for internal use only, not be Purchase Order to above supplier' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'NotesEng' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'NotesEng',N'Notes: This Purchase Request is for internal use only, not be Purchase Order to above supplier',N'Notes: This Purchase Request is for internal use only, not be Purchase Order to above supplier',N'Notes: This Purchase Request is for internal use only, not be Purchase Order to above supplier',N'Notes: This Purchase Request is for internal use only, not be Purchase Order to above supplier')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'NotesViet') UPDATE LANGUAGES SET VIETNAM=N'Ghi Chú: Phiếu đề nghị mua hàng chỉ sử dụng lưu hành nội bộ, không có giá trị là đơn đặt hàng đối với nhà cung cấp nêu trên', ENGLISH=N'Ghi Chú: Phiếu đề nghị mua hàng chỉ sử dụng lưu hành nội bộ, không có giá trị là đơn đặt hàng đối với nhà cung cấp nêu trên', VIETNAM_OR=N'Ghi Chú: Phiếu đề nghị mua hàng chỉ sử dụng lưu hành nội bộ, không có giá trị là đơn đặt hàng đối với nhà cung cấp nêu trên', ENGLISH_OR=N'Ghi Chú: Phiếu đề nghị mua hàng chỉ sử dụng lưu hành nội bộ, không có giá trị là đơn đặt hàng đối với nhà cung cấp nêu trên' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'NotesViet' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'NotesViet',N'Ghi Chú: Phiếu đề nghị mua hàng chỉ sử dụng lưu hành nội bộ, không có giá trị là đơn đặt hàng đối với nhà cung cấp nêu trên',N'Ghi Chú: Phiếu đề nghị mua hàng chỉ sử dụng lưu hành nội bộ, không có giá trị là đơn đặt hàng đối với nhà cung cấp nêu trên',N'Ghi Chú: Phiếu đề nghị mua hàng chỉ sử dụng lưu hành nội bộ, không có giá trị là đơn đặt hàng đối với nhà cung cấp nêu trên',N'Ghi Chú: Phiếu đề nghị mua hàng chỉ sử dụng lưu hành nội bộ, không có giá trị là đơn đặt hàng đối với nhà cung cấp nêu trên')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'POAuthorization') UPDATE LANGUAGES SET VIETNAM=N'1. PO will be approved as authorization letter/ PO được phê duyệt theo giấy ủy quyền', ENGLISH=N'1. PO will be approved as authorization letter/ PO được phê duyệt theo giấy ủy quyền', VIETNAM_OR=N'1. PO will be approved as authorization letter/ PO được phê duyệt theo giấy ủy quyền', ENGLISH_OR=N'1. PO will be approved as authorization letter/ PO được phê duyệt theo giấy ủy quyền' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'POAuthorization' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'POAuthorization',N'1. PO will be approved as authorization letter/ PO được phê duyệt theo giấy ủy quyền',N'1. PO will be approved as authorization letter/ PO được phê duyệt theo giấy ủy quyền',N'1. PO will be approved as authorization letter/ PO được phê duyệt theo giấy ủy quyền',N'1. PO will be approved as authorization letter/ PO được phê duyệt theo giấy ủy quyền')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'POExpense') UPDATE LANGUAGES SET VIETNAM=N'2. PR will be approved as expense value/ PR được phê duyệt theo chi phí', ENGLISH=N'2. PR will be approved as expense value/ PR được phê duyệt theo chi phí', VIETNAM_OR=N'2. PR will be approved as expense value/ PR được phê duyệt theo chi phí', ENGLISH_OR=N'2. PR will be approved as expense value/ PR được phê duyệt theo chi phí' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'POExpense' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'POExpense',N'2. PR will be approved as expense value/ PR được phê duyệt theo chi phí',N'2. PR will be approved as expense value/ PR được phê duyệt theo chi phí',N'2. PR will be approved as expense value/ PR được phê duyệt theo chi phí',N'2. PR will be approved as expense value/ PR được phê duyệt theo chi phí')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'SeniorManager') UPDATE LANGUAGES SET VIETNAM=N'< 30,000,000 VND (< 1,500 USD): Senior manager', ENGLISH=N'< 30,000,000 VND (< 1,500 USD): Senior manager', VIETNAM_OR=N'< 30,000,000 VND (< 1,500 USD): Senior manager', ENGLISH_OR=N'< 30,000,000 VND (< 1,500 USD): Senior manager' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'SeniorManager' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'SeniorManager',N'< 30,000,000 VND (< 1,500 USD): Senior manager',N'< 30,000,000 VND (< 1,500 USD): Senior manager',N'< 30,000,000 VND (< 1,500 USD): Senior manager',N'< 30,000,000 VND (< 1,500 USD): Senior manager')
IF EXISTS (SELECT * FROM LANGUAGES WHERE FORM=N'frmDXMH_SSD' AND KEYWORD =N'GeneralDirector') UPDATE LANGUAGES SET VIETNAM=N'> 30,000,000 VND (> 1,500 USD): General Director', ENGLISH=N'> 30,000,000 VND (> 1,500 USD): General Director', VIETNAM_OR=N'> 30,000,000 VND (> 1,500 USD): General Director', ENGLISH_OR=N'> 30,000,000 VND (> 1,500 USD): General Director' WHERE FORM=N'frmDXMH_SSD' AND KEYWORD=N'GeneralDirector' ELSE INSERT INTO LANGUAGES(FORM,KEYWORD,VIETNAM,ENGLISH,VIETNAM_OR,ENGLISH_OR) VALUES(N'frmDXMH_SSD',N'GeneralDirector',N'> 30,000,000 VND (> 1,500 USD): General Director',N'> 30,000,000 VND (> 1,500 USD): General Director',N'> 30,000,000 VND (> 1,500 USD): General Director',N'> 30,000,000 VND (> 1,500 USD): General Director')
