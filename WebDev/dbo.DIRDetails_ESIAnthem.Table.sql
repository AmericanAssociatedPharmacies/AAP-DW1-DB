USE [WebDev]
GO
/****** Object:  Table [dbo].[DIRDetails_ESIAnthem]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DIRDetails_ESIAnthem](
	[NABP] [nvarchar](50) NULL,
	[NPI] [nvarchar](50) NULL,
	[PharmacyName] [nvarchar](255) NULL,
	[CORPORATE_NAME] [nvarchar](50) NULL,
	[CHAIN_NUMBER] [nvarchar](50) NULL,
	[CORPORATE_ID] [nvarchar](50) NULL,
	[CARRIER_ID] [nvarchar](50) NULL,
	[Carrier_Name] [nvarchar](255) NULL,
	[TOTAL_CLAIMS] [nvarchar](50) NULL,
	[FEE_FOR_PAID_CLAIMS] [nvarchar](50) NULL,
	[TOTAL_FEE ] [nvarchar](50) NULL,
	[Email] [nvarchar](255) NULL,
	[Owner] [nvarchar](255) NULL,
	[Phone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[TM First] [nvarchar](50) NULL,
	[TM Last] [nvarchar](50) NULL,
	[TM#] [nvarchar](50) NULL
) ON [PRIMARY]
GO
