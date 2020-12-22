USE [ODSIntake]
GO
/****** Object:  Table [dbo].[McKesson_20180529_Clean]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[McKesson_20180529_Clean](
	[ItemNumber] [float] NULL,
	[NDC] [nvarchar](255) NULL,
	[ProperContractPrice] [float] NULL
) ON [PRIMARY]
GO
