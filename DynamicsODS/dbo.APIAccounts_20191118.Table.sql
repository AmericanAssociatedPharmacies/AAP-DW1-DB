USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[APIAccounts_20191118]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIAccounts_20191118](
	[PMID] [int] NOT NULL,
	[APIAccountNo] [varchar](15) NOT NULL,
	[APIEffectiveDate] [date] NULL,
	[APIQuitDate] [date] NULL
) ON [PRIMARY]
GO
