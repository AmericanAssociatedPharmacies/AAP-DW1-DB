USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetCatalogItemContent]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCatalogItemContent]
@CatalogItemID AS uniqueidentifier
AS

SELECT
    [Content]
FROM
    [Catalog]
WHERE
    [ItemID] = @CatalogItemID
GO
