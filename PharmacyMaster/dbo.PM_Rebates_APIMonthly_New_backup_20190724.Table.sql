USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Rebates_APIMonthly_New_backup_20190724]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Rebates_APIMonthly_New_backup_20190724](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [datetime] NULL,
	[PMID] [nvarchar](255) NULL,
	[APIAccountNo] [nvarchar](255) NULL,
	[Pharmacy Name] [nvarchar](255) NULL,
	[Business Class] [nvarchar](255) NULL,
	[Rebate Administrator] [nvarchar](255) NULL,
	[API Generic Sales] [money] NULL,
	[API Brand Sales] [money] NULL,
	[API OTC Sales] [money] NULL,
	[API Total Whse Sales] [money] NULL,
	[API Whse Gross Rebate] [money] NULL,
	[Adjust for Promotions] [money] NULL,
	[Adjust for Returns] [money] NULL,
	[Adjust for Rebate Errors] [money] NULL,
	[Generic Admin Fee] [money] NULL,
	[API WHSE REBATE for Payout] [money] NULL,
	[Less Negative Rebates] [money] NULL,
	[Unpaid Finance Charges] [money] NULL,
	[Check Fee] [money] NULL,
	[Held Rebate] [money] NULL,
	[Rebate to Pay Acct/Admin] [money] NULL,
	[Less Group Admin] [money] NULL,
	[Net Rebate to Store] [money] NULL,
	[Pay Account] [bit] NULL,
	[Print Rebate Letter] [bit] NULL,
	[Brand Credits Disbursed] [money] NULL,
	[Accelerated Pay Discount] [money] NULL,
	[Avg Rebate Percentage] [float] NULL,
	[A/P Payment Mode] [nvarchar](255) NULL,
	[Previous Month Held Rebate] [money] NULL,
	[PostAveRebatePerc] [nvarchar](255) NULL,
	[True10Sales] [money] NULL,
	[True10Rebate] [money] NULL,
	[AreteRebateFee] [money] NULL,
	[APIInstantRebate] [money] NULL,
	[CalcAPIRebatePercentage] [decimal](18, 4) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
	[RowversionID] [varbinary](8) NOT NULL,
	[APIGenericSalesTier1] [money] NOT NULL,
	[APIGenericSalesTier2] [money] NOT NULL,
	[APIGenericRebateTier1] [money] NOT NULL,
	[APIGenericRebateTier2] [money] NOT NULL
) ON [PRIMARY]
GO
