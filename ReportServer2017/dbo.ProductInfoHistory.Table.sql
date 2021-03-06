USE [ReportServer2017]
GO
/****** Object:  Table [dbo].[ProductInfoHistory]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductInfoHistory](
	[DateTime] [datetime] NULL,
	[DbSchemaHash] [varchar](128) NOT NULL,
	[Sku] [varchar](25) NOT NULL,
	[BuildNumber] [varchar](25) NOT NULL,
 CONSTRAINT [IX_ProductInfoHistory_DateTime] UNIQUE NONCLUSTERED 
(
	[DateTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ProductInfoHistory] ADD  DEFAULT (getdate()) FOR [DateTime]
GO
