USE [ODSIntake]
GO
/****** Object:  Table [dbo].[TableAudit]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableAudit](
	[RowID] [int] IDENTITY(1,1) NOT NULL,
	[ServerName] [varchar](255) NULL,
	[DbName] [varchar](255) NULL,
	[SchemaName] [varchar](255) NULL,
	[TableName] [varchar](255) NULL,
	[LastUpdate] [datetime] NULL,
	[LastSeek] [datetime] NULL,
	[LastScan] [datetime] NULL,
	[LastLookup] [datetime] NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TableAudit] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
