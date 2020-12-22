USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Nova_Brands_20181018]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nova_Brands_20181018](
	[Drug Name 30] [nvarchar](255) NULL,
	[Drug Unit] [nvarchar](255) NULL,
	[NDC Nbr] [nvarchar](255) NULL,
	[Manufacturer] [nvarchar](255) NULL,
	[Qty Dspn YTD Unt] [float] NULL,
	[List] [nvarchar](255) NULL
) ON [PRIMARY]
GO
