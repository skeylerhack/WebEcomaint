IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Item]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Item](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemCode] [nvarchar](50) NULL,
	[ItemName] [nvarchar](250) NULL,
	[ItemNameA] [nvarchar](250) NULL,
	[ItemNameH] [nvarchar](250) NULL,
	[OtherName] [nvarchar](250) NULL,
	[Barcode] [nvarchar](50) NULL,
	[IDItemGroup] [bigint] NULL,
	[Description] [nvarchar](50) NULL,
	[UOMConverionGroupID] [bigint] NULL,
	[BasedUOM] [bigint] NOT NULL,
 CONSTRAINT [PK_Item] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ItemGroup]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemGroup](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ItemGroupName] [nvarchar](250) NULL,
	[ItemGroupNameA] [nvarchar](250) NULL,
	[ItemGroupNameH] [nvarchar](250) NULL,
	[Note] [nvarchar](500) NULL,
 CONSTRAINT [PK_ItemGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ItemMay]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ItemMay]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ItemMay](
	[MS_MAY] [nvarchar](30) NOT NULL,
	[ItemID] [bigint] NOT NULL,
	[StandardOutput] [numeric](18, 2) NULL,
	[MS_DV_TG_Output] [bigint] NULL,
	[StandardSpeed] [numeric](18, 2) NULL,
	[MS_DV_TG_Speed] [bigint] NULL,
	[DataCollectionCycle] [bigint] NULL,
	[DownTimeRecord] [bigint] NULL,
	[WorkingCycle] [int] NULL,
	[NumberPerCyle] [numeric](18, 2) NULL,
	[TimeSendMgs] [numeric](18, 2) NULL,
 CONSTRAINT [PK_ItemMay] PRIMARY KEY CLUSTERED 
(
	[MS_MAY] ASC,
	[ItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[Operator]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Operator]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Operator](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[OperatorCode] [nvarchar](50) NULL,
	[OperatorName] [nvarchar](250) NULL,
	[OperatorNameA] [nvarchar](250) NULL,
	[OperatorNameH] [nvarchar](250) NULL,
	[CardID] [int] NULL,
	[Note] [nvarchar](500) NULL,
 CONSTRAINT [PK_Operator] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[PrODetails]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PrODetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PrODetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PROID] [bigint] NOT NULL,
	[MS_MAY] [nvarchar](30) NULL,
	[MS_HE_THONG] [int] NULL,
	[AllocatedQuantity] [numeric](18, 2) NULL,
	[PlannedStartTime] [datetime] NULL,
	[DueTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[CaSTT] [int] NULL,
	[StandardSpeed] [numeric](18, 2) NULL,
	[StandardOutput] [numeric](18, 2) NULL,
	[ActualQuantity] [numeric](18, 2) NULL,
	[WorkingCycle] [int] NULL,
	[NumberPerCycle] [numeric](18, 2) NULL,
	[DownTimeRecord] [numeric](18, 2) NULL,
 CONSTRAINT [PK_PrODetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProductionOrder]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductionOrder]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductionOrder](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[PrOrNumber] [nvarchar](50) NULL,
	[OrderDate] [datetime] NULL,
	[StartDate] [datetime] NULL,
	[DueDate] [datetime] NULL,
	[ItemID] [bigint] NULL,
	[ItemDescription] [nvarchar](50) NULL,
	[PlannedQuantity] [numeric](18, 2) NULL,
	[ActualQty] [numeric](18, 2) NULL,
	[ItemUOM] [bigint] NULL,
	[Status] [bigint] NULL,
	[OriginPrOID] [bigint] NULL,
	[Stage] [bigint] NULL,
 CONSTRAINT [PK_ProductionOrder] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProductionRun]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductionRun]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductionRun](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[MS_MAY] [nvarchar](30) NULL,
	[CaSTT] [int] NULL,
	[OperatorID] [bigint] NULL,
	[StartTime] [datetime] NULL,
	[EndTime] [datetime] NULL,
	[ActualSpeed] [numeric](18, 2) NULL,
 CONSTRAINT [PK_MachineRun] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[ProductionRunDetails]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProductionRunDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProductionRunDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductionRunID] [bigint] NOT NULL,
	[ItemID] [bigint] NULL,
	[POID] [bigint] NULL,
	[DetailsID] [bigint] NULL,
	[AllocatedQuantity] [numeric](18, 2) NULL,
	[ActualQuantity] [numeric](18, 2) NULL,
	[DefectQuantity] [numeric](18, 2) NULL,
	[ActualSpeed] [numeric](18, 2) NULL,
 CONSTRAINT [PK_ProductionRunDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[SatusProDuct]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SatusProDuct]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SatusProDuct](
	[ID] [smallint] NOT NULL,
	[NAME_STATUS] [nvarchar](500) NULL,
	[NAME_STATUS_A] [nvarchar](500) NULL,
	[NAME_STATUS_H] [nvarchar](500) NULL
 CONSTRAINT [PK_SatusProDuct] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[UOM]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UOM]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UOM](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UOMCode] [nvarchar](50) NULL,
	[UOMName] [nvarchar](250) NULL,
	[UOMNameA] [nvarchar](250) NULL,
	[UOMNameH] [nvarchar](250) NULL,
	[Length] [numeric](18, 2) NULL,
	[Width] [numeric](18, 2) NULL,
	[Height] [numeric](18, 2) NULL,
	[Volume] [numeric](18, 2) NULL,
	[Weight] [numeric](18, 2) NULL,
	[BasedUOM] [bit] NULL,
	[UOMNote] [nvarchar](500) NULL,
 CONSTRAINT [PK_UOM] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[UOMConversionGroup]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UOMConversionGroup]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UOMConversionGroup](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[GroupName] [nvarchar](250) NULL,
	[BasedUOMID] [bigint] NULL,
	[Note] [nvarchar](500) NULL,
	[GroupNameA] [nvarchar](250) NULL,
	[GroupNameH] [nvarchar](250) NULL,
 CONSTRAINT [PK_UOMConversionGourp] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
/****** Object:  Table [dbo].[UOMConversionGroupDetails]    Script Date: 14/11/2020 08:54:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UOMConversionGroupDetails]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UOMConversionGroupDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[UOMConversionGroupID] [bigint] NOT NULL,
	[UOMID] [bigint] NOT NULL,
	[UOMQuantity] [numeric](18, 2) NOT NULL,
	[BasedUOMQuantity] [numeric](18, 2) NOT NULL,
	[Note] [nvarchar](500) NULL,
 CONSTRAINT [PK_UOMConversionGroupDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Item_ItemGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[Item]'))
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_ItemGroup] FOREIGN KEY([IDItemGroup])
REFERENCES [dbo].[ItemGroup] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Item_ItemGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[Item]'))
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_ItemGroup]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Item_UOMConversionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[Item]'))
ALTER TABLE [dbo].[Item]  WITH CHECK ADD  CONSTRAINT [FK_Item_UOMConversionGroup] FOREIGN KEY([UOMConverionGroupID])
REFERENCES [dbo].[UOMConversionGroup] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Item_UOMConversionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[Item]'))
ALTER TABLE [dbo].[Item] CHECK CONSTRAINT [FK_Item_UOMConversionGroup]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ItemMay_Item]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemMay]'))
ALTER TABLE [dbo].[ItemMay]  WITH CHECK ADD  CONSTRAINT [FK_ItemMay_Item] FOREIGN KEY([ItemID])
REFERENCES [dbo].[Item] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ItemMay_Item]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemMay]'))
ALTER TABLE [dbo].[ItemMay] CHECK CONSTRAINT [FK_ItemMay_Item]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ItemMay_MAY]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemMay]'))
ALTER TABLE [dbo].[ItemMay]  WITH CHECK ADD  CONSTRAINT [FK_ItemMay_MAY] FOREIGN KEY([MS_MAY])
REFERENCES [dbo].[MAY] ([MS_MAY])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ItemMay_MAY]') AND parent_object_id = OBJECT_ID(N'[dbo].[ItemMay]'))
ALTER TABLE [dbo].[ItemMay] CHECK CONSTRAINT [FK_ItemMay_MAY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PODetails_ProductionOrder]') AND parent_object_id = OBJECT_ID(N'[dbo].[PrODetails]'))
ALTER TABLE [dbo].[PrODetails]  WITH CHECK ADD  CONSTRAINT [FK_PODetails_ProductionOrder] FOREIGN KEY([PROID])
REFERENCES [dbo].[ProductionOrder] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_PODetails_ProductionOrder]') AND parent_object_id = OBJECT_ID(N'[dbo].[PrODetails]'))
ALTER TABLE [dbo].[PrODetails] CHECK CONSTRAINT [FK_PODetails_ProductionOrder]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionOrder_ProductionOrder]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionOrder]'))
ALTER TABLE [dbo].[ProductionOrder]  WITH CHECK ADD  CONSTRAINT [FK_ProductionOrder_ProductionOrder] FOREIGN KEY([ID])
REFERENCES [dbo].[ProductionOrder] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionOrder_ProductionOrder]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionOrder]'))
ALTER TABLE [dbo].[ProductionOrder] CHECK CONSTRAINT [FK_ProductionOrder_ProductionOrder]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MachineRun_CA]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRun]'))
ALTER TABLE [dbo].[ProductionRun]  WITH CHECK ADD  CONSTRAINT [FK_MachineRun_CA] FOREIGN KEY([CaSTT])
REFERENCES [dbo].[CA] ([STT])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MachineRun_CA]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRun]'))
ALTER TABLE [dbo].[ProductionRun] CHECK CONSTRAINT [FK_MachineRun_CA]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MachineRun_Operator]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRun]'))
ALTER TABLE [dbo].[ProductionRun]  WITH CHECK ADD  CONSTRAINT [FK_MachineRun_Operator] FOREIGN KEY([OperatorID])
REFERENCES [dbo].[Operator] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_MachineRun_Operator]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRun]'))
ALTER TABLE [dbo].[ProductionRun] CHECK CONSTRAINT [FK_MachineRun_Operator]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRunDetails_ProductionRun]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRunDetails]'))
ALTER TABLE [dbo].[ProductionRunDetails]  WITH CHECK ADD  CONSTRAINT [FK_ProductionRunDetails_ProductionRun] FOREIGN KEY([ProductionRunID])
REFERENCES [dbo].[ProductionRun] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_ProductionRunDetails_ProductionRun]') AND parent_object_id = OBJECT_ID(N'[dbo].[ProductionRunDetails]'))
ALTER TABLE [dbo].[ProductionRunDetails] CHECK CONSTRAINT [FK_ProductionRunDetails_ProductionRun]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UOMConversionGroupDetails_UOM]') AND parent_object_id = OBJECT_ID(N'[dbo].[UOMConversionGroupDetails]'))
ALTER TABLE [dbo].[UOMConversionGroupDetails]  WITH CHECK ADD  CONSTRAINT [FK_UOMConversionGroupDetails_UOM] FOREIGN KEY([UOMID])
REFERENCES [dbo].[UOM] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UOMConversionGroupDetails_UOM]') AND parent_object_id = OBJECT_ID(N'[dbo].[UOMConversionGroupDetails]'))
ALTER TABLE [dbo].[UOMConversionGroupDetails] CHECK CONSTRAINT [FK_UOMConversionGroupDetails_UOM]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UOMConversionGroupDetails_UOMConversionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[UOMConversionGroupDetails]'))
ALTER TABLE [dbo].[UOMConversionGroupDetails]  WITH CHECK ADD  CONSTRAINT [FK_UOMConversionGroupDetails_UOMConversionGroup] FOREIGN KEY([UOMConversionGroupID])
REFERENCES [dbo].[UOMConversionGroup] ([ID])
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UOMConversionGroupDetails_UOMConversionGroup]') AND parent_object_id = OBJECT_ID(N'[dbo].[UOMConversionGroupDetails]'))
ALTER TABLE [dbo].[UOMConversionGroupDetails] CHECK CONSTRAINT [FK_UOMConversionGroupDetails_UOMConversionGroup]
GO


if not exists(select * from sys.columns 
where Name = N'LOAI_MENU' and Object_ID = Object_ID(N'MENU'))
begin
    ALTER TABLE dbo.MENU ADD LOAI_MENU BIT  DEFAULT (0)
END    
GO	
--[StandardSpeed] [numeric] (18, 2) NULL,
--[DataCollectionCycle] [int] NULL,
--[WorkingCycle] [int] NULL,
--[NumberPerCyle] [numeric] (18, 2) NULL,
--[TimeSendMgs] [numeric] (18, 2) NULL

if not exists(select * from sys.columns 
where Name = N'StandardSpeed' and Object_ID = Object_ID(N'MAY'))
begin
    ALTER TABLE dbo.MAY ADD StandardSpeed [numeric] (18, 2) NULL
END    
GO	

if not exists(select * from sys.columns 
where Name = N'NumberPerCyle' and Object_ID = Object_ID(N'MAY'))
begin
    ALTER TABLE dbo.MAY ADD NumberPerCyle [numeric] (18, 2) NULL
END    
GO	


if not exists(select * from sys.columns 
where Name = N'TimeSendMgs' and Object_ID = Object_ID(N'MAY'))
begin
    ALTER TABLE dbo.MAY ADD TimeSendMgs [numeric] (18, 2) NULL
END    
GO	



if not exists(select * from sys.columns 
where Name = N'DataCollectionCycle' and Object_ID = Object_ID(N'MAY'))
begin
    ALTER TABLE dbo.MAY ADD DataCollectionCycle INT
END    
GO


if not exists(select * from sys.columns 
where Name = N'WorkingCycle' and Object_ID = Object_ID(N'MAY'))
begin
    ALTER TABLE dbo.MAY ADD WorkingCycle INT
END    
GO

IF (SELECT COUNT(*) FROM dbo.LIC_MENU WHERE MENU_ID =N'ΞΠή͎͎͢') = 0
BEGIN
INSERT INTO dbo.LIC_MENU ( TYPE_LIC, MENU_ID )
VALUES  ( N'̦', -- TYPE_LIC - nvarchar(50)
          N'ΞΠή͎͎͢'  -- MENU_ID - nvarchar(1000)
          )
END

UPDATE dbo.MENU SET MENU_TYPE = -1 WHERE MENU_ID ='mnuMasterData'

