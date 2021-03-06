USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[UDVendors]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UDVendors](
	[VendorID] [int] NULL,
	[OldVendorID] [int] NULL,
	[OldVolumeName] [varchar](50) NULL,
	[Reports] [varchar](1) NULL,
	[Active] [int] NULL,
	[EffectDate] [datetime] NULL,
	[Factor] [numeric](2, 2) NULL,
	[TotalPercentRebate] [numeric](2, 2) NULL,
	[Active2007] [int] NULL,
	[VendorPair] [int] NULL,
	[PPVendorID] [int] NULL,
	[OldRebateName] [varchar](50) NULL,
	[RebateReportDisplayName] [varchar](50) NULL
) ON [PRIMARY]
GO
