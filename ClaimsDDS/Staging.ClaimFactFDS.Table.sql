USE [ClaimsDDS]
GO
/****** Object:  Table [Staging].[ClaimFactFDS]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[ClaimFactFDS](
	[DateofServiceKey] [int] NOT NULL,
	[PharmacyKey] [int] NOT NULL,
	[DrugKey] [int] NOT NULL,
	[EventKey] [int] NOT NULL,
	[PrescribedRefills] [int] NULL,
	[RefillNumber] [int] NULL,
	[TotalQuantity] [decimal](15, 3) NULL,
	[ContractCost] [money] NULL,
	[AWP] [money] NULL,
	[UandC] [money] NULL,
	[CopayAmountSubmitted] [money] NULL,
	[IngredientCostSubmitted] [money] NULL,
	[DispensingFeeSubmitted] [money] NULL,
	[IncentiveFeeSubmitted] [money] NULL,
	[SalesTaxSubmitted] [money] NULL,
	[CopayAmountPaid] [money] NULL,
	[IngredientCostPaid] [money] NULL,
	[DispensingFeePaid] [money] NULL,
	[SalesTaxPaid] [money] NULL,
	[IncentiveFeePaid] [money] NULL,
	[ClaimAmountPaid] [money] NULL,
	[QuantityDispensed] [decimal](10, 3) NULL,
	[DaysSupply] [int] NULL,
	[AdjustedContractCost] [money] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[TransactionCount] [tinyint] NOT NULL,
	[OtherAmountPaid] [money] NOT NULL,
	[eVoucherAmountPaid] [money] NOT NULL,
	[DispensedRevenue] [money] NOT NULL,
	[BrandCost] [money] NOT NULL,
	[GenericCost] [money] NOT NULL,
	[SPXCost] [money] NOT NULL,
	[MonthYearKey] [int] NOT NULL,
	[GPIKey] [int] NOT NULL,
 CONSTRAINT [CPK_Staging_ClaimFactFDS] PRIMARY KEY CLUSTERED 
(
	[DateofServiceKey] ASC,
	[PharmacyKey] ASC,
	[DrugKey] ASC,
	[EventKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [psClaimsFactFDS]([DateofServiceKey])
) ON [psClaimsFactFDS]([DateofServiceKey])
GO
ALTER TABLE [Staging].[ClaimFactFDS] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
ALTER TABLE [Staging].[ClaimFactFDS] ADD  DEFAULT ((1)) FOR [TransactionCount]
GO
ALTER TABLE [Staging].[ClaimFactFDS] ADD  DEFAULT ((0.00)) FOR [OtherAmountPaid]
GO
ALTER TABLE [Staging].[ClaimFactFDS] ADD  DEFAULT ((0.00)) FOR [eVoucherAmountPaid]
GO
ALTER TABLE [Staging].[ClaimFactFDS] ADD  DEFAULT ((0.00)) FOR [DispensedRevenue]
GO
ALTER TABLE [Staging].[ClaimFactFDS] ADD  DEFAULT ((0.00)) FOR [BrandCost]
GO
ALTER TABLE [Staging].[ClaimFactFDS] ADD  DEFAULT ((0.00)) FOR [GenericCost]
GO
ALTER TABLE [Staging].[ClaimFactFDS] ADD  DEFAULT ((0.00)) FOR [SPXCost]
GO
