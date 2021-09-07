

IF NOT EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='TVT_IC_KHO')
BEGIN
CREATE TYPE [TVT_IC_KHO] AS TABLE(
	[MS_KHO] [int]  NULL,
	[TEN_KHO] [nvarchar](50) NULL,
	[DIA_CHI] [nvarchar](100) NULL,
	[SO_DO] [nvarchar](255) NULL,
	[ISIT] [bit] NULL,
	[MS_CONG_NHAN] [nvarchar](9) NULL,
	[NGAY_LOCK] [datetime] NULL,
	[GIO_LOCK] [datetime] NULL,
	[UNAME] [nvarchar](50) NULL,
	[SN_CANH_BAO] [int] NULL,
	[KHO_DD] [bit] NULL,
	[MS_KHO_CHINH] [int] NULL,
	[MS_DON_VI] [nvarchar](6) NULL,
	[IS_UPDATE] [BIT] NULL
)
END