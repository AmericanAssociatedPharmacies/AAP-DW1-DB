USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[SegmentedChunk] Script Date: 12/21/2020 8:09:39 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SegmentedChunk] (
    [ChunkId]          UNIQUEIDENTIFIER NOT NULL,
    [SnapshotDataId]   UNIQUEIDENTIFIER NOT NULL,
    [ChunkFlags]       TINYINT          NOT NULL,
    [ChunkName]        NVARCHAR (260)   NOT NULL,
    [ChunkType]        INT              NOT NULL,
    [Version]          SMALLINT         NOT NULL,
    [MimeType]         NVARCHAR (260)   NULL,
    [SegmentedChunkId] BIGINT           IDENTITY (1, 1) NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ChunkId_SnapshotDataId]
    ON [dbo].[SegmentedChunk]([ChunkId] ASC, [SnapshotDataId] ASC);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UNIQ_SnapshotChunkMapping]
    ON [dbo].[SegmentedChunk]([SnapshotDataId] ASC, [ChunkType] ASC, [ChunkName] ASC)
    INCLUDE([ChunkFlags], [ChunkId]);


GO
ALTER TABLE [dbo].[SegmentedChunk]
    ADD CONSTRAINT [PK_SegmentedChunk] PRIMARY KEY CLUSTERED ([SegmentedChunkId] ASC);


GO
ALTER TABLE [dbo].[SegmentedChunk]
    ADD CONSTRAINT [DF_SegmentedChunk_ChunkId] DEFAULT (newsequentialid()) FOR [ChunkId];


