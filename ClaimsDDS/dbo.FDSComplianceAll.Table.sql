USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[FDSComplianceAll]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDSComplianceAll](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[PMID] [int] NULL,
	[GPI] [varchar](25) NULL,
	[DrugDesc] [varchar](100) NULL,
	[DispenseQty] [numeric](38, 3) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[DispensedAtInvoicePrice] [decimal](18, 2) NULL,
	[PurchaseQuantity] [decimal](18, 2) NULL,
	[PurchaseAtInvoicePrice] [decimal](18, 2) NULL,
	[LeakageQuantity] [decimal](18, 2) NULL,
	[LeakageAtInvoicePrice] [decimal](18, 2) NULL,
 CONSTRAINT [CPK_FDSComplianceAll] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psClaimsFact_RangeLeft]([DateKey])
) ON [psClaimsFact_RangeLeft]([DateKey])
GO
ALTER TABLE [dbo].[FDSComplianceAll] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
