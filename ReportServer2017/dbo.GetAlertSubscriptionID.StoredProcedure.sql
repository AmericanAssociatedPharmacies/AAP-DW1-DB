USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetAlertSubscriptionID]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlertSubscriptionID]
@UserID uniqueidentifier,
@ItemID uniqueidentifier,
@AlertType nvarchar(50)
AS
BEGIN
    SELECT
        AlertSubscriptionID
    FROM [AlertSubscribers]
    WHERE
        UserID = @UserID AND
        ItemID = @ItemID AND
        AlertType = @AlertType
END
GO
