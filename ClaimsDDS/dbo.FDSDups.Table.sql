USE [ClaimsDDS]
GO
/****** Object:  Table [dbo].[FDSDups]    Script Date: 12/22/2020 6:54:01 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FDSDups](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[RowversionID] [varbinary](8) NULL,
	[DateKey] [int] NULL
) ON [PRIMARY]
GO
