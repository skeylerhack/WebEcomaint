IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[THONG_TIN]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[THONG_TIN](
		[MS_TTIN] [nvarchar](50) NOT NULL,
		[THONG_TIN] [int] NULL,
		[GHI_CHU] [nvarchar](500) NULL,
	 CONSTRAINT [PK_THONG_TIN] PRIMARY KEY CLUSTERED 
	(
		[MS_TTIN] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
END

IF NOT EXISTS (SELECT * FROM THONG_TIN WHERE MS_TTIN = 'BBCP_MAIL')
BEGIN
	INSERT [dbo].[THONG_TIN] ([MS_TTIN], [THONG_TIN], [GHI_CHU]) 
	VALUES (N'BBCP_MAIL', 0, N'1- la cho dinh nghia mail trong BPCP va moi lan lock phieu xuat thi goi mail theo mail dinh nghia cua BPCP')
END
