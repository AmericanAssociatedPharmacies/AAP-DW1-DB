USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[ClearSessionSnapshot] Script Date: 12/21/2020 8:34:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ClearSessionSnapshot]
@SessionID as varchar(32),
@OwnerSid as varbinary(85) = NULL,
@OwnerName as nvarchar(260),
@AuthType as int,
@Expiration as datetime
AS

DECLARE @OwnerID uniqueidentifier
EXEC GetUserID @OwnerSid, @OwnerName, @AuthType, @OwnerID OUTPUT

EXEC DereferenceSessionSnapshot @SessionID, @OwnerID

UPDATE SE
SET
   SE.SnapshotDataID = null,
   SE.IsPermanentSnapshot = null,
   SE.SnapshotExpirationDate = null,
   SE.ShowHideInfo = null,
   SE.HasInteractivity = null,
   SE.AutoRefreshSeconds = null,
   SE.Expiration = @Expiration
FROM
   [aapssrs01_ReportServerTempDB].dbo.SessionData AS SE
WHERE
   SE.SessionID = @SessionID AND
   SE.OwnerID = @OwnerID
