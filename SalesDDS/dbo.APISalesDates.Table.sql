USE [SalesDDS]
GO
/****** Object:  Table [dbo].[APISalesDates]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APISalesDates](
	[WHAccountID] [varchar](32) NULL,
	[FirstSalesDate] [datetime2](3) NULL,
	[LastSalesDate] [datetime2](3) NULL
) ON [PRIMARY]
GO
