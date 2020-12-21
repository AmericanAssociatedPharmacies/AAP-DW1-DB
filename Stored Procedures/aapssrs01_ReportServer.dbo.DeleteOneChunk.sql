USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteOneChunk] Script Date: 12/21/2020 8:48:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteOneChunk]
@SnapshotID uniqueidentifier,
@IsPermanentSnapshot bit,
@ChunkName nvarchar(260),
@ChunkType int
AS
SET NOCOUNT OFF
-- for segmented chunks we just need to
-- remove the mapping, the cleanup thread
-- will pick up the rest of the pieces
IF @IsPermanentSnapshot != 0 BEGIN

DELETE ChunkData
WHERE
    SnapshotDataID = @SnapshotID AND
    ChunkName = @ChunkName AND
    ChunkType = @ChunkType

DELETE	SegmentedChunk
WHERE
    SnapshotDataId = @SnapshotID AND
    ChunkName = @ChunkName AND
    ChunkType = @ChunkType

END ELSE BEGIN

DELETE [aapssrs01_ReportServerTempDB].dbo.ChunkData
WHERE
    SnapshotDataID = @SnapshotID AND
    ChunkName = @ChunkName AND
    ChunkType = @ChunkType

DELETE	[aapssrs01_ReportServerTempDB].dbo.SegmentedChunk
WHERE
    SnapshotDataId = @SnapshotID AND
    ChunkName = @ChunkName AND
    ChunkType = @ChunkType

END
