USE [SalesDDS]
GO
/****** Object:  Table [dbo].[Sales_Aggregate]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Sales_Aggregate](
	[DateKey] [int] NOT NULL,
	[PharmacyKey] [int] NOT NULL,
	[AccountAge] [int] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Sales_Aggregate] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
