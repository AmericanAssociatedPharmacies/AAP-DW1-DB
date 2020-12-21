USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Event] Script Date: 12/21/2020 8:03:55 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Event] (
    [EventID]          UNIQUEIDENTIFIER NOT NULL,
    [EventType]        NVARCHAR (260)   NOT NULL,
    [EventData]        NVARCHAR (260)   NULL,
    [TimeEntered]      DATETIME         NOT NULL,
    [ProcessStart]     DATETIME         NULL,
    [ProcessHeartbeat] DATETIME         NULL,
    [BatchID]          UNIQUEIDENTIFIER NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_Event2]
    ON [dbo].[Event]([ProcessStart] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Event_TimeEntered]
    ON [dbo].[Event]([TimeEntered] ASC);


GO
ALTER TABLE [dbo].[Event]
    ADD CONSTRAINT [PK_Event] PRIMARY KEY CLUSTERED ([EventID] ASC);


