USE [SalesDDS]
GO
/****** Object:  Table [Staging].[EventDimCAH]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[EventDimCAH](
	[EventKey] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[InvoiceNumber] [varchar](25) NULL,
	[InvoiceLineNumber] [int] NULL,
	[InvoiceDate] [datetime] NULL,
	[PMID] [int] NULL,
	[DistributionCenter] [int] NULL,
	[NDC] [varchar](25) NULL,
	[UPC] [varchar](25) NULL,
	[ItemNumber] [varchar](25) NULL,
	[ItemDescription] [varchar](1000) NULL,
	[ItemType] [varchar](25) NULL,
	[OrderNumber] [varchar](25) NULL,
	[IsBackupSource] [bit] NOT NULL,
	[IsTenSource] [bit] NOT NULL,
	[IsSourceWeekly] [bit] NOT NULL,
	[IsTopGenerics] [bit] NOT NULL,
	[RowversionID] [varbinary](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[CHPH_AAP_ID] [int] NOT NULL,
 CONSTRAINT [CPK_Staging_EventDimCAH] PRIMARY KEY CLUSTERED 
(
	[EventKey] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psSalesFact_RangeLeft]([DateKey])
) ON [psSalesFact_RangeLeft]([DateKey])
GO
ALTER TABLE [Staging].[EventDimCAH] ADD  DEFAULT ((0)) FOR [IsBackupSource]
GO
ALTER TABLE [Staging].[EventDimCAH] ADD  DEFAULT ((0)) FOR [IsTenSource]
GO
ALTER TABLE [Staging].[EventDimCAH] ADD  DEFAULT ((0)) FOR [IsSourceWeekly]
GO
ALTER TABLE [Staging].[EventDimCAH] ADD  DEFAULT ((0)) FOR [IsTopGenerics]
GO
ALTER TABLE [Staging].[EventDimCAH] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[EventDimCAH] ADD  DEFAULT ((0)) FOR [CHPH_AAP_ID]
GO
