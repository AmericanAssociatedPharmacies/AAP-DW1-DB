USE [ODSIntake]
GO
/****** Object:  Table [Staging].[APIMonthlyRebate]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[APIMonthlyRebate](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[FileRowID] [int] NOT NULL,
	[Marker] [varchar](500) NULL,
	[PMID] [varchar](500) NULL,
	[APIAcctNumber] [varchar](500) NULL,
	[PharmacyName] [varchar](500) NULL,
	[BusinessClass] [varchar](500) NULL,
	[RebateAdministrator] [varchar](500) NULL,
	[APIGenericSales] [varchar](500) NULL,
	[APIBrandSales] [varchar](500) NULL,
	[APIOTCSales] [varchar](500) NULL,
	[APITotalWhseSales] [varchar](500) NULL,
	[APIWhseGrossRebate] [varchar](500) NULL,
	[AdjustforPromotions] [varchar](500) NULL,
	[AdjustforReturns] [varchar](500) NULL,
	[AdjustforRebateErrors] [varchar](500) NULL,
	[GenericAdminFee] [varchar](500) NULL,
	[APIWHSEREBATEforPayout] [varchar](500) NULL,
	[LessNegativeRebates] [varchar](500) NULL,
	[UnpaidFinanceCharges] [varchar](500) NULL,
	[CheckFee] [varchar](500) NULL,
	[HeldRebate] [varchar](500) NULL,
	[RebatetoPayAcctAdmin] [varchar](500) NULL,
	[LessGroupAdmin] [varchar](500) NULL,
	[PreviousMonthHeldRebate] [varchar](500) NULL,
	[NetRebatetoStore] [varchar](500) NULL,
	[PayAccount] [varchar](500) NULL,
	[PrintRebateLetter] [varchar](500) NULL,
	[BrandCreditsDisbursed] [varchar](500) NULL,
	[AcceleratedPayDiscount] [varchar](500) NULL,
	[AvgRebatePercentage] [varchar](500) NULL,
	[APPaymentMode] [varchar](500) NULL,
	[PostAveRebatePercent] [varchar](500) NULL,
	[TrueTenSales] [varchar](500) NULL,
	[TrueTenRebate] [varchar](500) NULL,
	[AreteRebateFee] [varchar](500) NULL,
	[FileProcessed] [varchar](1000) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[APIMonthlyRebate] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
