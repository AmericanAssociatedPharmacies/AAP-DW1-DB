USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetBatchRecords] Script Date: 12/21/2020 9:00:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetBatchRecords]
@BatchID uniqueidentifier
AS
SELECT [Action], Item, Parent, Param, BoolParam, Content, Properties
FROM [Batch]
WHERE BatchID = @BatchID
ORDER BY AddedOn
