
CREATE TABLE [dbo].[ProductionRunDetails](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[POID] [bigint] NULL,
	MS_HE_THONG INT NULL,
	MS_TO INT null,
	MS_MAY NVARCHAR(30) NULL,
	[ItemID] [bigint] NULL,
	StartTime DATETIME,
	CaSTT INT,
	OperatorID BIGINT,
	EndTime DATETIME,
	[AllocatedQuantity] [numeric](18, 2) NULL,
	[StandardOutput] [numeric](18, 2) NULL,
	[StandardSpeed] [numeric](18, 2) NULL,
	[ActualQuantity] [numeric](18, 2) NULL,
	OmePackWeight [numeric](18, 3) NULL,
	CD [numeric](18, 3) NULL,
	[DefectQuantity] [numeric](18, 2) NULL,
	[ActualSpeed] [numeric](18, 2) NULL,
 CONSTRAINT [PK_ProductionRunDetails] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

