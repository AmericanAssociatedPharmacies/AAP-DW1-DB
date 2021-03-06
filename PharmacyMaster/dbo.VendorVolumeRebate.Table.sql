USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[VendorVolumeRebate]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VendorVolumeRebate](
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
	[StorePaidDt] [smalldatetime] NULL,
 CONSTRAINT [PK_VendorVolumeRebate] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VendorVolumeRebate] ADD  CONSTRAINT [DF_VendorVolumeRebate_VolumeAmt]  DEFAULT ((0.00)) FOR [VolumeAmt]
GO
ALTER TABLE [dbo].[VendorVolumeRebate] ADD  CONSTRAINT [DF_VendorVolumeRebate_RebateAmt]  DEFAULT ((0.00)) FOR [RebateAmt]
GO
ALTER TABLE [dbo].[VendorVolumeRebate] ADD  CONSTRAINT [DF_VendorVolumeRebate_Eligibility]  DEFAULT ((1)) FOR [Eligibility]
GO
