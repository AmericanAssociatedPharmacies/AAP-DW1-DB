USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteSnapshotAndChunks] Script Date: 12/21/2020 8:51:10 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteSnapshotAndChunks]
@SnapshotID uniqueidentifier,
@IsPermanentSnapshot bit
AS

-- Delete from Snapshot, ChunkData and SegmentedChunk table.
-- Shared segments are not deleted.
-- TODO: currently this is being called from a bunch of places that handles exceptions.
-- We should try to delete the segments in some of all of those cases as well.
IF @IsPermanentSnapshot != 0 BEGIN

    DELETE ChunkData
    WHERE ChunkData.SnapshotDataID = @SnapshotID

    DELETE SegmentedChunk
    WHERE SegmentedChunk.SnapshotDataId = @SnapshotID

    DELETE SnapshotData
    WHERE SnapshotData.SnapshotDataID = @SnapshotID

END ELSE BEGIN

    DELETE [aapssrs01_ReportServerTempDB].dbo.ChunkData
    WHERE SnapshotDataID = @SnapshotID

    DELETE [aapssrs01_ReportServerTempDB].dbo.SegmentedChunk
    WHERE SnapshotDataId = @SnapshotID

    DELETE [aapssrs01_ReportServerTempDB].dbo.SnapshotData
    WHERE SnapshotDataID = @SnapshotID

END
