USE [aapssrs01_ReportServer]
GO
/****** Object:  StoredProcedure [dbo].[GetCatalogItemContent]    Script Date: 12/22/2020 5:44:05 AM ******/
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
