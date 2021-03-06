USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[RemoveReportFromSession]    Script Date: 12/22/2020 5:44:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RemoveReportFromSession]
@SessionID as varchar(32),
@ReportPath as nvarchar(440),
@OwnerSid as varbinary(85) = NULL,
@OwnerName as nvarchar(260),
@AuthType as int
AS

DECLARE @OwnerID uniqueidentifier
EXEC GetUserID @OwnerSid, @OwnerName, @AuthType, @OwnerID OUTPUT

EXEC DereferenceSessionSnapshot @SessionID, @OwnerID

DELETE
   SE
FROM
   [aapssrs01_ReportServerTempDB].dbo.SessionData AS SE
WHERE
   SE.SessionID = @SessionID AND
   SE.ReportPath = @ReportPath AND
   SE.OwnerID = @OwnerID

DELETE FROM [aapssrs01_ReportServerTempDB].dbo.SessionLock WHERE SessionID=@SessionID

-- Delete any persisted streams associated with this session
UPDATE PS
SET
    PS.RefCount = 0,
    PS.ExpirationDate = GETDATE()
FROM
    [aapssrs01_ReportServerTempDB].dbo.PersistedStream AS PS
WHERE
    PS.SessionID = @SessionID
GO
