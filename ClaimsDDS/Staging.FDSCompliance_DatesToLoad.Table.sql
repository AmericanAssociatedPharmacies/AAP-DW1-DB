USE [ClaimsDDS]
GO
/****** Object:  Table [Staging].[FDSCompliance_DatesToLoad]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Staging].[FDSCompliance_DatesToLoad](
	[RN] [int] NOT NULL,
	[DateKey] [int] NULL
) ON [PRIMARY]
GO
