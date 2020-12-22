USE [ODSIntake]
GO
/****** Object:  Table [dbo].[McKesson20180425]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[McKesson20180425](
	[Item #] [varchar](500) NULL,
	[NDC] [varchar](500) NULL,
	[ItemDescription] [varchar](500) NULL,
	[GenericDescription] [varchar](500) NULL,
	[CurrentPrice] [varchar](500) NULL,
	[DateKey] [int] NULL
) ON [PRIMARY]
GO
