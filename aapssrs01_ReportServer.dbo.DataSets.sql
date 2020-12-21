USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[DataSets] Script Date: 12/21/2020 8:03:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DataSets] (
    [ID]     UNIQUEIDENTIFIER NOT NULL,
    [ItemID] UNIQUEIDENTIFIER NOT NULL,
    [LinkID] UNIQUEIDENTIFIER NULL,
    [Name]   NVARCHAR (260)   NOT NULL
);


GO
CREATE CLUSTERED INDEX [IX_DataSet_ItemID_Name]
    ON [dbo].[DataSets]([ItemID] ASC, [Name] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_DataSetLinkID]
    ON [dbo].[DataSets]([LinkID] ASC);


GO
ALTER TABLE [dbo].[DataSets]
    ADD CONSTRAINT [PK_DataSet] PRIMARY KEY NONCLUSTERED ([ID] ASC);


GO
ALTER TABLE [dbo].[DataSets]
    ADD CONSTRAINT [FK_DataSetItemID] FOREIGN KEY ([ItemID]) REFERENCES [dbo].[Catalog] ([ItemID]);


GO
ALTER TABLE [dbo].[DataSets]
    ADD CONSTRAINT [FK_DataSetLinkID] FOREIGN KEY ([LinkID]) REFERENCES [dbo].[Catalog] ([ItemID]);


