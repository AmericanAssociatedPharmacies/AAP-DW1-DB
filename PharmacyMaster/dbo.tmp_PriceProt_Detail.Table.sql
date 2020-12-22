USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[tmp_PriceProt_Detail]    Script Date: 12/22/2020 7:35:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_PriceProt_Detail](
	[PMID] [int] NOT NULL,
	[Account Name] [varchar](65) NULL,
	[City] [varchar](50) NULL,
	[State] [varchar](2) NULL,
	[CHAcct] [nvarchar](6) NULL,
	[File Date] [datetime] NULL,
	[Due To Date] [money] NULL,
	[Item#] [varchar](50) NULL,
	[Description] [varchar](255) NULL,
	[NDC] [varchar](50) NULL,
	[Protected Price] [money] NULL,
	[New Price] [money] NULL,
	[Protection Start] [datetime] NULL,
	[Protection End] [datetime] NULL,
	[Protected Qty] [int] NULL,
	[Usage To Date] [int] NULL
) ON [PRIMARY]
GO
