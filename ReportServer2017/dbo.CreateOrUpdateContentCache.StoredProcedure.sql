USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[CreateOrUpdateContentCache]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CreateOrUpdateContentCache]
    @CatalogItemID uniqueidentifier,
    @ParamsHash int,
    @EffectiveParams nvarchar(max),
    @ContentType nvarchar(256),
    @Version smallint,
    @Content varbinary(max)
AS
BEGIN
    DECLARE @ExpirationDate as DateTime
    SET @ExpirationDate = NULL

    SELECT TOP 1 @ExpirationDate = AbsoluteExpiration
    FROM
        [ReportServer2017TempDB].dbo.[ExecutionCache]
    WHERE
        ReportId = @CatalogItemID AND
        ParamsHash = @ParamsHash
    ORDER BY AbsoluteExpiration DESC

    BEGIN TRANSACTION CONTENTCACHEUPSERT
    IF NOT EXISTS (SELECT ContentCacheID FROM [ReportServer2017TempDB].[dbo].ContentCache WHERE CatalogItemID = @CatalogItemID AND ParamsHash = @ParamsHash AND  ContentType = @ContentType)
        INSERT INTO [ReportServer2017TempDB].[dbo].ContentCache
            (
                [CatalogItemID],
                [CreatedDate],
                [ParamsHash],
                [EffectiveParams],
                [ContentType],
                [ExpirationDate],
                [Version],
                [Content]
            )
        VALUES
            (
                @CatalogItemID,
                GETDATE(),
                @ParamsHash,
                @EffectiveParams,
                @ContentType,
                @ExpirationDate,
                @Version,
                @Content
            )
    ELSE
        UPDATE [ReportServer2017TempDB].[dbo].ContentCache
        SET
            [CatalogItemID] = @CatalogItemID,
            [CreatedDate] = GETDATE(),
            [ParamsHash] = @ParamsHash,
            [EffectiveParams] = @EffectiveParams,
            [ContentType] = @ContentType,
            [ExpirationDate] = @ExpirationDate,
            [Version] = @Version,
            [Content] = @Content
         WHERE CatalogItemID = @CatalogItemID AND ParamsHash = @ParamsHash AND  ContentType = @ContentType
    COMMIT TRANSACTION CONTENTCACHEUPSERT
END
GO
