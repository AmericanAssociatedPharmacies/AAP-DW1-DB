USE [ODSIntake]
GO
/****** Object:  Table [dbo].[TableIndexUsage]    Script Date: 12/22/2020 7:30:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableIndexUsage](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](100) NULL,
	[DbName] [varchar](100) NULL,
	[ObjectName] [varchar](100) NULL,
	[SchemaName] [varchar](100) NULL,
	[IndexName] [varchar](100) NULL,
	[index_id] [int] NOT NULL,
	[IndexSizeKB] [bigint] NULL,
	[user_seeks] [bigint] NULL,
	[user_scans] [bigint] NULL,
	[user_lookups] [bigint] NULL,
	[user_updates] [bigint] NULL,
	[last_user_seek] [datetime] NULL,
	[last_user_scan] [datetime] NULL,
	[last_user_lookup] [datetime] NULL,
	[last_user_update] [datetime] NULL,
	[RowCreatedDate] [datetime] NOT NULL,
 CONSTRAINT [CPK_ableIndexUsage] PRIMARY KEY CLUSTERED 
(
	[RowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TableIndexUsage] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
