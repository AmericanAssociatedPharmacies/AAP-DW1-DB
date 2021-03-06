USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[SetDefaultEmail]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetDefaultEmail]
    @UserID uniqueidentifier,
    @DefaultEmailAddress nvarchar(256)
AS
BEGIN
    IF EXISTS (SELECT * FROM UserContactInfo WHERE UserID = @UserID) BEGIN
        UPDATE UserContactInfo SET
        DefaultEmailAddress = @DefaultEmailAddress
        WHERE UserID=@UserID
    END ELSE BEGIN
        INSERT
        INTO [UserContactInfo] (UserID, DefaultEmailAddress)
        VALUES (@UserID, @DefaultEmailAddress)
    END
END
GO
