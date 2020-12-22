USE [NCPDPODS]
GO
/****** Object:  Table [dbo].[Rural]    Script Date: 12/22/2020 7:25:47 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rural](
	[ST] [nvarchar](255) NULL,
	[CountyName] [nvarchar](255) NULL,
	[CT] [nvarchar](255) NULL,
	[RUCA 2010] [float] NULL,
	[CTY FIPS] [nvarchar](255) NULL,
	[Memo] [nvarchar](255) NULL
) ON [PRIMARY]
GO
