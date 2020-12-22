USE [SSRS]
GO
/****** Object:  Table [dbo].[rpt_Compliance_FDS]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rpt_Compliance_FDS](
	[PMID] [int] NULL,
	[Dispense Qty] [decimal](18, 2) NULL,
	[Dispense @ AWP] [decimal](18, 2) NULL
) ON [PRIMARY]
GO
