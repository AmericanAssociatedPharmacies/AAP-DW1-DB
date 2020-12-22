USE [SalesDDS]
GO
/****** Object:  Table [dbo].[CAH_20200616]    Script Date: 12/22/2020 7:55:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAH_20200616](
	[ID] [int] NOT NULL,
	[CAHType] [varchar](1) NULL,
	[Brand] [varchar](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
