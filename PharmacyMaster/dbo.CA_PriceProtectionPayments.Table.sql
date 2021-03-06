USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[CA_PriceProtectionPayments]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CA_PriceProtectionPayments](
	[Date] [varchar](10) NULL,
	[CustomerNumber] [varchar](50) NULL,
	[CustomerName] [varchar](255) NULL,
	[PriceProtectionDueToDate] [money] NULL,
	[State] [varchar](255) NULL,
	[SubAffiliation] [varchar](255) NULL,
	[DC] [float] NULL,
	[Protection] [money] NULL,
	[AdjForPriorNegBal] [money] NULL,
	[AmountDue] [money] NULL
) ON [PRIMARY]
GO
