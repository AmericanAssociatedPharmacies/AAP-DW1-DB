USE [ODSIntake]
GO
/****** Object:  Table [dbo].[SQLObject]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQLObject](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](100) NULL,
	[BaseDbName] [varchar](100) NULL,
	[BaseSchemaObjectName] [varchar](100) NULL,
	[BaseObject] [varchar](100) NULL,
	[ReferencedDbName] [varchar](100) NULL,
	[ReferencedSchemaName] [varchar](100) NULL,
	[ReferencedObjectName] [varchar](100) NULL,
	[IsAmbigous] [bit] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SQLObject] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
