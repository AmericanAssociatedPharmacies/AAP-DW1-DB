USE [ODSIntake]
GO
/****** Object:  Table [dbo].[APIPurchases_ObjectXRef]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APIPurchases_ObjectXRef](
	[DbName] [varchar](25) NULL,
	[ObjectDefinition] [varchar](8000) NULL,
	[ObjectName] [varchar](255) NULL,
	[ObjectType] [varchar](10) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APIPurchases_ObjectXRef] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
