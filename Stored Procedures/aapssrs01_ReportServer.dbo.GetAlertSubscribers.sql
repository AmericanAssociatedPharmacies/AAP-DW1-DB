USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetAlertSubscribers] Script Date: 12/21/2020 8:57:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAlertSubscribers]
    @ItemID uniqueidentifier,
    @AlertType nvarchar(50)
AS
BEGIN
    SELECT
        U.[DefaultEmailAddress]
    FROM
        [AlertSubscribers] as A
        INNER JOIN UserContactInfo as U ON A.[UserID] = U.[UserID]
    WHERE
        A.[ItemID] = @ItemID
        AND
        A.[AlertType] = @AlertType
END
