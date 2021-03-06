IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PHIEU_BAO_TRI_TINH_TRANG]') AND type in (N'U'))
BEGIN 
	CREATE TABLE [dbo].[PHIEU_BAO_TRI_TINH_TRANG](
		[ID] [int] NOT NULL,
		[MS_PHIEU_BAO_TRI] [nvarchar](20) NULL,
		[THONG_SO_DO] [nvarchar](500) NULL,
		[THIET_BI_DO] [nvarchar](500) NULL,
		[TT_TRUOC_BT] [nvarchar](500) NULL,
		[TT_SAU_BT] [nvarchar](500) NULL,
		[MS_DV_DO] [smallint] NULL,
		[XAC_NHAN] [bit] NULL,
		[GHI_CHU] [nvarchar](500) NULL,
		[USER_XN] [nvarchar](50) NULL,
	 CONSTRAINT [PK_PHIEU_BAO_TRI_TINH_TRANG] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]
	
	
	ALTER TABLE [dbo].[PHIEU_BAO_TRI_TINH_TRANG]  WITH CHECK ADD  CONSTRAINT [FK_PHIEU_BAO_TRI_TINH_TRANG_DON_VI_DO] FOREIGN KEY([MS_DV_DO])
	REFERENCES [dbo].[DON_VI_DO] ([MS_DV_DO])
	ON UPDATE CASCADE
	

	ALTER TABLE [dbo].[PHIEU_BAO_TRI_TINH_TRANG] CHECK CONSTRAINT [FK_PHIEU_BAO_TRI_TINH_TRANG_DON_VI_DO]
END 

