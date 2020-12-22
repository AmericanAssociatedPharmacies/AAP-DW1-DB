USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[DeleteAlertSubscription]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAlertSubscription]
    @AlertSubscriptionID bigint
AS
BEGIN
    DELETE FROM [AlertSubscribers] WHERE
    AlertSubscriptionID = @AlertSubscriptionID
END
GO
