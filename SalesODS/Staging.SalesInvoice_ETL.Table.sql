USE [SalesODS]
GO
/****** Object:  Table [Staging].[SalesInvoice_ETL]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[SalesInvoice_ETL](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[InvDate] [datetime] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [Staging].[SalesInvoice_ETL] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
