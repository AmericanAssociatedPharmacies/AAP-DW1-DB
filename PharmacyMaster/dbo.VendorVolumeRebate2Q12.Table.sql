USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[VendorVolumeRebate2Q12]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorVolumeRebate2Q12](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[VendorID] [int] NULL,
	[PMID] [int] NULL,
	[UDNo] [varchar](50) NULL,
	[StoreName] [nvarchar](100) NULL,
	[VolumeAmt] [numeric](18, 2) NULL,
	[RebateAmt] [numeric](18, 2) NULL,
	[AccruedStartdt] [smalldatetime] NULL,
	[AccruedEnddt] [smalldatetime] NULL,
	[FileID] [int] NULL,
	[TransactionID] [int] NULL,
	[Eligibility] [int] NULL,
	[PayTo] [nchar](10) NULL,
	[Affiliate] [nvarchar](50) NULL,
	[StorePaidDt] [smalldatetime] NULL
) ON [PRIMARY]
GO
