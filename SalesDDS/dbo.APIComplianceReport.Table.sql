USE [SalesDDS]
GO
/****** Object:  Table [dbo].[APIComplianceReport]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIComplianceReport](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [int] NOT NULL,
	[GPI] [varchar](14) NULL,
	[Description] [varchar](500) NULL,
	[AWPPerDose] [numeric](13, 5) NULL,
	[Doses] [numeric](38, 3) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[IsGeneric] [bit] NULL,
	[NDC] [varchar](13) NULL,
	[InvoiceDate] [date] NULL,
	[InvoicePerDose] [money] NOT NULL,
	[APIUnitAmount] [money] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APIComplianceReport] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[APIComplianceReport] ADD  DEFAULT ((0.00)) FOR [InvoicePerDose]
GO
ALTER TABLE [dbo].[APIComplianceReport] ADD  DEFAULT ((0.00)) FOR [APIUnitAmount]
GO
