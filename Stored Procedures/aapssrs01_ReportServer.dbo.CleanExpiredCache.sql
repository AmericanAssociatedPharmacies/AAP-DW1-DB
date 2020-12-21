USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CleanExpiredCache] Script Date: 12/21/2020 8:31:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CleanExpiredCache]
AS
SET NOCOUNT OFF
DECLARE @now as datetime
SET @now = DATEADD(minute, -1, GETDATE())

UPDATE SN
SET
   PermanentRefcount = PermanentRefcount - 1
FROM
   [aapssrs01_ReportServerTempDB].dbo.SnapshotData AS SN
   INNER JOIN [aapssrs01_ReportServerTempDB].dbo.ExecutionCache AS EC ON SN.SnapshotDataID = EC.SnapshotDataID
WHERE
   EC.AbsoluteExpiration < @now

DELETE EC
FROM
   [aapssrs01_ReportServerTempDB].dbo.ExecutionCache AS EC
WHERE
   EC.AbsoluteExpiration < @now
