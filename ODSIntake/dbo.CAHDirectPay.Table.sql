USE [ODSIntake]
GO
/****** Object:  Table [dbo].[CAHDirectPay]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAHDirectPay](
	[﻿PMID] [varchar](500) NULL,
	[Primary CA#] [varchar](500) NULL,
	[Account Name] [varchar](500) NULL,
	[SumOfCCA   AAP Generics 872, 25676, 25677] [varchar](500) NULL,
	[Calculated generic rebate] [varchar](500) NULL,
	[Effective Rebate%] [varchar](500) NULL,
	[HRTA] [varchar](500) NULL,
	[Group Rebate Pmts] [varchar](500) NULL,
	[COG Rebate] [varchar](500) NULL,
	[Leader Rebate] [varchar](500) NULL,
	[MSI Rebate] [varchar](500) NULL,
	[Generic Rebate Adjustment] [varchar](500) NULL,
	[Price Protection rebate] [varchar](500) NULL,
	[Price Protection Adjustment] [varchar](500) NULL,
	[ST] [varchar](500) NULL,
	[Sort Code] [varchar](500) NULL,
	[Payment method] [varchar](500) NULL
) ON [PRIMARY]
GO
