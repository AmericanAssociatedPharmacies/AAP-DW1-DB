USE [SalesDDS]
GO
/****** Object:  Table [Staging].[CAH]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CAH](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[DC] [int] NULL,
	[CUSTOMER_NAME] [varchar](63) NULL,
	[CUSTOMER_NO] [varchar](31) NULL,
	[ITEM_NO] [varchar](31) NULL,
	[PMID] [int] NULL,
	[STORE] [varchar](31) NULL,
	[NDC] [varchar](15) NULL,
	[ITEM_TYPE] [varchar](15) NULL,
	[ITEM_DESCR] [varchar](127) NULL,
	[GENERIC_NAME] [varchar](127) NULL,
	[TRADE_NAME] [varchar](127) NULL,
	[INV_DATE] [datetime] NULL,
	[INVOICE_NO] [varchar](15) NULL,
	[TYPE] [varchar](15) NULL,
	[ORDER_QTY] [numeric](18, 0) NULL,
	[SHIP_QTY] [numeric](18, 0) NULL,
	[UNIT_COST] [float] NULL,
	[EXT_COST] [float] NULL,
	[CORP_AWP] [float] NULL,
	[WAC] [float] NULL,
	[VENDOR_NAME] [varchar](127) NULL,
	[UPC] [varchar](127) NULL,
	[CONTRACT_FLAG] [varchar](31) NULL,
	[BRAND] [varchar](31) NULL,
	[GENERIC_CODE] [varchar](31) NULL,
	[STRENGTH] [varchar](127) NULL,
	[SHORT_CODE] [varchar](31) NULL,
	[ENCODING] [varchar](31) NULL,
	[ContractNo] [varchar](31) NULL,
	[ContractDesc] [varchar](255) NULL,
	[MM_DD_YY_LOAD] [datetime] NULL,
	[OrderNo] [varchar](20) NULL,
	[InvoiceLineNumber] [int] NULL,
	[RowversionID] [varbinary](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[IsBackupSource] [bit] NOT NULL,
	[IsTenSource] [bit] NOT NULL,
	[IsSourceWeekly] [bit] NOT NULL,
	[IsTopGenerics] [bit] NOT NULL,
	[RowversionID_DB1] [varbinary](8) NULL,
	[DEA] [varchar](25) NULL,
 CONSTRAINT [PK_Staging_CHPH_AAP] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psSalesFact_RangeLeft]([DateKey])
) ON [psSalesFact_RangeLeft]([DateKey])
GO
ALTER TABLE [Staging].[CAH] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[CAH] ADD  DEFAULT ((0)) FOR [IsBackupSource]
GO
ALTER TABLE [Staging].[CAH] ADD  DEFAULT ((0)) FOR [IsTenSource]
GO
ALTER TABLE [Staging].[CAH] ADD  DEFAULT ((0)) FOR [IsSourceWeekly]
GO
ALTER TABLE [Staging].[CAH] ADD  DEFAULT ((0)) FOR [IsTopGenerics]
GO
