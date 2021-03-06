USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[20200826_2]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[20200826_2](
	[MonthYearKey] [int] NOT NULL,
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
	[TransactionCount] [tinyint] NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[IsPaidClaim] [bit] NOT NULL,
	[OtherAmountPaid] [money] NOT NULL,
	[eVoucherAmountPaid] [money] NOT NULL,
	[DispensedRevenue] [money] NOT NULL,
	[BrandCost] [money] NOT NULL,
	[GenericCost] [money] NOT NULL,
	[SPXCost] [money] NOT NULL,
	[GPIKey] [int] NOT NULL
) ON [ps_RangeLeft_CCYYMM]([MonthYearKey])
GO
