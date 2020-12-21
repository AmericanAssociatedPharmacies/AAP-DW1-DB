USE [aapssrs01_ReportServer]
GO

/****** Object: Table [dbo].[SubscriptionResults] Script Date: 12/21/2020 8:10:32 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[SubscriptionResults] (
    [SubscriptionResultID]  UNIQUEIDENTIFIER NOT NULL,
    [SubscriptionID]        UNIQUEIDENTIFIER NOT NULL,
    [ExtensionSettingsHash] INT              NOT NULL,
    [ExtensionSettings]     NVARCHAR (MAX)   NOT NULL,
    [SubscriptionResult]    NVARCHAR (260)   NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_SubscriptionResults]
    ON [dbo].[SubscriptionResults]([SubscriptionID] ASC, [ExtensionSettingsHash] ASC);


GO
ALTER TABLE [dbo].[SubscriptionResults]
    ADD CONSTRAINT [PK_SubscriptionResults] PRIMARY KEY CLUSTERED ([SubscriptionResultID] ASC);


GO
ALTER TABLE [dbo].[SubscriptionResults]
    ADD CONSTRAINT [FK_SubscriptionResults_Subscriptions] FOREIGN KEY ([SubscriptionID]) REFERENCES [dbo].[Subscriptions] ([SubscriptionID]) ON DELETE CASCADE;


