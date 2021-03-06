USE [API]
GO
/****** Object:  Table [dbo].[SalesFrequency]    Script Date: 12/22/2020 6:09:18 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalesFrequency](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[Orders] [int] NULL,
	[CustomerName] [varchar](75) NULL,
	[InvDate] [datetime] NULL,
	[APIAccountNo] [varchar](32) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_SalesFrequency] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SalesFrequency] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
