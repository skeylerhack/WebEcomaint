
IF((SELECT COUNT(*) FROM dbo.DIEM) = 0)
BEGIN
INSERT [dbo].[DIEM] ([DIEM]) VALUES (0)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (1)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (2)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (3)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (4)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (5)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (6)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (7)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (8)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (9)
INSERT [dbo].[DIEM] ([DIEM]) VALUES (10)
END

