USE [SalesDDS]
GO
/****** Object:  Table [dbo].[ETL_SalesDetail_InvDate]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_SalesDetail_InvDate](
	[InvDate] [datetime2](3) NULL,
	[IsComplete] [bit] NOT NULL
) ON [PRIMARY]
GO
