USE [Pricing]
GO
/****** Object:  Table [dbo].[PriceFact]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceFact](
	[DateKey] [int] NOT NULL,
	[DrugKey] [int] NOT NULL,
	[CompetitorDrugKey] [int] NOT NULL,
	[APINetPrice] [money] NULL,
	[APIManufacturerInvoicePrice] [money] NULL,
	[APIHoldBackAmount] [money] NULL,
	[APICustomerInvoicePrice] [money] NULL,
	[APICustomerNetPrice] [money] NULL,
	[APIRebate] [money] NULL,
	[APIRebatePercentage] [float] NULL,
	[APIPricePerUnit] [money] NULL,
	[CardinalInvoicePrice] [money] NULL,
	[CardinalPricePerUnit] [money] NULL,
	[WACPackagePrice] [money] NULL,
	[WACPerDose] [money] NULL,
	[AWPPackagePrice] [money] NULL,
	[AWPPerDose] [money] NULL,
	[ABCInvoicePrice] [money] NULL,
	[ABC_AWP] [money] NULL,
	[ABC-CPA] [money] NULL,
	[McKesson-IPC] [money] NULL,
	[McKesson-APCI] [money] NULL,
	[Valley] [money] NULL,
	[RiverCity] [money] NULL,
	[Healthsource] [money] NULL,
	[Harvard] [money] NULL,
	[Par-Med] [money] NULL,
	[Bloodworth] [money] NULL,
	[NC Mutual] [money] NULL,
	[SmithDrug] [money] NULL,
	[H.D. Smith] [money] NULL,
	[Kinray] [money] NULL,
	[Morris-Dickson] [money] NULL,
	[Value Drug] [money] NULL,
	[Anda] [money] NULL,
	[Ezri Rx] [money] NULL,
	[Quest] [money] NULL,
	[H&H] [money] NULL,
	[Masters] [money] NULL,
	[Auburn] [money] NULL,
	[Belco] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[NADACPrice] [money] NULL,
	[NADACPricePerUnit] [money] NULL,
	[AWP] [money] NULL,
	[DirectPrice] [money] NULL,
	[WAC] [money] NULL,
	[CMSFUL] [money] NULL,
	[AAWP] [money] NULL,
	[GEAP] [money] NULL,
	[McKesson] [money] NULL,
 CONSTRAINT [CPK_PriceFact] PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC,
	[DrugKey] ASC,
	[CompetitorDrugKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psDate]([DateKey])
) ON [psDate]([DateKey])
GO
ALTER TABLE [dbo].[PriceFact] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [dbo].[PriceFact]  WITH NOCHECK ADD  CONSTRAINT [FK_PriceFact_CompetitorDrugKey] FOREIGN KEY([CompetitorDrugKey])
REFERENCES [dbo].[CompetitorDrugDim] ([CompetitorDrugKey])
GO
ALTER TABLE [dbo].[PriceFact] CHECK CONSTRAINT [FK_PriceFact_CompetitorDrugKey]
GO
ALTER TABLE [dbo].[PriceFact]  WITH NOCHECK ADD  CONSTRAINT [FK_PriceFact_DateKey] FOREIGN KEY([DateKey])
REFERENCES [dbo].[DateDim] ([DateKey])
GO
ALTER TABLE [dbo].[PriceFact] CHECK CONSTRAINT [FK_PriceFact_DateKey]
GO
ALTER TABLE [dbo].[PriceFact]  WITH NOCHECK ADD  CONSTRAINT [FK_PriceFact_DrugKey] FOREIGN KEY([DrugKey])
REFERENCES [dbo].[DrugDim] ([DrugKey])
GO
ALTER TABLE [dbo].[PriceFact] CHECK CONSTRAINT [FK_PriceFact_DrugKey]
GO
