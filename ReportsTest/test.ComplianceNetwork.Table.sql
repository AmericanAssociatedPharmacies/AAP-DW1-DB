USE [ReportsTest]
GO
/****** Object:  Table [test].[ComplianceNetwork]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [test].[ComplianceNetwork](
	[PMID] [int] NULL,
	[TotalSales] [float] NULL,
	[TotalCost] [float] NULL,
	[TotalUnits] [int] NULL,
	[TotalDoses] [int] NULL,
	[TotalScripts] [int] NULL,
	[TotalDispensed] [int] NULL,
	[TotalCompliance] [float] NULL,
	[TotalDollarCompliance] [float] NULL
) ON [PRIMARY]
GO
