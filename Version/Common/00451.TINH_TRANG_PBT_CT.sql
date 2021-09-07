IF  NOT EXISTS (SELECT * FROM [TINH_TRANG_PBT_CT])
BEGIN
SET IDENTITY_INSERT [dbo].[TINH_TRANG_PBT_CT] ON
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (1, 1, N'APLN', N'Approved for Planning', N'Approved for Planning', NULL, NULL, 1)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (2, 1, N'IPLN', N'In Planning', N'In Planning', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (3, 1, N'WAPP', N'Waiting for Approval', N'Waiting for Approval', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (4, 1, N'WPLN', N'Waiting Planning', N'Waiting Planning', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (5, 2, N'IPRG', N'In Progress', N'In Progress', NULL, NULL, 1)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (6, 2, N'MREC', N'Materials Received', N'Materials Received', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (7, 2, N'SCHD', N'Scheduled', N'Scheduled', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (8, 2, N'WFAP', N'Waiting for Financial Approval', N'Waiting for Financial Approval', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (9, 2, N'WINF', N'Waiting for Information', N'Waiting for Information', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (10, 2, N'WMAT', N'Waiting for Material', N'Waiting for Material', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (11, 2, N'WMOC', N'Waiting for Management of Change', N'Waiting for Management of Change', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (12, 2, N'WPCN', N'Waiting Plant Conditions', N'Waiting Plant Conditions', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (13, 2, N'WPSD', N'Waiting for Plant Shut Down', N'Waiting for Plant Shut Down', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (14, 2, N'WPMT', N'Waiting for Post Maintenance Testing', N'Waiting for Post Maintenance Testing', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (15, 2, N'WSCH', N'Waiting for Scheduling', N'Waiting for Scheduling', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (16, 3, N'COMP', N'Completed', N'Completed', NULL, NULL, 1)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (17, 4, N'ACC', N'Accepted', N'Accepted', NULL, NULL, 1)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (18, 4, N'CAN', N'Cancelled', N'Cancelled', NULL, NULL, 0)
INSERT [dbo].[TINH_TRANG_PBT_CT] ([MS_TT_CT], [STT], [MA_SO], [TEN_TIENG_VIET], [TEN_TIENG_ANH], [TEN_TIENG_HOA], [GHI_CHU], [MAC_DINH]) VALUES (19, 5, N'CLOS', N'Closed', N'Closed', NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[TINH_TRANG_PBT_CT] OFF
END