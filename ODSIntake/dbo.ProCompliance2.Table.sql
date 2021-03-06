USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ProCompliance2]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProCompliance2](
	[CustomerNumber] [varchar](8) NULL,
	[DEA] [nvarchar](255) NULL,
	[Business Type] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Company Info] [nvarchar](255) NULL,
	[Address 1] [nvarchar](255) NULL,
	[Address 2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [float] NULL,
	[Drug Schedules] [nvarchar](255) NULL,
	[Expiration Date] [datetime] NULL
) ON [PRIMARY]
GO
