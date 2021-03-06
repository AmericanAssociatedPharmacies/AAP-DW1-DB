USE [IOSDDS]
GO
/****** Object:  Table [dbo].[InventoryFact]    Script Date: 12/22/2020 7:05:22 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InventoryFact](
	[DateKey] [int] NOT NULL,
	[DrugKey] [int] NOT NULL,
	[InventoryKey] [int] NOT NULL,
	[QuantityInLocation] [numeric](7, 0) NULL,
	[QuantityReservedForPick] [numeric](17, 3) NULL,
	[PickPriority] [numeric](3, 0) NULL,
	[PutAwayPriority] [numeric](3, 0) NULL,
	[LastStockTakeDate] [numeric](3, 0) NULL,
	[UnusableNonConformingStockOnHandQuantity] [numeric](15, 3) NULL,
	[UsableNonConformingStockOnHandQuantity] [numeric](15, 3) NULL,
	[NonConformityCertificateNumber] [numeric](7, 0) NULL,
	[OrderReferenceNumber] [numeric](7, 0) NULL,
	[OrderReferenceLineNumber] [numeric](5, 0) NULL,
	[TransactionCount] [tinyint] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_InvetoryFact_2] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC,
	[DrugKey] ASC,
	[InventoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psIOSDDS_RangeLeft]([DateKey])
) ON [psIOSDDS_RangeLeft]([DateKey])
GO
ALTER TABLE [dbo].[InventoryFact] ADD  DEFAULT ((1)) FOR [TransactionCount]
GO
ALTER TABLE [dbo].[InventoryFact] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
