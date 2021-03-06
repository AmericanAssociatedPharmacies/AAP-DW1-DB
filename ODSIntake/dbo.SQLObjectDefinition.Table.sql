USE [ODSIntake]
GO
/****** Object:  Table [dbo].[SQLObjectDefinition]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SQLObjectDefinition](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](100) NULL,
	[DbName] [varchar](100) NULL,
	[ObjectDefinition] [varchar](8000) NULL,
	[ObjectSchemaName] [varchar](100) NULL,
	[ObjectName] [varchar](100) NULL,
	[ObjectType] [varchar](100) NULL,
	[ObjectTypeName] [varchar](100) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SQLObjectDefinition] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
