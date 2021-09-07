


if not exists (select * from ds_report where REPORT_NAME = 'ucBaoCaoHieuChuanKiemDinh')
begin

INSERT [dbo].[DS_REPORT] ([REPORT_NAME], [TEN_REPORT_VIET], [TEN_REPORT_ANH], [TEN_REPORT_HOA], [LOAI_REPORT], [STT], [CUSTUMER], [NOTE], [SCRIPT], [TAB], [NAMES], [TYPE],[REPORT_MAIL]) 
VALUES (N'ucBaoCaoHieuChuanKiemDinh',--tên user cotrol
 N'Lịch hiệu chuẩn và kiểm định theo năm', -- Tên report tiếng việt
 N'Annual calibration & inspection schedule', --tên report tiếng anh
  NULL,
   8, --Loại report (xem ghi chú bên dưới)
   1, --STT
   NULL, NULL, NULL, NULL,
    N'ucBaoCaoHieuChuanKiemDinh', --Tên user control
     1, --1: excel, 2: crytal report view
     1)--1 report, 2 emia
end
go 

if not exists (select * from nhom_report where REPORT_NAME = 'ucBaoCaoHieuChuanKiemDinh')
begin
insert into nhom_report
select 1, N'ucBaoCaoHieuChuanKiemDinh','Access' --Phân quyền có thể thực hiện trên phần mềm vào phân quyền>>reports
end
go

if not exists (select * from LIC_REPORT where REPORT_NAME = N'ήΊ͈Ά΢͊Ά΢͔ΖΎή͊ΔήΆΠ͚ΖΎΞ͌ΖΠΔ')
begin
INSERT INTO dbo.LIC_REPORT
           ([TYPE_LIC]
           ,[REPORT_NAME])
     VALUES
           (N'̦'
           ,N'ήΊ͈Ά΢͊Ά΢͔ΖΎή͊ΔήΆΠ͚ΖΎΞ͌ΖΠΔ')
end
GO

update DS_REPORT 
set stt = stt + 100 where LOAI_REPORT = 8 and REPORT_NAME <> N'ucBaoCaoHieuChuanKiemDinh'
