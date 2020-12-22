USE [ODSIntake]
GO
/****** Object:  Table [dbo].[MM_20180920]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MM_20180920](
	[CIN] [float] NULL,
	[Cardkey] [float] NULL,
	[Description] [nvarchar](255) NULL,
	[Old Invoice] [money] NULL,
	[New Invoice] [money] NULL,
	[Decrease] [float] NULL
) ON [PRIMARY]
GO
