USE [ODSIntake]
GO
/****** Object:  Table [dbo].[PurchasesObjects_20191018]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchasesObjects_20191018](
	[ServerName] [nvarchar](128) NULL,
	[DBName] [varchar](25) NULL,
	[ObjectDefinition] [varchar](8000) NULL,
	[ObjectName] [varchar](255) NULL,
	[ObjectType] [varchar](10) NULL
) ON [PRIMARY]
GO
