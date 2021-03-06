USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[IsSegmentedChunk]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[IsSegmentedChunk]
    @SnapshotId			uniqueidentifier,
    @IsPermanent		bit,
    @ChunkName			nvarchar(260),
    @ChunkType			int,
    @IsSegmented		bit out
as begin
    -- segmented chunks are read w/nolock
    -- we don't really care about locking in this scenario
    -- we just need to get some metadata which never changes (if it is segmented or not)
    if (@IsPermanent = 1) begin
        select top 1 @IsSegmented = IsSegmented
        from
        (
            select convert(bit, 0)
            from [ChunkData] c
            where c.ChunkName = @ChunkName and c.ChunkType = @ChunkType and c.SnapshotDataId = @SnapshotId
            union all
            select convert(bit, 1)
            from [SegmentedChunk] c WITH(NOLOCK)
            where c.ChunkName = @ChunkName and c.ChunkType = @ChunkType and c.SnapshotDataId = @SnapshotId
        ) A(IsSegmented)
    end
    else begin
        select top 1 @IsSegmented = IsSegmented
        from
        (
            select convert(bit, 0)
            from [ReportServer2017TempDB].dbo.[ChunkData] c
            where c.ChunkName = @ChunkName and c.ChunkType = @ChunkType and c.SnapshotDataId = @SnapshotId
            union all
            select convert(bit, 1)
            from [ReportServer2017TempDB].dbo.[SegmentedChunk] c WITH(NOLOCK)
            where c.ChunkName = @ChunkName and c.ChunkType = @ChunkType and c.SnapshotDataId = @SnapshotId
        ) A(IsSegmented)
    end
end
GO
