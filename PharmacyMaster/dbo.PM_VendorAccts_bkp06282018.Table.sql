USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PM_VendorAccts_bkp06282018]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_VendorAccts_bkp06282018](
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
	[RowVersion] [int] NOT NULL,
 CONSTRAINT [PK_PM_VendorAccts] PRIMARY KEY CLUSTERED 
(
	[PMID] ASC,
	[VendorID] ASC,
	[VendAcctNum] ASC,
	[Source] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PM_VendorAccts_bkp06282018] ADD  DEFAULT (getdate()) FOR [Created]
GO
ALTER TABLE [dbo].[PM_VendorAccts_bkp06282018] ADD  DEFAULT (getdate()) FOR [Modified]
GO
ALTER TABLE [dbo].[PM_VendorAccts_bkp06282018] ADD  DEFAULT ((1)) FOR [RowVersion]
GO
