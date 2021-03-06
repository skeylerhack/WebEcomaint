
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM] AS TABLE(
	[GROUP_ID] [int] NULL,
	[GROUP_NAME] [nvarchar](50) NULL,
	[DESCRIPTION] [nvarchar](100) NULL,
	[TYPE_LIC] [int] NULL,
	[IS_UPDATE] [bit] NULL
)
END


IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_BO_PHAN_CHIU_PHI' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_BO_PHAN_CHIU_PHI] AS TABLE(
	[MS_BP_CHIU_PHI] [int] NULL,
	[TEN_BP_CHIU_PHI] [nvarchar](500) NULL,
	[TEN_DON_VI] [nvarchar](500) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END
IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_FORM' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_FORM] AS TABLE(
	[FORM_NAME] [nvarchar](255) NULL,
	[TEN_FORM] [nvarchar](500) NULL,
	[QUYEN] [nvarchar](20) NULL,
	[IS_UPDATE] [bit] NULL,
	[GROUP_ID] [int] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_HE_THONG' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_HE_THONG] AS TABLE(
	[MS_HE_THONG] [int] NULL,
	[TEN_HE_THONG] [nvarchar](500) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_KHO' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_KHO] AS TABLE(
	[MS_KHO] [int] NULL,
	[TEN_KHO] [nvarchar](300) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_LOAI_CONG_VIEC' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_LOAI_CONG_VIEC] AS TABLE(
	[MS_LOAI_CV] [int] NULL,
	[TEN_LOAI_CV] [nvarchar](300) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_LOAI_MAY' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_LOAI_MAY] AS TABLE(
	[MS_LOAI_MAY] [nvarchar](20) NULL,
	[TEN_LOAI_MAY] [nvarchar](500) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_LOAI_PHU_TUNG' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_LOAI_PHU_TUNG] AS TABLE(
	[MS_LOAI_PT] [int] NULL,
	[TEN_LOAI_PT] [nvarchar](300) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_NHA_XUONG' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_NHA_XUONG] AS TABLE(
	[MS_N_XUONG] [nvarchar](50) NULL,
	[Ten_N_XUONG] [nvarchar](500) NULL,
	[DIA_CHI] [nvarchar](500) NULL,
	[QUAN] [nvarchar](500) NULL,
	[TINH] [nvarchar](500) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_REPORT' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_REPORT] AS TABLE(
	[REPORT_NAME] [nvarchar](255) NULL,
	[TEN_REPORT] [nvarchar](255) NULL,
	[QUYEN] [nvarchar](20) NULL,
	[GROUP_ID] [int] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOM_TO_PHONG_BAN' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOM_TO_PHONG_BAN] AS TABLE(
	[MS_TO] [int] NULL,
	[TEN_DON_VI] [nvarchar](300) NULL,
	[TEN_TO] [nvarchar](300) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_NHOMMENU' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_NHOMMENU] AS TABLE(
	[MENU_ID] [nvarchar](255) NULL,
	[MENU_NAME] [nvarchar](300) NULL,
	[GROUP_ID] [int] NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_USER_CHUC_NANG' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_USER_CHUC_NANG] AS TABLE(
	[STT] [int] NULL,
	[TEN_CHUC_NANG] [nvarchar](500) NULL,
	[MT_CN] [nvarchar](500) NULL,
	[USERNAME] [nvarchar](50) NULL,
	[CHON] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_USERS' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [dbo].[TVT_USERS] AS TABLE(
	[USERNAME_OLD] [nvarchar](50) NULL,
	[USERNAME] [nvarchar](50) NULL,
	[GROUP_ID] [int] NOT NULL,
	[FULL_NAME] [nvarchar](50) NULL,
	[PASS] [nvarchar](50) NOT NULL,
	[DESCRIPTION] [nvarchar](100) NULL,
	[MS_TO] [int] NULL,
	[USER_MAIL] [nvarchar](150) NULL,
	[MS_CONG_NHAN] [nvarchar](9) NULL,
	[ACTIVE] [bit] NULL,
	[IS_UPDATE] [bit] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_DON_VI_DO' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [TVT_DON_VI_DO] AS TABLE(
	[MS_DV_DO] [smallint]  NULL,
	[TEN_DV_DO] [nvarchar](50) NULL,
	[IS_UPDATE] [BIT] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_DON_VI_TINH' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [TVT_DON_VI_TINH] AS TABLE(
	[DVT] [nvarchar](10)  NULL,
	[TEN_1] [nvarchar](20) NULL,
	[TEN_2] [nvarchar](20) NULL,
	[TEN_3] [nvarchar](20) NULL,
	[GHI_CHU] [nvarchar](255) NULL,
	[IS_UPDATE] [BIT] NULL
)
END

IF NOT EXISTS (SELECT * FROM sys.types st JOIN sys.schemas ss ON st.schema_id = ss.schema_id WHERE st.name = N'TVT_DON_VI_TINH_RUN_TIME' AND ss.name = N'dbo')
BEGIN
CREATE TYPE [TVT_DON_VI_TINH_RUN_TIME] AS TABLE(
	[MS_DVT_RT] [int]  NULL,
	[TEN_DVT_RT] [nvarchar](50)  NULL,
	[IS_UPDATE] [BIT] NULL
)
END

