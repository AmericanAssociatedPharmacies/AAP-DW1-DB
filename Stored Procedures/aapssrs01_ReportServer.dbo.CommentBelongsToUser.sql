USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CommentBelongsToUser] Script Date: 12/21/2020 8:34:27 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CommentBelongsToUser]
@CommentID bigint,
@UserSid varbinary(85),
@UserName nvarchar(260),
@AuthType int
AS
BEGIN
    DECLARE @CommentOwner uniqueidentifier
    DECLARE @CurrentUser uniqueidentifier
    EXEC GetUserID @UserSid, @UserName, @AuthType, @CurrentUser OUTPUT
    SET @CommentOwner = (SELECT TOP(1) [UserID] FROM [Comments] WHERE [CommentID] = @CommentID)
    IF @CommentOwner = @CurrentUser
        SELECT 1
    ELSE
        SELECT 0
END
