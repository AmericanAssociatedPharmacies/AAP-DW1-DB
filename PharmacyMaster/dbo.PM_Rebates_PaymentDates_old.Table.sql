USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Rebates_PaymentDates_old]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Rebates_PaymentDates_old](
	[RebateMonth] [datetime] NOT NULL,
	[RebateType] [varchar](50) NOT NULL,
	[PaymentDate] [datetime] NULL
) ON [PRIMARY]
GO
