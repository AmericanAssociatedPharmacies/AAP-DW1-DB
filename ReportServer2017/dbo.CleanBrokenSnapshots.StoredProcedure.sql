USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[CleanBrokenSnapshots]    Script Date: 12/22/2020 7:43:21 AM ******/
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
    FROM [ReportServer2017TempDB].dbo.SnapshotData  WITH (NOLOCK)
    where [ReportServer2017TempDB].dbo.SnapshotData.PermanentRefcount <= 0
    AND [ReportServer2017TempDB].dbo.SnapshotData.ExpirationDate < @now
    AND [ReportServer2017TempDB].dbo.SnapshotData.Machine = @Machine
    SET @SnapshotsCleaned = @SnapshotsCleaned + @@ROWCOUNT

    SELECT @TempSnapshotID = (SELECT SnapshotDataID FROM #tempSnapshot)

    DELETE [ReportServer2017TempDB].dbo.ChunkData FROM [ReportServer2017TempDB].dbo.ChunkData INNER JOIN #tempSnapshot
    ON [ReportServer2017TempDB].dbo.ChunkData.SnapshotDataID = #tempSnapshot.SnapshotDataID
    SET @ChunksCleaned = @ChunksCleaned + @@ROWCOUNT

    DELETE [ReportServer2017TempDB].dbo.SnapshotData FROM [ReportServer2017TempDB].dbo.SnapshotData INNER JOIN #tempSnapshot
    ON [ReportServer2017TempDB].dbo.SnapshotData.SnapshotDataID = #tempSnapshot.SnapshotDataID
GO
