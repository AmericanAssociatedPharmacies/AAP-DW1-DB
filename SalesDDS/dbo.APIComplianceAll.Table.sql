USE [SalesDDS]
GO
/****** Object:  Table [dbo].[APIComplianceAll]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIComplianceAll](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[DateKey] [int] NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](25) NULL,
	[DrugDesc] [varchar](100) NULL,
	[PurchaseQty] [numeric](38, 3) NULL,
	[PurchaseAtInvoicePrice] [decimal](18, 2) NULL,
	[InvoicePerDose] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[PricePerUnit] [money] NOT NULL,
 CONSTRAINT [CPK_APIomplianceAll] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APIComplianceAll] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[APIComplianceAll] ADD  DEFAULT ((0.00)) FOR [PricePerUnit]
GO
