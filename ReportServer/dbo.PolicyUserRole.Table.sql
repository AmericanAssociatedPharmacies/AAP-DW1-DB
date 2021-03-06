USE [ReportServer]
GO
/****** Object:  Table [dbo].[PolicyUserRole]    Script Date: 12/22/2020 7:41:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PolicyUserRole](
	[ID] [uniqueidentifier] NOT NULL,
	[RoleID] [uniqueidentifier] NOT NULL,
	[UserID] [uniqueidentifier] NOT NULL,
	[PolicyID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_PolicyUserRole] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PolicyUserRole]  WITH NOCHECK ADD  CONSTRAINT [FK_PolicyUserRole_Policy] FOREIGN KEY([PolicyID])
REFERENCES [dbo].[Policies] ([PolicyID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[PolicyUserRole] CHECK CONSTRAINT [FK_PolicyUserRole_Policy]
GO
ALTER TABLE [dbo].[PolicyUserRole]  WITH NOCHECK ADD  CONSTRAINT [FK_PolicyUserRole_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[PolicyUserRole] CHECK CONSTRAINT [FK_PolicyUserRole_Role]
GO
ALTER TABLE [dbo].[PolicyUserRole]  WITH NOCHECK ADD  CONSTRAINT [FK_PolicyUserRole_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[PolicyUserRole] CHECK CONSTRAINT [FK_PolicyUserRole_User]
GO
