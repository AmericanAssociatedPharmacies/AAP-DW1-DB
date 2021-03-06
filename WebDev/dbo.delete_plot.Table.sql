USE [WebDev]
GO
/****** Object:  Table [dbo].[delete_plot]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[delete_plot](
	[PMID] [int] NOT NULL,
	[Total_GB] [decimal](38, 2) NULL,
	[Total_C] [decimal](38, 2) NULL,
	[C2] [decimal](38, 2) NULL,
	[description] [varchar](135) NULL,
	[CTotalPct] [decimal](38, 6) NULL,
	[C2Pct] [decimal](38, 6) NULL,
	[isMCorNPP] [int] NULL,
	[isAPIOnly] [int] NOT NULL
) ON [PRIMARY]
GO
