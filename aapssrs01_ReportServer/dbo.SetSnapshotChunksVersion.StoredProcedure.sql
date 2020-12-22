USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[SetSnapshotChunksVersion]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetSnapshotChunksVersion]
@SnapshotDataID as uniqueidentifier,
@IsPermanentSnapshot as bit,
@Version as smallint
AS
declare @affectedRows int
set @affectedRows = 0
if @IsPermanentSnapshot = 1
BEGIN
   if @Version > 0
   BEGIN
      UPDATE ChunkData
      SET Version = @Version
      WHERE SnapshotDataID = @SnapshotDataID

      SELECT @affectedRows = @affectedRows + @@rowcount

      UPDATE SegmentedChunk
      SET Version = @Version
      WHERE SnapshotDataId = @SnapshotDataID

      SELECT @affectedRows = @affectedRows + @@rowcount
   END ELSE BEGIN
      UPDATE ChunkData
      SET Version = Version
      WHERE SnapshotDataID = @SnapshotDataID

      SELECT @affectedRows = @affectedRows + @@rowcount

      UPDATE SegmentedChunk
      SET Version = Version
      WHERE SnapshotDataId = @SnapshotDataID

      SELECT @affectedRows = @affectedRows + @@rowcount
   END
END ELSE BEGIN
   if @Version > 0
   BEGIN
      UPDATE [aapssrs01_ReportServerTempDB].dbo.ChunkData
      SET Version = @Version
      WHERE SnapshotDataID = @SnapshotDataID

      SELECT @affectedRows = @affectedRows + @@rowcount

      UPDATE [aapssrs01_ReportServerTempDB].dbo.SegmentedChunk
      SET Version = @Version
      WHERE SnapshotDataId = @SnapshotDataID

      SELECT @affectedRows = @affectedRows + @@rowcount
   END ELSE BEGIN
      UPDATE [aapssrs01_ReportServerTempDB].dbo.ChunkData
      SET Version = Version
      WHERE SnapshotDataID = @SnapshotDataID

      SELECT @affectedRows = @affectedRows + @@rowcount

      UPDATE [aapssrs01_ReportServerTempDB].dbo.SegmentedChunk
      SET Version = Version
      WHERE SnapshotDataId = @SnapshotDataID

      SELECT @affectedRows = @affectedRows + @@rowcount
   END
END
SELECT @affectedRows
GO
