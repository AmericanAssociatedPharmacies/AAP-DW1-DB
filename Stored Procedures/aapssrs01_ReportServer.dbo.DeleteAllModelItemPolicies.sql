USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeleteAllModelItemPolicies] Script Date: 12/21/2020 8:42:48 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteAllModelItemPolicies]
@Path as nvarchar(450)
AS

DELETE Policies
FROM
   Policies AS P
   INNER JOIN ModelItemPolicy AS MIP ON P.PolicyID = MIP.PolicyID
   INNER JOIN Catalog AS C ON MIP.CatalogItemID = C.ItemID
WHERE
   C.[Path] = @Path
