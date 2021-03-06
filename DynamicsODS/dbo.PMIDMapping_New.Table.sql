USE [DynamicsODS]
GO
/****** Object:  Table [dbo].[PMIDMapping_New]    Script Date: 12/22/2020 6:59:33 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PMIDMapping_New](
	[RN] [bigint] NULL,
	[APIAccountNo] [nvarchar](100) NULL,
	[PMID] [nvarchar](100) NULL,
	[APIEffectiveDate] [date] NULL,
	[APIQuitDate] [date] NULL
) ON [PRIMARY]
GO
