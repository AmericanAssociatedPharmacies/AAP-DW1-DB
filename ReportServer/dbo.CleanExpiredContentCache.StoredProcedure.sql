USE [ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[CleanExpiredContentCache]    Script Date: 12/22/2020 7:41:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CleanExpiredContentCache]
AS
SET DEADLOCK_PRIORITY LOW
SET NOCOUNT ON
DECLARE @now as datetime

SET @now = DATEADD(minute, -1, GETDATE())

DELETE
FROM
   [ReportServerTempDB].dbo.[ContentCache]
WHERE
   ExpirationDate < @now

SELECT @@ROWCOUNT
GO
