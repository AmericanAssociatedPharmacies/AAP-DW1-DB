USE [ODSIntake]
GO
/****** Object:  Table [dbo].[APIMonthlyRebate]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIMonthlyRebate](
	[Marker] [varchar](500) NULL,
	[PMID] [varchar](500) NULL,
	[API Acct#] [varchar](500) NULL,
	[Pharmacy Name] [varchar](500) NULL,
	[Business Class] [varchar](500) NULL,
	[Rebate Administrator] [varchar](500) NULL,
	[API Generic Sales] [varchar](500) NULL,
	[API Brand Sales] [varchar](500) NULL,
	[API OTC Sales] [varchar](500) NULL,
	[API Total Whse Sales] [varchar](500) NULL,
	[API Whse Gross Rebate] [varchar](500) NULL,
	[Adjust for Promotions] [varchar](500) NULL,
	[Adjust for Returns] [varchar](500) NULL,
	[Adjust for Rebate Errors] [varchar](500) NULL,
	[Generic Admin Fee] [varchar](500) NULL,
	[API WHSE REBATE for Payout] [varchar](500) NULL,
	[Less Negative Rebates] [varchar](500) NULL,
	[Unpaid Finance Charges] [varchar](500) NULL,
	[Check Fee] [varchar](500) NULL,
	[Held Rebate] [varchar](500) NULL,
	[Rebate to Pay Acct Admin] [varchar](500) NULL,
	[Less Group Admin] [varchar](500) NULL,
	[Previous Month Held Rebate] [varchar](500) NULL,
	[Net Rebate to Store] [varchar](500) NULL,
	[Pay Account] [varchar](500) NULL,
	[Print Rebate Letter] [varchar](500) NULL,
	[Brand Credits Disbursed] [varchar](500) NULL,
	[Accelerated Pay Discount] [varchar](500) NULL,
	[Avg Rebate Percentage] [varchar](500) NULL,
	[A P Payment Mode] [varchar](500) NULL,
	[Post Ave Rebate %] [varchar](500) NULL,
	[True 10 Sales] [varchar](500) NULL,
	[True 10 Rebate] [varchar](500) NULL,
	[Arete Rebate Fee] [varchar](500) NULL
) ON [PRIMARY]
GO
