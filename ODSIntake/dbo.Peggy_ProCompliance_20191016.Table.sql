USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Peggy_ProCompliance_20191016]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Peggy_ProCompliance_20191016](
	[PharmacyNameDiff] [float] NULL,
	[Address1Diff] [float] NULL,
	[Address2Diff] [float] NULL,
	[CityDiff] [float] NULL,
	[StateDiff] [float] NULL,
	[ZipDiff] [float] NULL,
	[API#] [float] NULL,
	[Pharmacy] [nvarchar](255) NULL,
	[Address1] [nvarchar](255) NULL,
	[Address2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [float] NULL,
	[CustomerNumber] [float] NULL,
	[DEA] [nvarchar](255) NULL,
	[Business Type] [nvarchar](255) NULL,
	[Name] [nvarchar](255) NULL,
	[Company Info] [nvarchar](255) NULL,
	[Address 1] [nvarchar](255) NULL,
	[Address 2] [nvarchar](255) NULL,
	[City2] [nvarchar](255) NULL,
	[State3] [nvarchar](255) NULL,
	[Zip4] [float] NULL,
	[Drug Schedules] [nvarchar](255) NULL,
	[Expiration Date] [datetime] NULL
) ON [PRIMARY]
GO
