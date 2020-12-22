USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[VendorEligibilitySumm]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorEligibilitySumm](
	[PMID] [nvarchar](7) NULL,
	[volumeamt] [nvarchar](50) NULL,
	[rebateamt] [nvarchar](50) NULL,
	[paymentamt] [nvarchar](50) NULL,
	[eligible] [nvarchar](50) NULL,
	[PaytoPMID] [nvarchar](50) NULL
) ON [PRIMARY]
GO
