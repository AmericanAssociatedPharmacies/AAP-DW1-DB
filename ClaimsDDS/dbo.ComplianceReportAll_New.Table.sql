USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[ComplianceReportAll_New]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ComplianceReportAll_New](
	[Date] [date] NOT NULL,
	[PMID] [int] NOT NULL,
	[QuantityDispensed] [decimal](18, 2) NULL,
	[GenericQuantityDispensed] [decimal](18, 2) NULL,
	[BrandQuantityDispensed] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
