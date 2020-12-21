USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteHistoryRecordByHistoryId] Script Date: 12/21/2020 8:45:30 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

-- delete one historical snapshot by history id
CREATE PROCEDURE [dbo].[DeleteHistoryRecordByHistoryId]
@ReportID uniqueidentifier,
@HistoryId uniqueidentifier
AS
SET NOCOUNT OFF
DELETE
FROM History
WHERE ReportID = @ReportID AND HistoryId = @HistoryId
