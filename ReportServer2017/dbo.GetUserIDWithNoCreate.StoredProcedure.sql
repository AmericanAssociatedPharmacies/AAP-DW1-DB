USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetUserIDWithNoCreate]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserIDWithNoCreate]
@UserSid varbinary(85) = NULL,
@UserName nvarchar(260),
@AuthType int,
@UserID uniqueidentifier OUTPUT
AS
    IF @AuthType = 1 -- Windows
    BEGIN
        SELECT @UserID = (SELECT UserID FROM Users WHERE Sid = @UserSid AND AuthType = @AuthType)
    END
    ELSE
    BEGIN
        SELECT @UserID = (SELECT UserID FROM Users WHERE UserName = @UserName AND AuthType = @AuthType)
    END
GO
