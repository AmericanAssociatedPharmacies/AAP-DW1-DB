USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ChunkSegmentMapping] Script Date: 12/21/2020 8:01:51 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ChunkSegmentMapping] (
    [ChunkId]          UNIQUEIDENTIFIER NOT NULL,
    [SegmentId]        UNIQUEIDENTIFIER NOT NULL,
    [StartByte]        BIGINT           NOT NULL,
    [LogicalByteCount] INT              NOT NULL,
    [ActualByteCount]  INT              NOT NULL
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UNIQ_ChunkId_StartByte]
    ON [dbo].[ChunkSegmentMapping]([ChunkId] ASC, [StartByte] ASC)
    INCLUDE([ActualByteCount], [LogicalByteCount]);


GO
CREATE NONCLUSTERED INDEX [IX_ChunkSegmentMapping_SegmentId]
    ON [dbo].[ChunkSegmentMapping]([SegmentId] ASC);


GO
ALTER TABLE [dbo].[ChunkSegmentMapping]
    ADD CONSTRAINT [PK_ChunkSegmentMapping] PRIMARY KEY CLUSTERED ([ChunkId] ASC, [SegmentId] ASC);


GO
ALTER TABLE [dbo].[ChunkSegmentMapping]
    ADD CONSTRAINT [Positive_StartByte] CHECK ([StartByte]>=(0));


GO
ALTER TABLE [dbo].[ChunkSegmentMapping]
    ADD CONSTRAINT [Positive_LogicalByteCount] CHECK ([LogicalByteCount]>=(0));


GO
ALTER TABLE [dbo].[ChunkSegmentMapping]
    ADD CONSTRAINT [Positive_ActualByteCount] CHECK ([ActualByteCount]>=(0));


