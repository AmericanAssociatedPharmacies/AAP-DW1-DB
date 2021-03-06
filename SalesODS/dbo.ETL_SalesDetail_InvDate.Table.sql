USE [SalesODS]
GO
/****** Object:  Table [dbo].[ETL_SalesDetail_InvDate]    Script Date: 12/22/2020 7:58:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ETL_SalesDetail_InvDate](
	[InvDate] [datetime2](3) NULL,
	[IsComplete] [bit] NOT NULL,
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[RowUpdatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ETL_SalesDetail_InvDate] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
