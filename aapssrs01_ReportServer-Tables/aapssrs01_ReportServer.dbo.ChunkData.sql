USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ChunkData] Script Date: 12/21/2020 8:01:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ChunkData] (
    [ChunkID]        UNIQUEIDENTIFIER NOT NULL,
    [SnapshotDataID] UNIQUEIDENTIFIER NOT NULL,
    [ChunkFlags]     TINYINT          NULL,
    [ChunkName]      NVARCHAR (260)   NULL,
    [ChunkType]      INT              NULL,
    [Version]        SMALLINT         NULL,
    [MimeType]       NVARCHAR (260)   NULL,
    [Content]        IMAGE            NULL
);


GO
CREATE UNIQUE CLUSTERED INDEX [IX_ChunkData]
    ON [dbo].[ChunkData]([SnapshotDataID] ASC, [ChunkType] ASC, [ChunkName] ASC);


GO
ALTER TABLE [dbo].[ChunkData]
    ADD CONSTRAINT [PK_ChunkData] PRIMARY KEY NONCLUSTERED ([ChunkID] ASC);


