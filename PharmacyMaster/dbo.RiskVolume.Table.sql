USE [PharmacyMaster]
GO
/****** Object:  Table [dbo].[RiskVolume]    Script Date: 12/22/2020 7:35:34 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RiskVolume](
	[NCPDP] [varchar](20) NULL,
	[Year] [int] NULL,
	[Month] [int] NULL,
	[CHSVolume] [float] NULL,
	[APIVolume] [float] NULL,
	[MLVolume] [float] NULL,
	[TotalVolume] [float] NULL
) ON [PRIMARY]
GO
