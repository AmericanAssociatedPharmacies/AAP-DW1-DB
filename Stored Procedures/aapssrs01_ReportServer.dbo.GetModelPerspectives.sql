USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetModelPerspectives] Script Date: 12/21/2020 9:14:22 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetModelPerspectives]
@Path nvarchar (425),
@AuthType int
AS

SELECT
    C.[Type],
    SD.[NtSecDescPrimary],
    C.[Description]
FROM
    [Catalog] as C
    LEFT OUTER JOIN [SecData] AS SD ON C.[PolicyID] = SD.[PolicyID] AND SD.[AuthType] = @AuthType
WHERE
    [Path] = @Path

SELECT
    P.[PerspectiveID],
    P.[PerspectiveName],
    P.[PerspectiveDescription]
FROM
    [Catalog] as C
    INNER JOIN [ModelPerspective] as P ON C.[ItemID] = P.[ModelID]
WHERE
    [Path] = @Path
