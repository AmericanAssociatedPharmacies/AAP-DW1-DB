USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DereferenceSessionSnapshot] Script Date: 12/21/2020 8:52:16 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DereferenceSessionSnapshot]
@SessionID as varchar(32),
@OwnerID as uniqueidentifier
AS

UPDATE SN
SET TransientRefcount = TransientRefcount - 1
FROM
   SnapshotData AS SN
   INNER JOIN [aapssrs01_ReportServerTempDB].dbo.SessionData AS SE ON SN.SnapshotDataID = SE.SnapshotDataID
WHERE
   SE.SessionID = @SessionID AND
   SE.OwnerID = @OwnerID

UPDATE SN
SET TransientRefcount = TransientRefcount - 1
FROM
   [aapssrs01_ReportServerTempDB].dbo.SnapshotData AS SN
   INNER JOIN [aapssrs01_ReportServerTempDB].dbo.SessionData AS SE ON SN.SnapshotDataID = SE.SnapshotDataID
WHERE
   SE.SessionID = @SessionID AND
   SE.OwnerID = @OwnerID
