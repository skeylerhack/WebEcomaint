/****** Object:  Table [dbo].[WebMenu]    Script Date: 21/11/2017 10:44:33 ******/
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES 
                 WHERE  TABLE_NAME = 'WebMenu')
begin
DROP TABLE [dbo].[WebMenu]
end
GO

/****** Object:  Table [dbo].[WebMenu]    Script Date: 21/11/2017 10:44:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WebMenu](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MenuID] [nvarchar](100) NULL,
	[Name] [nvarchar](100) NULL,
	[NameEng] [nvarchar](100) NULL,
	[Root] [int] NULL,
	[Index] [int] NULL,
	[Hide] [bit] NULL,
	[MetaTitle] [nvarchar](max) NULL,
	[Icons] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[WebMenu] ON 

INSERT INTO dbo.WebMenu(id,MenuID, [Name], NameEng, [Root], [Index], Hide, MetaTitle, Icons)

VALUES
( 1, N'mnuDashboard', N'Tổng quan', N'Dashboard', 0, 1, 0, N'/EcomaintSite/dashboard', N'fa fa-fw fa-home' ), 
( 2, N'mnuUserRequest', N'Yêu cầu người sử dụng', N'User Request', 0, 3, 0, N'#', N'fa fa-fw fa-tasks' ), 
( 3, N'mnuListUserRequest', N'Danh sách yêu cầu', N'List of requests', 2, 1, 0, N'/EcomaintSite/user-request', N'fa fa-fw fa-location-arrow' ), 
( 4, N'mnuApproveRequest', N'Duyệt yêu cầu', N'Approve request', 2, 2, 0, N'/EcomaintSite/approve-request', N'fa fa-fw fa-location-arrow' ), 
( 5, N'mnuReport', N'Báo cáo', N'Report', 0, 7, 1, N'#', N'fa fa-fw fa-file-text' ), 
( 6, N'mnuStaffReport', N'Nhân viên', N'Staff', 5, 1, 1, N'#', N'fa fa-fw fa-tasks' ), 
( 7, N'mnuTotalHourStaff', N'Giờ công nhân viên', N'Total of working hours', 6, 1, 1, N'/EcomaintSite/report/tong-so-gio-cong', N'' ), 
( 22, N'mnuMasterPlan', N'Kế hoạch tổng thể', N'Master Plan', 0, 6, 0, N'#', N'fa fa-fw fa-pencil-square-o' ), 
( 23, N'mnuListMasterPlan', N'Danh sách kế hoạch', N'List plans', 22, 1, 0, N'/EcomaintSite/master-plan', N'fa fa-fw fa-location-arrow' ), 
( 24, N'mnuPeriodicMaintenance', N'Bảo trì định kỳ', N'Periodic maintenance', 22, 2, 0, N'/EcomaintSite/periodic-maintenance', N'fa fa-fw fa-location-arrow' ), 
( 25, N'mnuAbout', N'Liên hệ', N'Contact', 0, 8, 0, N'/EcomaintSite/about', N'fa fa-fw fa-phone' ), 
( 21, N'mnuMornitoring', N'Giám sát tình trạng', N'Condition inspection', 0, 4, 0, N'/EcomaintSite/monitoring', N'fa fa-fw fa-eye' ), 
( 19, N'mnuMaster', N'Danh mục', N'Master data', 0, 2, 0, N'#', N'fa fa-fw fa-database' ), 
( 20, N'mnuOrgUnit', N'Đơn vị', N'Org. unit', 19, 1, 0, N'/EcomaintSite/master-data/org-unit', NULL ), 
( 26, N'mnuWorkOrder', N'Phiếu bảo trì', N'Work Order', 0, 5, 0, N'#', N'fa fa-fw fa-recycle' ), 
( 27, N'mnuListWorkOrder', N'DS phiếu bảo trì', N'List work orders', 26, 1, 0, N'/EcomaintSite/work-order', N'fa fa-fw fa-location-arrow' )



SET IDENTITY_INSERT [dbo].[WebMenu] OFF

go
if exists (SELECT * FROM INFORMATION_SCHEMA.TABLES 
                 WHERE  TABLE_NAME = 'WebUserLogin')
begin
DROP TABLE [dbo].[WebUserLogin]
end
GO

/****** Object:  Table [dbo].[WebUserLogin]    Script Date: 21/11/2017 10:44:37 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WebUserLogin](
	[Username] [nvarchar](50) NOT NULL,
	[TimeLogin] [datetime] NOT NULL,
 CONSTRAINT [PK_WebUserLogin] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
