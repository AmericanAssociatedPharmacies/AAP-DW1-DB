USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Users] Script Date: 12/21/2020 8:11:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Users] (
    [UserID]       UNIQUEIDENTIFIER NOT NULL,
    [Sid]          VARBINARY (85)   NULL,
    [UserType]     INT              NOT NULL,
    [AuthType]     INT              NOT NULL,
    [UserName]     NVARCHAR (260)   NULL,
    [ServiceToken] NTEXT            NULL,
    [Setting]      NTEXT            NULL,
    [ModifiedDate] DATETIME         NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_Users]
    ON [dbo].[Users]([Sid] ASC, [UserName] ASC, [AuthType] ASC);


GO
ALTER TABLE [dbo].[Users]
    ADD CONSTRAINT [PK_Users] PRIMARY KEY NONCLUSTERED ([UserID] ASC);


