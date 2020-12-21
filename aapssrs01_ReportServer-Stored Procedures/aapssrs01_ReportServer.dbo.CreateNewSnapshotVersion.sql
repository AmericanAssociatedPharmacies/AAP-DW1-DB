USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[CreateNewSnapshotVersion] Script Date: 12/21/2020 8:37:06 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateNewSnapshotVersion]
    @OldSnapshotId UNIQUEIDENTIFIER,
    @NewSnapshotId UNIQUEIDENTIFIER,
    @IsPermanentSnapshot BIT,
    @Machine NVARCHAR(512)
AS
BEGIN
    IF(@IsPermanentSnapshot = 1) BEGIN
        INSERT [dbo].[SnapshotData] (
            SnapshotDataId,
            CreatedDate,
            ParamsHash,
            QueryParams,
            EffectiveParams,
            Description,
            DependsOnUser,
            PermanentRefCount,
            TransientRefCount,
            ExpirationDate,
            PageCount,
            HasDocMap,
            PaginationMode,
            ProcessingFlags
            )
        SELECT
            @NewSnapshotId,
            [sn].CreatedDate,
            [sn].ParamsHash,
            [sn].QueryParams,
            [sn].EffectiveParams,
            [sn].Description,
            [sn].DependsOnUser,
            0,
            1,		-- always create with transient refcount of 1
            [sn].ExpirationDate,
            [sn].PageCount,
            [sn].HasDocMap,
            [sn].PaginationMode,
            [sn].ProcessingFlags
        FROM [dbo].[SnapshotData] [sn]
        WHERE [sn].SnapshotDataId = @OldSnapshotId
    END
    ELSE BEGIN
        INSERT [aapssrs01_ReportServerTempDB].dbo.[SnapshotData] (
            SnapshotDataId,
            CreatedDate,
            ParamsHash,
            QueryParams,
            EffectiveParams,
            Description,
            DependsOnUser,
            PermanentRefCount,
            TransientRefCount,
            ExpirationDate,
            PageCount,
            HasDocMap,
            PaginationMode,
            ProcessingFlags,
            Machine,
            IsCached
            )
        SELECT
            @NewSnapshotId,
            [sn].CreatedDate,
            [sn].ParamsHash,
            [sn].QueryParams,
            [sn].EffectiveParams,
            [sn].Description,
            [sn].DependsOnUser,
            0,
            1,		-- always create with transient refcount of 1
            [sn].ExpirationDate,
            [sn].PageCount,
            [sn].HasDocMap,
            [sn].PaginationMode,
            [sn].ProcessingFlags,
            @Machine,
            [sn].IsCached
        FROM [aapssrs01_ReportServerTempDB].dbo.[SnapshotData] [sn]
        WHERE [sn].SnapshotDataId = @OldSnapshotId
    END

    EXEC [dbo].[CopyChunks]
        @OldSnapshotId = @OldSnapshotId,
        @NewSnapshotId = @NewSnapshotId,
        @IsPermanentSnapshot = @IsPermanentSnapshot
END
