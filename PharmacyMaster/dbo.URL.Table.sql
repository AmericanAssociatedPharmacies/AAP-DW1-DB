USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[URL]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[URL](
	[DEA # ] [nvarchar](255) NULL,
	[PMID] [bigint] NULL,
	[Rebate Sales] [float] NULL,
	[Rebate] [float] NULL,
	[Storeid] [nvarchar](255) NULL,
	[Facility Address] [nvarchar](255) NULL,
	[Facility City] [nvarchar](255) NULL,
	[FaSt] [nvarchar](255) NULL,
	[Facil Zip] [nvarchar](50) NULL
) ON [PRIMARY]
GO
