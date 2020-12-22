USE [ODSIntake]
GO
/****** Object:  Table [dbo].[McKesson_20180406_New]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[McKesson_20180406_New](
	[Item #] [varchar](500) NULL,
	[NDCUPC] [varchar](500) NULL,
	[GenericDescription] [varchar](500) NULL,
	[Current Price] [varchar](500) NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[CurrentPrice_New] [money] NULL
) ON [PRIMARY]
GO
