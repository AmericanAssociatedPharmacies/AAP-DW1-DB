USE [ODSIntake]
GO
/****** Object:  Table [dbo].[McKesson_20180507]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[McKesson_20180507](
	[ItemNum] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[SellDescription] [varchar](500) NULL,
	[GenericDoseForm] [varchar](8000) NULL
) ON [PRIMARY]
GO
