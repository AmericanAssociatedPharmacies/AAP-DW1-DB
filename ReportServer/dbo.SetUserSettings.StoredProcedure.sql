USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[SetUserSettings]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- set user properties on user account
CREATE PROCEDURE [dbo].[SetUserSettings]
@Setting ntext,
@UserSid as varbinary(85) = NULL,
@UserName as nvarchar(260) = NULL,
@AuthType int
AS
BEGIN
DECLARE @UserID uniqueidentifier
EXEC GetUserID @UserSid, @UserName, @AuthType, @UserID OUTPUT

IF (@UserID is not null)
	BEGIN
		UPDATE Users
		SET Setting = @Setting
		WHERE UserID = @UserID
	END
END
GO
