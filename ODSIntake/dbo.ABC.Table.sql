USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ABC]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ABC](
	[ABCItemNum] [varchar](max) NULL,
	[NDC] [varchar](12) NULL,
	[ABC_AWP] [money] NULL,
	[LPR_Price] [money] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
