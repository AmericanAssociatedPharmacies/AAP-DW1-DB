USE [SSISDB]
GO
/****** Object:  Table [internal].[execution_parameter_values]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[execution_parameter_values](
	[execution_parameter_id] [bigint] IDENTITY(1,1) NOT NULL,
	[execution_id] [bigint] NOT NULL,
	[object_type] [smallint] NOT NULL,
	[parameter_data_type] [nvarchar](128) NOT NULL,
	[parameter_name] [sysname] NOT NULL,
	[parameter_value] [sql_variant] NULL,
	[sensitive_parameter_value] [varbinary](max) NULL,
	[base_data_type] [nvarchar](128) NULL,
	[sensitive] [bit] NOT NULL,
	[required] [bit] NOT NULL,
	[value_set] [bit] NOT NULL,
	[runtime_override] [bit] NOT NULL,
 CONSTRAINT [PK_Execution_Parameter_value] PRIMARY KEY CLUSTERED 
(
	[execution_parameter_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [internal].[execution_parameter_values]  WITH CHECK ADD  CONSTRAINT [FK_ExecutionParameterValue_ExecutionId_Executions] FOREIGN KEY([execution_id])
REFERENCES [internal].[executions] ([execution_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[execution_parameter_values] CHECK CONSTRAINT [FK_ExecutionParameterValue_ExecutionId_Executions]
GO
