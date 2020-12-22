USE [ODSIntake]
GO
/****** Object:  Table [dbo].[McKesson_Clean]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[McKesson_Clean](
	[DateKey] [int] NULL,
	[ItemNumber] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[ProperContractPrice] [varchar](500) NULL
) ON [PRIMARY]
GO
