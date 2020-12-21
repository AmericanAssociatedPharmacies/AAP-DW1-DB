USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[ActiveSubscriptions] Script Date: 12/21/2020 7:31:40 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[ActiveSubscriptions] (
    [ActiveID]           UNIQUEIDENTIFIER NOT NULL,
    [SubscriptionID]     UNIQUEIDENTIFIER NOT NULL,
    [TotalNotifications] INT              NULL,
    [TotalSuccesses]     INT              NOT NULL,
    [TotalFailures]      INT              NOT NULL
);


