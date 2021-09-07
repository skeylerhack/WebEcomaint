
IF NOT EXISTS (SELECT * FROM sys.types WHERE is_table_type = 1 AND name ='TVT_VI_TRI_KHO')
BEGIN
CREATE TYPE TVT_VI_TRI_KHO AS TABLE(
	[MS_VI_TRI] [int]  NULL,
	[TEN_VI_TRI] [nvarchar](255) NULL,
	[GHI_CHU] [nvarchar](255) NULL,
	[MS_KHO] [int]  NULL,
	[TEN_KHO] [nvarchar](50) NULL,
	[IS_UPDATE] [BIT] NULL
 )


 END