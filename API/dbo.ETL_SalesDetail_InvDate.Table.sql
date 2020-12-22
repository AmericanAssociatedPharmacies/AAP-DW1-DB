USE [API]
GO
/****** Object:  Table [dbo].[ETL_SalesDetail_InvDate]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_SalesDetail_InvDate](
	[InvDate] [datetime2](3) NULL,
	[IsComplete] [bit] NOT NULL,
	[RowUpdatedDate] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ETL_SalesDetail_InvDate] ADD  DEFAULT ((0)) FOR [IsComplete]
GO
