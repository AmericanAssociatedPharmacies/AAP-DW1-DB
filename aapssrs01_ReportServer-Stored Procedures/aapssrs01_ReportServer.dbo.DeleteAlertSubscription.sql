USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteAlertSubscription] Script Date: 12/21/2020 8:42:19 AM ******/
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
