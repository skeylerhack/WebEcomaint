
if not exists (select * from ds_report where report_name = 'ucMailPhanTichTGNMay')
begin
INSERT INTO [dbo].[DS_REPORT]([REPORT_NAME],[TEN_REPORT_VIET],[TEN_REPORT_ANH],[LOAI_REPORT],[STT],[NAMES],[TYPE],[REPORT_MAIL])
     VALUES
('ucMailPhanTichTGNMay',N'Phân tích thời gian ngừng máy',N'BREAKDOWN ANALYSIS CHART',94,3,'ucMailPhanTichTGNMay',1,2)
end


if not exists (select * from LIC_REPORT where report_name = N'ήΊ͞ΆΖΜͤΔΆΠͬΖΊΔͬ͒͠͞Άζ')
begin
INSERT INTO [dbo].[LIC_REPORT]([TYPE_LIC],[REPORT_NAME])
	VALUES           (N'̦' ,   N'ήΊ͞ΆΖΜͤΔΆΠͬΖΊΔͬ͒͠͞Άζ')
end

if not exists (select * from NHOM_REPORT where report_name = 'ucMailPhanTichTGNMay')
begin
INSERT INTO [dbo].[NHOM_REPORT]([GROUP_ID],[REPORT_NAME],[QUYEN])
     VALUES(1,N'ucMailPhanTichTGNMay',N'Access')

end

