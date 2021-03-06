USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[UpdateSnapshotPaginationInfo]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSnapshotPaginationInfo]
@SnapshotDataID as uniqueidentifier,
@IsPermanentSnapshot as bit,
@PageCount as int,
@PaginationMode as smallint
AS
IF @IsPermanentSnapshot = 1
BEGIN
   UPDATE SnapshotData SET
    PageCount = @PageCount,
    PaginationMode = @PaginationMode
   WHERE SnapshotDataID = @SnapshotDataID
END ELSE BEGIN
   UPDATE [ReportServer2017TempDB].dbo.SnapshotData SET
    PageCount = @PageCount,
    PaginationMode = @PaginationMode
   WHERE SnapshotDataID = @SnapshotDataID
END
GO
