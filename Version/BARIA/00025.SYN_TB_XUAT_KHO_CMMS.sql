

/****** Object:  Table [dbo].[SYN_TB_XUAT_KHO_CMMS]    Script Date: 08/12/2015 11:12:43 ******/
IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SYN_TB_XUAT_KHO_CMMS]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SYN_TB_XUAT_KHO_CMMS](
	[STT] [bigint] IDENTITY(1,1) NOT NULL,
	[MS_DH_XUAT_PT] [nvarchar](14) NOT NULL,
	[SO_PHIEU_XN] [nvarchar](20) NULL,
	[GIO] [datetime] NULL,
	[ROW_ID_NHAP] [bigint] NULL,
	[ROW_ID] [bigint] NULL,
	[NGAY] [datetime] NULL,
	[MS_KHO] [nchar](10) NULL,
	[TEN_KHO] [nvarchar](50) NULL,
	[MS_PT] [nvarchar](25) NULL,
	[SO_LUONG_CTU] [float] NULL,
	[SO_LUONG_THUC_XUAT] [float] NULL,
	[MS_DH_NHAP_PT] [nvarchar](14) NULL,
	[MS_VI_TRI] [int] NULL,
	[TEN_VI_TRI] [nvarchar](255) NULL,
	[MS_MAY] [nvarchar](30) NULL,
	[MS_DANG_XUAT] [nvarchar](50) NULL,
	[DANG_XUAT_VIET] [nvarchar](100) NULL,
	[NGUOI_NHAN] [nvarchar](20) NULL,
	[NGAY_CHUNG_TU] [datetime] NULL,
	[SO_CHUNG_TU] [nvarchar](255) NULL,
	[MS_PHIEU_BAO_TRI] [nvarchar](20) NULL,
	[GHI_CHU] [nvarchar](255) NULL,
	[LY_DO_XUAT] [nvarchar](255) NULL,
	[THU_KHO] [nvarchar](50) NULL,
	[MS_BP_CHIU_PHI] [int] NULL,
	[NGUOI_LAP] [nvarchar](255) NULL,
	[CAN_CU] [nvarchar](255) NULL,
	[DON_GIA] [float] NULL,
	[NGOAI_TE] [nvarchar](6) NULL,
	[TY_GIA] [float] NULL,
	[TY_GIA_USD] [float] NULL,
	[BAO_HANH_DEN_NGAY] [datetime] NULL,
	[XUAT_XU] [nvarchar](50) NULL,
	[INSERT_DATE] [datetime] NULL,
	[UPDATE_DATE] [datetime] NULL,
	[DA_CHUYEN] [bit] NULL,
	[NGAY_CHUYEN] [datetime] NULL,
 CONSTRAINT [PK_SYN_TB_PHIEU_XUAT_CMMS] PRIMARY KEY CLUSTERED 
(
	[STT] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
END

GO
IF  NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_SYN_TB_PHIEU_XUAT_CMMS_DA_CHUYEN]') AND type = 'D')
BEGIN
	ALTER TABLE [dbo].[SYN_TB_XUAT_KHO_CMMS] ADD  CONSTRAINT [DF_SYN_TB_PHIEU_XUAT_CMMS_DA_CHUYEN]  DEFAULT ((0)) FOR [DA_CHUYEN]
END




