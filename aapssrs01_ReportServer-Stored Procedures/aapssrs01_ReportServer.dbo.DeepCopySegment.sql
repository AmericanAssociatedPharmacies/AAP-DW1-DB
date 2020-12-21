USE [aapssrs01_ReportServer]
GO

/****** Object: SqlProcedure [dbo].[DeepCopySegment] Script Date: 12/21/2020 8:41:44 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[DeepCopySegment]
    @ChunkId		uniqueidentifier,
    @IsPermanent	bit,
    @SegmentId		uniqueidentifier,
    @NewSegmentId	uniqueidentifier out
as
begin
    select @NewSegmentId = newid() ;
    if (@IsPermanent = 1) begin
        insert Segment(SegmentId, Content)
        select @NewSegmentId, seg.Content
        from Segment seg
        where seg.SegmentId = @SegmentId ;

        update ChunkSegmentMapping
        set SegmentId = @NewSegmentId
        where ChunkId = @ChunkId and SegmentId = @SegmentId ;
    end
    else begin
        insert [aapssrs01_ReportServerTempDB].dbo.Segment(SegmentId, Content)
        select @NewSegmentId, seg.Content
        from [aapssrs01_ReportServerTempDB].dbo.Segment seg
        where seg.SegmentId = @SegmentId ;

        update [aapssrs01_ReportServerTempDB].dbo.ChunkSegmentMapping
        set SegmentId = @NewSegmentId
        where ChunkId = @ChunkId and SegmentId = @SegmentId ;
    end
end
