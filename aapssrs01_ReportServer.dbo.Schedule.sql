USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Schedule] Script Date: 12/21/2020 8:08:57 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Schedule] (
    [ScheduleID]          UNIQUEIDENTIFIER NOT NULL,
    [Name]                NVARCHAR (260)   NOT NULL,
    [StartDate]           DATETIME         NOT NULL,
    [Flags]               INT              NOT NULL,
    [NextRunTime]         DATETIME         NULL,
    [LastRunTime]         DATETIME         NULL,
    [EndDate]             DATETIME         NULL,
    [RecurrenceType]      INT              NULL,
    [MinutesInterval]     INT              NULL,
    [DaysInterval]        INT              NULL,
    [WeeksInterval]       INT              NULL,
    [DaysOfWeek]          INT              NULL,
    [DaysOfMonth]         INT              NULL,
    [Month]               INT              NULL,
    [MonthlyWeek]         INT              NULL,
    [State]               INT              NULL,
    [LastRunStatus]       NVARCHAR (260)   NULL,
    [ScheduledRunTimeout] INT              NULL,
    [CreatedById]         UNIQUEIDENTIFIER NOT NULL,
    [EventType]           NVARCHAR (260)   NOT NULL,
    [EventData]           NVARCHAR (260)   NULL,
    [Type]                INT              NOT NULL,
    [ConsistancyCheck]    DATETIME         NULL,
    [Path]                NVARCHAR (260)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ScheduleForListTask]
    ON [dbo].[Schedule]([Type] ASC, [Path] ASC, [CreatedById] ASC)
    INCLUDE([Name], [StartDate], [Flags], [NextRunTime], [LastRunTime], [EndDate], [RecurrenceType], [MinutesInterval], [DaysInterval], [WeeksInterval], [DaysOfWeek], [DaysOfMonth], [Month], [MonthlyWeek], [State], [LastRunStatus], [ScheduledRunTimeout], [EventType], [EventData]);


GO
ALTER TABLE [dbo].[Schedule]
    ADD CONSTRAINT [PK_ScheduleID] PRIMARY KEY CLUSTERED ([ScheduleID] ASC);


GO
ALTER TABLE [dbo].[Schedule]
    ADD CONSTRAINT [IX_Schedule] UNIQUE NONCLUSTERED ([Name] ASC, [Path] ASC);


GO
ALTER TABLE [dbo].[Schedule]
    ADD CONSTRAINT [FK_Schedule_Users] FOREIGN KEY ([CreatedById]) REFERENCES [dbo].[Users] ([UserID]);


