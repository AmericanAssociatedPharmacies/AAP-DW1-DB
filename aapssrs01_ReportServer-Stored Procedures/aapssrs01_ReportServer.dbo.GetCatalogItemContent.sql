USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetCatalogItemContent] Script Date: 12/21/2020 9:00:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].GetCatalogItemContent
@CatalogItemID AS uniqueidentifier
AS

SELECT
    [Content]
FROM
    [Catalog]
WHERE
    [ItemID] = @CatalogItemID
