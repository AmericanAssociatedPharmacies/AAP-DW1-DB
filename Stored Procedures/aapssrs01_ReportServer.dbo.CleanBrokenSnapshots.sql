USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CleanBrokenSnapshots] Script Date: 12/21/2020 8:31:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CleanBrokenSnapshots]
@Machine nvarchar(512),
@SnapshotsCleaned int OUTPUT,
@ChunksCleaned int OUTPUT,
@TempSnapshotID uniqueidentifier OUTPUT
AS
    SET DEADLOCK_PRIORITY LOW
    DECLARE @now AS datetime
    SELECT @now = GETDATE()

    CREATE TABLE #tempSnapshot (SnapshotDataID uniqueidentifier)
    INSERT INTO #tempSnapshot SELECT TOP 1 SnapshotDataID
    FROM SnapshotData  WITH (NOLOCK)
    where SnapshotData.PermanentRefcount <= 0
    AND ExpirationDate < @now
    SET @SnapshotsCleaned = @@ROWCOUNT

    DELETE ChunkData FROM ChunkData INNER JOIN #tempSnapshot
    ON ChunkData.SnapshotDataID = #tempSnapshot.SnapshotDataID
    SET @ChunksCleaned = @@ROWCOUNT

    DELETE SnapshotData FROM SnapshotData INNER JOIN #tempSnapshot
    ON SnapshotData.SnapshotDataID = #tempSnapshot.SnapshotDataID

    TRUNCATE TABLE #tempSnapshot

    INSERT INTO #tempSnapshot SELECT TOP 1 SnapshotDataID
    FROM [aapssrs01_ReportServerTempDB].dbo.SnapshotData  WITH (NOLOCK)
    where [aapssrs01_ReportServerTempDB].dbo.SnapshotData.PermanentRefcount <= 0
    AND [aapssrs01_ReportServerTempDB].dbo.SnapshotData.ExpirationDate < @now
    AND [aapssrs01_ReportServerTempDB].dbo.SnapshotData.Machine = @Machine
    SET @SnapshotsCleaned = @SnapshotsCleaned + @@ROWCOUNT

    SELECT @TempSnapshotID = (SELECT SnapshotDataID FROM #tempSnapshot)

    DELETE [aapssrs01_ReportServerTempDB].dbo.ChunkData FROM [aapssrs01_ReportServerTempDB].dbo.ChunkData INNER JOIN #tempSnapshot
    ON [aapssrs01_ReportServerTempDB].dbo.ChunkData.SnapshotDataID = #tempSnapshot.SnapshotDataID
    SET @ChunksCleaned = @ChunksCleaned + @@ROWCOUNT

    DELETE [aapssrs01_ReportServerTempDB].dbo.SnapshotData FROM [aapssrs01_ReportServerTempDB].dbo.SnapshotData INNER JOIN #tempSnapshot
    ON [aapssrs01_ReportServerTempDB].dbo.SnapshotData.SnapshotDataID = #tempSnapshot.SnapshotDataID
