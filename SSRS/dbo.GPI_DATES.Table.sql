USE [SSRS]
GO
/****** Object:  Table [dbo].[GPI_DATES]    Script Date: 12/22/2020 8:05:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GPI_DATES](
	[ROW_ID] [int] IDENTITY(1,1) NOT NULL,
	[START_DATE] [datetime] NULL,
	[END_DATE] [datetime] NULL
) ON [PRIMARY]
GO
