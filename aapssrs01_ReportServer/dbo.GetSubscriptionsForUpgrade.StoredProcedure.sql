USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[GetSubscriptionsForUpgrade]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetSubscriptionsForUpgrade]
@CurrentVersion int
AS
SELECT
    [SubscriptionID]
FROM
    [Subscriptions]
WHERE
    [Version] != @CurrentVersion
GO
