USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[PollEventsForRSProcess]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[PollEventsForRSProcess]
    @NumberOfEvents AS INTEGER
AS

DECLARE @BatchID UNIQUEIDENTIFIER
SET @BatchID = NEWID()

UPDATE [Event] WITH (TABLOCKX)
    SET [BatchID] = @BatchID,
    [ProcessStart] = GETUTCDATE(),
    [ProcessHeartbeat] = GETUTCDATE()
FROM (
    SELECT TOP (@NumberOfEvents) [EventID]
    FROM [Event] WITH (TABLOCKX)
    WHERE [ProcessStart] is NULL AND [EventType] <> 'DataModelRefresh'
    ORDER BY [TimeEntered]
    ) AS t1
WHERE [Event].[EventID] = t1.[EventID]

SELECT TOP (@NumberOfEvents)
    E.[EventID],
    E.[EventType],
    E.[EventData]
FROM
    [Event] E WITH (TABLOCKX)
WHERE
    [BatchID] = @BatchID
    AND [EventType] <> 'DataModelRefresh'
ORDER BY [TimeEntered]
GO
