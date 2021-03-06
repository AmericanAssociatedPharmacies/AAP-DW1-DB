USE [Medispan_Staging]
GO
/****** Object:  Table [dbo].[MF2SEC_3]    Script Date: 12/22/2020 7:17:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MF2SEC_3](
	[External_Drug_ID] [varchar](20) NOT NULL,
	[External_Drug_ID_Format_Code] [varchar](1) NOT NULL,
	[Alternate_Drug_ID] [varchar](20) NOT NULL,
	[Alternate_Drug_ID_Format_Code] [varchar](1) NOT NULL,
	[Transaction_Code] [nvarchar](1) NULL,
	[Reserve] [nvarchar](21) NULL,
PRIMARY KEY CLUSTERED 
(
	[External_Drug_ID] ASC,
	[External_Drug_ID_Format_Code] ASC,
	[Alternate_Drug_ID] ASC,
	[Alternate_Drug_ID_Format_Code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
