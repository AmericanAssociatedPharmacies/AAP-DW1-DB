USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetAllProperties] Script Date: 12/21/2020 8:59:05 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetAllProperties]
@Path nvarchar (425),
@EditSessionID varchar(32) = NULL,
@OwnerSid as varbinary(85) = NULL,
@OwnerName as nvarchar(260) = NULL,
@AuthType int
AS
BEGIN

DECLARE @OwnerID uniqueidentifier
if(@EditSessionID is not null)
BEGIN
    EXEC GetUserID @OwnerSid, @OwnerName, @AuthType, @OwnerID OUTPUT
END

select
   iif( Catalog.LinkSourceID is null, Catalog.Property, Linked.Property) as Property, 
   Catalog.Description,
   Catalog.Type,
   DATALENGTH( Catalog.Content ),
   Catalog.ItemID,
   C.UserName,
   C.UserName,
   Catalog.CreationDate,
   M.UserName,
   M.UserName,
   Catalog.ModifiedDate,
   Catalog.MimeType,
   Catalog.ExecutionTime,
   SecData.NtSecDescPrimary,
   Catalog.LinkSourceID,
   Catalog.Hidden,
   Catalog.ExecutionFlag,
   Catalog.SnapshotLimit,
   Catalog.Name,
   Catalog.SubType,
   Catalog.ComponentID
FROM ExtendedCatalog(@OwnerID, @Path, @EditSessionID) Catalog
   INNER JOIN Users C ON Catalog.CreatedByID = C.UserID
   INNER JOIN Users M ON Catalog.ModifiedByID = M.UserID
   LEFT OUTER JOIN SecData ON Catalog.PolicyID = SecData.PolicyID AND SecData.AuthType = @AuthType
   LEFT OUTER JOIN Catalog Linked ON Linked.ItemID = Catalog.LinkSourceID
END
