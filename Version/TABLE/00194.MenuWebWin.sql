IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MenuWebWin]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MenuWebWin](
	[MenuWEB_ID] [NVARCHAR](100) NOT NULL,
	[MENU_ID] [NVARCHAR](255) NOT NULL
) ON [PRIMARY]
END
DELETE dbo.MenuWebWin
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnEXWarehouse', N'mnuXuatkhoVTPT')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnIPWarehouse', N'mnuNhapkhoVTPT')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuApproveRequest', N'mnuYeucauNSD_DSX')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuListMasterPlan', N'mnuKehoachtongthe')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuListUserRequest', N'mnuYeucauNSD_Nhap')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuListWorkOrder', N'MnuPhieuBaoTri')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuMaster', N'mnuMasterData')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuMasterPlan', N'mnuKehoachtongthe')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuMornitoring', N'mnuGiamsattinhtrang')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuMyEcomain', N'mnuGiamsattinhtrang')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuOrgUnit', N'mnuMeasuringUnit')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuPeriodicMaintenance', N'mnuBaotri')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuReceiptRequest', N'mnuYeucauNSD_DBT')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuUserRequest', N'mnuYeucauNSD')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuWorkOrder', N'MnuPhieuBaoTri')
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnWarehouse', N'mnuQuanlykho')
GO
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuHazardReport', N'mnuHazardReport')
GO
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuStopCard', N'mnuStopCard')
GO
GO
INSERT [dbo].[MenuWebWin] ([MenuWEB_ID], [MENU_ID]) VALUES (N'mnuLeaderShip', N'mnuLeadershipDetails')
GO
