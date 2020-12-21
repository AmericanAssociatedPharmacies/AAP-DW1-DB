USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[CleanupLock] Script Date: 12/21/2020 8:02:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[CleanupLock] (
    [ID]          INT            NOT NULL,
    [MachineName] NVARCHAR (256) NULL,
    [LockDate]    DATETIME       NOT NULL
);


