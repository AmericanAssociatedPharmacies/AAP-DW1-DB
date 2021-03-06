USE [SSISDB]
GO
/****** Object:  Table [internal].[executable_statistics]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[executable_statistics](
	[statistics_id] [bigint] IDENTITY(1,1) NOT NULL,
	[execution_id] [bigint] NOT NULL,
	[executable_id] [bigint] NOT NULL,
	[execution_path] [nvarchar](max) NULL,
	[start_time] [datetimeoffset](7) NULL,
	[end_time] [datetimeoffset](7) NULL,
	[execution_hierarchy] [hierarchyid] NULL,
	[execution_duration] [int] NULL,
	[execution_result] [smallint] NULL,
	[execution_value] [sql_variant] NULL,
 CONSTRAINT [PK_Executable_statistics] PRIMARY KEY CLUSTERED 
(
	[statistics_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [internal].[executable_statistics]  WITH CHECK ADD  CONSTRAINT [FK_ExecutableStatistics_ExecutableId_Executables] FOREIGN KEY([executable_id])
REFERENCES [internal].[executables] ([executable_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[executable_statistics] CHECK CONSTRAINT [FK_ExecutableStatistics_ExecutableId_Executables]
GO
ALTER TABLE [internal].[executable_statistics]  WITH CHECK ADD  CONSTRAINT [FK_ExecutableStatistics_ExecutionId_Executions] FOREIGN KEY([execution_id])
REFERENCES [internal].[executions] ([execution_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[executable_statistics] CHECK CONSTRAINT [FK_ExecutableStatistics_ExecutionId_Executions]
GO
