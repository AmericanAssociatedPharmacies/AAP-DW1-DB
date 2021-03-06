USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[SetReencryptedUserServiceToken]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SetReencryptedUserServiceToken]
@UserID uniqueidentifier,
@ServiceToken ntext
AS

UPDATE [dbo].[Users]
SET [ServiceToken] = @ServiceToken
WHERE [UserID] = @UserID
GO
