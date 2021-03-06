USE [SSISDB]
GO
/****** Object:  Table [internal].[operations]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[operations](
	[operation_id] [bigint] IDENTITY(1,1) NOT NULL,
	[operation_type] [smallint] NOT NULL,
	[created_time] [datetimeoffset](7) NULL,
	[object_type] [smallint] NULL,
	[object_id] [bigint] NULL,
	[object_name] [nvarchar](260) NULL,
	[status] [int] NOT NULL,
	[start_time] [datetimeoffset](7) NULL,
	[end_time] [datetimeoffset](7) NULL,
	[caller_sid] [varbinary](85) NOT NULL,
	[caller_name] [sysname] NOT NULL,
	[process_id] [int] NULL,
	[stopped_by_sid] [varbinary](85) NULL,
	[stopped_by_name] [nvarchar](128) NULL,
	[operation_guid] [uniqueidentifier] NULL,
	[server_name] [nvarchar](128) NULL,
	[machine_name] [nvarchar](128) NULL,
 CONSTRAINT [PK_Operations] PRIMARY KEY CLUSTERED 
(
	[operation_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
