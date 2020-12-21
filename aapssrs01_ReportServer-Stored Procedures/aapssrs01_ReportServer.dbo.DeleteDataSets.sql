USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteDataSets] Script Date: 12/21/2020 8:43:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteDataSets]
@ItemID [uniqueidentifier]
AS
DELETE
FROM [DataSets]
WHERE [ItemID] = @ItemID
DELETE
FROM [aapssrs01_ReportServerTempDB].dbo.TempDataSets
WHERE [ItemID] = @ItemID
