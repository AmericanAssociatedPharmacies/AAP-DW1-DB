USE [ODSIntake]
GO
/****** Object:  Table [dbo].[ASW_20191016]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ASW_20191016](
	[Customer Number] [nvarchar](255) NULL,
	[Pharmacy] [nvarchar](255) NULL,
	[DEA] [nvarchar](255) NULL,
	[Address 1] [nvarchar](255) NULL,
	[Address 2] [nvarchar](255) NULL,
	[City ] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](255) NULL,
	[API Status] [nvarchar](255) NULL
) ON [PRIMARY]
GO
