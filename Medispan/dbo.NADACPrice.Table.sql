USE [Medispan]
GO
/****** Object:  Table [dbo].[NADACPrice]    Script Date: 12/22/2020 7:12:43 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NADACPrice](
	[NDC Description] [nvarchar](200) NULL,
	[NDC] [nvarchar](50) NULL,
	["NADAC Per Unit"] [nvarchar](50) NULL,
	["Effective Date"] [nvarchar](50) NULL,
	["Pricing Unit"] [nvarchar](50) NULL,
	["Pharmacy Type Indicator"] [nvarchar](50) NULL,
	[OTC] [nvarchar](50) NULL,
	["Explanation Code"] [nvarchar](50) NULL,
	["Classification for Rate Setting"] [nvarchar](50) NULL,
	["Corresponding Generic Drug NADAC Per Unit"] [nvarchar](50) NULL,
	["Corresponding Generic Drug Effective Date"] [nvarchar](50) NULL
) ON [PRIMARY]
GO
