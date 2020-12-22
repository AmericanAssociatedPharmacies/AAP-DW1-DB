USE [ODSIntake]
GO
/****** Object:  Table [Staging].[TableA]    Script Date: 12/22/2020 7:30:12 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[TableA](
	[C1] [int] NULL,
	[LastName] [varchar](25) NULL,
	[FirstName] [varchar](25) NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL
) ON [PRIMARY]
GO
