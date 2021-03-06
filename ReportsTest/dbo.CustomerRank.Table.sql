USE [ReportsTest]
GO
/****** Object:  Table [dbo].[CustomerRank]    Script Date: 12/22/2020 7:51:44 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerRank](
	[PMID] [int] NULL,
	[CustomerRank] [float] NULL,
	[FirstSalesDate] [date] NULL,
	[Age] [int] NULL,
	[APIOrFq] [int] NULL,
	[CAHOrFq] [int] NULL,
	[ComOrFq] [int] NULL,
	[BizDay] [int] NULL,
	[GenSales] [float] NULL,
	[GenSalesPerBizDay] [float] NULL
) ON [PRIMARY]
GO
