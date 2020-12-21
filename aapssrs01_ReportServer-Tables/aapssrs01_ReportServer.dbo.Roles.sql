USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Roles] Script Date: 12/21/2020 8:08:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Roles] (
    [RoleID]      UNIQUEIDENTIFIER NOT NULL,
    [RoleName]    NVARCHAR (260)   NOT NULL,
    [Description] NVARCHAR (512)   NULL,
    [TaskMask]    NVARCHAR (32)    NOT NULL,
    [RoleFlags]   TINYINT          NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_Roles]
    ON [dbo].[Roles]([RoleName] ASC);


GO
ALTER TABLE [dbo].[Roles]
    ADD CONSTRAINT [PK_Roles] PRIMARY KEY NONCLUSTERED ([RoleID] ASC);


