if exists(select * from sys.columns 
            where  Object_ID = Object_ID(N'DS_IMPORT'))
begin
drop table DS_IMPORT 
end

create TABLE [dbo].[DS_IMPORT](
	[MS_IMPORT] [int] NOT NULL,
	[TEN_IMPORT] [nvarchar](500) NULL,
	[TEN_IMPORT_A] [nvarchar](500) NULL,
	[TEN_IMPORT_H] [nvarchar](500) NULL,
	[SU_DUNG] [bit] NULL,
	[IMPORT] [bit] NULL,
	[MS_IMPORT_CHA] [int] NULL,
 CONSTRAINT [PK_DS_IMPORT] PRIMARY KEY CLUSTERED 
(
	[MS_IMPORT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (1, N'Danh sách địa điểm', N'Danh sách địa điểm', NULL, 1, 1, 105)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (2, N'Di chuyển thiết bị', N'Di chuyển thiết bị', NULL, 1, 1, 105)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (3, N'Phân rã cấu trúc bộ phận', N'Phân rã cấu trúc bộ phận', NULL, 1, 1, 105)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (4, N'Thời gian chạy máy', N'Thời gian chạy máy', NULL, 1, 1, 105)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (5, N'Danh mục công việc', N'Danh mục công việc', NULL, 1, 1, 105)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (6, N'Danh mục giám sát tình trạng', N'Danh mục giám sát tình trạng', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (7, N'Danh mục thiết bị', N'Danh mục thiết bị', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (8, N'Danh mục vật tư phụ tùng', N'Danh mục vật tư phụ tùng', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (9, N'Danh mục nhà cung cấp', N'Danh mục nhà cung cấp', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (10, N'Cấu trúc thiết bị phụ tùng', N'Cấu trúc thiết bị phụ tùng', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (11, N'Danh sách nhà xưởng', N'Danh sách nhà xưởng', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (12, N'Danh mục thiết bị', N'Danh mục thiết bị', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (13, N'Danh mục vật tư phụ tùng', N'Danh mục vật tư phụ tùng', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (14, N'Cấu trúc bộ phận', N'Cấu trúc bộ phận', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (15, N'Cấu trúc thiết bị phụ tùng', N'Cấu trúc thiết bị phụ tùng', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (16, N'Cấu trúc thiết bị công việc', N'Cấu trúc thiết bị công việc', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (17, N'Cấu trúc thiết bị công việc', N'Cấu trúc thiết bị công việc', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (18, N'Cấu trúc thiết bị giám sát tình trạng đinh tính', N'Cấu trúc thiết bị giám sát tình trạng đinh tính', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (19, N'Cấu trúc thiết bị giám sát tình trạng đinh lượng', N'Cấu trúc thiết bị giám sát tình trạng đinh lượng', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (20, N'Cấu trúc thiết bị giám sát tình trạng đinh tính', N'Cấu trúc thiết bị giám sát tình trạng đinh tính', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (21, N'Cấu trúc thiết bị giám sát tình trạng đinh lượng', N'Cấu trúc thiết bị giám sát tình trạng đinh lượng', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (22, N'Máy loại bảo trì phòng ngừa', N'Máy loại bảo trì phòng ngừa', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (23, N'Quy định bảo trì định kỳ công việc', N'Quy định bảo trì định kỳ công việc', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (24, N'Quy định bảo trì định kỳ phụ tùng', N'Quy định bảo trì định kỳ phụ tùng', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (25, N'Máy loại bảo trì phòng ngừa', N'Máy loại bảo trì phòng ngừa', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (26, N'Quy định bảo trì định kỳ công việc', N'Quy định bảo trì định kỳ công việc', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (27, N'Quy định bảo trì định kỳ phụ tùng', N'Quy định bảo trì định kỳ phụ tùng', NULL, 1, 0, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (28, N'Cập nhật cấu trúc bộ phận', N'Cập nhật cấu trúc bộ phận', NULL, 1, 1, NULL)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (71, N'Đơn vị tính', N'Đơn vị tính', N'Đơn vị tính', 1, 1, 101)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (72, N'Danh sách Nhà cung cấp', N'Danh sách Nhà cung cấp', N'Danh sách Nhà cung cấp', 1, 1, 100)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (73, N'Người liên hệ', N'Người liên hệ', N'Người liên hệ', 1, 1, 100)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (74, N'Hãng sản xuất', N'Hãng sản xuất', N'Hãng sản xuất', 1, 1, 100)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (75, N'Danh mục Quốc gia', N'Danh mục Quốc gia', NULL, 1, 1, 105)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (76, N'Danh mục Vật tư phụ tùng', N'Danh mục Vật tư phụ tùng', NULL, 1, 1, 102)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (77, N'GSTT Định tính', N'Danh mục GSTT Định tính', NULL, 1, 1, 103)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (78, N'GSTT Định lượng', N'Danh mục GSTT Định lượng', NULL, 1, 1, 103)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (79, N'Danh sách Thiết bị', N'Danh sách Thiết bị', N'Danh sách Thiết bị', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (80, N'Cấu trúc Thiết bị', N'Cấu trúc Thiết bị', N'Cấu trúc Thiết bị', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (81, N'Cấu trúc Thiết bị - Phụ tùng', N'Cấu trúc Thiết bị - Phụ tùng', N'Cấu trúc Thiết bị - Phụ tùng', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (82, N'Cấu trúc Thiết bị - Công việc', N'Cấu trúc Thiết bị - Công việc', N'Cấu trúc Thiết bị - Công việc', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (83, N'Cấu trúc Thiết bị - GSTT Định tính', N'Cấu trúc Thiết bị - GSTT Định tính', N'Cấu trúc Thiết bị - GSTT Định tính', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (84, N'Cấu trúc Thiết bị - GSTT Định lượng', N'Cấu trúc Thiết bị - GSTT Định lượng', N'Cấu trúc Thiết bị - GSTT Định lượng', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (85, N'Thiết bị - Loại Bảo trì', N'Thiết bị - Loại Bảo trì', N'Thiết bị - Loại Bảo trì', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (86, N'Loại bảo trì Công việc', N'Loại bảo trì Công việc', N'Loại bảo trì Công việc', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (87, N'Loại bảo trì Công việc Phụ Tùng', N'Loại bảo trì Công việc Phụ Tùng', N'Loại bảo trì Công việc Phụ Tùng', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (88, N'Quy định HC ĐHĐ', N'Quy định HC ĐHĐ', N'Quy định HC ĐHĐ', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (89, N'Cấu trúc TB - TS Bộ phận', N'Cấu trúc TB - TS Bộ phận', N'Cấu trúc TB - TS Bộ phận', 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (100, N'01 - Thông tin Nhà cung cấp', N'01 - Thông tin Nhà cung cấp', NULL, 1, 1, 100)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (101, N'02 - Đơn vị tính, Đơn vị đo', N'02 - Đơn vị tính, Đơn vị đo', NULL, 1, 1, 101)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (102, N'03 - Danh sách Vật tư Phụ tùng', N'03 - Danh sách Vật tư Phụ tùng', NULL, 1, 1, 102)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (103, N'04 - Công việc bảo trì giám sát', N'04 - Công việc bảo trì giám sát', NULL, 1, 1, 103)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (104, N'05 - Thông tin Thiết bị', N'05 - Thông tin Thiết bị', NULL, 1, 1, 104)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (105, N'00 - Dữ liệu khởi tạo', N'00 - Dữ liệu khởi tạo', N'00 - Dữ liệu khởi tạo', 1, 1, 105)
INSERT [dbo].[DS_IMPORT] ([MS_IMPORT], [TEN_IMPORT], [TEN_IMPORT_A], [TEN_IMPORT_H], [SU_DUNG], [IMPORT], [MS_IMPORT_CHA]) VALUES (999, N'Công việc bảo trì', N'Danh mục Công việc bảo trì', NULL, 1, 1, 103)
ALTER TABLE [dbo].[DS_IMPORT] ADD  CONSTRAINT [DF_DS_IMPORT_SU_DUNG]  DEFAULT ((1)) FOR [SU_DUNG]
GO
ALTER TABLE [dbo].[DS_IMPORT] ADD  CONSTRAINT [DF_DS_IMPORT_IMPORT]  DEFAULT ((1)) FOR [IMPORT]
GO
