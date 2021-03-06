USE [MedispanImages]
GO
/****** Object:  Table [Archive].[IM2UDIJ_L]    Script Date: 12/22/2020 7:20:03 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Archive].[IM2UDIJ_L](
	[Unique_Drug_ID] [numeric](19, 0) NOT NULL,
	[Start_Date] [numeric](19, 0) NOT NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Stop_Date] [bigint] NULL,
	[Image_ID] [bigint] NULL,
	[Reserve] [nvarchar](35) NULL,
PRIMARY KEY CLUSTERED 
(
	[Unique_Drug_ID] ASC,
	[Start_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
