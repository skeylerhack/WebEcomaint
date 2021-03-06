
/****** Object:  Table [dbo].[DIEU_KHOAN_MAC_DINH]    Script Date: 08/31/2017 08:40:36 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_KHOAN_MAC_DINH]') AND type in (N'U'))
DROP TABLE [dbo].[DIEU_KHOAN_MAC_DINH]
GO


GO

/****** Object:  Table [dbo].[DIEU_KHOAN_MAC_DINH]    Script Date: 08/31/2017 08:40:36 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DIEU_KHOAN_MAC_DINH](
	[STT] [int] IDENTITY(1,1) NOT NULL,
	[TEN_DIEU_KHOAN] [nvarchar](256) NOT NULL,
	[NOI_DUNG_DIEU_KHOAN] [nvarchar](1024) NULL,
 CONSTRAINT [PK_DIEU_KHOAN_MAC_DINH] PRIMARY KEY CLUSTERED 
(
	[STT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET IDENTITY_INSERT [dbo].[DIEU_KHOAN_MAC_DINH] ON
INSERT [dbo].[DIEU_KHOAN_MAC_DINH] ([STT], [TEN_DIEU_KHOAN], [NOI_DUNG_DIEU_KHOAN]) VALUES (1, N'Delivery time', N'Within 03 days after PO')
INSERT [dbo].[DIEU_KHOAN_MAC_DINH] ([STT], [TEN_DIEU_KHOAN], [NOI_DUNG_DIEU_KHOAN]) VALUES (2, N'Thời gian thực hiện', N'Trong vòng 03 ngày sau khi ký PO')
INSERT [dbo].[DIEU_KHOAN_MAC_DINH] ([STT], [TEN_DIEU_KHOAN], [NOI_DUNG_DIEU_KHOAN]) VALUES (3, N'Terms of Payment', N'TT 15 days after receiving Handover and invoice')
INSERT [dbo].[DIEU_KHOAN_MAC_DINH] ([STT], [TEN_DIEU_KHOAN], [NOI_DUNG_DIEU_KHOAN]) VALUES (4, N'Điều kiện thanh toán', N'15 ngày sau khi ký biên bản nghiệm thu và nhận Hóa đơn hợp lệ')
INSERT [dbo].[DIEU_KHOAN_MAC_DINH] ([STT], [TEN_DIEU_KHOAN], [NOI_DUNG_DIEU_KHOAN]) VALUES (5, N'Terms of Delivery', N'Delivery at Shiseido Vietnam Inc')
INSERT [dbo].[DIEU_KHOAN_MAC_DINH] ([STT], [TEN_DIEU_KHOAN], [NOI_DUNG_DIEU_KHOAN]) VALUES (6, N'Điều kiện giao hàng', N'Giao tại địa chỉ của Công ty TNHH Shiseido Việt Nam')
INSERT [dbo].[DIEU_KHOAN_MAC_DINH] ([STT], [TEN_DIEU_KHOAN], [NOI_DUNG_DIEU_KHOAN]) VALUES (7, N'Other terms and conditions/ Những điều khoản khác', N'Price is not including Foreign Contractor Tax/Giá không bao gồm thuế nhà thầu nước ngoài')
SET IDENTITY_INSERT [dbo].[DIEU_KHOAN_MAC_DINH] OFF


							
							

						
						
						
