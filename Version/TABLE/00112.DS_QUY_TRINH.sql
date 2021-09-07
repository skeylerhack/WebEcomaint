IF NOT EXISTS (SELECT * FROM [DS_QUY_TRINH] WHERE MS_QT = 1)
	INSERT [dbo].[DS_QUY_TRINH] ([MS_QT], [TEN_QT_V], [TEN_QT_E], [TEN_QT_H]) VALUES (1, N'Đề xuất mua hàng', N'Purchase request', NULL)
GO
IF NOT EXISTS (SELECT * FROM [DS_QUY_TRINH] WHERE MS_QT = 2)
	INSERT [dbo].[DS_QUY_TRINH] ([MS_QT], [TEN_QT_V], [TEN_QT_E], [TEN_QT_H]) VALUES (2, N'Đơn đặt hàng', N'Purchase order', NULL)
GO
