USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[FlushCacheByID]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[FlushCacheByID]
@ItemID as uniqueidentifier
AS
BEGIN

DECLARE @AffectedSnapshots table (SnapshotDataID uniqueidentifier)

DELETE FROM [aapssrs01_ReportServerTempDB].dbo.ExecutionCache
OUTPUT DELETED.SnapshotDataID into @AffectedSnapshots
WHERE ReportID = @ItemID

UPDATE [aapssrs01_ReportServerTempDB].dbo.SnapshotData
SET PermanentRefcount = PermanentRefcount - 1
WHERE SnapshotDataID IN (SELECT SnapshotDataID FROM @AffectedSnapshots)

END
GO
