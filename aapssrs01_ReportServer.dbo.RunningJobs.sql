USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[RunningJobs] Script Date: 12/21/2020 8:08:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RunningJobs] (
    [JobID]        NVARCHAR (32)    NOT NULL,
    [StartDate]    DATETIME         NOT NULL,
    [ComputerName] NVARCHAR (32)    NOT NULL,
    [RequestName]  NVARCHAR (425)   NOT NULL,
    [RequestPath]  NVARCHAR (425)   NOT NULL,
    [UserId]       UNIQUEIDENTIFIER NOT NULL,
    [Description]  NTEXT            NULL,
    [Timeout]      INT              NOT NULL,
    [JobAction]    SMALLINT         NOT NULL,
    [JobType]      SMALLINT         NOT NULL,
    [JobStatus]    SMALLINT         NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_RunningJobsStatus]
    ON [dbo].[RunningJobs]([ComputerName] ASC, [JobType] ASC);


GO
ALTER TABLE [dbo].[RunningJobs]
    ADD CONSTRAINT [PK_RunningJobs] PRIMARY KEY CLUSTERED ([JobID] ASC);


