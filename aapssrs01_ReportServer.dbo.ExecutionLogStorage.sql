USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ExecutionLogStorage] Script Date: 12/21/2020 8:04:09 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ExecutionLogStorage] (
    [LogEntryId]        BIGINT           IDENTITY (1, 1) NOT NULL,
    [InstanceName]      NVARCHAR (38)    NOT NULL,
    [ReportID]          UNIQUEIDENTIFIER NULL,
    [UserName]          NVARCHAR (260)   NULL,
    [ExecutionId]       NVARCHAR (64)    NULL,
    [RequestType]       TINYINT          NOT NULL,
    [Format]            NVARCHAR (26)    NULL,
    [Parameters]        NTEXT            NULL,
    [ReportAction]      TINYINT          NULL,
    [TimeStart]         DATETIME         NOT NULL,
    [TimeEnd]           DATETIME         NOT NULL,
    [TimeDataRetrieval] INT              NOT NULL,
    [TimeProcessing]    INT              NOT NULL,
    [TimeRendering]     INT              NOT NULL,
    [Source]            TINYINT          NOT NULL,
    [Status]            NVARCHAR (40)    NOT NULL,
    [ByteCount]         BIGINT           NOT NULL,
    [RowCount]          BIGINT           NOT NULL,
    [AdditionalInfo]    XML              NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ExecutionLog]
    ON [dbo].[ExecutionLogStorage]([TimeStart] ASC, [LogEntryId] ASC);

