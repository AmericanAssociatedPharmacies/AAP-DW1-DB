USE [ReportServer2017]
GO
/****** Object:  StoredProcedure [dbo].[TempChunkExists]    Script Date: 12/22/2020 7:43:21 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[TempChunkExists]
    @ChunkId uniqueidentifier
AS
BEGIN
    SELECT COUNT(1) FROM [ReportServer2017TempDB].dbo.SegmentedChunk
    WHERE ChunkId = @ChunkId
END
GO
