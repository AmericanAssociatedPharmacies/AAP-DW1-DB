USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[ReadChunkSegment]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[ReadChunkSegment]
    @ChunkId		uniqueidentifier,
    @SegmentId		uniqueidentifier,
    @IsPermanent	bit,
    @DataIndex		int,
    @Length			int
as begin
    if(@IsPermanent = 1) begin
        select substring(seg.Content, @DataIndex + 1, @Length) as [Content]
        from Segment seg
        join ChunkSegmentMapping csm on (csm.SegmentId = seg.SegmentId)
        where csm.ChunkId = @ChunkId and csm.SegmentId = @SegmentId
    end
    else begin
        select substring(seg.Content, @DataIndex + 1, @Length) as [Content]
        from [ReportServer2017TempDB].dbo.Segment seg
        join [ReportServer2017TempDB].dbo.ChunkSegmentMapping csm on (csm.SegmentId = seg.SegmentId)
        where csm.ChunkId = @ChunkId and csm.SegmentId = @SegmentId
    end
end
GO
