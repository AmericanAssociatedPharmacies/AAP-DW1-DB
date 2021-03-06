USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[rebate_PPartnerPaymentsByVendor4Q2010]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rebate_PPartnerPaymentsByVendor4Q2010](
	[vendor_id] [float] NULL,
	[vendorpair] [float] NULL,
	[vendor] [nvarchar](255) NULL,
	[rebatereportdisplayname] [nvarchar](255) NULL,
	[Volume] [float] NULL,
	[Rebate] [float] NULL,
	[payment] [float] NULL,
	[NumStoresPaid] [float] NULL
) ON [PRIMARY]
GO
