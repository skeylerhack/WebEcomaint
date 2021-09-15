﻿DELETE dbo.WebMenu
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (1, N'mnuDashboard', N'Trang chủ', N'Home', 0, 1, 0, N'/EcomaintSite/dashboard', N'fa fa-fw fa-home')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (2, N'mnuUserRequest', N'Yêu cầu bảo trì', N'User Request', 0, 3, 0, N'#', N'fa fa-fw fa-tasks')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (3, N'mnuListUserRequest', N'Danh sách yêu cầu', N'List of requests', 2, 1, 0, N'/EcomaintSite/user-request', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (4, N'mnuApproveRequest', N'Duyệt yêu cầu', N'Approve request', 2, 2, 1, N'/EcomaintSite/approve-request', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (5, N'mnuReport', N'Báo cáo', N'Report', 0, 9, 1, N'#', N'fa fa-fw fa-file-text')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (6, N'mnuStaffReport', N'Nhân viên', N'Staff', 5, 1, 1, N'#', N'fa fa-fw fa-tasks')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (7, N'mnuTotalHourStaff', N'Giờ công nhân viên', N'Total of working hours', 6, 1, 1, N'/EcomaintSite/report/tong-so-gio-cong', N'')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (8, N'mnWarehouse', N'Kho', N'Warehouse', 0, 7, 1, N'/EcomaintSite/Warehouse', N'fa fa-fw fas fa-university')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (9, N'mnIPWarehouse', N'Nhập kho', N'Import Warehouse', 8, 1, 0, N'/EcomaintSite/Warehouse/ImportWarehouse', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (10, N'mnEXWarehouse', N'Xuất kho', N'Export Warehouse', 8, 2, 0, N'/EcomaintSite/Warehouse/ExportWarehouse', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (12, N'mnuGenerality', N'Tổng quan', N'Generality', 0, 2, 0, N'#', N'fa fa-fw fa fa-building')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (13, N'mnuMyEcomain', N'Ecomain của tôi', N'My Ecomain', 12, 1, 0, N'/EcomaintSite/my-ecomain', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (19, N'mnuMaster', N'Danh mục', N'Master data', 0, 10, 1, N'#', N'fa fa-fw fa-database')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (20, N'mnuOrgUnit', N'Đơn vị', N'Org. unit', 19, 1, 0, N'/EcomaintSite/master-data/org-unit', NULL)
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (22, N'mnuMasterPlan', N'Kế hoạch tổng thể', N'Master Plan', 0, 6, 1, N'#', N'fa fa-fw fa-pencil-square-o')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (23, N'mnuListMasterPlan', N'Danh sách kế hoạch', N'List plans', 22, 1, 0, N'/EcomaintSite/master-plan', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (24, N'mnuPeriodicMaintenance', N'Bảo trì định kỳ', N'Periodic maintenance', 22, 2, 0, N'/EcomaintSite/periodic-maintenance', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (25, N'mnuAbout', N'Liên hệ', N'Contact', 0, 8, 0, N'/EcomaintSite/about', N'fa fa-fw fa-phone')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (26, N'mnuWorkOrder', N'Phiếu bảo trì', N'Work Order', 0, 5, 1, N'#', N'fa fa-fw fa-recycle')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (27, N'mnuListWorkOrder', N'DS phiếu bảo trì', N'List work orders', 26, 1, 1, N'/EcomaintSite/work-order', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (28, N'mnuMornitoring', N'Giám sát tình trạng', N'Condition inspection', 0, 4, 0, N'/EcomaintSite/monitoring', N'fa fa-fw fa-eye')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (30, N'mnuSafety', N'An toàn', N'Safe', 0, 6, 0, N'#', N'fa fa-life-ring')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (31, N'mnuHazardReport', N'Báo cáo an toàn', N'Hazard report', 30, 1, 0, N'/EcomaintSite/hazardreport', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (32, N'mnuStopCard', N'Thẻ Stop', N'Stop Card', 30, 2, 0, N'/EcomaintSite/stopcard', N'fa fa-fw fa-location-arrow')
INSERT [dbo].[WebMenu] ([ID], [MenuID], [Name], [NameEng], [Root], [Index], [Hide], [MetaTitle], [Icons]) VALUES (33, N'mnuLeaderShip', N'Kiểm toán', N'Leader Ship', 30, 3, 0, N'/EcomaintSite/leadership', N'fa fa-fw fa-location-arrow')


