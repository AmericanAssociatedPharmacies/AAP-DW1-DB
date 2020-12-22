USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[PromoteSnapshotInfo]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[PromoteSnapshotInfo]
@SnapshotDataID as uniqueidentifier,
@IsPermanentSnapshot as bit,
@PageCount as int,
@HasDocMap as bit,
@PaginationMode as smallint,
@ProcessingFlags as int
AS

-- HasDocMap: Processing engine may not
-- compute this flag in all cases, which
-- can lead to it being false when passed into
-- this proc, however the server needs this
-- flag to be true if it was ever set to be
-- true in order to communicate that there is a
-- document map to the viewer control.

IF @IsPermanentSnapshot = 1
BEGIN
   UPDATE SnapshotData SET
	PageCount = @PageCount,
	HasDocMap = COALESCE(@HasDocMap | HasDocMap, @HasDocMap),
	PaginationMode = @PaginationMode,
	ProcessingFlags = @ProcessingFlags
   WHERE SnapshotDataID = @SnapshotDataID
END ELSE BEGIN
   UPDATE [ReportServerTempDB].dbo.SnapshotData SET
	PageCount = @PageCount,
	HasDocMap = COALESCE(@HasDocMap | HasDocMap, @HasDocMap),
	PaginationMode = @PaginationMode,
	ProcessingFlags = @ProcessingFlags
   WHERE SnapshotDataID = @SnapshotDataID
END
GO
