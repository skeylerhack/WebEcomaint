IF NOT EXISTS (SELECT * FROM LOAI_GUI_MAIL WHERE MS_LOAI_EMAIL = 1)
BEGIN
INSERT [dbo].[LOAI_GUI_MAIL] ([MS_LOAI_EMAIL], [TEN_LOAI_EMAIL], [GHI_CHU]) VALUES (1, N'Khi nhập yêu cầu bảo trì', N'Khi user nhập yêu cầu bảo trì')
END

IF NOT EXISTS (SELECT * FROM LOAI_GUI_MAIL WHERE MS_LOAI_EMAIL = 2)
BEGIN
INSERT [dbo].[LOAI_GUI_MAIL] ([MS_LOAI_EMAIL], [TEN_LOAI_EMAIL], [GHI_CHU]) VALUES (2, N'Khi duyệt yêu cầu bảo trì', N'Khi bộ phận sản xuất duyệt yêu cầu bảo trì')
END

IF NOT EXISTS (SELECT * FROM LOAI_GUI_MAIL WHERE MS_LOAI_EMAIL = 3)
BEGIN
INSERT [dbo].[LOAI_GUI_MAIL] ([MS_LOAI_EMAIL], [TEN_LOAI_EMAIL], [GHI_CHU]) VALUES (3, N'Khi tiếp nhận yêu cầu bảo trì', N'Khi tiếp nhận yêu cầu bảo trì')
END
