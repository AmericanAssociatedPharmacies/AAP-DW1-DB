USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[CreateSegmentedChunk]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[CreateSegmentedChunk]
    @SnapshotId		uniqueidentifier,
    @IsPermanent	bit,
    @ChunkName		nvarchar(260),
    @ChunkFlags		tinyint,
    @ChunkType		int,
    @Version		smallint,
    @MimeType		nvarchar(260) = null,
    @Machine		nvarchar(512),
    @ChunkId		uniqueidentifier out
as begin
    declare @output table (ChunkId uniqueidentifier) ;
    if (@IsPermanent = 1) begin
        delete SegmentedChunk
        where SnapshotDataId = @SnapshotId and ChunkName = @ChunkName and ChunkType = @ChunkType

        delete ChunkData
        where SnapshotDataID = @SnapshotId and ChunkName = @ChunkName and ChunkType = @ChunkType

        insert SegmentedChunk(SnapshotDataId, ChunkFlags, ChunkName, ChunkType, Version, MimeType)
        output inserted.ChunkId into @output
        values (@SnapshotId, @ChunkFlags, @ChunkName, @ChunkType, @Version, @MimeType) ;
    end
    else begin
        delete [ReportServer2017TempDB].dbo.SegmentedChunk
        where SnapshotDataId = @SnapshotId and ChunkName = @ChunkName and ChunkType = @ChunkType

        delete [ReportServer2017TempDB].dbo.ChunkData
        where SnapshotDataID = @SnapshotId and ChunkName = @ChunkName and ChunkType = @ChunkType

        insert [ReportServer2017TempDB].dbo.SegmentedChunk(SnapshotDataId, ChunkFlags, ChunkName, ChunkType, Version, MimeType, Machine)
        output inserted.ChunkId into @output
        values (@SnapshotId, @ChunkFlags, @ChunkName, @ChunkType, @Version, @MimeType, @Machine) ;
    end
    select top 1 @ChunkId = ChunkId from @output
end
GO
