USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteDataSources] Script Date: 12/21/2020 8:43:47 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteDataSources]
@ItemID [uniqueidentifier]
AS

DELETE
FROM [DataSource]
WHERE [ItemID] = @ItemID or [SubscriptionID] = @ItemID
DELETE
FROM [aapssrs01_ReportServerTempDB].dbo.TempDataSources
WHERE [ItemID] = @ItemID
