USE [WebDev]
GO
/****** Object:  Table [dbo].[OtherOwnershipAll-1]    Script Date: 12/22/2020 8:08:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OtherOwnershipAll-1](
	[PMID] [int] NULL,
	[CollectionId] [int] NOT NULL,
	[otherownerid] [int] NOT NULL,
	[Location Type] [varchar](5) NOT NULL,
	[NPI] [nvarchar](11) NULL,
	[Owner] [nvarchar](max) NULL,
	[Legal Name] [nvarchar](max) NULL,
	[DBA] [nvarchar](max) NULL,
	[OtherNPI] [nvarchar](max) NULL,
	[NCPDP] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[Address 2] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[State] [nvarchar](max) NULL,
	[Zip] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
