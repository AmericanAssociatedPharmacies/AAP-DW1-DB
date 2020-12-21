USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Notifications] Script Date: 12/21/2020 8:07:20 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Notifications] (
    [NotificationID]          UNIQUEIDENTIFIER NOT NULL,
    [SubscriptionID]          UNIQUEIDENTIFIER NOT NULL,
    [ActivationID]            UNIQUEIDENTIFIER NULL,
    [ReportID]                UNIQUEIDENTIFIER NOT NULL,
    [SnapShotDate]            DATETIME         NULL,
    [ExtensionSettings]       NTEXT            NOT NULL,
    [Locale]                  NVARCHAR (128)   NOT NULL,
    [Parameters]              NTEXT            NULL,
    [ProcessStart]            DATETIME         NULL,
    [NotificationEntered]     DATETIME         NOT NULL,
    [ProcessAfter]            DATETIME         NULL,
    [Attempt]                 INT              NULL,
    [SubscriptionLastRunTime] DATETIME         NOT NULL,
    [DeliveryExtension]       NVARCHAR (260)   NOT NULL,
    [SubscriptionOwnerID]     UNIQUEIDENTIFIER NOT NULL,
    [IsDataDriven]            BIT              NOT NULL,
    [BatchID]                 UNIQUEIDENTIFIER NULL,
    [ProcessHeartbeat]        DATETIME         NULL,
    [Version]                 INT              NOT NULL,
    [ReportZone]              INT              NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_Notifications]
    ON [dbo].[Notifications]([ProcessAfter] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Notifications2]
    ON [dbo].[Notifications]([ProcessStart] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_Notifications3]
    ON [dbo].[Notifications]([NotificationEntered] ASC);


GO
ALTER TABLE [dbo].[Notifications]
    ADD CONSTRAINT [PK_Notifications] PRIMARY KEY CLUSTERED ([NotificationID] ASC);


GO
ALTER TABLE [dbo].[Notifications]
    ADD CONSTRAINT [FK_Notifications_Subscriptions] FOREIGN KEY ([SubscriptionID]) REFERENCES [dbo].[Subscriptions] ([SubscriptionID]) ON DELETE CASCADE;


