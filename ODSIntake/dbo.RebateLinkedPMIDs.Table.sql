USE [ODSIntake]
GO
/****** Object:  Table [dbo].[RebateLinkedPMIDs]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RebateLinkedPMIDs](
	[PMID] [int] NOT NULL,
	[LinkedPMIDs] [varchar](255) NULL
) ON [PRIMARY]
GO
