USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetUserSettings]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetUserSettings]
@UserSid as varbinary(85) = NULL,
@UserName as nvarchar(260) = NULL,
@AuthType int
AS
BEGIN

DECLARE @UserID uniqueidentifier
EXEC GetUserID @UserSid, @UserName, @AuthType, @UserID OUTPUT

if (@UserID is not null)
    BEGIN
        SELECT Setting FROM Users WHERE UserId = @UserID
    END
END
GO
