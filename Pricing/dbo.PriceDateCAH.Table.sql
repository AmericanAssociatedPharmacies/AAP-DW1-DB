USE [Pricing]
GO
/****** Object:  Table [dbo].[PriceDateCAH]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PriceDateCAH](
	[DateDimKey] [int] NOT NULL,
	[PriceDateKey] [int] NULL,
	[PriceDateKeyToLoad] [int] NULL
) ON [PRIMARY]
GO
