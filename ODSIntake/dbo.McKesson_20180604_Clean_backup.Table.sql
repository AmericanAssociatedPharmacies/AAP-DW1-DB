USE [ODSIntake]
GO
/****** Object:  Table [dbo].[McKesson_20180604_Clean_backup]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[McKesson_20180604_Clean_backup](
	[DateKey] [int] NULL,
	[McKessonItemNumber] [varchar](50) NULL,
	[NDC] [varchar](11) NULL,
	[Price] [money] NULL
) ON [PRIMARY]
GO
