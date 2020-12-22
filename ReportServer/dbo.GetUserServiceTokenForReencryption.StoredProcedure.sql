USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[GetUserServiceTokenForReencryption]    Script Date: 12/22/2020 7:41:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetUserServiceTokenForReencryption]
@UserID as uniqueidentifier
AS

SELECT [ServiceToken]
FROM [dbo].[Users]
WHERE [UserID] = @UserID
GO
