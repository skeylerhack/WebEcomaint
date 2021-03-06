IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_NGAY', N'COLUMN',N'SO_PHUT_NGAY'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_NGAY', @level2type=N'COLUMN',@level2name=N'SO_PHUT_NGAY'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_GSTT', N'COLUMN',N'MS_BO_PHAN'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_GSTT', @level2type=N'COLUMN',@level2name=N'MS_BO_PHAN'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_GSTT', N'COLUMN',N'MS_TS_GSTT'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_GSTT', @level2type=N'COLUMN',@level2name=N'MS_TS_GSTT'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_GSTT', N'COLUMN',N'MS_MAY'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_GSTT', @level2type=N'COLUMN',@level2name=N'MS_MAY'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_GSTT', N'COLUMN',N'STT'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_GSTT', @level2type=N'COLUMN',@level2name=N'STT'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_CVVP', N'COLUMN',N'STT'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_CVVP', @level2type=N'COLUMN',@level2name=N'STT'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_CVVP', N'COLUMN',N'NGAY'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_CVVP', @level2type=N'COLUMN',@level2name=N'NGAY'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_CVVP', N'COLUMN',N'MS_CONG_NHAN'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_CVVP', @level2type=N'COLUMN',@level2name=N'MS_CONG_NHAN'
GO
IF  EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO', N'COLUMN',N'SO_PHUT_KHONG_DD'))
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO', @level2type=N'COLUMN',@level2name=N'SO_PHUT_KHONG_DD'
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_PBT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_PBT]'))
ALTER TABLE [dbo].[DIEU_DO_PBT] DROP CONSTRAINT [FK_DIEU_DO_PBT_DIEU_DO]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_NGAY_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_NGAY]'))
ALTER TABLE [dbo].[DIEU_DO_NGAY] DROP CONSTRAINT [FK_DIEU_DO_NGAY_DIEU_DO]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_KHTT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_KHTT]'))
ALTER TABLE [dbo].[DIEU_DO_KHTT] DROP CONSTRAINT [FK_DIEU_DO_KHTT_DIEU_DO]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_GSTT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_GSTT]'))
ALTER TABLE [dbo].[DIEU_DO_GSTT] DROP CONSTRAINT [FK_DIEU_DO_GSTT_DIEU_DO]
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_CVVP_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_CVVP]'))
ALTER TABLE [dbo].[DIEU_DO_CVVP] DROP CONSTRAINT [FK_DIEU_DO_CVVP_DIEU_DO]
GO
/****** Object:  Table [dbo].[DIEU_DO_PBT]    Script Date: 13/03/2018 08:31:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_PBT]') AND type in (N'U'))
DROP TABLE [dbo].[DIEU_DO_PBT]
GO
/****** Object:  Table [dbo].[DIEU_DO_NGAY]    Script Date: 13/03/2018 08:31:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_NGAY]') AND type in (N'U'))
DROP TABLE [dbo].[DIEU_DO_NGAY]
GO
/****** Object:  Table [dbo].[DIEU_DO_KHTT]    Script Date: 13/03/2018 08:31:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_KHTT]') AND type in (N'U'))
DROP TABLE [dbo].[DIEU_DO_KHTT]
GO
/****** Object:  Table [dbo].[DIEU_DO_GSTT]    Script Date: 13/03/2018 08:31:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_GSTT]') AND type in (N'U'))
DROP TABLE [dbo].[DIEU_DO_GSTT]
GO

/****** Object:  Table [dbo].[DIEU_DO_CVVP]    Script Date: 13/03/2018 08:31:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_CVVP]') AND type in (N'U'))
DROP TABLE [dbo].[DIEU_DO_CVVP]
GO
/****** Object:  Table [dbo].[DIEU_DO]    Script Date: 13/03/2018 08:31:04 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO]') AND type in (N'U'))
begin
	DROP TABLE [dbo].[DIEU_DO]
end
GO
/****** Object:  Table [dbo].[DIEU_DO]    Script Date: 13/03/2018 08:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DIEU_DO](
	[ID_DD] [bigint] IDENTITY(1,1) NOT NULL,
	[MS_DIEU_DO] [nvarchar](50) NULL,
	[NGAY_DD] [date] NULL,
	[USER_DD] [nvarchar](50) NULL,
	[DD_TN] [date] NULL,
	[DD_DN] [date] NULL,
	[CV_TN] [date] NULL,
	[CV_DN] [date] NULL,
	[MS_DON_VI] [nvarchar](20) NULL,
	[MS_TO] [int] NULL,
	[SO_NV_DD] [float] NULL,
	[SO_GIO_DD] [float] NULL,
	[HIEU_SUAT_DD] [float] NULL,
	[SO_PHUT_KHONG_DD] [float] NULL,
	[GHI_CHU] [nvarchar](500) NULL,
 CONSTRAINT [PK_DIEU_DO] PRIMARY KEY CLUSTERED 
(
	[ID_DD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DIEU_DO_CVVP]    Script Date: 13/03/2018 08:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_CVVP]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DIEU_DO_CVVP](
	[ID_DD_CVVP] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_DD] [bigint] NULL,
	[MS_CONG_NHAN] [nvarchar](9) NULL,
	[NGAY] [datetime] NULL,
	[STT] [int] NULL,
	[SO_NGUOI_DD] [float] NULL,
	[NGAY_DD] [date] NULL,
 CONSTRAINT [PK_DIEU_DO_CVVP] PRIMARY KEY CLUSTERED 
(
	[ID_DD_CVVP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DIEU_DO_GSTT]    Script Date: 13/03/2018 08:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_GSTT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DIEU_DO_GSTT](
	[ID_DD_GSTT] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_DD] [bigint] NULL,
	[STT] [int] NULL,
	[MS_MAY] [nvarchar](30) NULL,
	[MS_TS_GSTT] [nvarchar](10) NULL,
	[MS_BO_PHAN] [nvarchar](50) NULL,
	[MS_TT] [int] NULL,
	[SO_GIO_KH] [float] NULL,
	[SO_NGUOI_DD] [float] NULL,
	[NGAY_DD] [date] NULL,
 CONSTRAINT [PK_DIEU_DO_GSTT] PRIMARY KEY CLUSTERED 
(
	[ID_DD_GSTT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DIEU_DO_KHTT]    Script Date: 13/03/2018 08:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_KHTT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DIEU_DO_KHTT](
	[ID_DD_KHTT] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_DD] [bigint] NULL,
	[HANG_MUC_ID] [int] NULL,
	[MS_MAY] [nvarchar](50) NULL,
	[MS_CV] [int] NULL,
	[MS_BO_PHAN] [nvarchar](50) NULL,
	[SO_GIO_KH] [float] NULL,
	[SO_NGUOI_DD] [float] NULL,
	[NGAY_DD] [date] NULL,
 CONSTRAINT [PK_DIEU_DO_KHTT] PRIMARY KEY CLUSTERED 
(
	[ID_DD_KHTT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DIEU_DO_NGAY]    Script Date: 13/03/2018 08:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_NGAY]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DIEU_DO_NGAY](
	[ID_DD_NGAY] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_DD] [bigint] NULL,
	[NGAY] [date] NULL,
	[NV] [float] NULL,
	[GIO_LV] [float] NULL,
	[HIEU_SUAT] [float] NULL,
	[SP_NGAY] [float] NULL,
	[SP_DA_DD] [float] NULL,
	[SO_PHUT_NGAY] [float] NULL,
 CONSTRAINT [PK_DIEU_DO_NGAY] PRIMARY KEY CLUSTERED 
(
	[ID_DD_NGAY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[DIEU_DO_PBT]    Script Date: 13/03/2018 08:31:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DIEU_DO_PBT]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DIEU_DO_PBT](
	[ID_DD_PBT] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_DD] [bigint] NULL,
	[MS_PHIEU_BAO_TRI] [nvarchar](20) NULL,
	[MS_MAY] [nvarchar](50) NULL,
	[MS_CV] [int] NULL,
	[MS_BO_PHAN] [nvarchar](50) NULL,
	[SO_GIO_KH] [float] NULL,
	[SO_NGUOI_DD] [float] NULL,
	[NGAY_DD] [date] NULL,
 CONSTRAINT [PK_DIEU_DO_PBT] PRIMARY KEY CLUSTERED 
(
	[ID_DD_PBT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_CVVP_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_CVVP]'))
ALTER TABLE [dbo].[DIEU_DO_CVVP]  WITH CHECK ADD  CONSTRAINT [FK_DIEU_DO_CVVP_DIEU_DO] FOREIGN KEY([ID_DD])
REFERENCES [dbo].[DIEU_DO] ([ID_DD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_CVVP_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_CVVP]'))
ALTER TABLE [dbo].[DIEU_DO_CVVP] CHECK CONSTRAINT [FK_DIEU_DO_CVVP_DIEU_DO]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_GSTT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_GSTT]'))
ALTER TABLE [dbo].[DIEU_DO_GSTT]  WITH CHECK ADD  CONSTRAINT [FK_DIEU_DO_GSTT_DIEU_DO] FOREIGN KEY([ID_DD])
REFERENCES [dbo].[DIEU_DO] ([ID_DD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_GSTT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_GSTT]'))
ALTER TABLE [dbo].[DIEU_DO_GSTT] CHECK CONSTRAINT [FK_DIEU_DO_GSTT_DIEU_DO]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_KHTT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_KHTT]'))
ALTER TABLE [dbo].[DIEU_DO_KHTT]  WITH CHECK ADD  CONSTRAINT [FK_DIEU_DO_KHTT_DIEU_DO] FOREIGN KEY([ID_DD])
REFERENCES [dbo].[DIEU_DO] ([ID_DD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_KHTT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_KHTT]'))
ALTER TABLE [dbo].[DIEU_DO_KHTT] CHECK CONSTRAINT [FK_DIEU_DO_KHTT_DIEU_DO]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_NGAY_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_NGAY]'))
ALTER TABLE [dbo].[DIEU_DO_NGAY]  WITH CHECK ADD  CONSTRAINT [FK_DIEU_DO_NGAY_DIEU_DO] FOREIGN KEY([ID_DD])
REFERENCES [dbo].[DIEU_DO] ([ID_DD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_NGAY_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_NGAY]'))
ALTER TABLE [dbo].[DIEU_DO_NGAY] CHECK CONSTRAINT [FK_DIEU_DO_NGAY_DIEU_DO]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_PBT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_PBT]'))
ALTER TABLE [dbo].[DIEU_DO_PBT]  WITH CHECK ADD  CONSTRAINT [FK_DIEU_DO_PBT_DIEU_DO] FOREIGN KEY([ID_DD])
REFERENCES [dbo].[DIEU_DO] ([ID_DD])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_DIEU_DO_PBT_DIEU_DO]') AND parent_object_id = OBJECT_ID(N'[dbo].[DIEU_DO_PBT]'))
ALTER TABLE [dbo].[DIEU_DO_PBT] CHECK CONSTRAINT [FK_DIEU_DO_PBT_DIEU_DO]
GO
--IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO', N'COLUMN',N'SO_PHUT_KHONG_DD'))
--EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Số phút/Nếu số phút điều độ trong ngày nhỏ hơn số phút này thì sẽ không điều độ công việc tiếp.' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO', @level2type=N'COLUMN',@level2name=N'SO_PHUT_KHONG_DD'
--GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_CVVP', N'COLUMN',N'MS_CONG_NHAN'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Dùng ghi nhận kế hoạch nhân viên văn phòng ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_CVVP', @level2type=N'COLUMN',@level2name=N'MS_CONG_NHAN'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_CVVP', N'COLUMN',N'NGAY'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Ngày ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_CVVP', @level2type=N'COLUMN',@level2name=N'NGAY'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_CVVP', N'COLUMN',N'STT'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã dùngghi nhiều dòng ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_CVVP', @level2type=N'COLUMN',@level2name=N'STT'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_GSTT', N'COLUMN',N'STT'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'STT - ghi nhận kết quả kiểm tra thông số định lượng ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_GSTT', @level2type=N'COLUMN',@level2name=N'STT'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_GSTT', N'COLUMN',N'MS_MAY'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Thiết bị ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_GSTT', @level2type=N'COLUMN',@level2name=N'MS_MAY'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_GSTT', N'COLUMN',N'MS_TS_GSTT'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Thông số kiểm tra - một lần kiểm tra nhiều thông số  ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_GSTT', @level2type=N'COLUMN',@level2name=N'MS_TS_GSTT'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_GSTT', N'COLUMN',N'MS_BO_PHAN'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Bộ phận ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_GSTT', @level2type=N'COLUMN',@level2name=N'MS_BO_PHAN'
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'dbo', N'TABLE',N'DIEU_DO_NGAY', N'COLUMN',N'SO_PHUT_NGAY'))
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'so phut con lai = SP_NGAY - SP_DA_DD THEO NGAY' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DIEU_DO_NGAY', @level2type=N'COLUMN',@level2name=N'SO_PHUT_NGAY'
GO
