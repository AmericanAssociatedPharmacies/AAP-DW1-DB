USE [SalesDDS]
GO
/****** Object:  Table [Staging].[API]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[API](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[APISalesInvoiceID] [int] NOT NULL,
	[InvNbr] [varchar](32) NULL,
	[OrderNbr] [varchar](15) NULL,
	[InvDate] [datetime] NULL,
	[WHAccountID] [varchar](32) NULL,
	[CustomerName] [varchar](255) NULL,
	[CarrierCode] [varchar](15) NULL,
	[CarrierDesc] [varchar](255) NULL,
	[CustomerRef] [varchar](255) NULL,
	[Whsnum] [varchar](2) NULL,
	[OrdType] [varchar](2) NULL,
	[DateLoaded] [datetime] NULL,
	[APISalesDetailID] [int] NOT NULL,
	[InvLine] [varchar](32) NULL,
	[APIItemNbr] [varchar](50) NULL,
	[ItemDescription] [varchar](125) NULL,
	[Qty] [decimal](18, 2) NULL,
	[UnitAmount] [decimal](18, 2) NULL,
	[ItemGrp] [varchar](5) NULL,
	[AcctGrp] [varchar](5) NULL,
	[Territory] [varchar](4) NULL,
	[LineAmt] [decimal](18, 2) NULL,
	[ExtSales] [decimal](18, 2) NULL,
	[NDC_orig] [varchar](50) NULL,
	[NDC] [varchar](11) NULL,
	[Type] [varchar](15) NULL,
	[WHNbr] [varchar](2) NULL,
	[Rebate] [decimal](18, 2) NULL,
	[DateKey] [int] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[PMID] [int] NULL,
	[APIHoldbackPercent] [decimal](18, 4) NOT NULL,
	[APIHoldbackAmount] [money] NOT NULL,
	[RebateAfterAPIHoldbackAmount] [money] NULL,
	[AffiliateHoldbackPercent] [decimal](18, 4) NOT NULL,
	[AffiliateHoldbackAmount] [money] NOT NULL,
	[FinalRebateAmount] [money] NOT NULL,
	[RowversionID] [varbinary](8) NOT NULL,
	[PharmacyKey] [int] NOT NULL,
	[IsCredit] [bit] NOT NULL,
	[TransTypeCode] [varchar](10) NULL,
	[TransTypeCodeDesc] [varchar](50) NULL,
 CONSTRAINT [CPK_Staging_API] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psSalesFact_RangeLeft]([DateKey])
) ON [psSalesFact_RangeLeft]([DateKey])
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT ((0.00)) FOR [APIHoldbackPercent]
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT ((0.00)) FOR [APIHoldbackAmount]
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT ((0.00)) FOR [RebateAfterAPIHoldbackAmount]
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT ((0.00)) FOR [AffiliateHoldbackPercent]
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT ((0.00)) FOR [AffiliateHoldbackAmount]
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT ((0.00)) FOR [FinalRebateAmount]
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT ((0)) FOR [PharmacyKey]
GO
ALTER TABLE [Staging].[API] ADD  DEFAULT ((0)) FOR [IsCredit]
GO
