USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[History] Script Date: 12/21/2020 8:04:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[History] (
    [HistoryID]      UNIQUEIDENTIFIER NOT NULL,
    [ReportID]       UNIQUEIDENTIFIER NOT NULL,
    [SnapshotDataID] UNIQUEIDENTIFIER NOT NULL,
    [SnapshotDate]   DATETIME         NOT NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_History]
    ON [dbo].[History]([ReportID] ASC, [SnapshotDate] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_SnapshotDataID]
    ON [dbo].[History]([SnapshotDataID] ASC);


GO
ALTER TABLE [dbo].[History]
    ADD CONSTRAINT [PK_History] PRIMARY KEY NONCLUSTERED ([HistoryID] ASC);


