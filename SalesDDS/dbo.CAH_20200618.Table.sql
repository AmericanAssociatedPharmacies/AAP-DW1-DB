USE [SalesDDS]
GO
/****** Object:  Table [dbo].[CAH_20200618]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAH_20200618](
	[ID] [int] NOT NULL,
	[DateKey] [int] NOT NULL,
	[Type] [varchar](15) NULL,
	[Brand] [varchar](31) NULL,
 CONSTRAINT [CPK_20200618] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
