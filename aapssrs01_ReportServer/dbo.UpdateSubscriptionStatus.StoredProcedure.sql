USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[UpdateSubscriptionStatus]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSubscriptionStatus]
@SubscriptionID uniqueidentifier,
@Status nvarchar(260)
AS

update Subscriptions set
        [LastStatus] = @Status
where
    [SubscriptionID] = @SubscriptionID
GO
