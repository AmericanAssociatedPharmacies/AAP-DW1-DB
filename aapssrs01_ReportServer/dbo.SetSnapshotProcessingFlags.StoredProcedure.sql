USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[SetSnapshotProcessingFlags]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetSnapshotProcessingFlags]
@SnapshotDataID as uniqueidentifier,
@IsPermanentSnapshot as bit,
@ProcessingFlags int
AS

if @IsPermanentSnapshot = 1
BEGIN
    UPDATE SnapshotData
    SET ProcessingFlags = @ProcessingFlags
    WHERE SnapshotDataID = @SnapshotDataID
END ELSE BEGIN
    UPDATE [aapssrs01_ReportServerTempDB].dbo.SnapshotData
    SET ProcessingFlags = @ProcessingFlags
    WHERE SnapshotDataID = @SnapshotDataID
END
GO
