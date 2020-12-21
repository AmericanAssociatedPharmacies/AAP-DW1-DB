USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[AddItemToFavorites] Script Date: 12/21/2020 8:26:35 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddItemToFavorites]
@ItemID uniqueidentifier,
@UserName nvarchar (425),
@UserSid varbinary(85) = NULL,
@AuthType int
AS

DECLARE @UserID uniqueidentifier
EXEC GetUserID @UserSid, @UserName, @AuthType, @UserID OUTPUT

IF NOT EXISTS (SELECT UserID FROM [Favorites] WHERE UserID = @UserID AND ItemID = @ItemID)
BEGIN
    INSERT INTO [dbo].[Favorites] (ItemID, UserID) VALUES (@ItemID, @UserID)
END
