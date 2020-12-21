USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[SnapshotData] Script Date: 12/21/2020 8:10:18 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SnapshotData] (
    [SnapshotDataID]    UNIQUEIDENTIFIER NOT NULL,
    [CreatedDate]       DATETIME         NOT NULL,
    [ParamsHash]        INT              NULL,
    [QueryParams]       NTEXT            NULL,
    [EffectiveParams]   NTEXT            NULL,
    [Description]       NVARCHAR (512)   NULL,
    [DependsOnUser]     BIT              NULL,
    [PermanentRefcount] INT              NOT NULL,
    [TransientRefcount] INT              NOT NULL,
    [ExpirationDate]    DATETIME         NOT NULL,
    [PageCount]         INT              NULL,
    [HasDocMap]         BIT              NULL,
    [PaginationMode]    SMALLINT         NULL,
    [ProcessingFlags]   INT              NULL
);


GO
EXECUTE sp_tableoption @TableNamePattern = N'[dbo].[SnapshotData]', @OptionName = N'text in row', @OptionValue = N'256';


GO
CREATE NONCLUSTERED INDEX [IX_SnapshotCleaning]
    ON [dbo].[SnapshotData]([PermanentRefcount] ASC);


GO
ALTER TABLE [dbo].[SnapshotData]
    ADD CONSTRAINT [PK_SnapshotData] PRIMARY KEY CLUSTERED ([SnapshotDataID] ASC);


