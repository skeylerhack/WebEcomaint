
if not exists (select * from ds_report where report_name = 'ucMailNhapXuatTon')
begin
INSERT INTO [dbo].[DS_REPORT]([REPORT_NAME],[TEN_REPORT_VIET],[TEN_REPORT_ANH],[LOAI_REPORT],[STT],[NAMES],[TYPE],[REPORT_MAIL])
     VALUES
('ucMailNhapXuatTon',N'Báo cáo nhập xuất tồn theo loại VTPT',N'Inventory transaction report filtered by Item type',94,19,'ucMailNhapXuatTon',2,2)
end


if not exists (select * from LIC_REPORT where report_name = N'ήΊ͞ΆΖΜ͠ΔΆΤʹήΆάͬ΢Π')
begin
INSERT INTO [dbo].[LIC_REPORT]([TYPE_LIC],[REPORT_NAME])
	VALUES           (N'̦' ,   N'ήΊ͞ΆΖΜ͠ΔΆΤʹήΆάͬ΢Π')
end

if not exists (select * from NHOM_REPORT where report_name = 'ucMailNhapXuatTon')
begin
INSERT INTO [dbo].[NHOM_REPORT]([GROUP_ID],[REPORT_NAME],[QUYEN])
     VALUES(1,N'ucMailNhapXuatTon',N'Access')
end











