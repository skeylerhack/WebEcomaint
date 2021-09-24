CREATE TABLE [dbo].[ST_Safety](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Staffname] [nvarchar](200) NULL,
	[Department] [int] NULL,
	[Position] [nvarchar](200) NULL,
	[Userlogin] [nvarchar](200) NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_ST_Safety] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]



