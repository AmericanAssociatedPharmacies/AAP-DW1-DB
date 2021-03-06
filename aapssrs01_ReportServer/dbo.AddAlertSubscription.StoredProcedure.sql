USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[AddAlertSubscription]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddAlertSubscription]
    @UserID uniqueidentifier,
    @ItemID uniqueidentifier,
    @AlertType nvarchar(50)
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM AlertSubscribers WHERE
    UserID = @UserID AND
    ItemID = @ItemID AND
    AlertType = @AlertType) BEGIN
        INSERT
        INTO [AlertSubscribers] (UserID, ItemID, AlertType)
        VALUES (@UserID, @ItemID, @AlertType)
    END
END
GO
