USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_Rebates_PPDetails]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_Rebates_PPDetails](
	[Period] [varchar](6) NOT NULL,
	[StorePaidDT] [smalldatetime] NULL,
	[PMID] [int] NULL,
	[VendorName] [varchar](150) NULL,
	[AccountName] [varchar](65) NULL,
	[Affiliate] [nvarchar](50) NULL,
	[Eligibility] [int] NULL,
	[Volume] [numeric](38, 2) NULL,
	[Rebate Amount] [numeric](38, 2) NULL,
	[Rebate Paid] [numeric](8, 2) NULL,
	[AAPPaymentMode] [varchar](255) NULL
) ON [PRIMARY]
GO
