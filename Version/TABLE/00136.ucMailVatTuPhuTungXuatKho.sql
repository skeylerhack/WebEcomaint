


if not exists (select * from ds_report where report_name = 'ucMailVatTuPhuTungXuatKho')
begin
INSERT INTO [dbo].[DS_REPORT]([REPORT_NAME],[TEN_REPORT_VIET],[TEN_REPORT_ANH],[LOAI_REPORT],[STT],[NAMES],[TYPE],[REPORT_MAIL])
     VALUES
('ucMailVatTuPhuTungXuatKho',N'Thống kê vật tư, phụ tùng xuất kho ',N'List of requested items but not received',94,20,'ucMailVatTuPhuTungXuatKho',2,2)
end


if not exists (select * from LIC_REPORT where report_name = N'ήΊ͞ΆΖΜͰΆάͬήͤΔήͬήΠΒʹήΆά͚Δ΢')
begin
INSERT INTO [dbo].[LIC_REPORT]([TYPE_LIC],[REPORT_NAME])
	VALUES           (N'̦' ,   N'ήΊ͞ΆΖΜͰΆάͬήͤΔήͬήΠΒʹήΆά͚Δ΢')
end

if not exists (select * from NHOM_REPORT where report_name = 'ucMailVatTuPhuTungXuatKho')
begin
INSERT INTO [dbo].[NHOM_REPORT]([GROUP_ID],[REPORT_NAME],[QUYEN])
     VALUES(1,N'ucMailVatTuPhuTungXuatKho',N'Access')
end











