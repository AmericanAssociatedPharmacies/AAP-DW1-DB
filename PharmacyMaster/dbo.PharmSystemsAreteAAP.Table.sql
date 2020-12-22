USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[PharmSystemsAreteAAP]    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PharmSystemsAreteAAP](
	[Software] [nvarchar](255) NULL,
	[parent] [varchar](255) NULL,
	[StoreCount] [int] NULL,
	[Company] [varchar](5) NOT NULL
) ON [PRIMARY]
GO
