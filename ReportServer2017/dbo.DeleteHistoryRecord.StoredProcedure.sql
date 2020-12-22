USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[DeleteHistoryRecord]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- delete one historical snapshot
CREATE PROCEDURE [dbo].[DeleteHistoryRecord]
@ReportID uniqueidentifier,
@SnapshotDate DateTime
AS
SET NOCOUNT OFF
DELETE
FROM History
WHERE ReportID = @ReportID AND SnapshotDate = @SnapshotDate
GO
