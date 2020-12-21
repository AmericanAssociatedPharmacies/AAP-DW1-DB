USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[GetContentCache] Script Date: 12/21/2020 9:08:42 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetContentCache]
    @CatalogItemID uniqueidentifier,
    @ParamsHash int,
    @ContentType nvarchar(256)
AS
BEGIN
    DECLARE @now as DateTime
    SET @now = GETDATE()

    SELECT ContentCacheID, CatalogItemID, CreatedDate, ParamsHash, ExpirationDate, Version, ContentType, Content
    FROM [aapssrs01_ReportServerTempDB].dbo.ContentCache WITH (NOLOCK)
    WHERE
        CatalogItemID = @CatalogItemID
        AND ParamsHash = @ParamsHash
        AND ContentType = @ContentType
        AND ExpirationDate > @now
END
