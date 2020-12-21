USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CleanExpiredContentCache] Script Date: 12/21/2020 8:32:01 AM ******/
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
       [aapssrs01_ReportServerTempDB].dbo.[ContentCache]
    WHERE
       ExpirationDate < @now

    SELECT @@ROWCOUNT
