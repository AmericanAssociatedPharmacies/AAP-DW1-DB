USE [IOSDDS]
GO
/****** Object:  Table [Archive].[Inventory]    Script Date: 12/22/2020 7:05:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[Inventory](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[WarehouseNumber] [varchar](3) NULL,
	[LocationZone] [varchar](2) NULL,
	[LocationID] [varchar](8) NULL,
	[Item] [varchar](35) NULL,
	[Batch] [varchar](13) NULL,
	[FirstPutAwayDate] [date] NULL,
	[OldestReceptionDate] [date] NULL,
	[QuantityInLocation] [numeric](7, 0) NULL,
	[QuantityReservedForPick] [numeric](17, 3) NULL,
	[StockTakeStatus] [varchar](1) NULL,
	[PickPriority] [numeric](3, 0) NULL,
	[PutAwayPriority] [numeric](3, 0) NULL,
	[LastStockTakeDate] [numeric](3, 0) NULL,
	[LocationType] [varchar](6) NULL,
	[UnusableNonConformingStockOnHandQuantity] [numeric](15, 3) NULL,
	[UsableNonConformingStockOnHandQuantity] [numeric](15, 3) NULL,
	[NonConformityCertificateNumber] [numeric](7, 0) NULL,
	[IsSerialNumberTracking] [varchar](1) NULL,
	[OrderReferenceNumber] [numeric](7, 0) NULL,
	[OrderReferenceLineNumber] [numeric](5, 0) NULL,
	[LandedCostsRequired] [varchar](1) NULL,
	[IsQualityControl] [varchar](1) NULL,
	[IsTransitDelivery] [varchar](1) NULL,
	[IsHeldBalance] [varchar](1) NULL,
	[ItemNumber] [varchar](6) NULL,
	[ETLDateKey] [int] NOT NULL,
	[ETLDate] [date] NULL,
	[ETLTime] [time](7) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowversionID] [varbinary](8) NOT NULL,
	[StockTakeListNumber] [numeric](7, 0) NULL,
 CONSTRAINT [CPK_Staging_Inventory] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[ETLDateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psIOSDDS_RangeLeft]([ETLDateKey])
) ON [psIOSDDS_RangeLeft]([ETLDateKey])
GO
ALTER TABLE [Archive].[Inventory] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
