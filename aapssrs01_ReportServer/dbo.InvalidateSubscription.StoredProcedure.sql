USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[InvalidateSubscription]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[InvalidateSubscription]
@SubscriptionID uniqueidentifier,
@Flags int,
@LastStatus nvarchar(260)
AS

-- Mark all subscriptions for this report as inactive for the given flags
update
    Subscriptions
set
    [InactiveFlags] = S.[InactiveFlags] | @Flags,
    [LastStatus] = @LastStatus
from
    Subscriptions S
where
    SubscriptionID = @SubscriptionID
GO
