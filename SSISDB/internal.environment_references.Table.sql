USE [SSISDB]
GO
/****** Object:  Table [internal].[environment_references]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[environment_references](
	[reference_id] [bigint] IDENTITY(1,1) NOT NULL,
	[project_id] [bigint] NOT NULL,
	[reference_type] [char](1) NOT NULL,
	[environment_folder_name] [nvarchar](128) NULL,
	[environment_name] [sysname] NOT NULL,
	[validation_status] [char](1) NOT NULL,
	[last_validation_time] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_environment_references] PRIMARY KEY CLUSTERED 
(
	[reference_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [internal].[environment_references]  WITH CHECK ADD  CONSTRAINT [FK_ProjectEnvironment_ProjectId_Projects] FOREIGN KEY([project_id])
REFERENCES [internal].[projects] ([project_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[environment_references] CHECK CONSTRAINT [FK_ProjectEnvironment_ProjectId_Projects]
GO
