USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CleanHistoryForReport] Script Date: 12/21/2020 8:33:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- delete snapshots exceeding # of snapshots. won't work if @SnapshotLimit = 0
CREATE PROCEDURE [dbo].[CleanHistoryForReport]
@SnapshotLimit int,
@ReportID uniqueidentifier
AS
SET NOCOUNT OFF
DELETE FROM History
WHERE ReportID = @ReportID and SnapshotDate <
    (SELECT MIN(SnapshotDate)
     FROM
        (SELECT TOP (@SnapshotLimit) SnapshotDate
         FROM History
         WHERE ReportID = @ReportID
         ORDER BY SnapshotDate DESC
        ) AS TopSnapshots
    )
