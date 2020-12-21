USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Comments] Script Date: 12/21/2020 8:02:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Comments] (
    [CommentID]    BIGINT           IDENTITY (1, 1) NOT NULL,
    [ItemID]       UNIQUEIDENTIFIER NOT NULL,
    [UserID]       UNIQUEIDENTIFIER NOT NULL,
    [ThreadID]     BIGINT           NULL,
    [Text]         NVARCHAR (2048)  NOT NULL,
    [CreatedDate]  DATETIME         NOT NULL,
    [ModifiedDate] DATETIME         NULL,
    [AttachmentID] UNIQUEIDENTIFIER NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_Comments_Item]
    ON [dbo].[Comments]([ItemID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Comments_User]
    ON [dbo].[Comments]([UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Comments_Thread]
    ON [dbo].[Comments]([ThreadID] ASC);


GO
ALTER TABLE [dbo].[Comments]
    ADD CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED ([CommentID] ASC);


GO
ALTER TABLE [dbo].[Comments]
    ADD CONSTRAINT [FK_Comments_Catalog] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[Catalog] ([ItemID]) ON DELETE CASCADE;


GO
ALTER TABLE [dbo].[Comments]
    ADD CONSTRAINT [FK_Comments_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID]) ON DELETE CASCADE;


GO
ALTER TABLE [dbo].[Comments]
    ADD CONSTRAINT [FK_Comments_Comments] FOREIGN KEY ([ThreadID]) REFERENCES [dbo].[Comments] ([CommentID]);


GO
ALTER TABLE [dbo].[Comments]
    ADD CONSTRAINT [FK_Comments_CatalogResource] FOREIGN KEY ([AttachmentID]) REFERENCES [dbo].[Catalog] ([ItemID]);


