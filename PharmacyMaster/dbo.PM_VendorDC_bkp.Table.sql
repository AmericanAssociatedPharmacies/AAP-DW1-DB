USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_VendorDC_bkp]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_VendorDC_bkp](
	[PMID] [int] NULL,
	[VendorID] [int] NULL,
	[isPrimary] [int] NOT NULL,
	[VendAcctNum] [varchar](32) NULL,
	[DCNum] [int] NULL,
	[Source] [varchar](3) NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_VendorDC_bkp] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_VendorDC_bkp] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_VendorDC_bkp] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
