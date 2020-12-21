USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[PolicyUserRole] Script Date: 12/21/2020 8:07:46 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[PolicyUserRole] (
    [ID]       UNIQUEIDENTIFIER NOT NULL,
    [RoleID]   UNIQUEIDENTIFIER NOT NULL,
    [UserID]   UNIQUEIDENTIFIER NOT NULL,
    [PolicyID] UNIQUEIDENTIFIER NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_PolicyUserRole]
    ON [dbo].[PolicyUserRole]([RoleID] ASC, [UserID] ASC, [PolicyID] ASC);


GO
ALTER TABLE [dbo].[PolicyUserRole]
    ADD CONSTRAINT [PK_PolicyUserRole] PRIMARY KEY NONCLUSTERED ([ID] ASC);


GO
ALTER TABLE [dbo].[PolicyUserRole]
    ADD CONSTRAINT [FK_PolicyUserRole_User] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]);


GO
ALTER TABLE [dbo].[PolicyUserRole]
    ADD CONSTRAINT [FK_PolicyUserRole_Role] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID]);


GO
ALTER TABLE [dbo].[PolicyUserRole]
    ADD CONSTRAINT [FK_PolicyUserRole_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policies] ([PolicyID]) ON DELETE CASCADE;


