
IF NOT EXISTS(select * from CHI_PHI_NHAP_KHO 
            where [MS_CHI_PHI] = 1)
BEGIN
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (1, N'Phí nhập khẩu', NULL, NULL, 1, NULL, 1)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (2, N'Thuế nhập khẩu', NULL, NULL, 1, NULL, 0)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (3, N'Phí vận chuyển', NULL, NULL, 1, NULL, 0)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (4, N'Phí bảo hiểm', NULL, NULL, 1, NULL, 0)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (5, N'Thuế nhà thầu', NULL, NULL, 1, NULL, 0)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (6, N'Cost6', NULL, NULL, 1, NULL, 0)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (7, N'Cost7', NULL, NULL, 1, NULL, 0)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (8, N'Cost8', NULL, NULL, 1, NULL, 0)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (9, N'Cost9', NULL, NULL, 1, NULL, 0)
INSERT [dbo].[CHI_PHI_NHAP_KHO] ([MS_CHI_PHI], [TEN_VIET], [TEN_ANH], [TEN_HOA], [DANG_PB], [GHI_CHU], [ACTIVE]) VALUES (10, N'Phí khác', NULL, NULL, 1, NULL, 1)END

