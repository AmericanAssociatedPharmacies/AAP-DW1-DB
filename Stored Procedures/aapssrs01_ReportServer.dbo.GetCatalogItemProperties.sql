USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetCatalogItemProperties] Script Date: 12/21/2020 9:01:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetCatalogItemProperties]
@CatalogItemID AS uniqueidentifier
AS

SELECT
   [ItemID] AS [ItemId],
   [Path],
   [Name],
   [Type],
   DATALENGTH(Content) AS [SizeInBytes],
   C.[UserName] AS [CreatorUserName],
   [CreationDate],
   M.[UserName] AS [ModifierUserName],
   [Catalog].[ModifiedDate],
   [MimeType],
   [Hidden]
FROM
    [Catalog]
    INNER JOIN Users C ON [Catalog].CreatedByID = C.UserID
    INNER JOIN Users M ON [Catalog].ModifiedByID = M.UserID
WHERE
    [ItemID] = @CatalogItemID
