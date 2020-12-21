USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteBatchRecords] Script Date: 12/21/2020 8:43:07 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteBatchRecords]
@BatchID uniqueidentifier
AS
SET NOCOUNT OFF
DELETE
FROM [Batch]
WHERE BatchID = @BatchID
