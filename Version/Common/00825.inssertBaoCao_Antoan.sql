

if not exists (select * from ds_report where REPORT_NAME = 'frmBCLSTB_Antoan')
begin

INSERT [dbo].[DS_REPORT] ([REPORT_NAME], [TEN_REPORT_VIET], [TEN_REPORT_ANH], [TEN_REPORT_HOA], [LOAI_REPORT], [STT], [CUSTUMER], [NOTE], [SCRIPT], [TAB], [NAMES], [TYPE],[REPORT_MAIL]) 
VALUES (N'frmBCLSTB_Antoan',--tên user cotrol
 N'Báo cáo lịch sử thiết bị an toàn', -- Tên report tiếng việt
 N'Maintenance history for safe equiment', --tên report tiếng anh
  NULL,
   1, --Loại report (xem ghi chú bên dưới)
   101, --STT
   NULL, NULL, NULL, NULL,
    N'frmBCLSTB_Antoan', --Tên user control
     1, --1: excel, 2: crytal report view
     1)--1 report, 2 emia
end
go 

if not exists (select * from nhom_report where REPORT_NAME = 'frmBCLSTB_Antoan')
begin
insert into nhom_report
select 1, N'frmBCLSTB_Antoan','Access' --Phân quyền có thể thực hiện trên phần mềm vào phân quyền>>reports
end
go


INSERT INTO dbo.LIC_REPORT
           ([TYPE_LIC]
           ,[REPORT_NAME])
     VALUES
           (N'̦'
           ,N'ΐΨΞ͈͈͊ͪͬ͜΂͆Πά΢ΆΠ')
           
         