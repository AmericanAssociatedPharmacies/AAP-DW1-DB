USE [SSRS]
GO
/****** Object:  Table [dbo].[rpt_Compliance_API]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt_Compliance_API](
	[PMID] [int] NULL,
	[Purchase Qty] [decimal](18, 2) NULL,
	[Purchases @ AWP] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
