USE [ODSIntake]
GO
/****** Object:  Table [dbo].[Db1Cleanup_ReferencedObjects]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Db1Cleanup_ReferencedObjects](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](500) NULL,
	[DbName] [varchar](500) NULL,
	[referencing_schema_name] [varchar](500) NULL,
	[referencing_object_name] [varchar](500) NULL,
	[referencing_object_type_desc] [varchar](500) NULL,
	[referenced_schema_name] [varchar](500) NULL,
	[referenced_object_name] [varchar](500) NULL,
	[referenced_object_type_desc] [varchar](500) NULL,
	[referenced_server_name] [varchar](500) NULL,
	[referenced_database_name] [varchar](500) NULL,
	[RowCreatedDate] [datetime] NOT NULL,
	[IsActiveAAPDb] [bit] NULL,
	[IsUsedLoadCHPH] [bit] NULL,
	[IsUsedAAPLoadVerify] [bit] NULL,
	[IsUsedInApplication] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Db1Cleanup_ReferencedObjects] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
