
if not exists (select * from ds_report where report_name = 'ucMailDanhSachPhieuNhapKho')
begin
INSERT INTO [dbo].[DS_REPORT]([REPORT_NAME],[TEN_REPORT_VIET],[TEN_REPORT_ANH],[LOAI_REPORT],[STT],[NAMES],[TYPE],[REPORT_MAIL])
     VALUES
('ucMailDanhSachPhieuNhapKho',N'Danh sách phiếu nhập kho',N'List of receipts',94,18,'ucMailDanhSachPhieuNhapKho',2,2)
end


if not exists (select * from LIC_REPORT where report_name = N'ήΊ͞ΆΖΜ͌ΆΠΔͪΆΊΔͤΔΖΎή͠ΔΆΤ͚Δ΢')
begin
INSERT INTO [dbo].[LIC_REPORT]([TYPE_LIC],[REPORT_NAME])
	VALUES           (N'̦' ,   N'ήΊ͞ΆΖΜ͌ΆΠΔͪΆΊΔͤΔΖΎή͠ΔΆΤ͚Δ΢')
end

if not exists (select * from NHOM_REPORT where report_name = 'ucMailDanhSachPhieuNhapKho')
begin
INSERT INTO [dbo].[NHOM_REPORT]([GROUP_ID],[REPORT_NAME],[QUYEN])
     VALUES(1,N'ucMailDanhSachPhieuNhapKho',N'Access')
end

