USE [ClaimsDDS]
GO
/****** Object:  Table [Staging].[ClaimFactRX30_PreLoad]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ClaimFactRX30_PreLoad](
	[DateOfServiceKey] [int] NOT NULL,
	[PharmacyKey] [int] NOT NULL,
	[EventKey] [int] NOT NULL,
	[DrugKey] [int] NOT NULL,
	[DispensingFeeSubmitted] [money] NOT NULL,
	[IngredientCostSubmitted] [money] NOT NULL,
	[DispensingFeePaid] [money] NOT NULL,
	[IngredientCostPaid] [money] NOT NULL,
	[TotalAmountPaid] [money] NOT NULL,
	[AmountofCopay] [money] NOT NULL,
	[UsualandCustomaryCharge] [money] NOT NULL,
	[TotalPrice] [money] NOT NULL,
	[PatientPayAmount] [money] NOT NULL,
	[GrossAmountDue] [money] NOT NULL,
	[OtherAmount] [money] NOT NULL,
	[FlatSalesTaxAmountPaid] [money] NOT NULL,
	[PercentageSalesTaxAmountPaid] [money] NOT NULL,
	[PercentageSalesTaxRate] [numeric](10, 2) NOT NULL,
	[PercentageSalesTaxBasisPaid] [money] NOT NULL,
	[IncentiveAmountPaid] [money] NOT NULL,
	[AWPUnitPrice] [numeric](13, 5) NULL,
	[CardinalPharmacyCost] [money] NOT NULL,
	[APIPharmacyCost] [money] NOT NULL,
	[UnitOfSale] [money] NOT NULL,
	[TransactionCount] [tinyint] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RxDiscount] [money] NULL,
	[QuantityDispensed] [decimal](15, 3) NOT NULL,
 CONSTRAINT [CPK_Staging_ClaimFact_PreLoad] PRIMARY KEY CLUSTERED 
(
	[DateOfServiceKey] ASC,
	[PharmacyKey] ASC,
	[EventKey] ASC,
	[DrugKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = ON, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psClaimFact]([DateOfServiceKey])
) ON [psClaimFact]([DateOfServiceKey])
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [DispensingFeeSubmitted]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [IngredientCostSubmitted]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [DispensingFeePaid]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [IngredientCostPaid]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [TotalAmountPaid]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [AmountofCopay]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [UsualandCustomaryCharge]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [TotalPrice]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [PatientPayAmount]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [GrossAmountDue]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [OtherAmount]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [FlatSalesTaxAmountPaid]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [PercentageSalesTaxAmountPaid]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [PercentageSalesTaxRate]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [PercentageSalesTaxBasisPaid]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [IncentiveAmountPaid]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [AWPUnitPrice]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [CardinalPharmacyCost]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [APIPharmacyCost]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0.00)) FOR [UnitOfSale]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((1)) FOR [TransactionCount]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[ClaimFactRX30_PreLoad] ADD  DEFAULT ((0)) FOR [QuantityDispensed]
GO
