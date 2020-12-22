USE [SSISDB]
GO
/****** Object:  Table [internal].[environment_permissions]    Script Date: 12/22/2020 8:03:50 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [internal].[environment_permissions](
	[id] [bigint] IDENTITY(1,1) NOT NULL,
	[sid] [internal].[adt_sid] NOT NULL,
	[object_id] [bigint] NOT NULL,
	[permission_type] [smallint] NOT NULL,
	[is_role] [bit] NOT NULL,
	[is_deny] [bit] NOT NULL,
	[grantor_sid] [internal].[adt_sid] NOT NULL,
 CONSTRAINT [PK_Environment_Permissions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [internal].[environment_permissions]  WITH CHECK ADD  CONSTRAINT [FK_EnvironmentPermissions_ObjectId_Environments] FOREIGN KEY([object_id])
REFERENCES [internal].[environments] ([environment_id])
ON DELETE CASCADE
GO
ALTER TABLE [internal].[environment_permissions] CHECK CONSTRAINT [FK_EnvironmentPermissions_ObjectId_Environments]
GO
ALTER TABLE [internal].[environment_permissions]  WITH CHECK ADD  CONSTRAINT [CK_Environment_PermissionType] CHECK  (([permission_type]=(4) OR [permission_type]=(2) OR [permission_type]=(1)))
GO
ALTER TABLE [internal].[environment_permissions] CHECK CONSTRAINT [CK_Environment_PermissionType]
GO
