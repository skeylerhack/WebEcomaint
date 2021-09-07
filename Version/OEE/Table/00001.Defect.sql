
CREATE TABLE [dbo].[Defect](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DefectName] [nvarchar](50) NULL,
	[DefectName_E] [nvarchar](50) NULL,
	[DefectName_C] [nvarchar](50) NULL,
	[ID_DG] [int] NOT NULL,
	[THU_TU] [int] NULL,
	[Note] [nvarchar](250) NULL,
 CONSTRAINT [PK_Defect] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DefectGroup]    Script Date: 30/06/2021 11:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DefectGroup](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DefectGroupName] [nvarchar](50) NULL,
	[DefectGroupName_E] [nvarchar](50) NULL,
	[DefectGroupName_C] [nvarchar](50) NULL,
	[THU_TU] [int] NULL,
	[Note] [nvarchar](250) NULL,
 CONSTRAINT [PK_NHOM_LOI] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QCData]    Script Date: 30/06/2021 11:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QCData](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[DocNum] [nvarchar](9) NULL,
	[QCName] [nvarchar](50) NULL,
	[QCDate] [datetime] NULL,
 CONSTRAINT [PK_QCData_1] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[QCDataDetails]    Script Date: 30/06/2021 11:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[QCDataDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ID_QC] [bigint] NOT NULL,
	[ID_PO] [bigint] NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[MS_MAY] [nvarchar](30) NOT NULL,
	[ProductionDate] [datetime] NULL,
	[ID_Defect] [int] NOT NULL,
	[Quantity] [int] NULL,
	[Note] [nvarchar](250) NULL,
 CONSTRAINT [PK_QCDataDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[ID_QC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Defect]  WITH CHECK ADD  CONSTRAINT [FK_Defect_DefectGroup] FOREIGN KEY([ID_DG])
REFERENCES [dbo].[DefectGroup] ([ID])
GO
ALTER TABLE [dbo].[Defect] CHECK CONSTRAINT [FK_Defect_DefectGroup]
GO
