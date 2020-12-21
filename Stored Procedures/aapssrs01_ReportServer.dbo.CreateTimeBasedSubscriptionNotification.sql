USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CreateTimeBasedSubscriptionNotification] Script Date: 12/21/2020 8:40:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateTimeBasedSubscriptionNotification]
@SubscriptionID uniqueidentifier,
@LastRunTime datetime,
@LastStatus nvarchar(260)
as

insert into [Notifications]
    (
    [NotificationID],
    [SubscriptionID],
    [ActivationID],
    [ReportID],
    [ReportZone],
    [SnapShotDate],
    [ExtensionSettings],
    [Locale],
    [Parameters],
    [NotificationEntered],
    [SubscriptionLastRunTime],
    [DeliveryExtension],
    [SubscriptionOwnerID],
    [IsDataDriven],
    [Version]
    )
select
    NewID(),
    S.[SubscriptionID],
    NULL,
    S.[Report_OID],
    S.[ReportZone],
    NULL,
    S.[ExtensionSettings],
    S.[Locale],
    S.[Parameters],
    GETUTCDATE(),
    @LastRunTime,
    S.[DeliveryExtension],
    S.[OwnerID],
    0,
    S.[Version]
from
    [Subscriptions] S
where
    S.[SubscriptionID] = @SubscriptionID and InactiveFlags = 0 and
    S.[DataSettings] is null


-- Create any data driven subscription by creating a data driven event
insert into [Event]
    (
    [EventID],
    [EventType],
    [EventData],
    [TimeEntered]
    )
select
    NewID(),
    'DataDrivenSubscription',
    S.SubscriptionID,
    GETUTCDATE()
from
    [Subscriptions] S
where
    S.[SubscriptionID] = @SubscriptionID and InactiveFlags = 0 and
    S.[DataSettings] is not null

update [Subscriptions]
set
    [LastRunTime] = @LastRunTime,
    [LastStatus] = @LastStatus
where
    [SubscriptionID] = @SubscriptionID and InactiveFlags = 0
