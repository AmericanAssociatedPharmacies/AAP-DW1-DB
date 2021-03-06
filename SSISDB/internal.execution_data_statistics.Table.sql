USE [SSISDB]
GO
/****** Object:  Table [internal].[execution_data_statistics]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[execution_data_statistics](
	[data_stats_id] [bigint] IDENTITY(1,1) NOT NULL,
	[execution_id] [bigint] NOT NULL,
	[package_name] [nvarchar](260) NOT NULL,
	[package_location_type] [nvarchar](128) NULL,
	[package_path_full] [nvarchar](4000) NULL,
	[task_name] [nvarchar](4000) NULL,
	[dataflow_path_id_string] [nvarchar](4000) NULL,
	[dataflow_path_name] [nvarchar](4000) NULL,
	[source_component_name] [nvarchar](4000) NULL,
	[destination_component_name] [nvarchar](4000) NULL,
	[rows_sent] [bigint] NULL,
	[created_time] [datetimeoffset](7) NULL,
	[execution_path] [nvarchar](max) NULL,
 CONSTRAINT [PK_Execution_data_statistics] PRIMARY KEY CLUSTERED 
(
	[data_stats_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [internal].[execution_data_statistics]  WITH CHECK ADD  CONSTRAINT [FK_ExecDataStat_ExecutionId_Executions] FOREIGN KEY([execution_id])
REFERENCES [internal].[executions] ([execution_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[execution_data_statistics] CHECK CONSTRAINT [FK_ExecDataStat_ExecutionId_Executions]
GO
