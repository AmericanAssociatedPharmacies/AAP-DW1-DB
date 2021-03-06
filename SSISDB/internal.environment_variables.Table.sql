USE [SSISDB]
GO
/****** Object:  Table [internal].[environment_variables]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[environment_variables](
	[variable_id] [bigint] IDENTITY(1,1) NOT NULL,
	[environment_id] [bigint] NOT NULL,
	[name] [sysname] NOT NULL,
	[description] [nvarchar](1024) NULL,
	[type] [nvarchar](128) NOT NULL,
	[sensitive] [bit] NOT NULL,
	[value] [sql_variant] NULL,
	[sensitive_value] [varbinary](max) NULL,
	[base_data_type] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_Environment_Variables] PRIMARY KEY CLUSTERED 
(
	[variable_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [Unique_Environment_Variable] UNIQUE NONCLUSTERED 
(
	[environment_id] ASC,
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [internal].[environment_variables]  WITH CHECK ADD  CONSTRAINT [FK_EnvironmentVariables_EnvironmentId_Environments] FOREIGN KEY([environment_id])
REFERENCES [internal].[environments] ([environment_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[environment_variables] CHECK CONSTRAINT [FK_EnvironmentVariables_EnvironmentId_Environments]
GO
