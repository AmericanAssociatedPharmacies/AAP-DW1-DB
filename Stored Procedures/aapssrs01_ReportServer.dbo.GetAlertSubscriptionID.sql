USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetAlertSubscriptionID] Script Date: 12/21/2020 8:58:01 AM ******/
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
