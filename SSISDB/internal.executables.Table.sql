USE [SSISDB]
GO
/****** Object:  Table [internal].[executables]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[executables](
	[executable_id] [bigint] IDENTITY(1,1) NOT NULL,
	[project_id] [bigint] NOT NULL,
	[project_version_lsn] [bigint] NOT NULL,
	[package_name] [nvarchar](260) NOT NULL,
	[package_location_type] [nvarchar](128) NULL,
	[package_path_full] [nvarchar](4000) NULL,
	[executable_name] [nvarchar](4000) NULL,
	[executable_guid] [nvarchar](38) NULL,
	[package_path] [nvarchar](max) NULL,
 CONSTRAINT [PK_Executables] PRIMARY KEY CLUSTERED 
(
	[executable_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [internal].[executables]  WITH CHECK ADD  CONSTRAINT [FK_Executables] FOREIGN KEY([project_id])
REFERENCES [internal].[projects] ([project_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[executables] CHECK CONSTRAINT [FK_Executables]
GO
