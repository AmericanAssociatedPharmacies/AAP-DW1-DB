USE [ODSIntake]
GO
/****** Object:  Table [dbo].[DatabaseSize_AllServers]    Script Date: 12/22/2020 7:30:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DatabaseSize_AllServers](
	[ServerName] [nvarchar](128) NULL,
	[database_name] [nvarchar](128) NULL,
	[log_size_mb] [decimal](8, 2) NULL,
	[row_size_mb] [decimal](8, 2) NULL,
	[total_size_mb] [decimal](8, 2) NULL,
	[RowCreatedDate] [datetime] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DatabaseSize_AllServers] ADD  DEFAULT (getdate()) FOR [RowCreatedDate]
GO
