USE [SSISDB]
GO
/****** Object:  Table [internal].[execution_property_override_values]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[execution_property_override_values](
	[property_id] [bigint] IDENTITY(1,1) NOT NULL,
	[execution_id] [bigint] NOT NULL,
	[property_path] [nvarchar](4000) NOT NULL,
	[property_value] [nvarchar](max) NULL,
	[sensitive_property_value] [varbinary](max) NULL,
	[sensitive] [bit] NOT NULL,
 CONSTRAINT [PK_Execution_Property_Override_Value] PRIMARY KEY CLUSTERED 
(
	[property_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [internal].[execution_property_override_values]  WITH CHECK ADD  CONSTRAINT [FK_ExecutionPropertyOverrideValue_ExecutionId_Executions] FOREIGN KEY([execution_id])
REFERENCES [internal].[executions] ([execution_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[execution_property_override_values] CHECK CONSTRAINT [FK_ExecutionPropertyOverrideValue_ExecutionId_Executions]
GO
