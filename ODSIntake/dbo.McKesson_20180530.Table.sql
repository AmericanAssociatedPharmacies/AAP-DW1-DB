USE [ODSIntake]
GO
/****** Object:  Table [dbo].[McKesson_20180530]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[McKesson_20180530](
	[ItemNumber] [nvarchar](255) NULL,
	[NDC_Original] [nvarchar](255) NULL,
	[ProperContractPrice] [float] NULL,
	[NDC] [float] NULL
) ON [PRIMARY]
GO
