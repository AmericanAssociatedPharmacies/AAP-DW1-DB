USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[PMIDMapping_20191119]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMIDMapping_20191119](
	[RN] [int] NULL,
	[PMID] [int] NOT NULL,
	[APIAccountNo] [varchar](15) NOT NULL,
	[APIEffectiveDate] [date] NULL,
	[APIQuitDate] [date] NULL
) ON [PRIMARY]
GO
