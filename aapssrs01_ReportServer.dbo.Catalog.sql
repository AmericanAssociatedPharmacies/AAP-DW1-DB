USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Catalog] Script Date: 12/21/2020 8:00:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Catalog] (
    [ItemID]         UNIQUEIDENTIFIER NOT NULL,
    [Path]           NVARCHAR (425)   NOT NULL,
    [Name]           NVARCHAR (425)   NOT NULL,
    [ParentID]       UNIQUEIDENTIFIER NULL,
    [Type]           INT              NOT NULL,
    [Content]        VARBINARY (MAX)  NULL,
    [Intermediate]   UNIQUEIDENTIFIER NULL,
    [SnapshotDataID] UNIQUEIDENTIFIER NULL,
    [LinkSourceID]   UNIQUEIDENTIFIER NULL,
    [Property]       NTEXT            NULL,
    [Description]    NVARCHAR (512)   NULL,
    [Hidden]         BIT              NULL,
    [CreatedByID]    UNIQUEIDENTIFIER NOT NULL,
    [CreationDate]   DATETIME         NOT NULL,
    [ModifiedByID]   UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]   DATETIME         NOT NULL,
    [MimeType]       NVARCHAR (260)   NULL,
    [SnapshotLimit]  INT              NULL,
    [Parameter]      NTEXT            NULL,
    [PolicyID]       UNIQUEIDENTIFIER NOT NULL,
    [PolicyRoot]     BIT              NOT NULL,
    [ExecutionFlag]  INT              NOT NULL,
    [ExecutionTime]  DATETIME         NULL,
    [SubType]        NVARCHAR (128)   NULL,
    [ComponentID]    UNIQUEIDENTIFIER NULL
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[Catalog]', @OptionName = N'text in row', @OptionValue = N'256';


GO
CREATE UNIQUE CLUSTERED INDEX [IX_Catalog]
    ON [dbo].[Catalog]([Path] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Link]
    ON [dbo].[Catalog]([LinkSourceID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Parent]
    ON [dbo].[Catalog]([ParentID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SnapshotDataId]
    ON [dbo].[Catalog]([SnapshotDataID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_ComponentLookup]
    ON [dbo].[Catalog]([Type] ASC, [ComponentID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Policy]
    ON [dbo].[Catalog]([PolicyID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DatasetLookup]
    ON [dbo].[Catalog]([Type] ASC, [ItemID] ASC);


GO
ALTER TABLE [dbo].[Catalog]
    ADD CONSTRAINT [PK_Catalog] PRIMARY KEY NONCLUSTERED ([ItemID] ASC);


GO
ALTER TABLE [dbo].[Catalog]
    ADD CONSTRAINT [FK_Catalog_ParentID] FOREIGN KEY ([ParentID]) REFERENCES [dbo].[Catalog] ([ItemID]);


GO
ALTER TABLE [dbo].[Catalog]
    ADD CONSTRAINT [FK_Catalog_LinkSourceID] FOREIGN KEY ([LinkSourceID]) REFERENCES [dbo].[Catalog] ([ItemID]);


GO
ALTER TABLE [dbo].[Catalog]
    ADD CONSTRAINT [FK_Catalog_Policy] FOREIGN KEY ([PolicyID]) REFERENCES [dbo].[Policies] ([PolicyID]);


GO
ALTER TABLE [dbo].[Catalog]
    ADD CONSTRAINT [FK_Catalog_CreatedByID] FOREIGN KEY ([CreatedByID]) REFERENCES [dbo].[Users] ([UserID]);


GO
ALTER TABLE [dbo].[Catalog]
    ADD CONSTRAINT [FK_Catalog_ModifiedByID] FOREIGN KEY ([ModifiedByID]) REFERENCES [dbo].[Users] ([UserID]);


