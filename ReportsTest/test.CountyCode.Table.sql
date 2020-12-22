USE [ReportsTest]
GO
/****** Object:  Table [test].[CountyCode]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [test].[CountyCode](
	[StateAbbreviation] [varchar](2) NULL,
	[StateFIPSCode] [varchar](2) NULL,
	[CountyFIPSCode] [varchar](4) NULL,
	[FIPSEntityCode] [varchar](6) NULL,
	[ANSICode] [varchar](10) NULL,
	[GUName] [varchar](20) NULL,
	[EntityDescription] [varchar](6) NULL
) ON [PRIMARY]
GO
