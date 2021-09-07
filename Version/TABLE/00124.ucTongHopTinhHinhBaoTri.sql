if not exists (select * from ds_report where report_name = 'ucTongHopTinhHinhBaoTri')
begin
INSERT INTO [dbo].[DS_REPORT]([REPORT_NAME],[TEN_REPORT_VIET],[TEN_REPORT_ANH],[LOAI_REPORT],[STT],[NAMES],[TYPE],[REPORT_MAIL])
     VALUES
('ucTongHopTinhHinhBaoTri',N'Báo cáo tổng hợp công việc bảo trì thiết bị (dạng 3)',N'Maintenance summary report  (format 3)',3,9,'ucTongHopTinhHinhBaoTri',1,1)
end


if not exists (select * from LIC_REPORT where report_name = N'ήΊͬ΢ΠΒ͔΢ΤͬΖΠΔ͔ΖΠΔ͈Ά΢ͬΨΖ')
begin
INSERT INTO [dbo].[LIC_REPORT]([TYPE_LIC],[REPORT_NAME])
	VALUES           (N'̦' ,   N'ήΊͬ΢ΠΒ͔΢ΤͬΖΠΔ͔ΖΠΔ͈Ά΢ͬΨΖ')
end

if not exists (select * from NHOM_REPORT where report_name = 'ucTongHopTinhHinhBaoTri')
begin
INSERT INTO [dbo].[NHOM_REPORT]([GROUP_ID],[REPORT_NAME],[QUYEN])
     VALUES(1,N'ucTongHopTinhHinhBaoTri',N'Access')

end
