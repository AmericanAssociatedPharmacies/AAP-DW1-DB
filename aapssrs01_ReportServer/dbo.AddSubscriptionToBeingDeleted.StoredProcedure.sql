USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[AddSubscriptionToBeingDeleted]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddSubscriptionToBeingDeleted]
@SubscriptionID uniqueidentifier
AS
-- Delete subscription if it is already in this table
-- Delete orphaned subscriptions, based on the age criteria: > 10 minutes
delete from [SubscriptionsBeingDeleted]
where (SubscriptionID = @SubscriptionID) or (DATEDIFF( minute, [CreationDate], GetUtcDate() ) > 10)

-- Add subscription being deleted into the DeletedSubscription table
insert into [SubscriptionsBeingDeleted] VALUES(@SubscriptionID, GetUtcDate())
GO
