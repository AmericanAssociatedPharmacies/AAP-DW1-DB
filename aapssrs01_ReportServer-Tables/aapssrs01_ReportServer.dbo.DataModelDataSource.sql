USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[DataModelDataSource] Script Date: 12/21/2020 8:02:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DataModelDataSource] (
    [DSID]             BIGINT           IDENTITY (1, 1) NOT NULL,
    [ItemId]           UNIQUEIDENTIFIER NOT NULL,
    [DSType]           INT              NOT NULL,
    [DSKind]           INT              NOT NULL,
    [AuthType]         INT              NOT NULL,
    [ConnectionString] VARBINARY (MAX)  NULL,
    [Username]         VARBINARY (MAX)  NULL,
    [Password]         VARBINARY (MAX)  NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_DataModelDataSource]
    ON [dbo].[DataModelDataSource]([ItemId] ASC);


GO
ALTER TABLE [dbo].[DataModelDataSource]
    ADD CONSTRAINT [PK_DataModelDataSource] PRIMARY KEY CLUSTERED ([DSID] ASC);


GO
ALTER TABLE [dbo].[DataModelDataSource]
    ADD CONSTRAINT [FK_DataModelDataSource_Catalog] FOREIGN KEY ([ItemId]) REFERENCES [dbo].[Catalog] ([ItemID]) ON DELETE CASCADE;


