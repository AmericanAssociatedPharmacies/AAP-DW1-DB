USE [Pricing]
GO
/****** Object:  Table [dbo].[APIVendors]    Script Date: 12/22/2020 7:32:24 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIVendors](
	[APIVendorNumber] [nvarchar](255) NULL,
	[NANAME] [nvarchar](255) NULL,
	[NAADR1] [nvarchar](255) NULL,
	[NAADR2] [nvarchar](255) NULL,
	[NAADR3] [nvarchar](255) NULL,
	[NAADR4] [nvarchar](255) NULL,
	[NAPOCD] [nvarchar](255) NULL,
	[LCUSLICL] [nvarchar](255) NULL,
	[LCUSLIID] [nvarchar](255) NULL
) ON [PRIMARY]
GO
