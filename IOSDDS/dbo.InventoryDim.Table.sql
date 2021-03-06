USE [IOSDDS]
GO
/****** Object:  Table [dbo].[InventoryDim]    Script Date: 12/22/2020 7:05:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryDim](
	[InventoryKey] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseNumber] [varchar](3) NULL,
	[WarehouseNUmberDescription] [varchar](100) NULL,
	[LocationZone] [varchar](2) NULL,
	[LocationID] [varchar](8) NULL,
	[LocationType] [varchar](6) NULL,
	[Item] [varchar](35) NULL,
	[Batch] [varchar](13) NULL,
	[FirstPutAwayDate] [date] NULL,
	[OldestReceptionDate] [date] NULL,
	[StockTakeStatus] [varchar](1) NULL,
	[IsSerialNumberTracking] [varchar](1) NULL,
	[LandedCostsRequired] [varchar](1) NULL,
	[IsQualityControl] [varchar](1) NULL,
	[IsTransitDelivery] [varchar](1) NULL,
	[IsHeldBalance] [varchar](1) NULL,
	[ItemNumber] [varchar](6) NULL,
	[ETLDate] [date] NULL,
	[ETLTime] [time](7) NULL,
	[RowversionID] [varbinary](8) NOT NULL,
	[StockTakeListNumber] [numeric](7, 0) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_InventoryDim] PRIMARY KEY CLUSTERED 
(
	[InventoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IOSFG]
) ON [IOSFG]
GO
ALTER TABLE [dbo].[InventoryDim] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
