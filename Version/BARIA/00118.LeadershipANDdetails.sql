IF NOT   EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Leadership]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Leadership](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Content] [nvarchar](max) NULL,
	[UserCreate] [nvarchar](30) NULL,
	[DateCreate] [datetime] NULL,
	[UserEdits] [nvarchar](30) NULL,
	[DateEdits] [datetime] NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_Leadership] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET IDENTITY_INSERT [dbo].[Leadership] ON 
INSERT [dbo].[Leadership] ([ID], [Content], [UserCreate], [DateCreate], [UserEdits], [DateEdits], [Active]) VALUES (1, N'Noi dung 1', N'admin', CAST(N'2021-09-08T09:08:59.857' AS DateTime), NULL, NULL, 1)
INSERT [dbo].[Leadership] ([ID], [Content], [UserCreate], [DateCreate], [UserEdits], [DateEdits], [Active]) VALUES (2, N'Noi Dung 2', N'admin', CAST(N'2021-09-08T09:09:12.390' AS DateTime), NULL, NULL, 1)
SET IDENTITY_INSERT [dbo].[Leadership] OFF
END

IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LeadershipDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LeadershipDetails](
	[IDLeadership] [int] NOT NULL,
	[UserName] [nvarchar](30) NOT NULL,
	[DateCreate] [datetime] NOT NULL,
	[Yes] [bit] NULL,
	[No] [bit] NULL,
	[NA] [bit] NULL,
 CONSTRAINT [PK_LeadershipDetails] PRIMARY KEY CLUSTERED 
(
	[IDLeadership] ASC,
	[UserName] ASC,
	[DateCreate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
ALTER TABLE [dbo].[LeadershipDetails]  WITH CHECK ADD  CONSTRAINT [FK_LeadershipDetails_Leadership] FOREIGN KEY([IDLeadership])
REFERENCES [dbo].[Leadership] ([ID])
ALTER TABLE [dbo].[LeadershipDetails] CHECK CONSTRAINT [FK_LeadershipDetails_Leadership]
END





