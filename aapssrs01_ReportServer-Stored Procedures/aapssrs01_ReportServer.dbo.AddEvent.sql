USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[AddEvent] Script Date: 12/21/2020 8:25:56 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddEvent]
@EventType nvarchar (260),
@EventData nvarchar (260)
AS

insert into [Event]
    ([EventID], [EventType], [EventData], [TimeEntered], [ProcessStart], [BatchID])
values
    (NewID(), @EventType, @EventData, GETUTCDATE(), NULL, NULL)
