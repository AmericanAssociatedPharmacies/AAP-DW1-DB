USE [ODSIntake]
GO
/****** Object:  Table [Staging].[CAHDirectPay]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[CAHDirectPay](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[PMID] [varchar](500) NULL,
	[PrimaryCANumber] [varchar](500) NULL,
	[AccountName] [varchar](500) NULL,
	[SumOfCCAAAPGenerics] [varchar](500) NULL,
	[CalculatedGenericRebate] [varchar](500) NULL,
	[EffectiveRebatePercent] [varchar](500) NULL,
	[HRTA] [varchar](500) NULL,
	[GroupRebatePayments] [varchar](500) NULL,
	[COGRebate] [varchar](500) NULL,
	[LeaderRebate] [varchar](500) NULL,
	[MSIRebate] [varchar](500) NULL,
	[GenericRebateAdjustment] [varchar](500) NULL,
	[PriceProtectionRebate] [varchar](500) NULL,
	[PriceProtectionAdjustment] [varchar](500) NULL,
	[ST] [varchar](500) NULL,
	[SortCode] [varchar](500) NULL,
	[PaymentMethod] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[CAHDirectPay] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
