USE [ODSIntake]
GO
/****** Object:  Table [Staging].[CHAAPImport_old_RSE_20200816]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CHAAPImport_old_RSE_20200816](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NOT NULL,
	[DC] [varchar](500) NULL,
	[CustomerName] [varchar](500) NULL,
	[CustomerNumber] [varchar](500) NULL,
	[ItemNumber] [varchar](500) NULL,
	[Store] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[ItemType] [varchar](500) NULL,
	[ItemDescr] [varchar](500) NULL,
	[GenericName] [varchar](500) NULL,
	[TradeName] [varchar](500) NULL,
	[InvDate] [varchar](500) NULL,
	[InvoiceNumber] [varchar](500) NULL,
	[Type] [varchar](500) NULL,
	[OrderQty] [varchar](500) NULL,
	[ShipQty] [varchar](500) NULL,
	[UnitCost] [varchar](500) NULL,
	[ExtCost] [varchar](500) NULL,
	[CorpAWP] [varchar](500) NULL,
	[WAC] [varchar](500) NULL,
	[VendorName] [varchar](500) NULL,
	[UPC] [varchar](500) NULL,
	[ContractFlag] [varchar](500) NULL,
	[Brand] [varchar](500) NULL,
	[GenericCode] [varchar](500) NULL,
	[Strength] [varchar](500) NULL,
	[ShortCode] [varchar](500) NULL,
	[Encoding] [varchar](500) NULL,
	[ContractNumber] [varchar](500) NULL,
	[ContrDescr] [varchar](500) NULL,
	[OrderNumber] [varchar](500) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[ROWVERSIONID] [timestamp] NOT NULL,
 CONSTRAINT [CPK_Staging_CHAAPImport] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CHAAPImport_old_RSE_20200816] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
