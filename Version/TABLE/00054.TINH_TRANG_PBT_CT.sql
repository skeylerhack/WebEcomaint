

IF  NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TINH_TRANG_PBT_CT]') AND type in (N'U'))
BEGIN
	CREATE TABLE [dbo].[TINH_TRANG_PBT_CT](
		[MS_TT_CT] [int] IDENTITY(1,1) NOT NULL,
		[STT] [int] NOT NULL,
		[MA_SO] [nvarchar](50) NOT NULL,
		[TEN_TIENG_VIET] [nvarchar](500) NULL,
		[TEN_TIENG_ANH] [nvarchar](500) NULL,
		[TEN_TIENG_HOA] [nvarchar](500) NULL,
		[GHI_CHU] [nvarchar](1000) NULL,
		[MAC_DINH] [bit] NULL CONSTRAINT [DF_TINH_TRANG_PBT_CT_MAC_DINH]  DEFAULT ((0)),
	 CONSTRAINT [PK_TINH_TRANG_PBT_CT] PRIMARY KEY CLUSTERED 
	(
		[MS_TT_CT] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
	) ON [PRIMARY]


	EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Mã số tình trang PBT ứng với tình trang chi tiết' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'TINH_TRANG_PBT_CT', @level2type=N'COLUMN',@level2name=N'STT'

	ALTER TABLE [dbo].[TINH_TRANG_PBT_CT]  WITH CHECK ADD  CONSTRAINT [FK_TINH_TRANG_PBT_CT_TINH_TRANG_PBT] FOREIGN KEY([STT])
	REFERENCES [dbo].[TINH_TRANG_PBT] ([STT])
	ON UPDATE CASCADE
	ON DELETE CASCADE

	ALTER TABLE [dbo].[TINH_TRANG_PBT_CT] CHECK CONSTRAINT [FK_TINH_TRANG_PBT_CT_TINH_TRANG_PBT]






END
ELSE
BEGIN
if not exists(select * from sys.columns 
            where Name = N'MAC_DINH' and Object_ID = Object_ID(N'TINH_TRANG_PBT_CT'))
begin
    ALTER TABLE TINH_TRANG_PBT_CT ADD MAC_DINH  [bit] NULL CONSTRAINT [DF_TINH_TRANG_PBT_CT_MAC_DINH]  DEFAULT ((0))
END    
--[MAC_DINH] [bit] NULL CONSTRAINT [DF_TINH_TRANG_PBT_CT_MAC_DINH]  DEFAULT ((0)),
END