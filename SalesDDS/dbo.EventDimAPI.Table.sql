USE [SalesDDS]
GO
/****** Object:  Table [dbo].[EventDimAPI]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventDimAPI](
	[EventKey] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[InvoiceNumber] [varchar](50) NULL,
	[InvoiceLineNumber] [int] NULL,
	[InvoiceDate] [datetime] NULL,
	[TerritoryManagerNumber] [varchar](10) NULL,
	[AccountNumber] [varchar](25) NULL,
	[CustomerReference] [varchar](255) NULL,
	[PMID] [int] NULL,
	[WharehouseNumber] [varchar](25) NULL,
	[ItemGroupNumber] [varchar](25) NULL,
	[AccountGroupNumber] [varchar](25) NULL,
	[NDCOriginal] [varchar](50) NULL,
	[NDC] [varchar](50) NULL,
	[ItemNumber] [varchar](50) NULL,
	[RowversionID] [varbinary](8) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[IsCredit] [bit] NOT NULL,
	[Type] [varchar](250) NULL,
	[IsOrderFee] [bit] NOT NULL,
	[ItemDescription] [varchar](1000) NULL,
	[APISalesDetailID] [int] NOT NULL,
	[IsSourceDelete] [bit] NOT NULL,
	[RowversionIDOnDB1] [varbinary](8) NULL,
	[TransTypeCode] [varchar](10) NULL,
	[TransTypeCodeDesc] [varchar](50) NULL,
 CONSTRAINT [CPK_API_EventDim] PRIMARY KEY CLUSTERED 
(
	[EventKey] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psSalesFact_RangeLeft]([DateKey])
) ON [psSalesFact_RangeLeft]([DateKey])
GO
ALTER TABLE [dbo].[EventDimAPI] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[EventDimAPI] ADD  DEFAULT ((0)) FOR [IsCredit]
GO
ALTER TABLE [dbo].[EventDimAPI] ADD  DEFAULT ((0)) FOR [IsOrderFee]
GO
ALTER TABLE [dbo].[EventDimAPI] ADD  DEFAULT ((0)) FOR [APISalesDetailID]
GO
ALTER TABLE [dbo].[EventDimAPI] ADD  DEFAULT ((0)) FOR [IsSourceDelete]
GO
