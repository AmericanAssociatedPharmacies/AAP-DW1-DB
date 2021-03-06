USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[GetUserServiceToken]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserServiceToken]
@UserSid as varbinary(85) = NULL,
@UserName as nvarchar(260) = NULL,
@AuthType int
AS
BEGIN

DECLARE @UserID uniqueidentifier
EXEC GetUserID @UserSid, @UserName, @AuthType, @UserID OUTPUT

if (@UserID is not null)
	BEGIN
		SELECT ServiceToken FROM Users WHERE UserId = @UserID
	END
END
GO
