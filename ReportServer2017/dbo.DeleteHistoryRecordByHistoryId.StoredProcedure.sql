USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[DeleteHistoryRecordByHistoryId]    Script Date: 12/22/2020 7:43:21 AM ******/
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
GO
