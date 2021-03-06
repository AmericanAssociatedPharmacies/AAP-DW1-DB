USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetCatalogItemProperties]    Script Date: 12/22/2020 7:43:21 AM ******/
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
GO
