USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].['AAP Members$']    Script Date: 12/22/2020 7:35:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].['AAP Members$'](
	[ID] [float] NULL,
	[Pharmacy Name] [nvarchar](255) NULL,
	[Contact] [nvarchar](255) NULL,
	[addr1] [nvarchar](255) NULL,
	[addr2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](255) NULL
) ON [PRIMARY]
GO
