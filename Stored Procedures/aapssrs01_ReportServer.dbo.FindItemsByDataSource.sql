USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[FindItemsByDataSource] Script Date: 12/21/2020 8:53:43 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FindItemsByDataSource]
@ItemID uniqueidentifier,
@AuthType int
AS
SELECT
    C.Type,
    C.PolicyID,
    SD.NtSecDescPrimary,
    C.Name,
    C.Path,
    C.ItemID,
    DATALENGTH( C.Content ) AS [Size],
    C.Description,
    C.CreationDate,
    C.ModifiedDate,
    CU.UserName,
    CU.UserName,
    MU.UserName,
    MU.UserName,
    C.MimeType,
    C.ExecutionTime,
    C.Hidden,
    C.SubType,
    C.ComponentID
FROM
   Catalog AS C
   INNER JOIN Users AS CU ON C.CreatedByID = CU.UserID
   INNER JOIN Users AS MU ON C.ModifiedByID = MU.UserID
   LEFT OUTER JOIN SecData AS SD ON C.PolicyID = SD.PolicyID AND SD.AuthType = @AuthType
   INNER JOIN DataSource AS DS ON C.ItemID = DS.ItemID
WHERE
   DS.Link = @ItemID
