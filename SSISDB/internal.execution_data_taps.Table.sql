USE [SSISDB]
GO
/****** Object:  Table [internal].[execution_data_taps]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[execution_data_taps](
	[data_tap_id] [bigint] IDENTITY(1,1) NOT NULL,
	[execution_id] [bigint] NOT NULL,
	[package_path] [nvarchar](max) NULL,
	[dataflow_path_id_string] [nvarchar](4000) NULL,
	[dataflow_task_guid] [uniqueidentifier] NULL,
	[max_rows] [int] NULL,
	[filename] [nvarchar](4000) NULL,
 CONSTRAINT [PK_Execution_data_taps] PRIMARY KEY CLUSTERED 
(
	[data_tap_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [internal].[execution_data_taps]  WITH CHECK ADD  CONSTRAINT [FK_ExecDataTaps_ExecutionId_Executions] FOREIGN KEY([execution_id])
REFERENCES [internal].[executions] ([execution_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[execution_data_taps] CHECK CONSTRAINT [FK_ExecDataTaps_ExecutionId_Executions]
GO
