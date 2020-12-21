USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[Subscriptions] Script Date: 12/21/2020 8:10:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Subscriptions] (
    [SubscriptionID]    UNIQUEIDENTIFIER NOT NULL,
    [OwnerID]           UNIQUEIDENTIFIER NOT NULL,
    [Report_OID]        UNIQUEIDENTIFIER NOT NULL,
    [Locale]            NVARCHAR (128)   NOT NULL,
    [InactiveFlags]     INT              NOT NULL,
    [ExtensionSettings] NTEXT            NULL,
    [ModifiedByID]      UNIQUEIDENTIFIER NOT NULL,
    [ModifiedDate]      DATETIME         NOT NULL,
    [Description]       NVARCHAR (512)   NULL,
    [LastStatus]        NVARCHAR (260)   NULL,
    [EventType]         NVARCHAR (260)   NOT NULL,
    [MatchData]         NTEXT            NULL,
    [LastRunTime]       DATETIME         NULL,
    [Parameters]        NTEXT            NULL,
    [DataSettings]      NTEXT            NULL,
    [DeliveryExtension] NVARCHAR (260)   NULL,
    [Version]           INT              NOT NULL,
    [ReportZone]        INT              NOT NULL
);


