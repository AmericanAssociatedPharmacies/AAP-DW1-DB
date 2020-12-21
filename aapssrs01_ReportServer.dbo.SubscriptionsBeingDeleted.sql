USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[SubscriptionsBeingDeleted] Script Date: 12/21/2020 8:11:01 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SubscriptionsBeingDeleted] (
    [SubscriptionID] UNIQUEIDENTIFIER NOT NULL,
    [CreationDate]   DATETIME         NOT NULL
);


