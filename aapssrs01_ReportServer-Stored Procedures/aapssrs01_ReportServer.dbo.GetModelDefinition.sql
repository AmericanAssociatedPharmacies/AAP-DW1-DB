USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetModelDefinition] Script Date: 12/21/2020 9:13:59 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetModelDefinition]
@CatalogItemID as uniqueidentifier
AS

SELECT
    C.[Content]
FROM
    [Catalog] AS C
WHERE
    C.[ItemID] = @CatalogItemID
