USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CleanBatchRecords] Script Date: 12/21/2020 8:31:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CleanBatchRecords]
@MaxAgeMinutes int
AS
SET NOCOUNT OFF
DELETE FROM [Batch]
where BatchID in
   ( SELECT BatchID
     FROM [Batch]
     WHERE AddedOn < DATEADD(minute, -(@MaxAgeMinutes), GETUTCDATE()) )
