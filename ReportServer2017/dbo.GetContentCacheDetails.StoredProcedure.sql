USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[GetContentCacheDetails]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetContentCacheDetails]
    @CatalogItemID uniqueidentifier,
    @ParamsHash int,
    @ContentType nvarchar(256)
AS
BEGIN
    DECLARE @now as DateTime
    SET @now = GETDATE()

    SELECT ContentCacheID, CatalogItemID, CreatedDate, ParamsHash, EffectiveParams, ExpirationDate, Version, ContentType
    FROM [ReportServer2017TempDB].dbo.ContentCache WITH (NOLOCK)
    WHERE
        CatalogItemID = @CatalogItemID
        AND ParamsHash = @ParamsHash
        AND ContentType = @ContentType
        AND ExpirationDate > @now
END
GO
