USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_VendorAccts]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_VendorAccts](
	[PMID] [int] NOT NULL,
	[VendorID] [int] NOT NULL,
	[isPrimary] [int] NOT NULL,
	[VendAcctNum] [varchar](32) NOT NULL,
	[PVA] [varchar](30) NULL,
	[PaymentTerms] [varchar](50) NULL,
	[Source] [varchar](3) NOT NULL,
	[PVAEffectiveDate] [datetime] NULL,
	[Created] [datetime] NOT NULL,
	[Modified] [datetime] NOT NULL,
	[RowVersion] [int] NOT NULL
) ON [PRIMARY]
GO
